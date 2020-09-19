import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sustainability_app/change_notifiers.dart';
import 'package:sustainability_app/data_models.dart';
import 'package:provider/provider.dart';

class OvenButton {
  Color buttonColor;
  Color textColor;

  OvenButton(this.buttonColor, this.textColor);
}

class OvenButtons extends StatefulWidget {
  List<Map<String, OEEScore>> oeeScores;
  List<Map<String, List<OvenEnergy>>> energy;
  List<Map<String, List<OvenCounts>>> counts;

  OvenButtons(this.oeeScores, this.energy, this.counts);

  @override
  _OvenButtonsState createState() => _OvenButtonsState(oeeScores, energy, counts);
}

class _OvenButtonsState extends State<OvenButtons> {
  List<OvenButton> buttons = <OvenButton>[OvenButton(Colors.lightBlue, Colors.white),
                                          OvenButton(Colors.white, Colors.lightBlue),
                                          OvenButton(Colors.white, Colors.lightBlue)];
  List<Map<String, OEEScore>> oeeScores;
  List<Map<String, List<OvenEnergy>>> energy;
  List<Map<String, List<OvenCounts>>> counts;
  _OvenButtonsState(this.oeeScores,this.energy, this.counts);

  void _selectOven(int index, Oven oven) {
    setState(() {
      for (int buttonIndex = 0; buttonIndex < buttons.length; buttonIndex++) {
        if (buttonIndex == index) {
          // button selected
          buttons[buttonIndex].buttonColor = Colors.lightBlue;
          buttons[buttonIndex].textColor = Colors.white;
        } else {
          buttons[buttonIndex].buttonColor = Colors.white;
          buttons[buttonIndex].textColor = Colors.lightBlue;
        }
      }
    });

    // send state to one_score_widget
    oven.number = index;
    oven.oeeData = oeeScores[index];
    oven.energyData = energy[index];
    oven.countsData = counts[index];
  }

  @override
  Widget build(BuildContext context) {
    final oven = Provider.of<Oven>(context);

    return Container(
      width: 400,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MaterialButton(
            onPressed: () {
              _selectOven(0, oven);
            },
            color: buttons[0].buttonColor,
            textColor: buttons[0].textColor,
            child: Center(
                child: Text('Oven 1')
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent, width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
            
          ),
          MaterialButton(
            onPressed: () {
              _selectOven(1, oven);
            },
            color: buttons[1].buttonColor,
            textColor: buttons[1].textColor,
            child: Center(
                child: Text('Oven 2')
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent, width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
          ),
          MaterialButton(
            onPressed: () {
              _selectOven(2, oven);
            },
            color: buttons[2].buttonColor,
            textColor: buttons[2].textColor,
            child: Center(
                child: Text('Oven 3')
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent, width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
          ),
        ],
      ),
    );
  }
}