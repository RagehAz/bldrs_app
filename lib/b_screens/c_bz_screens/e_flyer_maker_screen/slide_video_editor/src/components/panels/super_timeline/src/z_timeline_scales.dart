part of super_time_line;

class TimelineScale {
  // --------------------------------------------------------------------------

  const TimelineScale();

  // --------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const double rulerLineThickness = 1;
  // --------------------------------------------------------------------------

  /// PIXEL TO SECONDS

  // --------------------
  static double getSecondsByPixel({
    required double pixels,
    required double secondPixelLength,
    required double totalSeconds,
  }){

    final double _tenthWidth = TimelineScale.tenthPixelLength(
      secondPixelLength: secondPixelLength,
    );

    final double _tenths =  pixels / _tenthWidth;
    double _seconds = _tenths / 10;

    final double _maxSecond = totalSeconds;
    const double _minSecond = 0;

    if (_seconds >= _maxSecond){
      _seconds = _maxSecond;
    }
    if (_seconds <= _minSecond){
      _seconds = 0;
    }

    return Numeric.roundFractions(_seconds, 1)!;
  }
  // --------------------
  static double totalSecondsPixelLength({
    required double totalSeconds,
    required double secondPixelLength,
  }){
    return totalSeconds * secondPixelLength;
  }
  // --------------------
  static double tenthPixelLength({
    required double secondPixelLength,
  }){
    return secondPixelLength / 10;
  }
  // --------------------------------------------------------------------------

  /// BLANK AREA

  // --------------------
  static double blankZoneWidth(){
    final double _timelineBoxWidth = Scale.screenWidth(getMainContext());
    return _timelineBoxWidth * 0.5;
  }
  // --------------------------------------------------------------------------

  /// TIME BOXES

  // --------------------
  static List<double> createTimeBoxes({
    required double seconds,
  }){
    final List<double> _output = [];

    double _seconds = seconds;
    final int _rounds = _seconds.ceil();

    for (int i = 0; i < _rounds; i++){

      if (_seconds >= 1){
        _output.add(1);
      }
      else {
        _output.add(_seconds);
      }
      _seconds--;

    }

    return _output;
  }
  // --------------------------------------------------------------------------
  void x(){}
}
