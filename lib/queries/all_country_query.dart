String allCountryQuery = r'''
query countries ($sortBy: CountryResultParametersSortInput){
    countries (sortBy: $sortBy){
        country 
        countryInfo {
            _id
            lat
            long
            flag
            iso3
            iso2 
        }
        continent
        result {
            population
            tests
            cases
            todayCases
            deaths
            todayDeaths
            recovered
            active
            critical
            casesPerOneMillion
            deathsPerOneMillion
            testsPerOneMillion
            activePerOneMillion
            recoveredPerOneMillion
            criticalPerOneMillion
            updated
        }
    }
}
''';
