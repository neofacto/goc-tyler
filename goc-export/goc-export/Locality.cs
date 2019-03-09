using System;
namespace goc_export
{
    public class Locality
    {
        public Locality()
        {
        }

        public string AdministrativeCityName { get; set; }
        public string CadastralCityName { get; set; }
        public string OfficialCityName {get;set;}
        public string IsOfficialLocality { get; set; }
        public string LuxembourgishName { get; set; }
        public int YRight { get; set; }
        public int XHeight { get; set; }
        public decimal LonLL84 { get; set; }
        public decimal LatLL84 { get; set; }
    }
}
