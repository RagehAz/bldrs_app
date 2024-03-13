part of super_time_line;

class TimelineSelector extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TimelineSelector({
    required this.height,
    required this.totalSeconds,
    required this.secondPixelLength,
    required this.onHandleChanged,
    this.minimumDurationInSeconds = 0.1,
    super.key
  });
  // --------------------
  final double height;
  final double secondPixelLength;
  final double totalSeconds;
  final Function(double start, double end) onHandleChanged;
  final double minimumDurationInSeconds;
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
  double _secondPixelLength = TimelineScale.initialSecondPixelLength;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _secondPixelLength = widget.secondPixelLength;

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

    if (oldWidget.secondPixelLength != widget.secondPixelLength) {

      final double _oldLeftSeconds = TimelineScale.getSecondsByPixel(
        secondPixelLength: _secondPixelLength,
        pixels: _leftPixels,
      );

      final double _oldRightSeconds = TimelineScale.getSecondsByPixel(
        secondPixelLength: _secondPixelLength,
        pixels: _rightPixels,
      );

      setState(() {
        _secondPixelLength = widget.secondPixelLength;
        _leftPixels = TimelineScale.getPixelsBySeconds(
          seconds: _oldLeftSeconds,
          secondPixelLength: _secondPixelLength,
        );
        _rightPixels = TimelineScale.getPixelsBySeconds(
          seconds: _oldRightSeconds,
          secondPixelLength: _secondPixelLength,
        );
        _max = _getTheMostMaxPixels();
      });

    }

    if (oldWidget.totalSeconds != widget.totalSeconds){
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

    final double _totalSecondsLength = TimelineScale.totalSecondsPixelLength(
      totalSeconds: widget.totalSeconds,
      secondPixelLength: _secondPixelLength,
    );

    return _totalSecondsLength;
  }
  // --------------------
  void _onRightHandleDragUpdate({
    required DragUpdateDetails details,
    required double rightSeconds,
    required double leftSeconds,
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

    widget.onHandleChanged(leftSeconds, rightSeconds);

  }
  // --------------------
  Future<void> _onRightHandleDragEnd(DragEndDetails details) async {

    final double? _correction = await TimelineScale.correctHandlePixels(
      pixels: _rightPixels,
      secondPixelLength: _secondPixelLength,
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
    required double rightSeconds,
    required double leftSeconds,
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

    widget.onHandleChanged(leftSeconds, rightSeconds);

  }
  // --------------------
  Future<void> _onLeftHandleDragEnd(DragEndDetails details) async {

    final double? _correction = await TimelineScale.correctHandlePixels(
      pixels: _leftPixels,
      secondPixelLength: _secondPixelLength,
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
    final double _minimumDurationInPixels = TimelineScale.getPixelsBySeconds(
        seconds: widget.minimumDurationInSeconds,
        secondPixelLength: _secondPixelLength,
      );
    // --------------------
    final double _blankWidth = TimelineScale.blankZoneWidth() - TimelineScale.handleWidth;
    // --------------------
    final double _totalAvailableWidth = TimelineScale.totalAvailableWidth(
      totalSeconds: widget.totalSeconds,
      secondPixelLength: _secondPixelLength,
    );
    // --------------------
    final double _selectorInnerWidth = TimelineScale.getSelectorInnerWidth(
      totalSeconds: widget.totalSeconds,
      secondPixelLength: _secondPixelLength,
    );
    // --------------------
    final double _rightSeconds = TimelineScale.getSecondsByPixel(
      secondPixelLength: _secondPixelLength,
      pixels: _rightPixels,
    );
    // --------------------
    final double _leftSeconds = TimelineScale.getSecondsByPixel(
      secondPixelLength: _secondPixelLength,
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
                    leftSeconds: _leftSeconds,
                    rightSeconds: _rightSeconds,
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
                    leftSeconds: _leftSeconds,
                    rightSeconds: _rightSeconds,
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
