import 'package:coffee_house_admin_version/components/components.dart';
import 'package:coffee_house_admin_version/components/constants.dart';
import 'package:coffee_house_admin_version/style/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
        gridData:  FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    touchTooltipData: BarTouchTooltipData(
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: defColor,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta,) {
    const style = TextStyle(
      color: defColor,
      fontSize: 12,
    );
    String text = '';

    for(int a = 0 ; allItems.length> a  ; a++){
      if(value.toInt() == a){
        text = allItems[a].drinkName;
      }
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles:  AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles:  AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles:  AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );


  LinearGradient get _barsGradient => const LinearGradient(
    colors: [

      Colors.blue,
      Colors.lightBlueAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );


  List<BarChartGroupData>  get barGroups => List.generate(allItems.length, (index) {
    return    BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: allItems[index].numberOfTimesSold.toDouble(),
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    );
  });
}

class BestSellerItem extends StatefulWidget {
  const BestSellerItem({super.key});

  @override
  State<StatefulWidget> createState() => BestSellerItemState();
}

class BestSellerItemState extends State<BestSellerItem> {
  @override
  Widget build(BuildContext context) {
    return  AspectRatio(
      aspectRatio: 1.7,
      child: Container(
        padding: const EdgeInsets.only(top: 10,left: 10,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
                color: secColor
          ),
          child: Column(
            children: [
              defText(text: 'Number of seller',textColor: backgroundColor),
              const SizedBox(height: 35,),
              const Expanded(child: _BarChart()),
            ],
          )),
    );
  }
}


