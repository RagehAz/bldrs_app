import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
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
                  translate: false,
                  verse: _text,
                  onTap: (){

                    backWidgetIsOn.value = !backWidgetIsOn.value;

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
                    verse:  'Go Back Widget is off',
                  );
                }

              }
          ),

        ],
    );

  }
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
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'GoBackWidget',);
    }
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {
        // -------------------------------
        Nav.goBackToHomeScreen(
          context: context,
          invoker: 'GoBackWidgetTest',
        );
        // -------------------------------
        await _triggerLoading();

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('GoBackWidget : should go back now ahoooooooooooooooooooooooo');

    return Container(
      width: Scale.superScreenWidth(context),
      height: Scale.superScreenHeight(context),
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
}
