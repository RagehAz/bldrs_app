import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TextFieldBubble({
    @required this.bubbleHeaderVM,
    @required this.appBarType,
    // this.titleVerse,
    // this.fieldIsRequired = false,
    // this.actionBtIcon,
    // this.onHeaderLeadinIconTap,

    this.formKey,
    this.bubbleWidth,
    this.hintVerse,
    this.counterIsOn = false,
    this.maxLines = 1,
    this.maxLength = 100,
    this.textController,
    this.keyboardTextInputType = TextInputType.text,
    this.onTextChanged,
    this.canObscure = false,
    this.isFormField,
    this.onSavedForForm,
    this.keyboardTextInputAction,
    this.initialText,
    this.validator,
    this.bulletPoints,
    // this.loading = false,
    this.leadingIcon,
    this.pasteFunction,
    this.textDirection,
    this.bubbleColor = Colorz.white10,
    this.onBubbleTap,
    this.isLoading = false,
    this.isError = false,
    this.columnChildren,
    this.onSubmitted,
    this.textSize = 2,
    this.minLines = 1,
    this.autoFocus = false,
    this.focusNode,
    this.isFloatingField = false,
    this.onFieldTap,
    this.autoValidate = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------

  final BubbleHeaderVM bubbleHeaderVM;

  // final Verse titleVerse;
  // final bool fieldIsRequired;
  // final String actionBtIcon;
  // final Function onHeaderLeadinIconTap;


  final double bubbleWidth;
  final Verse hintVerse;
  final bool counterIsOn;
  final int maxLines;
  final int maxLength;
  final TextEditingController textController;
  final TextInputType keyboardTextInputType;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<String> onSubmitted;
  final bool canObscure;
  final bool isFormField;
  final ValueChanged<String> onSavedForForm;
  final TextInputAction keyboardTextInputAction;
  final String initialText;
  final String Function(String) validator;
  final List<Verse> bulletPoints;
  // final bool loading;
  final String leadingIcon;
  final Function pasteFunction;
  final TextDirection textDirection;
  final Color bubbleColor;
  final Function onBubbleTap;
  final bool isLoading;
  final bool isError;
  final List<Widget> columnChildren;
  final int textSize;
  final int minLines;
  final bool autoFocus;
  final FocusNode focusNode;
  final bool isFloatingField;
  final Function onFieldTap;
  final GlobalKey formKey;
  final AppBarType appBarType;
  final bool autoValidate;
  /// --------------------------------------------------------------------------
  static const double pasteButtonWidth = 50;
  // --------------------
  static double _leadingIconSizeFactor(String leadingIcon){
    final double _sizeFactor =
    leadingIcon == Iconz.comWebsite ||
        leadingIcon == Iconz.comEmail ||
        leadingIcon == Iconz.comPhone
        ?
    0.6
        :
    1;
    return _sizeFactor;
  }
  // --------------------
  static double getFieldWidth({
    @required String leadingIcon,
    @required bool showUnObscure,
    @required BuildContext context,
    @required double bubbleWidth,
    @required bool hasPasteButton,
  }){

    final double fieldHeight = SuperTextField.getFieldHeight(
      context: context,
      minLines: 1,
      textSize: 2,
      scaleFactor: 1,
      withBottomMargin: false,
      withCounter: false,
    );


    final double _leadingIconSize = leadingIcon == null ? 0 : fieldHeight;
    final double _leadingAndFieldSpacing = leadingIcon == null ? 0 : 5;
    final double _obscureBtSize = showUnObscure == false ? 0 : fieldHeight;
    final double _obscureBtSpacing = showUnObscure == false ? 0 : 5;
    final double _pasteButtonWidthAndSpacing = hasPasteButton == true ? pasteButtonWidth + 5 : 0;
    final double _bubbleClearWidth = Bubble.clearWidth(context, bubbleWidthOverride: bubbleWidth);
    final double _fieldWidth = _bubbleClearWidth - _leadingIconSize
        - _leadingAndFieldSpacing - _obscureBtSize - _obscureBtSpacing - _pasteButtonWidthAndSpacing;

    return _fieldWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double fieldHeight = SuperTextField.getFieldHeight(
      context: context,
      minLines: 1,
      textSize: 2,
      scaleFactor: 1,
      withBottomMargin: false,
      withCounter: false,
    );
    final double leadingIconSize = leadingIcon == null ? 0 : fieldHeight;
    final double obscureBtSize = canObscure == false ? 0 : fieldHeight;
    final double fieldWidth = getFieldWidth(
      context: context,
      bubbleWidth: bubbleWidth,
      leadingIcon: leadingIcon,
      showUnObscure: canObscure,
      hasPasteButton: pasteFunction != null,
    );
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context, bubbleWidthOverride: bubbleWidth);
    // --------------------

    return Bubble(
        bubbleColor: Formers.validatorBubbleColor(
          // canErrorize: true,
          defaultColor: bubbleColor,
          validator: () => Formers.bakeValidator(
            validator: validator,
            text: textController?.text,
            keepEmbeddedBubbleColor: true,
          ),
        ),
      bubbleHeaderVM: bubbleHeaderVM.copyWith(
        headerWidth: _bubbleWidth - 20,
      ),
        // headerViewModel: BubbleHeaderVM(
        //   headerWidth: _bubbleWidth - 20,
        //   headlineVerse: titleVerse,
        //   redDot: fieldIsRequired,
        //   leadingIcon: actionBtIcon,
        //   onLeadingIconTap: onHeaderLeadinIconTap,
        // ),
        width: _bubbleWidth,
        onBubbleTap: onBubbleTap,
        columnChildren: <Widget>[

          /// BULLET POINTS
          if (Mapper.checkCanLoopList(bulletPoints) == true)
            BulletPoints(
              bubbleWidth: bubbleWidth,
              bulletPoints: bulletPoints,
            ),

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
                      height: leadingIconSize,
                      width: leadingIconSize,
                      icon: leadingIcon,
                      iconSizeFactor: _leadingIconSizeFactor(leadingIcon),
                    ),

                  /// SPACER
                  if (leadingIcon != null)
                    const SizedBox(width: 5,),

                  /// TEXT FIELD
                  SuperTextField(
                    appBarType: appBarType,
                    globalKey: formKey,
                    titleVerse: bubbleHeaderVM.headlineVerse,
                    width: fieldWidth,
                    isFormField: isFormField,
                    textDirection: textDirection,
                    hintVerse: hintVerse,
                    counterIsOn: counterIsOn,
                    textInputType: keyboardTextInputType,
                    maxLines: maxLines,
                    maxLength: maxLength,
                    textController: textController,
                    onChanged: onTextChanged,
                    onSubmitted: onSubmitted,
                    onSavedForForm: onSavedForForm,
                    textInputAction: keyboardTextInputAction,
                    initialValue: initialText,
                    validator: validator,
                    focusNode: focusNode,
                    autofocus: autoFocus,
                    isFloatingField : isFloatingField,
                    textSize: textSize,
                    minLines: minLines,
                    onTap: onFieldTap,
                    canObscure: canObscure,
                    autoValidate: autoValidate,
                  ),

                  /// SPACER
                  if (canObscure == true)
                    const SizedBox(width: 5,),

                  /// OBSCURE BUTTON
                  if (canObscure == true)
                    Consumer<UiProvider>(
                      builder: (_, UiProvider uiPro, Widget child){

                        final bool obscured = uiPro.textFieldsObscured;

                        return DreamBox(
                          height: obscureBtSize,
                          width: obscureBtSize,
                          color: obscured ? Colorz.nothing : Colorz.yellow200,
                          icon: Iconz.viewsIcon,
                          iconColor: obscured ? Colorz.white20 : Colorz.black230,
                          iconSizeFactor: 0.7,
                          bubble: false,
                          corners: SuperVerse.superVerseLabelCornerValue(context, 3),
                          onTap: (){
                            uiPro.triggerTextFieldsObscured(notify: true);
                          },
                          // boxFunction: horusOnTapCancel== null ? (){} : horusOnTapCancel, // this prevents keyboard action from going to next field in the form
                        );

                      },
                    ),

                ],
              ),

              /// LOADING INDICATOR
              if (isLoading == true)
              Loading(
                size: 35,
                loading: isLoading,
              ),

              /// TASK : MOVE PASTE BUTTON TO BE INSIDE THE ROW ABOVE JUST LIKE CONTACTS BUBBLE
              if (pasteFunction != null)
                DreamBox(
                  height: fieldHeight,
                  width: pasteButtonWidth,
                  verse: const Verse(
                    text: 'phid_paste',
                    translate: true,
                  ),
                  verseScaleFactor: 0.5,
                  verseWeight: VerseWeight.thin,
                  verseItalic: true,
                  color: Colorz.white10,
                  onTap: pasteFunction,
                ),

            ],
          ),

          if (Mapper.checkCanLoopList(columnChildren) == true)
          ...columnChildren,

        ]
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
