part of super_time_line;

class TimelineSelector extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TimelineSelector({
    required this.height,
    required this.totalSeconds,
    required this.secondPixelLength,
    required this.onHandleChanged,
    this.handleWidth = 10,
    this.minimumDurationInSeconds = 0.1,
    super.key
  });
  // --------------------
  final double height;
  final double handleWidth;
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
  double _leftPx = 0;
  double _rightPx = 0;
  // --------------------
  double _secondPixelLength = TimelineScale.initialSecondPixelLength;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _secondPixelLength = widget.secondPixelLength;

    _min = _getTheMostMinPixels();
    _max = _getTheMostMaxPixels();

    _leftPx = _min;
    _rightPx = _max;

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
        pixels: _leftPx,
        totalSeconds: oldWidget.totalSeconds,
      );

      final double _oldRightSeconds = TimelineScale.getSecondsByPixel(
        secondPixelLength: _secondPixelLength,
        pixels: _rightPx,
        totalSeconds: oldWidget.totalSeconds,
      );

      setState(() {
        _secondPixelLength = widget.secondPixelLength;
        _leftPx = TimelineScale.getPixelsBySeconds(
          seconds: _oldLeftSeconds,
          secondPixelLength: _secondPixelLength,
        );
        _rightPx = TimelineScale.getPixelsBySeconds(
          seconds: _oldRightSeconds,
          secondPixelLength: _secondPixelLength,
        );
        _max = _getTheMostMaxPixels();
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

    return _totalSecondsLength + widget.handleWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _minimumDurationInPixels = TimelineScale.getPixelsBySeconds(
        seconds: widget.minimumDurationInSeconds,
        secondPixelLength: _secondPixelLength,
      );
    // --------------------
    const Color _color = Colorz.yellow255;
    // --------------------
    const double _handleWidth = 10;
    const double _horizontalLineThickness = 2;
    final double _blankWidth = TimelineScale.blankZoneWidth() - _handleWidth;
    // --------------------
    final double _totalAvailableWidth = TimelineScale.totalAvailableWidth(
      totalSeconds: widget.totalSeconds,
      secondPixelLength: _secondPixelLength,
    );
    // --------------------
    final double _selectorInnerWidth = TimelineScale.getSelectorInnerWidth(
      totalSeconds: widget.totalSeconds,
      secondPixelLength: _secondPixelLength,
      handleWidth: _handleWidth,
    );
    const double _corner = _handleWidth * 0.5;
    // --------------------
    final double _rightS = TimelineScale.getSecondsByPixel(
      secondPixelLength: _secondPixelLength,
      pixels: _rightPx,
      totalSeconds: widget.totalSeconds,
    );
    // --------------------
    final double _leftS = TimelineScale.getSecondsByPixel(
      secondPixelLength: _secondPixelLength,
      pixels: _leftPx,
      totalSeconds: widget.totalSeconds,
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: _rightPx - _leftPx,
                    height: _horizontalLineThickness,
                    color: _color,
                    margin: EdgeInsets.only(
                        left: _leftPx + _handleWidth,
                    ),
                  ),
                ),

                /// BOTTOM LINE
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: _rightPx - _leftPx,
                    height: _horizontalLineThickness,
                    color: _color,
                    margin: EdgeInsets.only(
                        left: _leftPx + _handleWidth,
                    ),
                  ),
                ),

                /// LEFT HANDLE
                GestureDetector(
                  onHorizontalDragUpdate: (details) {

                    double newPosition = _leftPx + details.primaryDelta!;

                    newPosition.clamp(_min, _max);

                    if (newPosition >= _rightPx - _minimumDurationInPixels){
                      newPosition = _rightPx - _minimumDurationInPixels;
                    }

                    setState(() {
                      _leftPx = newPosition;
                    });

                    widget.onHandleChanged(_leftS, _rightS);

                  },
                  child: Container(
                    width: _handleWidth,
                    height: widget.height,
                    margin: EdgeInsets.only(
                      left: _leftPx,
                    ),
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: Borderers.cornerOnly(
                        appIsLTR: UiProvider.checkAppIsLeftToRight(),
                        enBottomLeft: _corner,
                        enTopLeft: _corner,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const SuperImage(
                      loading: false,
                      width: _handleWidth,
                      height: _handleWidth,
                      pic: Iconz.arrowLeft,
                      iconColor: Colorz.black255,
                      scale: 0.6,
                    ),
                  ),
                ),

                /// RIGHT HANDLE
                GestureDetector(
                  // onDoubleTap: _reset,
                  onHorizontalDragUpdate: (details) {

                    double newPosition = _rightPx + details.primaryDelta!;

                    newPosition.clamp(_min, _max);

                    if (newPosition <= _leftPx + _minimumDurationInPixels){
                      newPosition = _leftPx + _minimumDurationInPixels;
                    }

                    setState(() {
                      _rightPx = newPosition;
                    });

                    widget.onHandleChanged(_leftS, _rightS);

                  },
                  child: Container(
                    width: _handleWidth,
                    height: widget.height,
                    margin: EdgeInsets.only(
                      left: _rightPx + widget.handleWidth,
                    ),
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: Borderers.cornerOnly(
                        appIsLTR: UiProvider.checkAppIsLeftToRight(),
                        enBottomRight: _corner,
                        enTopRight: _corner,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const SuperImage(
                      loading: false,
                      width: _handleWidth,
                      height: _handleWidth,
                      pic: Iconz.arrowRight,
                      iconColor: Colorz.black255,
                      scale: 0.6,
                    ),
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
