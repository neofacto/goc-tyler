package com.annotator.model;

import java.util.ArrayList;
import java.util.List;

public class ParsedDoc {

	private String id;
	private String date;
	private String url;
	private String content;
	private List<Locality> localities;
	
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
	public List<Locality> getLocalities(){
		return localities;
	}

	public void setLocalities(List<Locality> locs){
		this.localities = locs;
	}
}
