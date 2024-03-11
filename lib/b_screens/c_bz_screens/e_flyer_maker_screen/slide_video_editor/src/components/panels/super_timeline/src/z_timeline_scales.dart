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
  // --------------------
  static const double handleWidth = 15;
  static const double handleCorner = handleWidth * 0.5;
  static const double selectorHorizontalLineThickness = 2;
  static const Color selectorColor = Colorz.yellow255;

  // --------------------------------------------------------------------------

  /// PIXEL TO SECONDS

  // --------------------
  static double getSecondsByPixel({
    required double pixels,
    required double secondPixelLength,
  }){

    final double _seconds = pixels / secondPixelLength;
    return _seconds; // Numeric.roundFractions(_seconds, 2)!;

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
    required double startTime,
    required double endTime,
    required bool scrollingIsLimitedBetweenHandles,
    required double secondPixelLength,
  }){

    double _goTo = scrollController.offset - details.focalPointDelta.dx;

    if (scrollingIsLimitedBetweenHandles == true){
      _goTo = _goTo.clamp(
          getPixelsBySeconds(
              seconds: startTime,
              secondPixelLength: secondPixelLength
          ),
          getPixelsBySeconds(
              seconds: endTime,
              secondPixelLength: secondPixelLength
          )
      );
    }

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
  }){

    if (mounted == true){

      final double _oldSecond = TimelineScale.getSecondsByPixel(
        secondPixelLength: secondPixelLength.value,
        pixels: scrollController.position.pixels,
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
  // --------------------
  static void handlePushCurrentTime({
    required double secondPixelLength,
    required ScrollController scrollController,
    required double startS,
    required double endS,
  }){

    final double _currentSecond = TimelineScale.getSecondsByPixel(
      secondPixelLength: secondPixelLength,
      pixels: scrollController.position.pixels,
    );

    if (startS >= _currentSecond){
      TimelineScale.jumpToSecond(
        scrollController: scrollController,
        second: startS,
        secondPixelLength: secondPixelLength,
      );
    }

    if (endS <= _currentSecond){
      TimelineScale.jumpToSecond(
        scrollController: scrollController,
        second: endS,
        secondPixelLength: secondPixelLength,
      );
    }

  }
  // --------------------------------------------------------------------------

  /// HANDLE DRAGGING

  // --------------------
  static double getLeftHandleDragPixels({
    required DragUpdateDetails details,
    required double leftPx,
    required double rightPx,
    required double min,
    required double max,
    required double minimumDurationInPixels,
  }){

    double newPosition = leftPx + details.primaryDelta!;

    newPosition = newPosition.clamp(min, max);

    if (newPosition >= rightPx - minimumDurationInPixels){
      newPosition = rightPx - minimumDurationInPixels;
    }

    return newPosition;
  }
  // --------------------
  static double getRightHandleDragPixels({
    required DragUpdateDetails details,
    required double leftPx,
    required double rightPx,
    required double min,
    required double max,
    required double minimumDurationInPixels,
  }){

    double newPosition = rightPx + details.primaryDelta!;

    newPosition = newPosition.clamp(min, max);

    if (newPosition <= leftPx + minimumDurationInPixels){
      newPosition = leftPx + minimumDurationInPixels;
    }

    return newPosition;
  }
  // --------------------
  static Future<double?> correctHandlePixels({
    required double pixels,
    required double secondPixelLength,
  }) async {
    double? _output;

    final double _seconds = TimelineScale.getSecondsByPixel(
      pixels: pixels,
      secondPixelLength: secondPixelLength,
    );
    final double _roundedSeconds = Numeric.roundFractions(_seconds, 2)!;

    if (_seconds != _roundedSeconds){

      await Future.delayed(const Duration(milliseconds: 400));

      _output = TimelineScale.getPixelsBySeconds(
        seconds: _roundedSeconds,
        secondPixelLength: secondPixelLength,
      );

    }

    return _output;
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
  }){

    final double _selectorBlankWidth = TimelineScale.blankZoneWidth() - TimelineScale.handleWidth;

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
