package com.annotator.model;

import java.util.List;
import java.util.UUID;

public class ParsedDoc {

	
	private UUID uuid = UUID.randomUUID();
	private String id;
	private String date;
	private String url;
	private String content;

	private String editor;
	private String titre;
	private String langue; 
	
	private List<Annotation> annots;
	private List<Locality> localities;
	
	public String getEditor() {
		return editor;
	}
	public void setEditor(String editor) {
		this.editor = editor;
	}
	public String getTitre() {
		return titre;
	}
	public void setTitre(String titre) {
		this.titre = titre;
	}
	public String getLangue() {
		return langue;
	}
	public void setLangue(String langue) {
		this.langue = langue;
	}
	public List<Annotation> getAnnots() {
		return annots;
	}
	public void setAnnots(List<Annotation> annots) {
		this.annots = annots;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<Locality> getLocalities() {
		return localities;
	}
	public void setLocalities(List<Locality> localities) {
		this.localities = localities;
	}
}
