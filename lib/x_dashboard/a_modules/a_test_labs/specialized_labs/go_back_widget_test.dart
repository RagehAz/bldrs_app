import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class GoBackWidgetTest extends StatefulWidget {

  const GoBackWidgetTest({
    Key key
  }) : super(key: key);

  @override
  State<GoBackWidgetTest> createState() => _GoBackWidgetTestState();
}

class _GoBackWidgetTestState extends State<GoBackWidgetTest> {

  final ValueNotifier<bool> backWidgetIsOn = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {


    return DashBoardLayout(
        listWidgets: <Widget>[

          ValueListenableBuilder(
              valueListenable: backWidgetIsOn,
              builder: (_, bool isOn, Widget child){

                final String _text = isOn == true ? 'Switch off' : 'Switch on';

                return WideButton(
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
                    verse: 'Go Back Widget is off',
                  );
                }

              }
          ),

        ],
    );

  }
}

class GoBackWidget extends StatelessWidget {

  const GoBackWidget({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    blog('GoBackWidget : should go back now ahoooooooooooooooooooooooo');

    Nav.goBack(context);

    return const SizedBox();

  }
}
