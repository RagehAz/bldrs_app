part of super_time_line;

class TimelineSelector extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TimelineSelector({
    required this.availableWidth,
    required this.totalSecondsWidth,
    required this.height,
    required this.totalSeconds,
    required this.secondPixelLength,
    this.handleWidth = 10,
    super.key
  });
  // --------------------
  final double availableWidth;
  final double totalSecondsWidth;
  final double height;
  final double handleWidth;
  final double secondPixelLength;
  final double totalSeconds;
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
  double _left = 0;
  double _right = 0;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _min = _getTheMostMinPixels();
    _max = _getTheMostMaxPixels();

    _left = _min;
    _right = _max;

  }
  // --------------------
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
      secondPixelLength: widget.secondPixelLength,
    );

    return _totalSecondsLength + widget.handleWidth;
  }
  // --------------------
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _handleWidth = 10;
    final double _blankWidth = TimelineScale.blankZoneWidth() - _handleWidth;
    final double _timeZoneWidth = widget.availableWidth - (_blankWidth*2);
    // --------------------

    final double _leftSeconds = TimelineScale.getSecondsByPixel(
      secondPixelLength: widget.secondPixelLength,
      pixels: _left,
      totalSeconds: widget.totalSeconds,
    );
    final double _rightSeconds = TimelineScale.getSecondsByPixel(
      secondPixelLength: widget.secondPixelLength,
      pixels: _right - widget.handleWidth,
      totalSeconds: widget.totalSeconds,
    );

    return Container(
      width: widget.availableWidth,
      height: widget.height,
      color: Colorz.green125,
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[

          /// LEFT BLANK
          SizedBox(
            height: widget.height,
            width: _blankWidth,
            child: BldrsText(
              verse: Verse.plain(_leftSeconds.toString()),
            ),
          ),

          /// TRIM ZONE
          SizedBox(
            width: _timeZoneWidth,
            height: widget.height,
            child: Stack(
              children: <Widget>[

                /// TOP LINE
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: _right - _left,
                    height: 5,
                    color: Colorz.bloodTest,
                    margin: EdgeInsets.only(left: _left),
                  ),
                ),

                /// BOTTOM LINE
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: _right - _left,
                    height: 5,
                    color: Colorz.bloodTest,
                    margin: EdgeInsets.only(left: _left),
                  ),
                ),

                /// LEFT HANDLE
                GestureDetector(
                  onHorizontalDragUpdate: (details) {

                    double newPosition = _left + details.primaryDelta!;
                    blog('a7a');

                    if (newPosition <= _min){
                      newPosition = _min;
                    }
                    if (newPosition >= _max){
                      newPosition = _max;
                    }
                    if (newPosition >= _right - widget.handleWidth){
                      newPosition = _right - widget.handleWidth;
                    }

                    setState(() {
                      _left = newPosition;
                    });

                  },
                  child: Container(
                    width: _handleWidth,
                    height: widget.height,
                    color: Colorz.red255,
                    margin: EdgeInsets.only(
                      left: _left,
                    ),
                  ),
                ),

                /// RIGHT HANDLE
                GestureDetector(
                  onHorizontalDragUpdate: (details) {

                    double newPosition = _right + details.primaryDelta!;
                    blog('a7a');

                    if (newPosition <= _min){
                      newPosition = _min;
                    }
                    if (newPosition >= _max){
                      newPosition = _max;
                    }
                    if (newPosition <= _left + widget.handleWidth){
                      newPosition = _left + widget.handleWidth;
                    }

                    setState(() {
                      _right = newPosition;
                    });

                  },
                  child: Container(
                    width: _handleWidth,
                    height: widget.height,
                    color: Colorz.red255,
                    margin: EdgeInsets.only(
                      left: _right,
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
            child: BldrsText(
              verse: Verse.plain(_rightSeconds.toString()),
            ),
          ),
        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
