part of 'covid_bloc.dart';

abstract class CovidState extends Equatable {
  final bool isLoading;
  const CovidState({
    required this.isLoading,
  });

  @override
  List<Object?> get props => [isLoading];
}

class CovidStateData extends CovidState {
  final CountryModel? countriesData;
  final CountryModelData? countrySpotlight;
  final GlobalDataModel? globalData;
  final String? sortBy;

  const CovidStateData({
    this.countriesData,
    this.countrySpotlight,
    this.globalData,
    this.sortBy,
    required bool isLoading,
  }) : super(isLoading: isLoading);

  CovidStateData copyWith({
    bool? isLoading,
    CountryModel? countriesData,
    GlobalDataModel? globalData,
    String? sortBy,
  }) =>
      CovidStateData(
        isLoading: isLoading ?? this.isLoading,
        countriesData: countriesData ?? this.countriesData,
        sortBy: sortBy,
        globalData: globalData ?? this.globalData,
      );

  @override
  List<Object?> get props => [
        isLoading,
        countriesData,
        countrySpotlight,
        sortBy,
        globalData,
      ];
}
