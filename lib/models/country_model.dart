import 'package:sayakaya_test/models/country_info_model.dart';
import 'package:sayakaya_test/models/result_model.dart';

class CountryModel {
  final List<CountryModelData> countries;

  CountryModel({required this.countries});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    List<CountryModelData> dataRows = [];

    for (var country in json['countries']) {
      dataRows.add(CountryModelData.fromJson(country));
    }

    return CountryModel(countries: dataRows);
  }
}

class CountryModelData {
  final String country;
  final CountryInfoModel countryInfo;
  final String continent;
  final ResultModel result;

  CountryModelData({
    required this.country,
    required this.countryInfo,
    required this.continent,
    required this.result,
  });

  factory CountryModelData.fromJson(Map<String, dynamic> json) {
    final countryInfo = CountryInfoModel.fromJson(json['countryInfo']);
    final result = ResultModel.fromJson(json['result']);

    return CountryModelData(
      country: json['country'],
      countryInfo: countryInfo,
      continent: json['continent'],
      result: result,
    );
  }
}
