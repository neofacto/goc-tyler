package com.annotator.ner;

import static org.elasticsearch.common.xcontent.XContentFactory.jsonBuilder;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collector;
import java.util.stream.Stream;

import com.annotator.model.Locality;
import com.annotator.model.ParsedDoc;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ontotext.kim.gate.KimGazetteer;

import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.TransportAddress;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.json.simple.JSONObject;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import static java.util.stream.Collectors.toList;

import gate.Factory;
import gate.Gate;
import gate.creole.ResourceInstantiationException;
import gate.util.GateException;

@SpringBootApplication
public class NerApplication {

	public static void main(String[] args) throws GateException, IOException {


		Gate.init();
		KimGazetteer gazzetter = new KimGazetteer();
		gazzetter.setDictionaryPath(new File("src/main/resources").toURL());
		gazzetter.init();

		Settings settings = Settings.builder()
		        .put("cluster.name", "docker-cluster").build();

		TransportClient client = new PreBuiltTransportClient(settings)
				.addTransportAddress(new TransportAddress(InetAddress.getLoopbackAddress(), 9300));


		List<String> stopWords  = Files.readAllLines(Paths.get("src/main/resources/frenchStopWords.txt"));

		Stream<Path> files = Files.walk(Paths.get("/home/silvio/hackton/goc-tyler/export01-newspapers1841-1878/export01-newspapers1841-1878/"))
				.filter(Files::isRegularFile);
		
		//load JSON file with localities
		String content = new String(Files.readAllBytes(Paths.get("localities.json")));
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<Locality> localities = mapper.readValue(content, new TypeReference<ArrayList<Locality>>(){});

		files.forEach(item ->{
			File f = new File(item.toUri());
			try {
				gazzetter.setDocument(Factory.newDocument(f.toURL()));
				String doc = gazzetter.getDocument().getContent().toString();
				boolean french = false;
				for(String st: stopWords) {
					doc.contains(st);
					french = true;
					break;
				}
				if(french) {
				
						
					String idStr = item.toUri().getPath().substring(item.toUri().getPath().lastIndexOf('-') + 1);
					String id = "article:"+idStr.replaceAll(".xml", "");
					ParsedDoc pd = new ParsedDoc();
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
						
						List<Locality> collected = localities.stream().filter(s->pd.getContent().contains(s.getCityName())).collect(toList());  

						pd.setLocalities(collected);

						gazzetter.setDocument(Factory.newDocument(pd.getContent()));
						gazzetter.execute();
						System.out.println(gazzetter.getDocument().getAnnotations().get("Lookup"));

						IndexRequest indexRequest = new IndexRequest("frenchnews","doc")
						        .source(jsonBuilder()
						            .startObject()
						                .field("doc_name", pd.getId())
						                .field("date", pd.getDate())
						                .field("url",pd.getUrl())
										.field("content",pd.getContent())
										.field("localities", pd.getLocalities())
						                .field("annotations","")
						            .endObject());
						System.out.println(client.index(indexRequest).get());
					}
				}
			} catch (ResourceInstantiationException | IOException | InterruptedException | ExecutionException | gate.creole.ExecutionException e) {
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
