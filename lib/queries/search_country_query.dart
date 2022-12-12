const String searchCountryQuery = r'''
query country ($country: String!, $filterBy: CountryResultParametersFilterInput){
    country(name: $country, filterBy: $filterBy) {
        country
        countryInfo {
            _id
            lat
            long
            flag
            iso2
            iso3
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
