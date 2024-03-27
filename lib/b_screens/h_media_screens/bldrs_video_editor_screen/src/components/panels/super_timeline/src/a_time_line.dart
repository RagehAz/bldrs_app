part of super_time_line;

class SuperTimeLine extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SuperTimeLine({
    required this.totalWidth,
    required this.height,
    required this.onTimeChanged,
    required this.onHandleChanged,
    required this.videoEditorController,
    required this.scrollController,
    required this.secondPixelLength,
    this.limitScrollingBetweenHandles = false,
    super.key,
  });
  // --------------------
  final double totalWidth;
  final double height;
  final Function(double current) onTimeChanged;
  final Function(double start, double end) onHandleChanged;
  final bool limitScrollingBetweenHandles;
  final VideoEditorController? videoEditorController;
  final ScrollController scrollController;
  final ValueNotifier<double> secondPixelLength;
  // --------------------
  @override
  _SuperTimeLineState createState() => _SuperTimeLineState();
  // --------------------------------------------------------------------------
}

class _SuperTimeLineState extends State<SuperTimeLine> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<double> _scale = ValueNotifier(1);
  final ValueNotifier<double> _previousScale = ValueNotifier(1);
  final ValueNotifier<double> _accumulatedScale = ValueNotifier(0);
  double _totalSeconds = 0;
  // --------------------
  double _startTime = 0;
  double _endTime = 0;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _defineTotalSeconds();

    widget.scrollController.addListener(_listenToScroll);
  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

      });

    }
    super.didChangeDependencies();
  }

   */
  // --------------------
  @override
  void didUpdateWidget(SuperTimeLine oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool _filesAreIdentical = VideoOps.checkVideoEditorVideosAreIdentical(
      oldController: oldWidget.videoEditorController,
      newController: widget.videoEditorController,
    );

    if (_filesAreIdentical == false) {

      widget.scrollController.removeListener(_listenToScroll);

      setState(() {
        _defineTotalSeconds();
      });

      TimelineScale.jumpToSecond(
        secondPixelLength: widget.secondPixelLength.value,
        scrollController: widget.scrollController,
        second: 0,
      );

      widget.scrollController.addListener(_listenToScroll);

    }

  }
  // --------------------
  @override
  void dispose() {
    widget.scrollController.removeListener(_listenToScroll);
    _scale.dispose();
    _previousScale.dispose();
    _accumulatedScale.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _defineTotalSeconds(){
    final int _ms = widget.videoEditorController?.videoDuration.inMilliseconds ?? 0;
    _totalSeconds = _ms / 1000;
    _startTime = 0;
    _endTime = _totalSeconds;
  }
  // --------------------
  void _listenToScroll(){

    /// fix_the_play_glitch
    // if (widget.videoEditorController?.isPlaying == false){

      final double _currentSecond = TimelineScale.getSecondsByPixel(
        secondPixelLength: widget.secondPixelLength.value,
        pixels: widget.scrollController.position.pixels,
      );

      widget.onTimeChanged(_currentSecond.clamp(0, _totalSeconds));

    // }

  }
  // --------------------
  void _onScaleUpdate(ScaleUpdateDetails details){

    if (details.pointerCount == 2){
      TimelineScale.scaleTimeline(
        details: details,
        scrollController: widget.scrollController,
        secondPixelLength: widget.secondPixelLength,
        mounted: mounted,
        accumulatedScale: _accumulatedScale,
        previousScale: _previousScale,
        scale: _scale,
      );
    }

    else if (details.pointerCount == 1) {
      TimelineScale.scrollManually(
        scrollController: widget.scrollController,
        details: details,
        startTime: _startTime,
        endTime: _endTime,
        secondPixelLength: widget.secondPixelLength.value,
        scrollingIsLimitedBetweenHandles: widget.limitScrollingBetweenHandles,
      );
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return GestureDetector(
      onScaleUpdate: _onScaleUpdate,
      child: SizedBox(
        width: widget.totalWidth,
        height: widget.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// TIMELINE
            TimelineBar(
              height: widget.height,
              width: widget.totalWidth,
              secondPixelLength: widget.secondPixelLength,
              totalSeconds: _totalSeconds,
              scrollController: widget.scrollController,
              videoEditorController: widget.videoEditorController,
              onHandleChanged: (double startS, double endS){

                if (widget.limitScrollingBetweenHandles == true){
                  TimelineScale.handlePushCurrentTime(
                    secondPixelLength: widget.secondPixelLength.value,
                    scrollController: widget.scrollController,
                    endS: endS,
                    startS: startS,
                  );
                }

                _startTime = startS;
                _endTime = endS;

                widget.onHandleChanged(startS, endS);
              },
            ),

            /// VERTICAL LINE
            Container(
              width: TimelineScale.rulerLineThickness,
              height: widget.height,
              color: Colorz.white255,
            ),

            /// CURRENT SECOND
            CurrentSecondText(
              totalSeconds: _totalSeconds,
              secondPixelLength: widget.secondPixelLength,
              scrollController: widget.scrollController,
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
