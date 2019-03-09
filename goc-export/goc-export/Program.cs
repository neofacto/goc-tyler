using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.Serialization;
using Schemas;

namespace goc_export
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            //fetch list of localities + coordinates
            var localityFetcher = new LocalityFetcher();
            var cityList = localityFetcher.GetLocalitiesFromFile();

            XmlSerializer serializer = new XmlSerializer(typeof(OAIPMHtype));
            XmlReaderSettings settings = new XmlReaderSettings();

            foreach (var f in Directory.GetFiles("../../../export/export/", "*.xml", SearchOption.AllDirectories))
            {
                using (FileStream file = new FileStream(f, FileMode.Open))
                {
                    using (System.Xml.XmlReader reader = System.Xml.XmlReader.Create(file))
                    {
                        var art = (OAIPMHtype)serializer.Deserialize(reader);
                    }
                }
            }
            //loop on each file
            //foreach file we search the content for one of the listed localities
            //if we have a match we create a new result 

            Console.ReadLine();
        }
    }
}
