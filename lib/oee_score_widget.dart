import 'dart:core';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sustainability_app/change_notifiers.dart';
import 'package:provider/provider.dart';

/// OEE Data
class OEEData {
  final int component;
  final double score;
  final charts.Color color;

  OEEData(this.component, this.score, Color color)
      : this.color = charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class OEEChart extends StatefulWidget {

  _OEEChartState createState() => _OEEChartState();

}

class _OEEChartState extends State<OEEChart> {
  static double oeeScore;

  @override
  Widget build(BuildContext context) {

    return Consumer<Oven>(
      builder: (context, oven, _) => Stack(
        children: <Widget>[charts.PieChart(createData(oven),
          animate: true,
          defaultRenderer: new charts.ArcRendererConfig(arcWidth: 20)),
          Center(
          child: Text("${oeeScore.toStringAsFixed(2)}%",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                  fontFamily: "Avenir",
                  fontWeight: FontWeight.bold,
                ),
            )
          )
        ],
    ),
    );
  }

  static List<charts.Series<OEEData, int>> createData(Oven oven) {
    final oee = oven.oeeData[oven.date];

    final data = [
      new OEEData(0, oee.availabilityScore * 100.0, Colors.blue),
      new OEEData(1, oee.qualityScore, Colors.grey),
      new OEEData(2, oee.performanceScore, Colors.lightBlueAccent),
    ];

    oeeScore = oee.score * 100;

    return [
      new charts.Series<OEEData, int>(
      id: 'OEE Score',
      domainFn: (OEEData score, _) => score.component,
      measureFn: (OEEData score, _) => score.score,
      colorFn: (OEEData score, _) => score.color,
      data: data,
    )];
  }

}

class OEELabels extends StatefulWidget {
  @override
  _OEELabelsState createState() => _OEELabelsState();

}

class _OEELabelsState extends State<OEELabels> {


  @override
  Widget build(BuildContext context) {
    return Consumer<Oven>(
      builder: (context, oven, _) =>
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      width: 250,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          Container(
                            child: Text("Availability:  ${oven.oeeData[oven.date].availabilityScore.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: "Avenir",
                                fontSize: 16.0,
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                          ),
                        ],
                      )
                  ),
                  Container(
                      width: 250,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          Container(
                            child: Text("Rate of Quality:  ${oven.oeeData[oven.date].qualityScore.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Avenir",
                                fontSize: 16.0,
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                          ),
                        ],
                      )
                  ),
                  Container(
                      width: 250,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          Container(
                            child: Text("Performance Efficiency: ${oven.oeeData[oven.date].performanceScore.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontFamily: "Avenir",
                                fontSize: 16.0,
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
                          ),
                        ],
                      )
                  ),
                ]
              )
          )
      );
  }

}

class OEEScoreWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 400,
    height: 375,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 6,
    blurRadius: 10,
    offset: Offset(0, 3), // changes position of shadow
    ),
    ],
    ),
      margin: EdgeInsets.fromLTRB(3.0, 30.0, 3.0, 35.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// Title Text Box
            Container(
              width: 350,
              height: 40,
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),

              child: Text("OEE Score",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                ),
              )
            ),
            /// OEE Donut Chart
            Container(
              width: 200,
              height: 200,
              child: OEEChart(),
            ),
            /// Labels
            Container(
              width: 250,
              height: 130,
              child: OEELabels(),
            ),
          ]
        )
      )
    );
  }


}