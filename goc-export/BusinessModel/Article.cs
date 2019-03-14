using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace BusinessModel
{
    public class Article
    {
        public Article()
        {
        }

        public string Identifier { get; set; }
        public string Source { get; set; }
        public string IsPartOf { get; set; }
        public DateTime Date { get; set; }//initial format is yyyy-mm-dd
        public string Publisher { get; set; }
        public string Link { get; set; } //hasVersion in xml
        [JsonIgnore]
        public string Description { get; set; }//Content that has been OCRed 
        public string DocumentType { get; set; } //typew in XML
        public string Language { get; set; }
        public string Title { get; set; }
        //public List<Locality> LinkedLocalities { get; set; } = new List<Locality>();
    }
}
