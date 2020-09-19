import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:sustainability_app/data_models.dart';

class ReadCSV {
  static List<File> dailyOvenFiles = <File>[
    new File('/Users/jaelyndomingo/Downloads/24toCode/daily/sm1_oven_daily.csv'),
    new File('/Users/jaelyndomingo/Downloads/24toCode/daily/sm4_oven_daily.csv'),
    new File('/Users/jaelyndomingo/Downloads/24toCode/daily/sm7_oven_daily.csv')];
  static List<File> minuteOvenFiles = <File>[
    new File('/Users/jaelyndomingo/Downloads/24toCode/minute_data/sm1_15_minute.csv'),
    new File('/Users/jaelyndomingo/Downloads/24toCode/minute_data/sm4_15_minute.csv'),
    new File('/Users/jaelyndomingo/Downloads/24toCode/minute_data/sm7_15_minute.csv')];

  static List<Map<String, OEEScore>> oeeScores = new List<Map<String, OEEScore>>();
  static List<Map<String, List<OvenEnergy>>> energy = new List<Map<String, List<OvenEnergy>>>();
  static List<Map<String, List<OvenCounts>>> counts = new List<Map<String, List<OvenCounts>>>();
  static List<String> dates = new List<String>();

  static void getOEEData() {
    for (int index = 0; index < dailyOvenFiles.length; index++){
      Map<String, OEEScore> oeeData = new Map<String, OEEScore>();
      File file = dailyOvenFiles[index];

      Stream<List> inputStream = file.openRead();

      inputStream
          .transform(utf8.decoder)
          .transform(new LineSplitter())
          .listen((String line) {
        List row = line.split(',');

        List<String> timestamp = row[2].split(' ');
        String date = timestamp[0];
        double availability = double.parse(row[7]);
        double performance = double.parse(row[8]);
        double score = double.parse(row[9]);

        if (index == 0) {
          dates.add(date);
        }
        oeeData[date] = new OEEScore(availability, 1, performance, score); // quality is always 1
        },
        onDone: () {
          print("read oee data is done!");
        },
        onError: (e) {
          print(e.toString());
        });

      oeeScores.add(oeeData);
    }
  }

  static void getOvenData() {
    for (int index = 0; index < minuteOvenFiles.length; index++){
      Map<String, List<OvenEnergy>> energyData = new Map<String, List<OvenEnergy>>();
      Map<String, List<OvenCounts>> countsData = new Map<String, List<OvenCounts>>();
      File file = minuteOvenFiles[index];

      Stream<List> inputStream = file.openRead();

      inputStream
          .transform(utf8.decoder)
          .transform(new LineSplitter())
          .listen((String line) {
        List row = line.split(',');

        String date = row[2];
        String time = row[1];
        double energy = double.parse(row[3]);
        int count = int.parse(row[4], onError: (source) => 0);
        DateTime dateTime = getDateTime(date, time);

        if (energyData[date] == null) {
          energyData[date] = new List<OvenEnergy>();
        }
        if (countsData[date] == null) {
          countsData[date] = new List<OvenCounts>();
        }
        energyData[date].add(new OvenEnergy(dateTime, energy));
        countsData[date].add(new OvenCounts(dateTime, count));
      },
          onDone: () {
            print("read oven data is done!");
          },
          onError: (e) {
            print(e.toString());
          });

      energy.add(energyData);
      counts.add(countsData);
    }
  }

  static DateTime getDateTime(String date, String time) {
    List<String> ymd = date.split('/');
    List<String> hm = time.split(':');

    return new DateTime(int.parse(ymd[2]), int.parse(ymd[0]), int.parse(ymd[1]), int.parse(hm[0]), int.parse(hm[1]));
  }

}