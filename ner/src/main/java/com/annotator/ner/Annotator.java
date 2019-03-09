package com.annotator.ner;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ontotext.kim.KIMConstants;
import com.ontotext.kim.gate.KimGazetteer;

import gate.Corpus;
import gate.CorpusController;
import gate.Factory;
import gate.Gate;
import gate.creole.Plugin;
import gate.creole.SerialAnalyserController;
import gate.util.GateException;

@RestController
public class Annotator {

	@GetMapping("/test")
	public void start() throws GateException, IOException, URISyntaxException {
		Gate.init();
		// load the ANNIE plugin 
		
		KimGazetteer gazzetter = new KimGazetteer();
		gazzetter.setDictionaryPath(new File("src/main/resources").toURL());
				/*new Plugin.Maven( 
		      "uk.ac.gate.plugins", "lkb_gazetteer", "8.5"); 
		Gate.getCreoleRegister().registerPlugin(anniePlugin); */
		
		
		// Tell ANNIE’s controller about the corpus you want to run on 
		Corpus corpus = Factory.newCorpus("test") ; 
		corpus.add(Factory.newDocument("This is a phrase for test proposes"));
		gazzetter.setCorpus(corpus); 
		

		//gazzetter.init();
		
		// Run ANNIE 
		gazzetter.execute();
		gazzetter.getCorpus().forEach(item -> System.out.println(item.getAnnotations()));

	}
	
}
