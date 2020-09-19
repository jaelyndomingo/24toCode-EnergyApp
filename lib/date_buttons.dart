import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sustainability_app/change_notifiers.dart';
import 'package:provider/provider.dart';

class DateButtons extends StatelessWidget {
  List<String> dates;
  int currentDate = 0;

  DateButtons(this.dates);

  void _changeDate(int change, Oven oven) {
    if (currentDate >= 0) {
      currentDate += change;
    }

    /// send state to one_score_widget
    oven.date = dates[currentDate];
    //print(dates[currentDate]);
  }

  @override
  Widget build(BuildContext context) {
    final oven = Provider.of<Oven>(context);

    return Container(
      width: 200,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Text("${dates[currentDate]}",
              style: TextStyle(
                color: Colors.lightBlue,
                fontFamily: "Avenir",
                fontSize: 16.0,
                ),
            ),
            padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
          ),
          /// back button
          Container(
            width: 50,
            height: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                _changeDate(-1, oven);
              },
              child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white
              ),
            ),
          ),
          /// forward button
          Container(
            width: 50,
            height: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                _changeDate(1, oven);
              },
              child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white
              ),
            ),
          ),
        ]
      )
    );
  }

}