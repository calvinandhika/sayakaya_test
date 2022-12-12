import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayakaya_test/bloc/country_detail/country_detail_cubit.dart';
import 'package:sayakaya_test/const/colors.dart';
import 'package:sayakaya_test/dialog/error_dialog.dart';
import 'package:sayakaya_test/widgets/covid_bar_chart.dart';
import 'package:sayakaya_test/widgets/country_data_tab.dart';
import 'package:sayakaya_test/widgets/custom_app_bar.dart';
import 'package:sayakaya_test/widgets/custom_bottom_navigation_bar.dart';

class CountryDetailScreen extends StatefulWidget {
  const CountryDetailScreen({super.key});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  final parameter = Get.parameters['countryName'];
  final PageController controller = PageController();

  @override
  void initState() {
    context.read<CountryDetailCubit>().searchCountryData(
          countryName: parameter!,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      appBar: CustomAppBar(title: parameter!),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: BlocConsumer<CountryDetailCubit, CountryDetailState>(
        listener: (context, state) {
          if (state is CountryDetailStateData) {
            if (state.exception != null) {
              showErrorDialog(
                title: 'Server Busy',
                body: 'Please wait a couple of second and try again',
                context: context,
              );
            }
          }
        },
        builder: (context, state) {
          if (state is CountryDetailStateData) {
            if (!state.isLoading && state.todayData != null) {
              return ListView(
                children: [
                  SizedBox(
                    height: 400,
                    child: CovidBarChart(
                      twoDaysAgoData: state.twoDaysAgoData!,
                      yesterdayData: state.yesterdayData!,
                      todayData: state.todayData!,
                    ),
                  ),
                  SizedBox(
                    height: 600,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      children: [
                        CountryDataTab(
                          countryData: state.todayData!,
                          title: 'Today Data',
                        ),
                        CountryDataTab(
                          countryData: state.yesterdayData!,
                          title: 'Yesterday Data',
                        ),
                        CountryDataTab(
                          countryData: state.twoDaysAgoData!,
                          title: 'Two Days Ago',
                          isLastPage: true,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state.exception != null) {
              return Center(
                child: Text(
                  'Try Again',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: kWhiteColor,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
