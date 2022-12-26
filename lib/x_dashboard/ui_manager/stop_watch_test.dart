import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_controller.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_counter_builder.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_records_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_button.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const StopWatchTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _StopWatchTestState createState() => _StopWatchTestState();
/// --------------------------------------------------------------------------
}

class _StopWatchTestState extends State<StopWatchTest> {

  StopWatchController stopWatchController;
  final ScrollController scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
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

    stopWatchController = StopWatchController(

    );
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _boxWidth = BldrsAppBar.width(context);
    final double _boxHeight = BldrsAppBar.height(context, AppBarType.basic) * 2;
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: const Verse(
        text: 'Stop watch test Screen',
        translate: false,
      ),
      skyType: SkyType.black,
      child: FloatingList(
        columnChildren: <Widget>[

          Container(
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
                      StopWatchCounterBuilder(
                          controller: stopWatchController,
                          builder: (String displayTime){
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
                            StopWatchButton(
                              icon: Iconz.play,
                              onTap: stopWatchController.start,
                            ),

                            /// PAUSE
                            StopWatchButton(
                              icon: Iconz.pause,
                              onTap: stopWatchController.pause,
                            ),

                            /// STOP
                            StopWatchButton(
                              icon: Iconz.stop,
                              onTap: stopWatchController.stop,
                            ),

                            /// LAP
                            StopWatchButton(
                              icon: Iconz.reload,
                              onTap: stopWatchController.lap,
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
                  child: StopWatchRecordsBuilder(
                    controller: stopWatchController,
                    builder: (List<StopWatchRecord> records){

                      if (records.isEmpty) {
                        return const SizedBox();
                      }

                      else {
                        return ListView.builder(
                            itemCount: records.length,
                            controller: scrollController,
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

          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
