part of 'covid_bloc.dart';

abstract class CovidEvent extends Equatable {
  const CovidEvent();

  @override
  List<Object> get props => [];
}

class CovidEventFetching extends CovidEvent {}

class CovidEventSortBy extends CovidEvent {
  final String sortBy;

  const CovidEventSortBy({
    required this.sortBy,
  });
}
