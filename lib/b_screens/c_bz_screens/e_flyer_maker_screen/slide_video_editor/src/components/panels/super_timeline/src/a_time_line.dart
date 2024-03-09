part of super_time_line;

class SuperTimeLineScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SuperTimeLineScreen({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _SuperTimeLineScreenState createState() => _SuperTimeLineScreenState();
// --------------------------------------------------------------------------
}

class _SuperTimeLineScreenState extends State<SuperTimeLineScreen> {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

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
    _loading.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  final double _secondPixelLength = 80;
  final double _totalSeconds = 3.6;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _timelineBoxWidth = Scale.screenWidth(context);
    const double _timelineBoxHeight = 100;
    final double _timelineStripHeight = _timelineBoxHeight * 0.5;
    final double _blankWidth = TimelineScale.blankZoneWidth();

    final List<double> _parts = TimelineScale.createTimeBoxes(
      seconds: _totalSeconds,
    );

    final double _totalSecondsLength = TimelineScale.totalSecondsPixelLength(
      totalSeconds: _totalSeconds,
      secondPixelLength: _secondPixelLength,
    );

    final double _tenthWidth = TimelineScale.tenthPixelLength(
        secondPixelLength: _secondPixelLength,
    );

    // --------------------
    return MainLayout(
      canSwipeBack: false,
      loading: _loading,
      title: Verse.plain('Super timeline screen'),
      child: Center(
        child: Container(
          width: _timelineBoxWidth,
          height: _timelineBoxHeight,
          color: Colorz.bloodTest,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// TIMELINE
              FloatingList(
                width: Scale.screenWidth(context),
                height: _timelineBoxHeight,
                scrollDirection: Axis.horizontal,
                scrollController: _scrollController,
                columnChildren: <Widget>[

                  SizedBox(
                    width: _blankWidth + _totalSecondsLength + _blankWidth,
                    height: _timelineBoxHeight,
                    child: Stack(
                      // alignment: Alignment.topCenter,
                      children: <Widget>[

                        /// SECONDS BOXES
                        Row(
                          children: <Widget>[

                            /// LEFT BLANK
                            SizedBox(
                              width: _blankWidth,
                              height: _timelineStripHeight,
                            ),

                            ///
                            ...List.generate(_parts.length, (index){

                              final double _part = _parts[index];

                              return Container(
                                width: _part * _secondPixelLength,
                                height: _timelineStripHeight,
                                color: Colorizer.createRandomColor(),
                              );

                            }),

                            /// RIGHT BLANK
                            SizedBox(
                              width: _blankWidth,
                              height: _timelineStripHeight,
                            ),

                          ],
                        ),

                        /// RULER
                        Ruler(
                          availableWidth: _blankWidth + _totalSecondsLength + _blankWidth,
                          height: _timelineStripHeight,
                          millimeters: (_totalSeconds * 10).toInt(),
                          millimeterWidth: _tenthWidth,
                        ),

                        /// SELECTOR
                        TimelineSelector(
                          availableWidth: _blankWidth + _totalSecondsLength + _blankWidth,
                          totalSecondsWidth: _totalSecondsLength,
                          height: _timelineBoxHeight,
                          secondPixelLength: _secondPixelLength,
                          totalSeconds: _totalSeconds,
                        ),

                      ],
                    ),
                  ),

                ],

              ),

              /// VERTICAL LINE
              Container(
                width: TimelineScale.rulerLineThickness,
                height: _timelineBoxHeight,
                color: Colorz.white255,
              ),

              /// CURRENT SECOND
              IgnorePointer(
                child: AnimatedBuilder(
                    animation: _scrollController,
                    builder: (_, __) {

                      final double _second = TimelineScale.getSecondsByPixel(
                        secondPixelLength: _secondPixelLength,
                        pixels: _scrollController.position.pixels,
                        totalSeconds: _totalSeconds,
                      );

                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: BldrsText(
                          verse: Verse.plain('${_second}s'),
                          labelColor: Colorz.black125,
                          size: 1,
                          margin: 3,
                        ),
                      );
                    }
                    ),
              ),

            ],
          ),
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
