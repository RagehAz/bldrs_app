import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/colors/colorizer.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_video_editor/src/components/panels/super_timeline/ruler.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

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
  List<double> createTimeBoxes({
    required double seconds,
  }){
    final List<double> _output = [];

    double _seconds = seconds;
    final int _rounds = _seconds.ceil();

    for (int i = 0; i < _rounds; i++){

      if (_seconds >= 1){
        _output.add(1);
      }
      else {
        _output.add(_seconds);
      }
      _seconds--;

    }

    return _output;
  }

  @override
  Widget build(BuildContext context) {

    final double _timelineBoxWidth = Scale.screenWidth(context);
    const double _timelineBoxHeight = 100;
    final double _timelineStripHeight = _timelineBoxHeight * 0.5;
    final double _blankWidth = _timelineBoxWidth * 0.5;

    final double _verticalLineThickness = 1;

    final double _seconds = 2.83;

    final double _secondLength = 50;

    final List<double> _parts = createTimeBoxes(
      seconds: _seconds,
    );
    final double _totalSecondsLength = _seconds * _secondLength;

    final double _millimeterWidth = _secondLength / 10;

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
                                width: _part * _secondLength,
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
                          millimeters: (_seconds * 10).toInt(),
                          millimeterWidth: _millimeterWidth,
                        ),

                      ],
                    ),
                  ),

                ],

              ),

              /// VERTICAL LINE
              Container(
                width: _verticalLineThickness,
                height: _timelineBoxHeight,
                color: Colorz.white255,
              ),

              /// CURRENT SECOND
              IgnorePointer(
                child: AnimatedBuilder(
                    animation: _scrollController,
                    builder: (_, __) {

                      final double _pixel = _scrollController.position.pixels;
                      final double _millimeters =  _pixel / _millimeterWidth;
                      double _second = _millimeters / 10;

                      final double _maxSecond = _seconds;
                      const double _minSecond = 0;

                      if (_second >= _maxSecond){
                        _second = _maxSecond;
                      }
                      if (_second <= _minSecond){
                        _second = 0;
                      }

                      _second = Numeric.roundFractions(_second, 1)!;

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
