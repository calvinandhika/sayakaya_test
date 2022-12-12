import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sayakaya_test/models/country_model.dart';
import 'package:sayakaya_test/widgets/legend_widget.dart';

class CovidBarChart extends StatelessWidget {
  final CountryModelData twoDaysAgoData;
  final CountryModelData yesterdayData;
  final CountryModelData todayData;

  const CovidBarChart({
    super.key,
    required this.twoDaysAgoData,
    required this.yesterdayData,
    required this.todayData,
  });

  static const pilateColor = Color(0xff632af2);
  static const cyclingColor = Color(0xffffb3ba);
  static const quickWorkoutColor = Color(0xff578eff);
  static const betweenSpace = 0.1;

  BarChartGroupData generateGroupData(
    int x, {
    required double twoDaysAgo,
    required double yesterday,
    required double today,
  }) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: twoDaysAgo,
          color: pilateColor,
          width: 15,
        ),
        BarChartRodData(
          fromY: twoDaysAgo + betweenSpace,
          toY: twoDaysAgo + betweenSpace + yesterday,
          color: quickWorkoutColor,
          width: 15,
        ),
        BarChartRodData(
          fromY: twoDaysAgo + betweenSpace + yesterday + betweenSpace,
          toY: twoDaysAgo + betweenSpace + yesterday + betweenSpace + today,
          color: cyclingColor,
          width: 15,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff787694),
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Today Cases';
        break;
      case 1:
        text = 'Today Deaths';
        break;
      case 2:
        text = 'Active';
        break;
      case 3:
        text = 'Critical';
        break;

      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Covid Cases',
              style: TextStyle(
                color: Color(0xff171547),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LegendsListWidget(
              legends: [
                Legend('Two Days Ago', pilateColor),
                Legend('Yesterday', quickWorkoutColor),
                Legend('Today', cyclingColor),
              ],
            ),
            const SizedBox(height: 14),
            AspectRatio(
              aspectRatio: 2,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 25,
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(enabled: false),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: [
                    generateGroupData(
                      0,
                      twoDaysAgo: twoDaysAgoData.result.todayCases / 10,
                      yesterday: yesterdayData.result.todayCases / 10,
                      today: todayData.result.todayCases / 10,
                    ),
                    generateGroupData(
                      1,
                      twoDaysAgo: twoDaysAgoData.result.todayDeaths / 1,
                      yesterday: yesterdayData.result.todayDeaths / 1,
                      today: todayData.result.todayDeaths / 1,
                    ),
                    generateGroupData(
                      2,
                      twoDaysAgo: twoDaysAgoData.result.active / 5000,
                      yesterday: yesterdayData.result.active / 5000,
                      today: todayData.result.active / 5000,
                    ),
                    generateGroupData(
                      3,
                      twoDaysAgo: twoDaysAgoData.result.critical / 100,
                      yesterday: yesterdayData.result.critical / 100,
                      today: todayData.result.critical / 100,
                    ),
                  ],
                  maxY: 25 + (betweenSpace * 3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
