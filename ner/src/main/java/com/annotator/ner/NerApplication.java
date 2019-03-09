package com.annotator.ner;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Stream;

import org.elasticsearch.action.bulk.BulkRequestBuilder;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.json.simple.parser.ParseException;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.annotator.model.Locality;
import com.annotator.model.ParsedDoc;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Lists;
import com.google.gson.Gson;
import com.ontotext.kim.gate.KimGazetteer;

import gate.Factory;
import gate.Gate;
import gate.creole.ResourceInstantiationException;
import gate.util.GateException;
import gate.util.InvalidOffsetException;
import static java.util.stream.Collectors.toList;

@SpringBootApplication
public class NerApplication {

	public static void main(String[] args) throws GateException, IOException, ParseException {


		Gate.init();
		KimGazetteer gazzetter = new KimGazetteer();
		gazzetter.setDictionaryPath(new File("src/main/resources").toURL());
		gazzetter.init();


		Settings settings = Settings.builder()
				.put("cluster.name", "docker-cluster").build();

		TransportClient client = new PreBuiltTransportClient(settings)
				.addTransportAddress(new TransportAddress(InetAddress.getLoopbackAddress(), 9300));


		List<String> stopWords  = Files.readAllLines(Paths.get("src/main/resources/frenchStopWords.txt"));

		Stream<Path> files = Files.walk(Paths.get(Paths.get(System.getProperty("user.dir")).getParent()+File.separator+"export01-newspapers1841-1878/export01-newspapers1841-1878/"))
				.filter(Files::isRegularFile);
		
		//load JSON file with localities
		String content = new String(Files.readAllBytes(Paths.get("src/main/resources/localities.json")));
		ObjectMapper mapper2 = new ObjectMapper();
		
		Locality[] localitie = new Gson().fromJson(content,Locality[].class);
		List<Locality> localities = Lists.newArrayList(localitie);
		System.out.println(localities);
		files.forEach(item ->{
		
		
			File f = new File(item.toUri());
			try {
				gazzetter.setDocument(Factory.newDocument(f.toURL()));
				
				StringBuilder bl = new StringBuilder();
				
				Files.readAllLines(f.toPath()).forEach(s-> bl.append(s));
					
				String doc = gazzetter.getDocument().getContent().toString();
				
				boolean french = false;
				for(String st: stopWords) {
					doc.contains(st);
					french = true;
					break;
				}
				if(french) {
					
					String editor="", title="", langue="";
					if(bl.toString().contains("<dcterms:isPartOf>"))
					 editor = bl.substring(bl.lastIndexOf("<dcterms:isPartOf>"), bl.indexOf("</dcterms:isPartOf>"));
					if(bl.toString().contains("<dc:title>"))
					 title = bl.substring(bl.lastIndexOf("<dc:title>"), bl.indexOf("</dc:title>"));
					if(bl.toString().contains("<dc:language>"))
					 langue = bl.substring(bl.lastIndexOf("<dc:language>"), bl.lastIndexOf("</dc:language>")); 
			

					String idStr = item.toUri().getPath().substring(item.toUri().getPath().lastIndexOf('-') + 1);
					String id = "article:"+idStr.replaceAll(".xml", "");
					ParsedDoc pd = new ParsedDoc();
					pd.setEditor(editor);
					pd.setTitre(title);
					pd.setLangue(langue);
					
					pd.setId(id);
					List<String> lines = new ArrayList<>();
					if(doc.split(id).length==3) {
						List<String> split = new ArrayList<>();
						for(String s: doc.split(id)) {
							if(s.contains("issue:newspaper"))
								pd.setDate("18"+s.split("/18")[2].replaceAll("/",""));
							if(s.contains("http://www.eluxemburgensia.lu/webclient/DeliveryManager?pid"))
								pd.setUrl(s.substring(s.indexOf("http://www.eluxemburgensia.lu/webclient/DeliveryManager?pid"), s.length()));
							lines.add(s);
						}

						pd.setContent(lines.get(lines.size()-1));
						System.out.println("======================>"+localities);
						ArrayList<Locality> collected = new ArrayList<Locality>();
						for(Locality l: localities) {
							if(pd!=null && pd.getContent()!=null && pd.getContent().contains(l.getCityName()))
								collected.add(l);
						}
						//List<Locality> collected = localities.stream().filter(s->doc.contains(s.getCityName())).collect(toList());  
						
						
						System.out.println(collected);
						//pd.setLocalities(collected);
						gazzetter.setDocument(Factory.newDocument(pd.getContent()));
						gazzetter.execute();

						Set<com.annotator.model.Annotation> annots = new HashSet<com.annotator.model.Annotation>();
						gazzetter.getDocument().getAnnotations().get("Lookup").forEach(item2 ->{
							try {
								String anno = gazzetter.getDocument().getContent().getContent(item2.getStartNode().getOffset(), item2.getEndNode().getOffset()).toString();
								if(!stopWords.contains(anno) && anno.length()>=5){
									com.annotator.model.Annotation a = new com.annotator.model.Annotation();
									a.setAnnotation(anno);
									a.setStart(item2.getStartNode().getOffset().intValue());
									a.setEnd(item2.getEndNode().getOffset().intValue());
									a.setEntity(item2.getFeatures().get("inst").toString());
									a.setOwlClass(item2.getFeatures().get("class").toString());
									annots.add(a);
								}
							} catch (InvalidOffsetException e) {
								e.printStackTrace();
							}
						});
						pd.setAnnots(Lists.newArrayList(annots));

						ObjectMapper mapper = new ObjectMapper();
						// Gets a list of SinkRecord from Kafka broker. 
						List<ParsedDoc> records = new ArrayList<ParsedDoc>();
						records.add(pd);
						for (int i = 0; i < records.size(); i++) {
							BulkRequestBuilder bulkRequest = client.prepareBulk();
							// Index and type is hardcoded and record.value() contains the Json message.
							
							Map<String, Object> map = mapper.readValue((String) new Gson().toJson(records.get(i)), new TypeReference<Map<String, Object>>() {
							});
							
							
							bulkRequest.add(client.prepareIndex("frenchnews","_doc").setSource(map));
						
							// Executing bulk requests.
							BulkResponse bulkResponse = bulkRequest.execute().actionGet();
							System.out.println(bulkResponse.getTook());
						}
						//System.out.println(gazzetter.getDocument().getAnnotations().get("Lookup"));
					}
				}
			} catch (ResourceInstantiationException | IOException | gate.creole.ExecutionException e) {
				e.printStackTrace();

			}
		});





		//gate.Document doc = Factory.newDocument(reader.getText());
		//System.out.println(doc.getContent());
	}

	/**
	 * 	//SpringApplication.run(NerApplication.class, args);
		Gate.init();
		// load the ANNIE plugin 

		KimGazetteer gazzetter = new KimGazetteer();





		System.out.println(gazzetter.getDocument().));

		// Run ANNIE 

		System.out.println("Annotations");
		gazzetter.getDocument().getAnnotations().forEach(item -> System.out.println(item));
	 */

}
