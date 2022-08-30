import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/a_keyboard_floating_field.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_field/aaa_floating_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyboardFloatingBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const KeyboardFloatingBubble({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        // /// TOP FAKE EXPANDER TO PUSH DOWNWARDS
        // const Expander(),

        /// FIELD BUBBLE
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colorz.black255,
            borderRadius: Bubble.borders(context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// TITLE AND BACK
              Container(
                width: BldrsAppBar.width(context),
                height: KeyboardFloatingField.titleHeight,
                // margin: const EdgeInsets.only(top: 10),
                alignment: Aligners.superCenterAlignment(context),
                padding: const EdgeInsets.all(5),
                // color: Colorz.blackSemi255,
                child: Row(
                  children: <Widget>[

                    BackAndSearchButton(
                      backAndSearchAction: BackAndSearchAction.goBack,
                      icon: Iconz.arrowDown,
                      iconSizeFactor: 0.5,
                      onTap: (){
                        Keyboard.closeKeyboard(context);
                      },
                    ),

                    Selector<UiProvider, KeyboardModel>(
                      selector: (_, UiProvider uiPro) => uiPro.keyboardModel,
                      shouldRebuild: (KeyboardModel old, KeyboardModel newModel){
                        return KeyboardModel.checkKeyboardsAreIdentical(
                            modelA: old,
                            modelB: newModel,
                        ) == false;
                      },
                      builder: (_, KeyboardModel model, Widget child){

                        return SuperVerse(
                          verse: model?.titleVerse?.toUpperCase(),
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
                  return KeyboardModel.checkKeyboardsAreIdentical(
                    modelA: old,
                    modelB: newModel,
                  ) == false;
                },
                builder: (_, KeyboardModel model, Widget child){

                  return FloatingField(
                    model: model,
                  );

                },
              ),

            ],
          ),
        ),

        /// BOTTOM PADDING
        AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          curve: Curves.ease,
          width: Scale.superScreenWidth(context),
          constraints: BoxConstraints(
            maxHeight: _keyboardHeight + 10,
          ),
          color: Colorz.nothing,
        ),

      ],
    );

  }
}
