import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayakaya_test/models/country_model.dart';
import 'package:sayakaya_test/models/global_data_model.dart';
import 'package:sayakaya_test/services/country_service.dart';

part 'covid_event.dart';
part 'covid_state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc()
      : super(
          const CovidStateData(isLoading: true),
        ) {
    on<CovidEventFetching>((event, emit) async {
      emit(
        const CovidStateData(
          isLoading: true,
        ),
      );
      final countryService = CountryService();

      try {
        final globalData = await countryService.getGlobalData();
        final countriesData = await countryService.getAllCountries(
          countryResultParametersSortInput: null,
        );
        emit(
          CovidStateData(
            isLoading: false,
            countriesData: countriesData,
            globalData: globalData,
          ),
        );
      } catch (e) {
        emit(
          CovidStateData(
            isLoading: false,
            exception: e.toString(),
          ),
        );
      }
    });

    on<CovidEventSortBy>(
      (event, emit) async {
        try {
          emit(
            (state as CovidStateData).copyWith(
              isLoading: true,
              sortBy: event.sortBy,
            ),
          );

          final countryService = CountryService();

          final countriesData = await countryService.getAllCountries(
            countryResultParametersSortInput: event.sortBy,
          );
          emit(
            (state as CovidStateData).copyWith(
              isLoading: false,
              countriesData: countriesData,
              sortBy: event.sortBy,
            ),
          );
        } catch (e) {
          emit(
            CovidStateData(
              isLoading: false,
              exception: e.toString(),
            ),
          );
        }
      },
    );
  }
}
