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
  static const double minTimelineScale = 0.3;
  static const double maxTimelineScale = 3;
  static const double initialMsPixelLength = 80/1000; // 80 pixel for each 1000 milliseconds
  // --------------------
  static const double handleWidth = 15;
  static const double handleCorner = handleWidth * 0.5;
  static const double selectorHorizontalLineThickness = 2;
  static const Color selectorColor = Colorz.yellow255;
  static const double frameSizeFactor = 0.3;
  static const int maxFramesPerSecond = 8;
  static const List<int> framesLoadingSequence = [4,3,2,1];
  // --------------------------------------------------------------------------

  /// PIXEL TO SECONDS

  // --------------------
  static int getMssByPixel({
    required double pixels,
    required double msPixelLength,
  }){

    final double _milliSeconds = pixels / msPixelLength;
    return _milliSeconds.toInt(); // Numeric.roundFractions(_seconds, 2)!;

  }
  // --------------------
  static double getPixelsByMss({
    required int milliSeconds,
    required double msPixelLength,
  }){

    return milliSeconds * msPixelLength;

  }
  // --------------------
  static double totalMssPixelLength({
    required int totalMilliSeconds,
    required double msPixelLength,
  }){
    return totalMilliSeconds * msPixelLength;
  }
  // --------------------
  static double tenthPixelLength({
    required double msPixelLength,
  }){
    final double secondPixelLength = msPixelLength * 1000;
    return secondPixelLength / 10;
  }
  // --------------------------------------------------------------------------

  /// SCROLLING - SCALING

  // --------------------
  static void scrollManually({
    required ScrollController scrollController,
    required ScaleUpdateDetails details,
    required int startMs,
    required int endMs,
    required bool scrollingIsLimitedBetweenHandles,
    required double msPixelLength,
  }){

    double _goTo = scrollController.offset - details.focalPointDelta.dx;

    if (scrollingIsLimitedBetweenHandles == true){
      _goTo = _goTo.clamp(
          getPixelsByMss(
              milliSeconds: startMs,
              msPixelLength: msPixelLength,
          ),
          getPixelsByMss(
              milliSeconds: endMs,
              msPixelLength: msPixelLength
          )
      );
    }

    scrollController.jumpTo(_goTo);
  }
  // --------------------
  static void jumpToMs({
    required int milliseconds,
    required double msPixelLength,
    required ScrollController scrollController,
  }){

    final double _goTo = TimelineScale.getPixelsByMss(
      milliSeconds: milliseconds,
      msPixelLength: msPixelLength,
    );
    scrollController.jumpTo(_goTo);

  }
  // --------------------
  static void scaleTimeline({
    required ScaleUpdateDetails details,
    required bool mounted,
    required ValueNotifier<double> accumulatedScale,
    required ValueNotifier<double> previousScale,
    required ValueNotifier<double> msPixelLength,
    required ValueNotifier<double> scale,
    required ScrollController scrollController,
  }){

    if (mounted == true){

      final int _oldMs = TimelineScale.getMssByPixel(
        msPixelLength: msPixelLength.value,
        pixels: scrollController.position.pixels,
      );

      final double scaleDelta = (details.horizontalScale - previousScale.value) * pinchingScaleFactor;
      accumulatedScale.value += scaleDelta;
      double _newScale = scale.value + accumulatedScale.value;
      _newScale = _newScale.clamp(minTimelineScale, maxTimelineScale);

      scale.value  = _newScale;
      msPixelLength.value = initialMsPixelLength * scale.value;
      previousScale.value = details.horizontalScale;

      TimelineScale.jumpToMs(
        milliseconds: _oldMs,
        msPixelLength: msPixelLength.value,
        scrollController: scrollController,
      );

    }

  }
  // --------------------
  static Future<void> scrollFromTo({
    required int fromMs,
    required int toMs,
    required double msPixelLength,
    required ScrollController controller,
  }) async {

    final double _endPixel = TimelineScale.getPixelsByMss(
      milliSeconds: toMs,
      msPixelLength: msPixelLength,
    );

    jumpToMs(
      milliseconds: fromMs,
      msPixelLength: msPixelLength,
      scrollController: controller,
    );

    final int _durationMs = toMs - fromMs;

    await Sliders.scrollTo(
      controller: controller,
      offset: _endPixel,
      duration: Duration(milliseconds: _durationMs),
      curve: Curves.linear,
    );

  }
  // --------------------
  static void handlePushCurrentTime({
    required double msPixelLength,
    required ScrollController scrollController,
    required int startMs,
    required int endMs,
  }){

    final int _currentSecond = TimelineScale.getMssByPixel(
      msPixelLength: msPixelLength,
      pixels: scrollController.position.pixels,
    );

    if (startMs >= _currentSecond){
      TimelineScale.jumpToMs(
        scrollController: scrollController,
        milliseconds: startMs,
        msPixelLength: msPixelLength,
      );
    }

    if (endMs <= _currentSecond){
      TimelineScale.jumpToMs(
        scrollController: scrollController,
        milliseconds: endMs,
        msPixelLength: msPixelLength,
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
    required double msPixelLength,
  }) async {
    final double? _output = pixels;

    // final double _milliSeconds = TimelineScale.getMssByPixel(
    //   pixels: pixels,
    //   msPixelLength: msPixelLength,
    // );
    // final double _roundedSeconds = Numeric.roundFractions(_seconds, 2)!;
    //
    // if (_seconds != _roundedSeconds){
    //
    //   await Future.delayed(const Duration(milliseconds: 400));
    //
    //   _output = TimelineScale.getPixelsBySeconds(
    //     seconds: _roundedSeconds,
    //     secondPixelLength: secondPixelLength,
    //   );
    //
    // }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// WIDTHS

  // --------------------
  static double totalAvailableWidth({
    required int totalMss,
    required double msPixelLength,
  }){
    final double _totalMssLength = TimelineScale.totalMssPixelLength(
      totalMilliSeconds: totalMss,
      msPixelLength: msPixelLength,
    );
    final double _blankWidth = TimelineScale.blankZoneWidth();
    return _blankWidth + _totalMssLength + _blankWidth;
  }
  // --------------------
  static double blankZoneWidth(){
    final double _timelineBoxWidth = Scale.screenWidth(getMainContext());
    return _timelineBoxWidth * 0.5;
  }
  // --------------------
  static int getTotalTenths({
    required int totalMss,
  }){
    final double totalSeconds = totalMss / 1000;
    return (totalSeconds * 10).ceil();
  }
  // --------------------
  static double getSelectorInnerWidth({
    required int totalMss,
    required double msPixelLength,
  }){

    final double _selectorBlankWidth = TimelineScale.blankZoneWidth() - TimelineScale.handleWidth;

    final double _totalAvailableWidth = TimelineScale.totalAvailableWidth(
      totalMss: totalMss,
      msPixelLength: msPixelLength,
    );

    return _totalAvailableWidth - (_selectorBlankWidth*2);
  }
  // --------------------------------------------------------------------------
}
