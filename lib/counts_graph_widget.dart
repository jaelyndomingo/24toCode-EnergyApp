import 'dart:core';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sustainability_app/change_notifiers.dart';
import 'package:sustainability_app/data_models.dart';
import 'package:sustainability_app/read_csv.dart';
import 'package:sustainability_app/date_buttons.dart';
import 'package:provider/provider.dart';

class CountsGraph extends StatefulWidget {
  @override
  _CountsGraphState createState() => _CountsGraphState();

}

class _CountsGraphState extends State<CountsGraph> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Oven>(
      builder: (context, oven, _) => new charts.TimeSeriesChart(
        _createSampleData(oven),
        animate: true,
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        defaultRenderer: new charts.BarRendererConfig<DateTime>(),
        defaultInteractions: false,
      ),
    );
  }

  static List<charts.Series<OvenCounts, DateTime>> _createSampleData(Oven oven) {
    final data = oven.countsData[oven.date];
    final Color color = Colors.lightBlueAccent;

    return [
      new charts.Series<OvenCounts, DateTime>(
        id: 'Oven Counts',
        domainFn: (OvenCounts oven, _) => oven.time,
        measureFn: (OvenCounts oven, _) => oven.counts,
        colorFn: (_, __) => charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha),
        data: data,
      )];
  }
}

class CountsGraphWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 610,
        height: 240,
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
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 540,
                    height: 30,
                    child: Text("Product Count",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  /// Counts Line Chart
                  Container(
                    width: 544,
                    height: 180,
                    child: CountsGraph(),
                  )
                ]
            )
        )
    );
  }

}