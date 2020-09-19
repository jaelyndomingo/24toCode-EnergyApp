import 'package:flutter/foundation.dart';
import 'package:sustainability_app/data_models.dart';

/**
 * Change Notifiers
 *
 * This class holds all the change notifiers that are used to notify listeners about changes made to
 * the class in one widget that is the provider to another widget that is the listener.
 */

/*
  Oven
  class to send oven data to OEE Widget when certain oven is selected
*/
class Oven with ChangeNotifier {
  int _number;
  Map<String, OEEScore> _oeeData;
  Map<String, List<OvenEnergy>> _energyData;
  Map<String, List<OvenCounts>> _countsData;
  String _date;

  Oven(this._number, this._oeeData, this._energyData, this._countsData, this._date);

  int get number => _number;
  Map<String, OEEScore> get oeeData => _oeeData;
  Map<String, List<OvenEnergy>> get energyData => _energyData;
  Map<String, List<OvenCounts>> get countsData => _countsData;
  String get date => _date;

  set number(int index) {
    _number = index;
    notifyListeners();
  }

  set oeeData(Map<String, OEEScore> data) {
    _oeeData = data;
    notifyListeners();
  }

  set energyData(Map<String, List<OvenEnergy>> data) {
    _energyData = data;
    notifyListeners();
  }

  set countsData(Map<String, List<OvenCounts>> data) {
    _countsData = data;
    notifyListeners();
  }

  set date(String day) {
    _date = day;
    notifyListeners();
  }
}

class EnergyOven with ChangeNotifier {
  int _number;
  Map<String, List<OvenEnergy>> _energyData;
  String _date;

  EnergyOven(this._number, this._energyData, this._date);

  int get number => _number;
  Map<String, List<OvenEnergy>> get energyData => _energyData;
  String get date => _date;
}

class CountsOven with ChangeNotifier {
  int _number;
  Map<String, List<OvenCounts>> _countsData;
  String _date;

  CountsOven(this._number, this._countsData, this._date);

  int get number => _number;
  Map<String, List<OvenCounts>> get countsData => _countsData;
  String get date => _date;
}