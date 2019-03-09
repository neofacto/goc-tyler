using System;
using System.IO;


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


            foreach(var f in Directory.GetFiles("../../../export/export/"))
            {

            }
            //loop on each file
            foreach (var d in Directory.GetDirectories("../../../export/export/"))
            {

            }
            //foreach file we search the content for one of the listed localities
            //if we have a match we create a new result 

            Console.ReadLine();
        }
    }
}
