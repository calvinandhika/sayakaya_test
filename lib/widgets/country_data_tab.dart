import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sayakaya_test/const/colors.dart';
import 'package:sayakaya_test/models/country_model.dart';

class CountryDataTab extends StatefulWidget {
  final CountryModelData countryData;
  final String title;
  final bool isLastPage;

  const CountryDataTab({
    super.key,
    this.isLastPage = false,
    required this.countryData,
    required this.title,
  });

  @override
  State<CountryDataTab> createState() => _CountryDataTabState();
}

class _CountryDataTabState extends State<CountryDataTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              widget.isLastPage
                  ? const SizedBox(
                      height: 22,
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Swipe to see more ->',
                          style: GoogleFonts.poppins(color: kWhiteColor),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBlueColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: kWhiteColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Covid Result',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: kWhiteColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              showData(
                'Population',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.population,
                ),
              ),
              showData(
                'Tests',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.tests,
                ),
              ),
              showData(
                'Cases',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.cases,
                ),
              ),
              showData(
                'Today Cases',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.todayCases,
                ),
              ),
              showData(
                'Deaths',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.deaths,
                ),
              ),
              showData(
                'Today Deaths',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.todayDeaths,
                ),
              ),
              showData(
                'Recovered',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.recovered,
                ),
              ),
              showData(
                'Active',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.active,
                ),
              ),
              showData(
                'Critical',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.critical,
                ),
              ),
              showData(
                'Cases Per One Million',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.casesPerOneMillion,
                ),
              ),
              showData(
                'Deaths Per One Million',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.deathsPerOneMillion,
                ),
              ),
              showData(
                'Tests Per One Million',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.testsPerOneMillion,
                ),
              ),
              showData(
                'Active Per One Million',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.activePerOneMillion,
                ),
              ),
              showData(
                'Recovered Per One Million',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.recoveredPerOneMillion,
                ),
              ),
              showData(
                'Critical Per One Million',
                NumberFormat.decimalPattern().format(
                  widget.countryData.result.criticalPerOneMillion,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showData(
    String title,
    String data,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            color: kWhiteColor,
            fontSize: 16,
          ),
        ),
        Text(
          data,
          style: GoogleFonts.poppins(
            color: kWhiteColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
