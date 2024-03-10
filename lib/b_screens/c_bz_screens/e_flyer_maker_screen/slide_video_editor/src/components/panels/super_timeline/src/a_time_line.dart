part of super_time_line;

class SuperTimeLine extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SuperTimeLine({
    required this.totalSeconds,
    required this.width,
    required this.height,
    super.key,
  });
  // --------------------
  final double totalSeconds;
  final double width;
  final double height;
  // --------------------
  @override
  _SuperTimeLineState createState() => _SuperTimeLineState();
// --------------------------------------------------------------------------
}

class _SuperTimeLineState extends State<SuperTimeLine> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<double> _secondPixelLength = ValueNotifier(80);
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
              secondPixelLength: _secondPixelLength,
              scrollController: _scrollController,
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
