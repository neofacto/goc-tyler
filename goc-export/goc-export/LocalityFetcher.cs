using System;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.IO;
using BusinessModel;

namespace goc_export
{
    public class LocalityFetcher
    {

        public LocalityFetcher()
        {

        }


        public CityList GetLocalitiesFromFile()
        {
            CityList cityList;
            // deserialize JSON directly from a file
            using (StreamReader file = File.OpenText(@"localities.json"))
            {
                JsonSerializer serializer = new JsonSerializer();
                cityList = (CityList)serializer.Deserialize(file, typeof(CityList));
            }
            return cityList;
        }
    }
}
