class ResultModel {
  final int population;
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
  final String updated;

  ResultModel({
    required this.population,
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
    required this.updated,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    double isDouble(json) {
      if (json is int) {
        return json.toDouble();
      } else {
        return json;
      }
    }

    return ResultModel(
      population: json['population'],
      tests: json['tests'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      active: json['active'],
      critical: json['critical'],
      casesPerOneMillion: isDouble(json['casesPerOneMillion']),
      deathsPerOneMillion: isDouble(json['deathsPerOneMillion']),
      testsPerOneMillion: isDouble(json['testsPerOneMillion']),
      activePerOneMillion: isDouble(json['testsPerOneMillion']),
      recoveredPerOneMillion: isDouble(json['testsPerOneMillion']),
      criticalPerOneMillion: isDouble(json['testsPerOneMillion']),
      updated: json['updated'],
    );
  }
}
