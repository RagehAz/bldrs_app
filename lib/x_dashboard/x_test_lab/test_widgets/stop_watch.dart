import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchBar extends StatefulWidget {
  /// -----------------------------------------------------------------------------
  const StopWatchBar({
    this.onStart,
    this.onPause,
    this.onStop,
    this.onLap,
    Key key
  }) : super(key: key);
  /// -----------------------------------------------------------------------------
  final Function onStart;
  final Function onPause;
  final Function onStop;
  final Function onLap;
/// -----------------------------------------------------------------------------
  @override
  _StopWatchBarState createState() => _StopWatchBarState();
/// -----------------------------------------------------------------------------
}

class _StopWatchBarState extends State<StopWatchBar> {
// -----------------------------------------------------------------------------
  /// STOP WATCH
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final bool _isHours = true;
  final ScrollController _logScrollController = ScrollController();
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _logScrollController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _startCounter() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);

    if (widget.onStart != null){
      widget.onStart();
    }
  }
// -------------------------------
  void _pauseCounter() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);

    if (widget.onPause != null){
      widget.onPause();
    }

  }
// -------------------------------
  Future<void> _lapCounter() async {
    _stopWatchTimer.onExecute.add(StopWatchExecute.lap);

    if (widget.onLap != null){
      widget.onLap();
    }

    await _logScrollController.animateTo(
      _logScrollController.position.maxScrollExtent + 20,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );

  }
// -------------------------------
  void _stopCounter() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    if (widget.onStop != null){
      widget.onStop();
    }
  }
// -----------------------------------------------------------------------------
  Widget button({
    @required String icon,
    @required Function onTap,
  }){

    final double _boxWidth = BldrsAppBar.width(context);
    final double _buttonSize = (_boxWidth * 0.5) / 4;

    return DreamBox(
        height: _buttonSize,
        width: _buttonSize,
        icon: icon,
        iconSizeFactor: 0.5,
        verseShadow: false,
        onTap: onTap,
      );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxWidth = BldrsAppBar.width(context);
    final double _boxHeight = BldrsAppBar.height(context, AppBarType.basic) * 2;

    return Container(
      width: _boxWidth,
      height: _boxHeight,
      decoration: const BoxDecoration(
        borderRadius: BldrsAppBar.corners,
        color: Colorz.white20
      ),
      child: Row(
        children: <Widget>[

          /// COUNTER AND CONTROLS
          SizedBox(
            width: _boxWidth * 0.5,
            height: _boxHeight,
            child: Column(
              children: <Widget>[

                /// COUNTER
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (BuildContext context, AsyncSnapshot<int> snap) {
                    final int value = snap.data;

                    final String displayTime = StopWatchTimer.getDisplayTime(value, hours: _isHours);

                    return DreamBox(
                      height: _boxHeight * 0.5,
                      width: _boxWidth * 0.5,
                      verse: Verse.plain(displayTime),
                    );
                  },
                ),

                /// CONTROLS
                SizedBox(
                  width: _boxWidth * 0.5,
                  height: _boxHeight * 0.5,
                  child: Row(
                    children: <Widget>[

                      /// START
                      button(
                        icon: Iconz.play,
                        onTap: _startCounter,
                      ),

                      /// PAUSE
                      button(
                        icon: Iconz.pause,
                        onTap: _pauseCounter,
                      ),

                      /// STOP
                      button(
                        icon: Iconz.stop,
                        onTap: _stopCounter,
                      ),

                      /// LAP
                      button(
                        icon: Iconz.reload,
                        onTap: _lapCounter,
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),

          /// LOG
          SizedBox(
            width: _boxWidth * 0.5,
            height: _boxHeight,
            child: StreamBuilder<List<StopWatchRecord>>(
              stream: _stopWatchTimer.records,
              initialData: _stopWatchTimer.records.value,
              builder: (BuildContext context, AsyncSnapshot<List<StopWatchRecord>> snap) {
                final List<StopWatchRecord> records = snap.data;

                if (records.isEmpty) {
                  return const SizedBox();
                }

                else {
                  return ListView.builder(
                      itemCount: records.length,
                      controller: _logScrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (BuildContext ctx, int index) {

                        final StopWatchRecord record = records[index];

                        final String _verse = '${index + 1} : ${record.displayTime}';
                        final String _highlighted = TextMod.removeTextBeforeLastSpecialCharacter(_verse, ': ');

                        return SuperVerse(
                          verse: Verse.plain(_verse),
                          weight: VerseWeight.thin,
                          highlight: ValueNotifier<String>(_highlighted),
                        );
                      });
                }
              },
            ),
          ),

        ],
      ),

    );
  }

}
