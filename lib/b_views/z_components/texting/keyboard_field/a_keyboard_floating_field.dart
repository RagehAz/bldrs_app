import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/aa_floating_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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

    final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
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
            shouldRebuild: (KeyboardModel old, KeyboardModel newModel){
              return old?.title != newModel?.title;
            },
            builder: (_, KeyboardModel model, Widget child){

              return WidgetFader(
                fadeType: FadeType.fadeIn,
                duration: const Duration(milliseconds: 150),
                curve: Curves.bounceOut,
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
                child: Container(
                  width: Scale.superScreenWidth(context),
                  height: Scale.superScreenHeight(context),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [

                      const Expander(),

                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colorz.skyLightBlue,
                          borderRadius: Bubble.borders(context),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            /// TITLE AND BACK
                            Container(
                              width: BldrsAppBar.width(context),
                              height: titleHeight,
                              // margin: const EdgeInsets.only(top: 10),
                              alignment: superCenterAlignment(context),
                              padding: const EdgeInsets.all(5),
                              // color: Colorz.blackSemi255,
                              child: Row(
                                children: <Widget>[

                                  BackAndSearchButton(
                                    backAndSearchAction: BackAndSearchAction.goBack,
                                    onTap: (){
                                      closeKeyboard(context);
                                    },
                                  ),

                                  Selector<UiProvider, KeyboardModel>(
                                    selector: (_, UiProvider uiPro) => uiPro.keyboardModel,
                                    shouldRebuild: (KeyboardModel old, KeyboardModel newModel){
                                      return old?.title != newModel?.title;
                                    },
                                    builder: (_, KeyboardModel model, Widget child){

                                      return SuperVerse(
                                        verse: model?.title?.toUpperCase(),
                                        margin: 10,
                                        italic: true,
                                        weight: VerseWeight.black,
                                      );

                                    },
                                  ),

                                ],
                              ),
                            ),

                            /// FIELD
                            Selector<UiProvider, KeyboardModel>(
                              selector: (_, UiProvider uiPro) => uiPro.keyboardModel,
                              shouldRebuild: (KeyboardModel old, KeyboardModel newModel){
                                return old?.title != newModel?.title;
                              },
                              builder: (_, KeyboardModel model, Widget child){

                                // blog('rebuilding field : ${model.title} : ${model.controller.hashCode} : ${model.controller.text}');

                                return FloatingField(
                                  model: model,
                                );

                              },
                            ),

                          ],
                        ),
                      ),

                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeIn,
                        width: superScreenWidth(context),
                        constraints: BoxConstraints(
                          maxHeight: _keyboardHeight + 10,
                        ),
                        color: Colorz.bloodTest,
                      ),

                    ],
                  ),
                ),
              );

            },);

        }


      },
    );

  }
}
