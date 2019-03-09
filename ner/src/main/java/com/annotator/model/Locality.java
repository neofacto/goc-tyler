package com.annotator.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Locality {
	@JsonProperty(value="AdministrativeCityName")
    private String cityName="";
	@JsonProperty(value="LatLL84")
	private String latitude="";
	@JsonProperty(value="LonLL84")
	private String longitude="";

    public String getCityName()
    {
        return cityName;
    }
    
    public void setCityName(String name)
    {
        this.cityName = name;
    }

    public String getLatitude()
    {
        return this.latitude;
    }

    public void setLatitude(String latitude)
    {
        this.latitude = latitude;
    }

    public String getLongitude()
    {
        return longitude;
    }

    public void setLongitude(String longitude)
    {
        this.longitude = longitude;
    }

    public String toString() {
    	return cityName;
    }
    
}