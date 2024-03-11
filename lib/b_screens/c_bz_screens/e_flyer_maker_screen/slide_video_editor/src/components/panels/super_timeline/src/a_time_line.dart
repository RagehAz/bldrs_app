part of super_time_line;

class SuperTimeLine extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SuperTimeLine({
    required this.totalSeconds,
    required this.width,
    required this.height,
    required this.onTimeChange,
    required this.onHandleChanged,
    super.key,
  });
  // --------------------
  final double totalSeconds;
  final double width;
  final double height;
  final Function(double current) onTimeChange;
  final Function(double start, double end) onHandleChanged;
  // --------------------
  @override
  _SuperTimeLineState createState() => _SuperTimeLineState();
  // --------------------------------------------------------------------------
}

class _SuperTimeLineState extends State<SuperTimeLine> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<double> _secondPixelLength = ValueNotifier(TimelineScale.initialSecondPixelLength);
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scale = ValueNotifier(1);
  final ValueNotifier<double> _previousScale = ValueNotifier(1);
  final ValueNotifier<double> _accumulatedScale = ValueNotifier(0);
  double _totalSeconds = 0;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.totalSeconds;
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
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _scrollController.dispose();
    _secondPixelLength.dispose();
    _scale.dispose();
    _previousScale.dispose();
    _accumulatedScale.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  List<Color> colors = [
    Colorz.green125,
    Colorz.blue125,
    Colorz.white125,
    Colorz.facebook,
    Colorz.darkBlue,
    Colorz.green125,
    Colorz.blue125,
    Colorz.white125,
    Colorz.facebook,
    Colorz.darkBlue,
    Colorz.green125,
    Colorz.blue125,
    Colorz.white125,
    Colorz.facebook,
    Colorz.darkBlue,
  ];
  // -----------------------------------------------------------------------------
  void _onScaleUpdate(ScaleUpdateDetails details){

    if (details.pointerCount == 2){
      TimelineScale.scaleTimeline(
        details: details,
        scrollController: _scrollController,
        secondPixelLength: _secondPixelLength,
        totalSeconds: _totalSeconds,
        mounted: mounted,
        accumulatedScale: _accumulatedScale,
        previousScale: _previousScale,
        scale: _scale,
      );
    }

    else if (details.pointerCount == 1) {
      TimelineScale.scrollManually(
        scrollController: _scrollController,
        details: details,
      );

      final double _currentSecond = TimelineScale.getSecondsByPixel(
        secondPixelLength: _secondPixelLength.value,
        pixels: _scrollController.position.pixels,
        totalSeconds: widget.totalSeconds,
      );

      widget.onTimeChange(_currentSecond);

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return GestureDetector(
      onScaleUpdate: _onScaleUpdate,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// TIMELINE
            TimelineBar(
              height: widget.height,
              width: widget.width,
              secondPixelLength: _secondPixelLength,
              totalSeconds: _totalSeconds,
              scrollController: _scrollController,
              onHandleChanged: widget.onHandleChanged,
            ),

            /// VERTICAL LINE
            Container(
              width: TimelineScale.rulerLineThickness,
              height: widget.height,
              color: Colorz.white255,
            ),

            /// CURRENT SECOND
            GestureDetector(
              onTap: () async {

                blog('a7aa awy');

                // await TimelineScale.scrollFromTo(
                //   controller: _scrollController,
                //   secondPixelLength: _secondPixelLength.value,
                //   fromSecond: 1.23,
                //   toSecond: 2.34,
                // );

                TimelineScale.jumpToSecond(
                  secondPixelLength: _secondPixelLength.value,
                  scrollController: _scrollController,
                  second: 2.0,
                );

              },
              child: CurrentSecondText(
                totalSeconds: _totalSeconds,
                secondPixelLength: _secondPixelLength,
                scrollController: _scrollController,
              ),
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
