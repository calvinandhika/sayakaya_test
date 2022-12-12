import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sayakaya_test/bloc/country_detail/country_detail_cubit.dart';
import 'package:sayakaya_test/bloc/covid/covid_bloc.dart';
import 'package:sayakaya_test/bloc/navigation/navigation_cubit.dart';
import 'package:sayakaya_test/const/colors.dart';
import 'package:sayakaya_test/const/router.dart';
import 'package:sayakaya_test/screens/country_detail_screen.dart';
import 'package:sayakaya_test/screens/homepage_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CovidBloc>(
          create: (context) => CovidBloc(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider<CountryDetailCubit>(
          create: (context) => CountryDetailCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: kWhiteColor,
                primary: kWhiteColor,
              ),
        ),
        getPages: [
          GetPage(
            name: countryDetailRoute,
            page: () => const CountryDetailScreen(),
          ),
        ],
        home: const MaterialApp(
          title: 'Covid Tracker',
          debugShowCheckedModeBanner: false,
          home: HomepageScreen(),
        ),
      ),
    ),
  );
}
