using System;
using System.Linq;

namespace BusinessModel
{
    public static class ModelExtensions
    {
        public static LightLocality ToLightLocality(this Locality loc , int year)
        {
            return new LightLocality()
            {
                AdministrativeCityName = loc.AdministrativeCityName,
                CadastralCityName = loc.CadastralCityName,
                IsOfficialLocality = loc.IsOfficialLocality,
                LatLL84 = loc.LatLL84,
                LonLL84 = loc.LonLL84,
                LuxembourgishName = loc.LuxembourgishName,
                OfficialCityName = loc.OfficialCityName,
                XHeight = loc.XHeight,
                YRight = loc.YRight, Articles = loc.YearArticles.Single(x => x.Key == year).Value
            };
        }
    }
}
