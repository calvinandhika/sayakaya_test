import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sayakaya_test/bloc/covid/covid_bloc.dart';
import 'package:sayakaya_test/const/colors.dart';
import 'package:sayakaya_test/models/country_model.dart';
import 'package:sayakaya_test/models/global_data_model.dart';
import 'package:sayakaya_test/widgets/custom_app_bar.dart';
import 'package:sayakaya_test/widgets/custom_bottom_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sayakaya_test/widgets/indicator.dart';

class CovidBarChart extends StatefulWidget {
  final CountryModelData twoDaysAgoData;
  final CountryModelData yesterdayData;
  final CountryModelData todayData;

  const CovidBarChart({
    super.key,
    required this.twoDaysAgoData,
    required this.yesterdayData,
    required this.todayData,
  });

  @override
  State<CovidBarChart> createState() => _CovidBarChartState();
}

class _CovidBarChartState extends State<CovidBarChart> {
  int touchedIndex = -1;

  @override
  void initState() {
    context.read<CovidBloc>().add(CovidEventFetching());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: BlocBuilder<CovidBloc, CovidState>(
        builder: (context, state) {
          if (state is CovidStateData) {
            if (!state.isLoading) {
              return Card(
                color: kDarkGreyColor,
                elevation: 0,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Covid New Cases',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
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
                          text: 'Today',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color(0xfff8b250),
                          text: 'Yesterday',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Color(0xff845bef),
                          text: 'Two Days Ago',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
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
    );
  }

  List<PieChartSectionData> showingSections(GlobalDataModel data) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: widget.todayData.result.todayCases.toDouble(),
            title: NumberFormat.decimalPattern().format(
              widget.todayData.result.todayCases,
            ),
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
            value: widget.yesterdayData.result.todayCases.toDouble(),
            title: NumberFormat.decimalPattern().format(
              widget.yesterdayData.result.todayCases,
            ),
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
            value: widget.twoDaysAgoData.result.todayCases.toDouble(),
            title: NumberFormat.decimalPattern().format(
              widget.twoDaysAgoData.result.todayCases,
            ),
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
