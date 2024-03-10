part of super_time_line;

class TimelineScale {
  // --------------------------------------------------------------------------

  const TimelineScale();

  // --------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const double rulerLineThickness = 1;
  // --------------------
  static const double pinchingScaleFactor = 0.1;
  static const double minTimelineScale = 0.7;
  static const double maxTimelineScale = 3;
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
  static double getPixelsBySeconds({
    required double seconds,
    required double secondPixelLength,
  }){

    // s = t / 10
    // t = p / w
    // s = (p / w) / 10
    // 10.s.w = p

    final double _tenthWidth = TimelineScale.tenthPixelLength(
      secondPixelLength: secondPixelLength,
    );

    return _tenthWidth * seconds * 10;
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

  /// SCROLLING - SCALING

  // --------------------
  static void scrollManually({
    required ScrollController scrollController,
    required ScaleUpdateDetails details,
  }){
    final double _goTo = scrollController.offset - details.focalPointDelta.dx;
    scrollController.jumpTo(_goTo);
  }
  // --------------------
  static void scrollToSecond({
    required double second,
    required double secondPixelLength,
    required ScrollController scrollController,
  }){

    final double _goTo = TimelineScale.getPixelsBySeconds(
      seconds: second,
      secondPixelLength: secondPixelLength,
    );
    scrollController.jumpTo(_goTo);

  }
  // --------------------
  static void scaleTimeline({
    required ScaleUpdateDetails details,
    required bool mounted,
    required ValueNotifier<double> accumulatedScale,
    required ValueNotifier<double> previousScale,
    required ValueNotifier<double> secondPixelLength,
    required ValueNotifier<double> scale,
    required ScrollController scrollController,
    required double totalSeconds,
  }){

    if (mounted == true){

      final double _oldSecond = TimelineScale.getSecondsByPixel(
        secondPixelLength: secondPixelLength.value,
        pixels: scrollController.position.pixels,
        totalSeconds: totalSeconds,
      );

      final double scaleDelta = (details.horizontalScale - previousScale.value) * pinchingScaleFactor;
      accumulatedScale.value += scaleDelta;
      double _newScale = scale.value + accumulatedScale.value;
      _newScale = _newScale.clamp(minTimelineScale, maxTimelineScale);

      scale.value  = _newScale;
      secondPixelLength.value = 80 * scale.value;
      previousScale.value = details.horizontalScale;

      TimelineScale.scrollToSecond(
        second: _oldSecond,
        secondPixelLength: secondPixelLength.value,
        scrollController: scrollController,
      );

    }

  }
  // --------------------------------------------------------------------------

  /// WIDTHS

  // --------------------
  static double totalAvailableWidth({
    required double totalSeconds,
    required double secondPixelLength,
  }){
    final double _totalSecondsLength = TimelineScale.totalSecondsPixelLength(
      totalSeconds: totalSeconds,
      secondPixelLength: secondPixelLength,
    );
    final double _blankWidth = TimelineScale.blankZoneWidth();
    return _blankWidth + _totalSecondsLength + _blankWidth;
  }
  // --------------------
  static double blankZoneWidth(){
    final double _timelineBoxWidth = Scale.screenWidth(getMainContext());
    return _timelineBoxWidth * 0.5;
  }
  // --------------------
  static int getTotalTenths({
    required double totalSeconds,
  }){
    return (totalSeconds * 10).toInt();
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
