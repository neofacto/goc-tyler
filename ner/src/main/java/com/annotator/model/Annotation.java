package com.annotator.model;

import org.apache.commons.lang.builder.EqualsBuilder;

import com.fasterxml.jackson.databind.annotation.JacksonStdImpl;
@JacksonStdImpl
public class Annotation {

	private String annotation;
	private int start;
	private int end;
	private String entity;
	private String owlClass;
	
	public String getAnnotation() {
		return annotation;
	}
	public void setAnnotation(String annotation) {
		this.annotation = annotation;
	}
	public long getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public long getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public String getEntity() {
		return entity;
	}
	public void setEntity(String entity) {
		this.entity = entity;
	}
	public String getOwlClass() {
		return owlClass;
	}
	public void setOwlClass(String owlClass) {
		this.owlClass = owlClass;
	}
	
	@Override
	public boolean equals(Object obj) {
		 if (obj == null) { return false; }
		   if (obj == this) { return true; }
		   if (obj.getClass() != getClass()) {
		     return false;
		   }
		   Annotation rhs = (Annotation) obj;
		   return new EqualsBuilder()
		                 .appendSuper(super.equals(obj))
		                 .append(annotation, rhs.annotation)
		                 .append(start, rhs.start)
		                 .append(end, rhs.end)
		                 .append(entity, rhs.entity)
		                 .append(owlClass, rhs.owlClass)
		                 .isEquals();
	}
	
	public String toString() {
		return annotation+", "+entity+", "+owlClass+", "+start+", "+end;
	}
}
