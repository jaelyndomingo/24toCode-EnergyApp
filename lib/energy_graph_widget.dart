import 'dart:core';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sustainability_app/change_notifiers.dart';
import 'package:sustainability_app/data_models.dart';
import 'package:sustainability_app/read_csv.dart';
import 'package:sustainability_app/date_buttons.dart';
import 'package:provider/provider.dart';

class EnergyGraph extends StatefulWidget {
  @override
  _EnergyGraphState createState() => _EnergyGraphState();
  
}

class _EnergyGraphState extends State<EnergyGraph> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Oven>(
      builder: (context, oven, _) => new charts.TimeSeriesChart(
        _createSampleData(oven),
        animate: true,
        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
        // should create the same type of [DateTime] as the data provided. If none
        // specified, the default creates local date time.
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }

  static List<charts.Series<OvenEnergy, DateTime>> _createSampleData(Oven oven) {
    final data = oven.energyData[oven.date];
    final Color color = Colors.lightBlue;

    return [
      new charts.Series<OvenEnergy, DateTime>(
        id: 'Oven Energy',
        domainFn: (OvenEnergy oven, _) => oven.time,
        measureFn: (OvenEnergy oven, _) => oven.energy,
        colorFn: (_, __) => charts.Color(r: color.red, g: color.green, b: color.blue, a: color.alpha),
        data: data,
      )];
  }
}

class ChartTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Oven>(
      builder: (context, oven, _) => Text("Oven ${oven.number + 1} (kW h)",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: "Avenir",
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightBlue,
        ),
      )
    );
  }

}

class EnergyGraphWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 610,
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
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 570,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Title Text Box
                        Container(
                            width: 175,
                            height: 30,
                            child: ChartTitle(),
                        ),
                        DateButtons(ReadCSV.dates),
                      ],
                    ),
                  ),
                  /// Energy Line Chart
                  Container(
                    width: 544,
                    height: 240,
                    child: EnergyGraph(),
                  )
                ]
            )
        )
    );
  }

}