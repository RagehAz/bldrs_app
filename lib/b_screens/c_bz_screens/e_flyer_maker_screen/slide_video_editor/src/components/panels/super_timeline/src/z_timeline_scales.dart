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
  static const double minTimelineScale = 0.5;
  static const double maxTimelineScale = 3;
  static const double initialSecondPixelLength = 80;
  // --------------------------------------------------------------------------

  /// PIXEL TO SECONDS

  // --------------------
  static double getSecondsByPixel({
    required double pixels,
    required double secondPixelLength,
    required double totalSeconds,
  }){

    final double _seconds = pixels / secondPixelLength;
    return _seconds; // Numeric.roundFractions(_seconds, 2)!;

    // final double _tenthWidth = TimelineScale.tenthPixelLength(
    //   secondPixelLength: secondPixelLength,
    // );

    // final double _tenths =  pixels / _tenthWidth;
    // double _seconds = _tenths / 10;
    //
    // final double _maxSecond = totalSeconds;
    // const double _minSecond = 0;
    //
    // _seconds.clamp(_minSecond, _maxSecond);
    //
    // /// if (_seconds >= _maxSecond){
    // ///   _seconds = _maxSecond;
    // /// }
    // /// if (_seconds <= _minSecond){
    // ///   _seconds = 0;
    // /// }
    //
    // return _seconds; // Numeric.roundFractions(_seconds, 2)!;
  }
  // --------------------
  static double getPixelsBySeconds({
    required double seconds,
    required double secondPixelLength,
  }){

    /// t : total time in seconds [seconds]
    /// s : tenth pixel length [tenthWidth]
    /// w : one second pixel length
    /// p : total pixels length

    return seconds * secondPixelLength;

    // s = t / 10
    // t = p / w
    // s = (p / w) / 10
    // 10.s.w = p

    // final double _tenthWidth = TimelineScale.tenthPixelLength(
    //   secondPixelLength: secondPixelLength,
    // );
    //
    // return _tenthWidth * seconds * 10;
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
  static void jumpToSecond({
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
      secondPixelLength.value = initialSecondPixelLength * scale.value;
      previousScale.value = details.horizontalScale;

      TimelineScale.jumpToSecond(
        second: _oldSecond,
        secondPixelLength: secondPixelLength.value,
        scrollController: scrollController,
      );

    }

  }
  // --------------------
  static Future<void> scrollFromTo({
    required double fromSecond,
    required double toSecond,
    required double secondPixelLength,
    required ScrollController controller,
  }) async {

    blog('allah ? : $secondPixelLength');

    final double _endPixel = TimelineScale.getPixelsBySeconds(
      seconds: toSecond,
      secondPixelLength: secondPixelLength,
    );

    blog('_endPixel : $_endPixel');


    jumpToSecond(
      second: fromSecond,
      secondPixelLength: secondPixelLength,
      scrollController: controller,
    );

    final int _milliseconds = ((toSecond - fromSecond) * 1000).toInt();
    blog('_milliseconds $_milliseconds');

    await Sliders.scrollTo(
      controller: controller,
      offset: _endPixel,
      duration: Duration(milliseconds: _milliseconds),
      curve: Curves.linear,
    );

    blog('haaa');

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
    return (totalSeconds * 10).ceil();
  }
  // --------------------
  static double getSelectorInnerWidth({
    required double totalSeconds,
    required double secondPixelLength,
    required double handleWidth,
  }){

    final double _selectorBlankWidth = TimelineScale.blankZoneWidth() - handleWidth;

    final double _totalAvailableWidth = TimelineScale.totalAvailableWidth(
      totalSeconds: totalSeconds,
      secondPixelLength: secondPixelLength,
    );

    return _totalAvailableWidth - (_selectorBlankWidth*2);
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
}
