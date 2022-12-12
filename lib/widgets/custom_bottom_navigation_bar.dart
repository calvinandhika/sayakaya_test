import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sayakaya_test/bloc/navigation/navigation_cubit.dart';
import 'package:sayakaya_test/const/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (value) {
            context.read<NavigationCubit>().goToTab(value);
          },
          currentIndex: context.read<NavigationCubit>().getCurrentTab(),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: kDarkGreyColor,
          unselectedItemColor: kWhiteColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Country List',
            ),
          ],
        );
      },
    );
  }
}
