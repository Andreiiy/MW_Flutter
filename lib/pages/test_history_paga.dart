import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_world/localization/language_constants.dart';
import 'package:math_world/math_generator/math_generator.dart';
import 'package:math_world/math_generator/models/point.dart';
import 'package:math_world/router/route_constants.dart';

class TestHistoryPage extends StatefulWidget {
  Map<String, int> listMonths = {
    "january": 1,
    "february": 2,
    "march": 3,
    "april": 4,
    "may": 5,
    "june": 6,
    "july": 7,
    "august": 8,
    "september": 9,
    "october": 10,
    "november": 11,
    "december": 12,
  };

  MathGenerator generator = new MathGenerator();

  String currentMonth = "january";
  List<Point> currentListPoints = [];

  List<Point> points = [
    Point(dateTimestemp: 1645392340000, number: 80),
    Point(dateTimestemp: 9782964000000, number: 95),
    Point(dateTimestemp: 1645392340000, number: 45),
    Point(dateTimestemp: 1645392340000, number: 10),
    Point(dateTimestemp: 1645392340000, number: 70),
    Point(dateTimestemp: 1645392340000, number: 90),
    Point(dateTimestemp: 1645392340000, number: 30),
    Point(dateTimestemp: 1640392340000, number: 80),
    Point(dateTimestemp: 1640392340000, number: 95),
    Point(dateTimestemp: 1640392340000, number: 45),
    Point(dateTimestemp: 1640392340000, number: 10),
    Point(dateTimestemp: 1640392340000, number: 70),
    Point(dateTimestemp: 1640392340000, number: 30),
    Point(dateTimestemp: 1642392340000, number: 80),
    Point(dateTimestemp: 1642392340000, number: 95),
    Point(dateTimestemp: 1642392340000, number: 45),
    Point(dateTimestemp: 1642392340000, number: 10),
    Point(dateTimestemp: 1642392340000, number: 70),
  ];

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
  int indexList = 1;

  @override
  void initState() {
    widget.currentMonth = widget.listMonths.keys.firstWhere(
            (k) => widget.listMonths[k] == DateTime.now().month,
        orElse: () => "january");
    widget.currentListPoints = getListPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff484443),
      ),
      backgroundColor: Color(0xff256E59),
      body: Container(
        child: Center(
          // margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 0),
                  child: new Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(5.0),
                            bottomLeft: const Radius.circular(5.0),
                            bottomRight: const Radius.circular(5.0),
                            topRight: const Radius.circular(5.0))),
                    child: new Center(
                        child: new Column(children: [
                      new DropdownButton<String>(
                          underline: Text(''),
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Center(child: new Text("0")),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          isExpanded: true,
                          value: widget.currentMonth,
                          onChanged: (newValue) {
                            if (newValue != null)
                              setState(() {
                                widget.currentMonth = newValue;
                                widget.currentListPoints = getListPoints();
                              });
                          },
                          items: buildDropDownMenuItems(
                              widget.listMonths.keys.toList())),
                    ])),
                  )),
              Expanded(
                  child: new PointsChart(
                      data: widget.currentListPoints
                          .map((point) => ChartTest(
                              number: indexList++,
                              points: point.number,
                              barColor: point.number <= 50
                                  ? charts.ColorUtil.fromDartColor(Colors.red)
                                  : point.number < 80
                                      ? charts.ColorUtil.fromDartColor(
                                          Colors.yellow)
                                      : charts.ColorUtil.fromDartColor(
                                          Colors.green)))
                          .toList())),
              FloatingActionButton.extended(
                backgroundColor: Colors.deepOrange,
                onPressed: () {
                  Navigator.pushNamed(context, registrationPage);
                },
                label: Text(
                  getTranslated(context, 'registration') ?? "",
                  style:
                      GoogleFonts.courgette(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(
      List<String> listItems) {
    List<DropdownMenuItem<String>>? items = [];
    for (String listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(
            listItem.toString(),
            style: TextStyle(fontSize: 20),
          ),
          value: listItem.toString(),
        ),
      );
    }
    return items;
  }

  List<Point> getListPoints() {
    var list = widget.points
        .where((point) =>
            DateTime.fromMicrosecondsSinceEpoch(point.dateTimestemp * 1000).month ==
            widget.listMonths[widget.currentMonth])
        .toList();
    DateTime data =  DateTime.fromMicrosecondsSinceEpoch( DateTime.now().millisecondsSinceEpoch * 1000);
    return list;
  }
}

class ChartTest {
  final int number;
  final int points;
  final charts.Color barColor;

  ChartTest(
      {required this.number, required this.points, required this.barColor});
}

class PointsChart extends StatefulWidget {
  final List<ChartTest> data;

  PointsChart({required this.data});

  @override
  _PointsChartState createState() => _PointsChartState();
}

class _PointsChartState extends State<PointsChart> {

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartTest, String>> series = [
      charts.Series(
          id: "points",
          data: widget.data,
          domainFn: (ChartTest series, _) => series.number.toString(),
          measureFn: (ChartTest series, _) => series.points,
          colorFn: (ChartTest series, _) => series.barColor)
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
