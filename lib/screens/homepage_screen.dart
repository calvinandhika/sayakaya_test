import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sayakaya_test/bloc/covid/covid_bloc.dart';
import 'package:sayakaya_test/const/colors.dart';
import 'package:sayakaya_test/dialog/error_dialog.dart';
import 'package:sayakaya_test/models/global_data_model.dart';
import 'package:sayakaya_test/widgets/custom_app_bar.dart';
import 'package:sayakaya_test/widgets/custom_bottom_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sayakaya_test/widgets/indicator.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  int touchedIndex = -1;

  @override
  void initState() {
    context.read<CovidBloc>().add(CovidEventFetching());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkGreyColor,
      appBar: const CustomAppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
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
                return Card(
                  color: kDarkGreyColor,
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Number Of Covid Global Case',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          color: kWhiteColor,
                        ),
                      ),
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 3,
                            centerSpaceRadius: 60,
                            sections: showingSections(state.globalData!),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Indicator(
                            color: Color(0xff0293ee),
                            text: 'Affected Countries',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xfff8b250),
                            text: 'Today Cases',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xff845bef),
                            text: 'Today Deaths',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xff13d38e),
                            text: 'Active',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xFFD36913),
                            text: 'Critical',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                    ],
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
    );
  }

  List<PieChartSectionData> showingSections(GlobalDataModel data) {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 10,
            title: data.affectedCountries.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 20,
            title: NumberFormat.decimalPattern().format(data.todayCases),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 10,
            title: NumberFormat.decimalPattern().format(data.todayDeaths),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 35,
            title: NumberFormat.decimalPattern().format(data.active),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xFFD36913),
            value: 20,
            title: NumberFormat.decimalPattern().format(data.critical),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
