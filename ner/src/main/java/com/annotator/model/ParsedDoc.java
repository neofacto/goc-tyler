package com.annotator.model;

<<<<<<< silvio
import java.util.List;
import java.util.Set;
import java.util.UUID;
=======
import java.util.ArrayList;
import java.util.List;
>>>>>>> master

public class ParsedDoc {

	
	private UUID uuid = UUID.randomUUID();
	private String id;
	private String date;
	private String url;
	private String content;
<<<<<<< silvio
	private String city;
	private String latitute;
	private String longitude;
	private List<Annotation> annots;
	
	
	
=======
	private List<Locality> localities;
>>>>>>> master
	
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
<<<<<<< silvio
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getLatitute() {
		return latitute;
	}
	public void setLatitute(String latitute) {
		this.latitute = latitute;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public UUID getUuid() {
		return uuid;
	}
	public void setUuid(UUID uuid) {
		this.uuid = uuid;
	}
	
=======
	public List<Locality> getLocalities(){
		return localities;
	}

	public void setLocalities(List<Locality> locs){
		this.localities = locs;
	}
>>>>>>> master
}
