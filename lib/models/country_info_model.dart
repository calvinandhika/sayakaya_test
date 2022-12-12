class CountryInfoModel {
  final String? id;
  final double lat;
  final double long;
  final String flag;
  final String? iso2;
  final String? iso3;

  CountryInfoModel({
    required this.id,
    required this.lat,
    required this.long,
    required this.flag,
    required this.iso2,
    required this.iso3,
  });

  factory CountryInfoModel.fromJson(Map<String, dynamic> json) {
    double isDouble(value) {
      if (value is int) {
        return value.toDouble();
      } else {
        return value;
      }
    }

    return CountryInfoModel(
      id: json['_id'] ?? '',
      lat: isDouble(json['lat']),
      long: isDouble(json['long']),
      flag: json['flag'],
      iso2: json['iso2'] ?? '',
      iso3: json['iso3'] ?? '',
    );
  }
}
