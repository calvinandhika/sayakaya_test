class GlobalDataModel {
  final int affectedCountries;
  final int tests;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final double casesPerOneMillion;
  final double deathsPerOneMillion;
  final double testsPerOneMillion;
  final double activePerOneMillion;
  final double recoveredPerOneMillion;
  final double criticalPerOneMillion;
  final int population;

  GlobalDataModel({
    required this.affectedCountries,
    required this.tests,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.active,
    required this.critical,
    required this.casesPerOneMillion,
    required this.deathsPerOneMillion,
    required this.testsPerOneMillion,
    required this.activePerOneMillion,
    required this.recoveredPerOneMillion,
    required this.criticalPerOneMillion,
    required this.population,
  });

  factory GlobalDataModel.fromJson(Map<String, dynamic> json) {
    double isDouble(value) {
      if (value is int) {
        return value.toDouble();
      } else {
        return value;
      }
    }

    json = json['globalTotal'];

    return GlobalDataModel(
      affectedCountries: json['affectedCountries'],
      tests: json['tests'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      active: json['recovered'],
      critical: json['critical'],
      casesPerOneMillion: isDouble(json['casesPerOneMillion']),
      deathsPerOneMillion: isDouble(json['deathsPerOneMillion']),
      testsPerOneMillion: isDouble(json['testsPerOneMillion']),
      activePerOneMillion: isDouble(json['activePerOneMillion']),
      recoveredPerOneMillion: isDouble(json['recoveredPerOneMillion']),
      criticalPerOneMillion: isDouble(json['criticalPerOneMillion']),
      population: json['population'],
    );
  }
}
