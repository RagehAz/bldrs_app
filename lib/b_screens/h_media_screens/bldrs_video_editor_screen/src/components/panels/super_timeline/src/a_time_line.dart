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
    required this.msPixelLength,
    this.limitScrollingBetweenHandles = false,
    super.key,
  });
  // --------------------
  final double totalWidth;
  final double height;
  final Function(int currentMs) onTimeChanged;
  final Function(int minMs, int maxMs) onHandleChanged;
  final bool limitScrollingBetweenHandles;
  final VideoEditorController? videoEditorController;
  final ScrollController scrollController;
  final ValueNotifier<double> msPixelLength;
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
  int _totalMss = 0;
  // --------------------
  int _startMs = 0;
  int _endMs = 0;
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

      TimelineScale.jumpToMs(
        msPixelLength: widget.msPixelLength.value,
        scrollController: widget.scrollController,
        milliseconds: 0,
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
    _totalMss = widget.videoEditorController?.videoDuration.inMilliseconds ?? 0;
    _startMs = 0;
    _endMs = _totalMss;
  }
  // --------------------
  void _listenToScroll(){

    /// fix_the_play_glitch
    // if (widget.videoEditorController?.isPlaying == false){

      final int _currentMs = TimelineScale.getMssByPixel(
        msPixelLength: widget.msPixelLength.value,
        pixels: widget.scrollController.position.pixels,
      );

      widget.onTimeChanged(_currentMs.clamp(0, _totalMss));

    // }

  }
  // --------------------
  void _onScaleUpdate(ScaleUpdateDetails details){

    if (details.pointerCount == 2){
      TimelineScale.scaleTimeline(
        details: details,
        scrollController: widget.scrollController,
        msPixelLength: widget.msPixelLength,
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
        startMs: _startMs,
        endMs: _endMs,
        msPixelLength: widget.msPixelLength.value,
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
              msPixelLength: widget.msPixelLength,
              totalMss: _totalMss,
              scrollController: widget.scrollController,
              videoEditorController: widget.videoEditorController,
              onHandleChanged: (int startMs, int endMs){

                if (widget.limitScrollingBetweenHandles == true){
                  TimelineScale.handlePushCurrentTime(
                    msPixelLength:  widget.msPixelLength.value,
                    scrollController: widget.scrollController,
                    endMs: endMs,
                    startMs: startMs,
                  );
                }

                _startMs = startMs;
                _endMs = endMs;

                widget.onHandleChanged(startMs, endMs);
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
              totalMss: _totalMss,
              msPixelLength: widget.msPixelLength,
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
