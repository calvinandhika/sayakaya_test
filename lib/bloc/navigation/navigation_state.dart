part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationStateTab extends NavigationState {
  final int currentTab;

  const NavigationStateTab(this.currentTab);

  @override
  List<Object> get props => [currentTab];
}
