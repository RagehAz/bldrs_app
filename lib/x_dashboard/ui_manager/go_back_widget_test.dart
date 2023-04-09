import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/router/go_back_widget.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
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
                  return const BldrsText(
                    verse: Verse(
                      id: 'Go Back Widget is off',
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
