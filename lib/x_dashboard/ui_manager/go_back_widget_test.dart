import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';

import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class GoBackWidgetTest extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GoBackWidgetTest({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<GoBackWidgetTest> createState() => _GoBackWidgetTestState();
/// --------------------------------------------------------------------------
}

class _GoBackWidgetTestState extends State<GoBackWidgetTest> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> backWidgetIsOn = ValueNotifier<bool>(false);
  // -----------------------------------------------------------------------------
  @override
  void dispose() {
    backWidgetIsOn.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
        listWidgets: <Widget>[

          ValueListenableBuilder(
              valueListenable: backWidgetIsOn,
              builder: (_, bool isOn, Widget child){

                final String _text = isOn == true ? 'Switch off' : 'Switch on';

                return WideButton(
                  verse: Verse.plain(_text),
                  onTap: (){

                    setNotifier(
                        notifier: backWidgetIsOn,
                        mounted: mounted,
                        value: !backWidgetIsOn.value,
                    );

                  },
                );

              }
          ),

          ValueListenableBuilder(
              valueListenable: backWidgetIsOn,
              builder: (_, bool isOn, Widget child){

                if (isOn == true){
                  return const GoBackWidget();
                }

                else {
                  return const SuperVerse(
                    verse: Verse(
                      text: 'Go Back Widget is off',
                      translate: false,
                    ),
                  );
                }

              }
          ),

        ],
    );

  }
  // -----------------------------------------------------------------------------
}

class GoBackWidget extends StatefulWidget {

  const GoBackWidget({
    Key key
  }) : super(key: key);

  @override
  State<GoBackWidget> createState() => _GoBackWidgetState();

}

class _GoBackWidgetState extends State<GoBackWidget> {
  /// Stream<List<NoteModel>> _receivedNotesStream;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        await Nav.pushHomeAndRemoveAllBelow(
          context: context,
          invoker: 'GoBackWidgetTest',
        );
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
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

    blog('GoBackWidget : should go back now ahoooooooooooooooooooooooo');

    return Container(
      width: Scale.screenWidth(context),
      height: Scale.screenHeight(context),
      color: Colorz.black230,
      // child: const Center(
      //   child: SuperVerse(
      //     verse:  'Wtf are you doing here ?',
      //     size: 5,
      //     weight: VerseWeight.black,
      //   ),
      // ),
    );

  }
  // -----------------------------------------------------------------------------
}
