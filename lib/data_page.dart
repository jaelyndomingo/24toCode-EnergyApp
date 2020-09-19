import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sustainability_app/change_notifiers.dart';
import 'package:sustainability_app/energy_graph_widget.dart';
import 'package:sustainability_app/oee_score_widget.dart';
import 'package:sustainability_app/oven_button.dart';
import 'package:sustainability_app/counts_graph_widget.dart';
import 'package:sustainability_app/read_csv.dart';

class DataPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      // read all CSV data
      ReadCSV.getOEEData();
      ReadCSV.getOvenData();

      return ChangeNotifierProvider(
          create: (context) => new Oven(0, ReadCSV.oeeScores[0], ReadCSV.energy[0], ReadCSV.counts[0], "7/2/2020"),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    EnergyGraphWidget(),
                    CountsGraphWidget(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    OEEScoreWidget(),
                    OvenButtons(ReadCSV.oeeScores, ReadCSV.energy, ReadCSV.counts),
                  ]
                )
              ]
          )
        )
      );
    }
}