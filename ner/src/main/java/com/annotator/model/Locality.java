package com.annotator.model;

public class Locality {
    private String cityName="";
	private String latitude="";
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