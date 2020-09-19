/**
 * Data Models
 *
 * baslkdfjlsdjf
 */

/*
  OEE Score
  class to handle information for the OEE Score Widget
*/
class OEEScore {
  double _availabilityScore;
  double _qualityScore;
  double _performanceScore;
  double _score;

  OEEScore(this._availabilityScore, this._qualityScore, this._performanceScore, this._score);

  double get availabilityScore => _availabilityScore;
  double get qualityScore => _qualityScore;
  double get performanceScore => _performanceScore;
  double get score => _score;
}

class OvenEnergy {
  DateTime _time;
  double _energy;

  OvenEnergy(this._time, this._energy);

  DateTime get time => _time;
  double get energy => _energy;
}

class OvenCounts {
  DateTime _time;
  int _counts;

  OvenCounts(this._time, this._counts);

  DateTime get time => _time;
  int get counts => _counts;
}