using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Serialization;
using Schemas;
using Newtonsoft.Json;
using System.Diagnostics;
using BusinessModel;

namespace goc_export
{
    class Program
    {
        static Dictionary<int, List<Locality>> YearLocality = new Dictionary<int, List<Locality>>();
        //static Dictionary<int, List<Locality>> YearLocalityDistrict = new Dictionary<int, List<Locality>>();

        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
            //fetch list of localities + coordinates
            var localityFetcher = new LocalityFetcher();
            var cityList = localityFetcher.GetLocalitiesFromFile();

            XmlSerializer serializer = new XmlSerializer(typeof(OAIPMHtype));
            XmlReaderSettings settings = new XmlReaderSettings();

            int maxFiles = 1000;
            int fileCounter = 0;
            Stopwatch globalSw = Stopwatch.StartNew();
            Stopwatch sw = Stopwatch.StartNew();

            foreach (var f in Directory.GetFiles("../../../export/", "*.xml", SearchOption.AllDirectories))
            {
                sw.Start();
                if (fileCounter == maxFiles)
                    break;
                using (FileStream file = new FileStream(f, FileMode.Open))
                {
                    using (System.Xml.XmlReader reader = System.Xml.XmlReader.Create(file))
                    {
                        var art = (OAIPMHtype)serializer.Deserialize(reader);
                        var item = art.Items.First() as ListRecordsType;
                        var recordType = item.record.First();
                        var meta = recordType.metadata;
                        var header = recordType.header;

                        var article = new Article()
                        {
                            Identifier = header.identifier, 
                                //Description = meta.
                        };

                        foreach(var cn in meta.ChildNodes )
                        {
                            var xe = cn as XmlElement;
                            switch(xe.LocalName)
                            {
                                case "source":
                                    article.Source = xe.InnerText;
                                    break;
                                case "isPartOf":
                                    article.IsPartOf = xe.InnerText;
                                    break;
                                case "date":
                                    article.Date = DateTime.ParseExact(xe.InnerText, "yyyy-MM-dd", null);
                                    break;
                                case "publisher":
                                    article.Publisher = xe.InnerText;
                                    break;
                                case "hasVersion":
                                    article.Link = xe.InnerText;
                                    break;
                                case "description":
                                    article.Description = xe.InnerText;
                                    break;
                                case "title":
                                    article.Title = xe.InnerText;
                                    break;
                                case "type":
                                    article.DocumentType = xe.InnerText;
                                    break;
                                case "language":
                                    article.Language = xe.InnerText;
                                    break;
                            }
                        }
                        var foundCount = ProcessArticle(article, cityList);
                        Console.WriteLine($"Found {foundCount} for {article.Identifier} dated from {article.Date.Year}");

                    }
                }
                fileCounter++;
                sw.Stop();
                Console.WriteLine($"Finished processing file #{fileCounter} in {sw.ElapsedMilliseconds}ms");
                sw.Reset();
            }

            Console.WriteLine($"Processed {fileCounter} files in {globalSw.ElapsedMilliseconds} ms");
            globalSw.Restart();

            using (StreamWriter file = File.CreateText(@"export.json"))
            {
                JsonSerializer jsonSerializer = new JsonSerializer();
                jsonSerializer.Serialize(file, YearLocality);
            }
           
            Console.WriteLine($"Exported json file in {globalSw.ElapsedMilliseconds} ms");
            Console.ReadLine();
        }

        private static int ProcessArticle(Article article, CityList cities)
        {
            var words = article.Description.Split(" ");
            var linkedLocalities = new List<Locality>();

            foreach (var w in words)
            {
                var matches = cities.cities.Where(x => x.AdministrativeCityName.ToLower() == w.ToLower() && x.IsOfficialLocality == "OUI").Distinct();
                if(matches.Any())
                {
                    linkedLocalities.AddRange(matches);
                    //article.LinkedLocalities.AddRange(matches);
                    foreach(var m in matches)
                    {
                        if (!m.YearArticles.ContainsKey(article.Date.Year))
                            m.YearArticles.Add(article.Date.Year, new List<Article>() { article });
                        else
                            m.YearArticles[article.Date.Year].Add(article);
                    }
                }
                //var matchesDistrict = cities.cities.Where(x => x.OfficialCityName.ToLower() == w.ToLower() && x.IsOfficialLocality == "NON").Distinct();
                //if (matchesDistrict.Any())
                //{
                //    linkedLocalitiesDistrict.AddRange(matchesDistrict);
                //    //article.LinkedLocalities.AddRange(matches);
                //    foreach (var m in matchesDistrict)
                //    {
                //        if (!m.YearArticles.ContainsKey(article.Date.Year))
                //            m.YearArticles.Add(article.Date.Year, new List<Article>() { article });
                //        else
                //            m.YearArticles[article.Date.Year].Add(article);
                //    }
                //}
            }
            if (!YearLocality.ContainsKey(article.Date.Year))
            {
                //YearLocality.Add(article.Date.Year, article.LinkedLocalities);
                YearLocality.Add(article.Date.Year, linkedLocalities);
            }
            else
            {
                //YearLocality[article.Date.Year].AddRange(article.LinkedLocalities);
                YearLocality[article.Date.Year].AddRange(linkedLocalities);
            }

            //if (!YearLocalityDistrict.ContainsKey(article.Date.Year))
            //{
            //    //YearLocality.Add(article.Date.Year, article.LinkedLocalities);
            //    YearLocalityDistrict.Add(article.Date.Year, linkedLocalitiesDistrict);
            //}
            //else
            //{
            //    //YearLocality[article.Date.Year].AddRange(article.LinkedLocalities);
            //    YearLocalityDistrict[article.Date.Year].AddRange(linkedLocalitiesDistrict);
            //}

            //return article.LinkedLocalities.Count();
            return linkedLocalities.Count();
        }
    }
}
