part of super_time_line;

class TimelineSelector extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TimelineSelector({
    required this.height,
    required this.totalMss,
    required this.msPixelLength,
    required this.onHandleChanged,
    this.minimumDurationMs = 100,
    super.key
  });
  // --------------------
  final double height;
  final double msPixelLength;
  final int totalMss;
  final Function(int startMs, int endMs) onHandleChanged;
  final int minimumDurationMs;
  // --------------------
  @override
  _TimelineSelectorState createState() => _TimelineSelectorState();
// --------------------------------------------------------------------------
}

class _TimelineSelectorState extends State<TimelineSelector> {
  // -----------------------------------------------------------------------------
  double _min = 0;
  double _max = 0;
  // --------------------
  double _leftPixels = 0;
  double _rightPixels = 0;
  // --------------------
  double _msPixelLength = TimelineScale.initialMsPixelLength;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _msPixelLength = widget.msPixelLength;

    _min = _getTheMostMinPixels();
    _max = _getTheMostMaxPixels();

    _leftPixels = _min;
    _rightPixels = _max;

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
  void didUpdateWidget(TimelineSelector oldWidget) {

    super.didUpdateWidget(oldWidget);

    if (oldWidget.msPixelLength != widget.msPixelLength) {

      final int _oldLeftMss = TimelineScale.getMssByPixel(
        msPixelLength: _msPixelLength,
        pixels: _leftPixels,
      );

      final int _oldRightMss = TimelineScale.getMssByPixel(
        msPixelLength: _msPixelLength,
        pixels: _rightPixels,
      );

      setState(() {
        _msPixelLength = widget.msPixelLength;
        _leftPixels = TimelineScale.getPixelsByMss(
          milliSeconds: _oldLeftMss,
          msPixelLength: _msPixelLength,
        );
        _rightPixels = TimelineScale.getPixelsByMss(
          milliSeconds: _oldRightMss,
          msPixelLength: _msPixelLength,
        );
        _max = _getTheMostMaxPixels();
      });

    }

    if (oldWidget.totalMss != widget.totalMss){
      setState(() {
        _min = _getTheMostMinPixels();
        _max = _getTheMostMaxPixels();
        _leftPixels = _min;
        _rightPixels = _max;
      });

    }

  }
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // --------------------
  double _getTheMostMinPixels(){
    return 0;
  }
  // --------------------
  double _getTheMostMaxPixels(){

    final double _totalSecondsLength = TimelineScale.totalMssPixelLength(
      totalMilliSeconds: widget.totalMss,
      msPixelLength: _msPixelLength,
    );

    return _totalSecondsLength;
  }
  // --------------------
  void _onRightHandleDragUpdate({
    required DragUpdateDetails details,
    required int rightMs,
    required int leftMs,
    required double minimumDurationInPixels,
  }){

    final double newPosition = TimelineScale.getRightHandleDragPixels(
      details: details,
      leftPx: _leftPixels,
      rightPx: _rightPixels,
      min: _min,
      max: _max,
      minimumDurationInPixels: minimumDurationInPixels,
    );

    setState(() {
      _rightPixels = newPosition;
    });

    widget.onHandleChanged(leftMs, rightMs);

  }
  // --------------------
  Future<void> _onRightHandleDragEnd(DragEndDetails details) async {

    final double? _correction = await TimelineScale.correctHandlePixels(
      pixels: _rightPixels,
      msPixelLength: _msPixelLength,
    );

    if (_correction != null){
      setState(() {
        _rightPixels = _correction;
      });
    }

  }
  // --------------------
  void _onLeftHandleDragUpdate({
    required DragUpdateDetails details,
    required int rightMs,
    required int leftMs,
    required double minimumDurationInPixels,
  }) {

    final double newPosition = TimelineScale.getLeftHandleDragPixels(
        details: details,
        leftPx: _leftPixels,
        rightPx: _rightPixels,
        min: _min,
        max: _max,
        minimumDurationInPixels: minimumDurationInPixels
    );

    setState(() {
      _leftPixels = newPosition;
    });

    widget.onHandleChanged(leftMs, rightMs);

  }
  // --------------------
  Future<void> _onLeftHandleDragEnd(DragEndDetails details) async {

    final double? _correction = await TimelineScale.correctHandlePixels(
      pixels: _leftPixels,
      msPixelLength: _msPixelLength,
    );

    if (_correction != null){
      setState(() {
        _leftPixels = _correction;
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _minimumDurationInPixels = TimelineScale.getPixelsByMss(
        milliSeconds: widget.minimumDurationMs,
        msPixelLength: _msPixelLength,
      );
    // --------------------
    final double _blankWidth = TimelineScale.blankZoneWidth() - TimelineScale.handleWidth;
    // --------------------
    final double _totalAvailableWidth = TimelineScale.totalAvailableWidth(
      totalMss: widget.totalMss,
      msPixelLength: _msPixelLength,
    );
    // --------------------
    final double _selectorInnerWidth = TimelineScale.getSelectorInnerWidth(
      totalMss: widget.totalMss,
      msPixelLength: _msPixelLength,
    );
    // --------------------
    final int _rightMs = TimelineScale.getMssByPixel(
      msPixelLength: _msPixelLength,
      pixels: _rightPixels,
    );
    // --------------------
    final int _leftMs = TimelineScale.getMssByPixel(
      msPixelLength: _msPixelLength,
      pixels: _leftPixels,
    );
    // --------------------
    return Container(
      width: _totalAvailableWidth,
      height: widget.height,
      // color: Colorz.green125,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[

          /// LEFT BLANK
          SizedBox(
            height: widget.height,
            width: _blankWidth,
          ),

          /// TRIM ZONE
          SizedBox(
            width: _selectorInnerWidth,
            height: widget.height,
            child: Stack(
              children: <Widget>[

                /// TOP LINE
                SelectorTopLine(
                  rightPixels: _rightPixels,
                  leftPixels: _leftPixels,
                ),

                /// BOTTOM LINE
                SelectorBottomLine(
                  leftPixels: _leftPixels,
                  rightPixels: _rightPixels,
                ),

                /// LEFT HANDLE
                LeftSelectorHandle(
                  height: widget.height,
                  leftPx: _leftPixels,
                  onHorizontalDragEnd: _onLeftHandleDragEnd,
                  onHorizontalDragUpdate: (details) => _onLeftHandleDragUpdate(
                    details: details,
                    leftMs: _leftMs,
                    rightMs: _rightMs,
                    minimumDurationInPixels: _minimumDurationInPixels,
                  ),
                ),

                /// RIGHT HANDLE
                RightSelectorHandle(
                  height: widget.height,
                  rightPixels: _rightPixels,
                  onHorizontalDragEnd: _onRightHandleDragEnd,
                  onHorizontalDragUpdate: (details) => _onRightHandleDragUpdate(
                    details: details,
                    leftMs: _leftMs,
                    rightMs: _rightMs,
                    minimumDurationInPixels: _minimumDurationInPixels,
                  ),
                ),

              ],
            ),
          ),

          /// RIGHT BLANK
          SizedBox(
            height: widget.height,
            width: _blankWidth,
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
