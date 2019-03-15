using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using BusinessModel;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;


namespace MVC.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class YearController : ControllerBase
    {
        static Dictionary<int, List<Locality>> YearLocality;

        // GET api/values
        //[HttpGet]
        //public ActionResult<IEnumerable<string>> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}

        // GET api/values/5
        [HttpGet("{id}")]
        public ActionResult<List<LightLocality>> Get(int id)
        {
            if(YearLocality == null){
            
                using (StreamReader file = System.IO.File.OpenText("export.json"))
                {
                    JsonSerializer serializer = new JsonSerializer();
                    YearLocality = (Dictionary<int, List<Locality>>)serializer.Deserialize(file, typeof(Dictionary<int, List<Locality>>));
                }
            }
            return YearLocality[id].Select(x => x.ToLightLocality(id)).ToList();
        }

        //// POST api/values
        //[HttpPost]
        //public void Post([FromBody] string value)
        //{
        //}

        //// PUT api/values/5
        //[HttpPut("{id}")]
        //public void Put(int id, [FromBody] string value)
        //{
        //}

        //// DELETE api/values/5
        //[HttpDelete("{id}")]
        //public void Delete(int id)
        //{
        //}
    }
}
