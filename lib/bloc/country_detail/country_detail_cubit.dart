import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayakaya_test/const/enum.dart';
import 'package:sayakaya_test/models/country_model.dart';
import 'package:sayakaya_test/services/country_service.dart';

part 'country_detail_state.dart';

class CountryDetailCubit extends Cubit<CountryDetailState> {
  CountryDetailCubit() : super(CountryDetailInitial());

  void searchCountryData({required String countryName}) async {
    emit(
      const CountryDetailStateData(
        isLoading: true,
      ),
    );
    final countryService = CountryService();

    try {
      final todayData = await countryService.searchCountry(
        country: countryName,
        filterBy: null,
      );

      Future.delayed(const Duration(seconds: 1));

      final yesterdayData = await countryService.searchCountry(
        country: countryName,
        filterBy: CountryResultParametersFilterInput.yesterday.name,
      );

      Future.delayed(const Duration(seconds: 1));

      final twoDaysAgoData = await countryService.searchCountry(
        country: countryName,
        filterBy: CountryResultParametersFilterInput.twoDaysAgo.name,
      );

      emit(
        CountryDetailStateData(
          isLoading: false,
          todayData: todayData,
          yesterdayData: yesterdayData,
          twoDaysAgoData: twoDaysAgoData,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
