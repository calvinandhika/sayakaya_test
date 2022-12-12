part of 'country_detail_cubit.dart';

abstract class CountryDetailState extends Equatable {
  const CountryDetailState();

  @override
  List<Object?> get props => [];
}

class CountryDetailInitial extends CountryDetailState {}

class CountryDetailStateData extends CountryDetailState {
  final bool isLoading;
  final CountryModelData? todayData;
  final CountryModelData? yesterdayData;
  final CountryModelData? twoDaysAgoData;
  final String? exception;

  const CountryDetailStateData({
    required this.isLoading,
    this.todayData,
    this.yesterdayData,
    this.twoDaysAgoData,
    this.exception,
  });

  @override
  List<Object?> get props => [
        isLoading,
        todayData,
        yesterdayData,
        twoDaysAgoData,
        exception,
      ];
}
