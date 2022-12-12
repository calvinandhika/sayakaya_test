import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:sayakaya_test/screens/homepage_screen.dart';
import 'package:sayakaya_test/screens/list_country_screen.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationStateTab(0));

  void goToTab(int tab) {
    emit(NavigationStateTab(tab));

    switch (tab) {
      case 0:
        Get.offAll(() => const HomepageScreen());
        break;
      case 1:
        Get.offAll(() => const ListCountryScreen());
        break;
      default:
    }
  }

  int getCurrentTab() {
    return (state as NavigationStateTab).currentTab;
  }
}
