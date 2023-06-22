import 'package:darak_project/helpers/colors_helper.dart';
import 'package:darak_project/helpers/texts_helper.dart';
import 'package:darak_project/module/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBaragraph extends StatelessWidget {
  final List monthlySummary;

  const MyBaragraph({Key? key, required this.monthlySummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        janAmount: monthlySummary[0],
        febAmount: monthlySummary[1],
        marchAmount: monthlySummary[2],
        aprilAmount: monthlySummary[3],
        mayAmount: monthlySummary[4],
        junAmount: monthlySummary[5],
        julyAmount: monthlySummary[6],
        augAmount: monthlySummary[7],
        sepAmount: monthlySummary[8],
        octAmount: monthlySummary[9],
        novAmount: monthlySummary[10],
        decAmount: monthlySummary[11]);
    myBarData.initializedBarData();
    return BarChart(BarChartData(
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true))
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        maxY: 50,
        minY: 0,
        barGroups: myBarData.barData
            .map((e) => BarChartGroupData(x: e.x, barRods: [
                  BarChartRodData(
                      toY: e.y,
                      color: ColorHelper.primaryColor,
                      width: 10,
                      borderRadius: BorderRadius.circular(2),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, toY: 50, color: Colors.grey[100]))
                ]))
            .toList()));
  }

  Widget getBottomTile(double value, TitleMeta meta) {
    var style = TextStyle(
        fontFamily: TextHelper.satoshiBold,
        fontSize: 14,
        color: ColorHelper.greyColor);
    late Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
          'Jan',
          style: style,
        );
        break;
      case 1:
        text = Text(
          'Feb',
          style: style,
        );
        break;
      case 2:
        text = Text(
          'Mar',
          style: style,
        );
        break;
      case 3:
        text = Text(
          'Apr',
          style: style,
        );
        break;
      case 4:
        text = Text(
          'May',
          style: style,
        );
        break;
      case 5:
        text = Text(
          'Jun',
          style: style,
        );
        break;
      case 6:
        text = Text(
          'Jul',
          style: style,
        );
        break;
      case 7:
        text = Text(
          'Aug',
          style: style,
        );
        break;
      case 8:
        text = Text(
          'Sep',
          style: style,
        );
        break;
      case 9:
        text = Text(
          'Oct',
          style: style,
        );
        break;
      case 10:
        text = Text(
          'Nov',
          style: style,
        );
        break;
      case 11:
        text = Text(
          'Dec',
          style: style,
        );
        break;
      case 12:
        text = Text(
          'Jan',
          style: style,
        );
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
