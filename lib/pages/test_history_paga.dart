import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/math_generator.dart';
import 'package:math_world/router/route_constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class TestHistoryPage extends StatefulWidget {
  MathGenerator generator = new MathGenerator();

  // List<Point> points = [
  //
  // ];

  final List<ChartTest> data = [

    ChartTest(
      number: 1,
      points: 80,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    ChartTest(
      number: 2,
      points: 95,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    ChartTest(
      number: 3,
      points: 45,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartTest(
      number: 4,
      points: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartTest(
      number: 5,
      points: 70,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    ChartTest(
      number: 6,
      points: 80,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    ChartTest(
      number: 7,
      points: 95,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    ChartTest(
      number: 8,
      points: 45,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartTest(
      number: 9,
      points: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartTest(
      number: 10,
      points: 70,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    ChartTest(
      number: 11,
      points: 80,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
    ChartTest(
      number: 12,
      points: 95,
      barColor: charts.ColorUtil.fromDartColor(Colors.green),
    ),
    ChartTest(
      number: 13,
      points: 45,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartTest(
      number: 14,
      points: 10,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartTest(
      number: 15,
      points: 70,
      barColor: charts.ColorUtil.fromDartColor(Colors.yellow),
    ),
  ];

  @override
  _TestHistoryPageState createState() => _TestHistoryPageState();
}

class _TestHistoryPageState extends State<TestHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
        backgroundColor: Color(0xff484443),),
      backgroundColor: Color(0xff256E59),
      body: Container(
        child:
              Center(
          // margin: EdgeInsets.all(20),
          child:Column(
            children: [
              SizedBox(height: 20,),

              Expanded(child:new PointsChart( data: widget.data,)),
              FloatingActionButton.extended(
                backgroundColor: Colors.deepOrange,
                onPressed: () {
                  Navigator.pushNamed(context, registrationPage);
                },
                label: Text(
                  getTranslated(context, 'registration')??"",
                  style: GoogleFonts.courgette(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),

      ),
    );
  }

}

class ChartTest {
  final int number;
  final int points;
  final charts.Color barColor;

  ChartTest(
      {
         required this.number,
         required this.points,
         required this.barColor
      }
      );
}


class PointsChart extends StatelessWidget {
  final List<ChartTest> data;

  PointsChart({required this.data});
  @override
  Widget build(BuildContext context) {

    List<charts.Series<ChartTest, String>> series = [
      charts.Series(
          id: "points",
          data: data,
          domainFn: (ChartTest series, _) => series.number.toString(),
          measureFn: (ChartTest series, _) => series.points,
          colorFn: (ChartTest series, _) => series.barColor
      )
    ];

    return Expanded(

      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Yearly Growth in the Flutter Community",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }

}