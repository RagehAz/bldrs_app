import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/aa_keyboard_floating_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/aaa_floating_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyboardFloatingField extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeyboardFloatingField({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  static double getTextFieldBubbleHeight({
    @required BuildContext context,
    @required int minLines,
    @required bool counterIsOn,
  }){

    final double _textFieldBubbleHeight = SuperTextField.getFieldHeight(
      context: context,
      minLines: minLines,
      textSize: FloatingField.textSize,
      scaleFactor: 1,
      withBottomMargin: false,
      withCounter: counterIsOn,
    ) + (Ratioz.appBarMargin * 2) + 30;

    return _textFieldBubbleHeight;
  }
// -----------------------------------------------------------------------------
  static const double titleHeight = 50;
// -----------------------------------------------------------------------------
  static double getTotalFloatingHeight({
    @required BuildContext context,
    @required int minLines,
    @required bool counterIsOn,
  }){

    final double fieldBubbleHeight = getTextFieldBubbleHeight(
      context: context,
      minLines: minLines,
      counterIsOn: counterIsOn,
    );

    final double _total = titleHeight + fieldBubbleHeight;

    return _total;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // final bool _keywordIsVisible = KeyboardVisibilityProvider?.isKeyboardVisible(context);
    // blog('in floating : _keyboardHeight : $_keyboardHeight');

    return Selector<UiProvider, bool>(
      selector: (_, UiProvider uiPro) => uiPro.keyboardIsOn,
      shouldRebuild: (bool old, bool newIsOn){
        return old != newIsOn;
      },
      child: Container(),
      builder: (_, bool _keyboardIsOn, Widget child){

        // blog('BUILDING KEYBOARD SUPER BUBBLE');

        if (_keyboardIsOn == false){
          return const SizedBox();
        }

        else {

          return Selector<UiProvider, KeyboardModel>(
            selector: (_, UiProvider uiPro) => uiPro.keyboardModel,
            // // shouldRebuild: (KeyboardModel old, KeyboardModel newModel){
            //   // return old?.titleVerse != newModel?.titleVerse;
            // // },
            builder: (_, KeyboardModel model, Widget child){

              if (model == null || model.isFloatingField == false){
                return const SizedBox();
              }

              else {

                // blog('model.isFloatingField : ${model.isFloatingField}');

                return WidgetFader(
                  fadeType: FadeType.fadeIn,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  builder: (double value, Widget child){

                    return Transform.scale(
                      scaleY: value,
                      alignment: Alignment.bottomCenter,
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );

                  },
                  child: const KeyboardFloatingBubble(),
                );
              }

            },);

        }

      },
    );

  }
}
