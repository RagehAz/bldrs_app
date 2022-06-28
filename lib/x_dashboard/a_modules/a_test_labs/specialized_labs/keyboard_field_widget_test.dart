import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class KeyboardFieldWidgetTest extends StatelessWidget {

  const KeyboardFieldWidgetTest({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colorz.black255,
        body: ListView(
          children: <Widget>[

            const Stratosphere(),

            SuperTextField(
              width: 200,
              fieldColor: Colorz.bloodTest,
              onTap: () async {

                // await WaitDialog.showWaitDialog(
                //   context: context,
                //   canManuallyGoBack: true,
                // );

              },
            ),

          ],
        ),
        bottomSheet: const KeyboardFieldWidget(),
      ),
    );

  }
}

class KeyboardFieldWidget extends StatelessWidget {

  const KeyboardFieldWidget({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bool _keyboardIs = keyboardIsOn(context);

    if (_keyboardIs == false){
      return const SizedBox();
    }

    else {
      return Container(
        width: superScreenWidth(context),
        height: 400,
        color: Colorz.black255,
        alignment: Alignment.center,
        child: WidgetFader(
          fadeType: FadeType.fadeIn,
          duration: const Duration(milliseconds: 250),
          builder: (double value, Widget child){

            blog('widget fader : $value');

            return Transform.scale(
              scaleY: value,
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );

          },
          child: Bubble(
            width: BldrsAppBar.width(context),
            title: 'text field title',
            bubbleColor: Colorz.white20,
            columnChildren: <Widget>[

              SuperTextField(
                width: BldrsAppBar.width(context) - 20,
              ),

            ],
          ),
        ),
      );
    }

  }
}
