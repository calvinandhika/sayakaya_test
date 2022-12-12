import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayakaya_test/bloc/covid/covid_bloc.dart';
import 'package:sayakaya_test/const/colors.dart';
import 'package:sayakaya_test/const/enum.dart';
import 'package:sayakaya_test/dialog/error_dialog.dart';
import 'package:sayakaya_test/widgets/country_card.dart';
import 'package:sayakaya_test/widgets/custom_app_bar.dart';
import 'package:sayakaya_test/widgets/custom_bottom_navigation_bar.dart';
import 'package:sayakaya_test/widgets/custom_search_field.dart';

class ListCountryScreen extends StatefulWidget {
  const ListCountryScreen({super.key});

  @override
  State<ListCountryScreen> createState() => _ListCountryScreenState();
}

class _ListCountryScreenState extends State<ListCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      appBar: const CustomAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CovidBloc>().add(CovidEventFetching());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: BlocConsumer<CovidBloc, CovidState>(
            listener: (context, state) {
              if (state is CovidStateData) {
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
              if (state is CovidStateData) {
                if (state.exception != null) {
                  return Center(
                    child: Text(
                      'Try Again',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: kWhiteColor,
                      ),
                    ),
                  );
                } else if (!state.isLoading) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        width: 400,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              CountryResultParametersSortInput.values.length,
                          itemBuilder: (context, index) {
                            final sortBy = CountryResultParametersSortInput
                                .values[index].name;
                            return Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: ChoiceChip(
                                selected: state.sortBy == sortBy,
                                labelStyle: TextStyle(
                                    color: state.sortBy == sortBy
                                        ? kWhiteColor
                                        : kBlackColor),
                                selectedColor: kBlueColor,
                                onSelected: (value) {
                                  context.read<CovidBloc>().add(
                                        CovidEventSortBy(sortBy: sortBy),
                                      );
                                },
                                label: Text(
                                  sortBy.toUpperCase(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: ListView.builder(
                            itemCount: state.countriesData?.countries.length,
                            itemBuilder: (context, index) {
                              final countryData =
                                  state.countriesData?.countries[index];
                              return CountryCard(
                                countryData: countryData!,
                              );
                            },
                          ),
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
              return const Text('Unknown Error');
            },
          ),
        ),
      ),
    );
  }
}
