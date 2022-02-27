import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TextFieldBubble({
    @required this.title,
    this.hintText = '...',
    this.counterIsOn = false,
    this.maxLines = 1,
    this.maxLength = 100,
    this.textController,
    this.keyboardTextInputType = TextInputType.text,
    this.textOnChanged,
    this.obscured = false,
    this.fieldIsFormField,
    this.onSaved,
    this.keyboardTextInputAction,
    this.initialTextValue,
    this.validator,
    this.comments,
    this.fieldIsRequired = false,
    // this.loading = false,
    this.actionBtIcon,
    this.actionBtFunction,
    this.onObscureTap,
    this.leadingIcon,
    this.pasteFunction,
    this.textDirection,
    this.bubbleColor = Colorz.white20,
    this.fieldOnTap,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String title;
  final String hintText;
  final bool counterIsOn;
  final int maxLines;
  final int maxLength;
  final TextEditingController textController;
  final TextInputType keyboardTextInputType;
  final ValueChanged<String> textOnChanged;
  final bool obscured;
  final bool fieldIsFormField;
  final ValueChanged<String> onSaved;
  final TextInputAction keyboardTextInputAction;
  final String initialTextValue;
  final ValueChanged<String> validator;
  final String comments;
  final bool fieldIsRequired;
  // final bool loading;
  final String actionBtIcon;
  final Function actionBtFunction;
  final Function onObscureTap;
  final String leadingIcon;
  final Function pasteFunction;
  final TextDirection textDirection;
  final Color bubbleColor;
  final Function fieldOnTap;

  /// --------------------------------------------------------------------------
  static double _leadingIconSizeFactor(String leadingIcon){
    final double _sizeFactor =
    leadingIcon == Iconz.comWebsite ||
        leadingIcon == Iconz.comEmail ||
        leadingIcon == Iconz.comPhone ?
    0.6
        :
    1;

    return _sizeFactor;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // int titleVerseSize = 2;
    // double actionBtSize = superVerseRealHeight(context, titleVerseSize, 1, null);
    // double actionBtCorner = actionBtSize * 0.4;
    final double leadingIconSize = leadingIcon == null ? 0 : 35;
    final double leadingAndFieldSpacing = leadingIcon == null ? 0 : 5;
    final double obscureBtSize = obscured == null ? 0 : 35;
    final double obscureBtSpacing = obscured == null ? 0 : 5;
    final double bubbleClearWidth = Bubble.clearWidth(context);
    final double fieldWidth = bubbleClearWidth - leadingIconSize - leadingAndFieldSpacing - obscureBtSize - obscureBtSpacing - 10;

    return Bubble(
        bubbleColor: bubbleColor,
        title: title,
        redDot: fieldIsRequired,
        actionBtIcon: actionBtIcon,
        actionBtFunction: actionBtFunction,
        width: Bubble.defaultWidth(context),
        columnChildren: <Widget>[

          /// TEXT FIELD ROW
          Stack(
            alignment: Aligners.superInverseTopAlignment(context),
            children: <Widget>[

              /// TEXT FIELD
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// LEADING ICON
                  if (leadingIcon != null)
                    DreamBox(
                      height: 35,
                      width: 35,
                      icon: leadingIcon,
                      iconSizeFactor: _leadingIconSizeFactor(leadingIcon),
                    ),

                  /// SPACER
                  if (leadingIcon != null)
                    const SizedBox(width: 5,),

                  /// TEXT FIELD
                  SizedBox(
                    width: fieldWidth,
                    child: SuperTextField(
                      onTap: fieldOnTap,
                      textDirection: textDirection,
                      fieldIsFormField: fieldIsFormField,
                      hintText: hintText,
                      counterIsOn: counterIsOn,
                      keyboardTextInputType: keyboardTextInputType,
                      maxLines: maxLines,
                      maxLength: maxLength,
                      textController: textController,
                      onChanged: textOnChanged,
                      obscured: obscured,
                      onSaved: onSaved,
                      keyboardTextInputAction: keyboardTextInputAction,
                      initialValue: initialTextValue,
                      validator: validator,
                      key: key,
                    ),
                  ),

                  /// SPACER
                  if (onObscureTap != null)
                    const SizedBox(width: 5,),

                  /// OBSCURE BUTTON
                  if (onObscureTap != null)
                    DreamBox(
                      height: 35,
                      width: 35,
                      color: obscured ? Colorz.nothing : Colorz.yellow200,
                      icon: Iconz.viewsIcon,
                      iconColor: obscured ? Colorz.white20 : Colorz.black230,
                      iconSizeFactor: 0.7,
                      bubble: false,
                      onTap: onObscureTap,
                      // boxFunction: horusOnTapCancel== null ? (){} : horusOnTapCancel, // this prevents keyboard action from going to next field in the form
                      corners: SuperVerse.superVerseLabelCornerValue(context, 3),
                    ),
                ],
              ),

              /// LOADING INDICATOR
              Selector<UiProvider, bool>(
                selector: (_, UiProvider uiProvider) => uiProvider.isLoading,
                child: const Loading(
                  size: 35,
                  loading: true,
                ),
                // shouldRebuild: ,
                builder: (BuildContext context, bool loading, Widget child){

                  if (loading == true) {
                    return child;
                  }

                  else {
                    return const SizedBox();
                  }

                  },
              ),

              /// PASTE BUTTON
              if (keyboardTextInputType == TextInputType.url)
                DreamBox(
                  height: 35,
                  verse: 'paste  ',
                  verseScaleFactor: 0.5,
                  verseWeight: VerseWeight.thin,
                  verseItalic: true,
                  color: Colorz.white10,
                  onTap: pasteFunction,
                ),

            ],
          ),

          /// BUBBLE COMMENTS
          if (comments != null)
            SuperVerse(
              verse: comments,
              italic: true,
              color: Colorz.white80,
              weight: VerseWeight.thin,
              leadingDot: true,
            ),

        ]
    );
  }
}

// class ShowPassword extends StatelessWidget {
//   final bool obscured;
//   final Function onTapDown;
//   final Function onTapUp;
//   final Function onTapCancel;
//   final int verseSize;
//
//   ShowPassword({
//     this.obscured = false,
//     this.onTapDown,
//     this.onTapUp,
//     this.onTapCancel,
//     this.verseSize = 3,
// });
//
//   @override
//   Widget build(BuildContext context) {
//     return DreamBox(
//       height: 35,
//       width: 35,
//       color: obscured? Colorz.Nothing : Colorz.YellowLingerie,
//       icon: Iconz.Views,
//       iconColor: obscured? Colorz.WhiteGlass : Colorz.Black225,
//       iconSizeFactor: 0.7,
//       bubble: false,
//       onTapDown: onTapDown == null ? (){} : onTapDown,
//       onTapUp: onTapUp == null ? (){} : onTapUp,
//       onTapCancel: onTapCancel == null ? (){} : onTapCancel,
//       boxFunction: onTapCancel == null ? (){} : onTapCancel,
//       corners: superVerseLabelCornerValue(context, verseSize),
//     );
//   }
// }
