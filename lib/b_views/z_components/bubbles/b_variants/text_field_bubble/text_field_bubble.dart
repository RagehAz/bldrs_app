import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/model/bubble_header_vm.dart';
import 'package:basics/bubbles/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class BldrsTextFieldBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsTextFieldBubble({
    required this.bubbleHeaderVM,
    required this.appBarType,
    this.formKey,
    this.bubbleWidth,
    this.hintVerse,
    this.counterIsOn = false,
    this.maxLines = 1,
    this.maxLength = 100,
    this.textController,
    this.keyboardTextInputType = TextInputType.text,
    this.onTextChanged,
    this.isObscured,
    this.isFormField,
    this.onSavedForForm,
    this.keyboardTextInputAction,
    this.initialText,
    this.validator,
    this.bulletPoints,
    this.leadingIcon,
    this.pasteFunction,
    this.textDirection,
    this.bubbleColor = Colorz.white10,
    this.onBubbleTap,
    this.isLoading = false,
    // this.isError = false,
    this.columnChildren,
    this.onSubmitted,
    this.textSize = 2,
    this.minLines = 1,
    this.autoFocus = false,
    this.focusNode,
    this.isFloatingField = false,
    this.onFieldTap,
    this.autoValidate = true,
    super.key
  });
  /// --------------------------------------------------------------------------

  final BubbleHeaderVM bubbleHeaderVM;
  final double? bubbleWidth;
  final Verse? hintVerse;
  final bool counterIsOn;
  final int maxLines;
  final int maxLength;
  final TextEditingController? textController;
  final TextInputType keyboardTextInputType;
  final ValueChanged<String?>? onTextChanged;
  final ValueChanged<String?>? onSubmitted;
  final ValueNotifier<bool>? isObscured;
  final bool? isFormField;
  final ValueChanged<String?>? onSavedForForm;
  final TextInputAction? keyboardTextInputAction;
  final String? initialText;
  final String? Function(String?)? validator;
  final List<Verse>? bulletPoints;
  final dynamic leadingIcon;
  final Function? pasteFunction;
  final TextDirection? textDirection;
  final Color bubbleColor;
  final Function? onBubbleTap;
  final bool isLoading;
  // final bool isError;
  final List<Widget>? columnChildren;
  final int textSize;
  final int minLines;
  final bool autoFocus;
  final FocusNode? focusNode;
  final bool isFloatingField;
  final Function? onFieldTap;
  final GlobalKey? formKey;
  final AppBarType appBarType;
  final bool autoValidate;
  /// --------------------------------------------------------------------------
  // static const double pasteButtonWidth = 50;
  // --------------------
  static double _leadingIconSizeFactor(dynamic leadingIcon){
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
  // static double getFieldWidth({
  //   required String leadingIcon,
  //   required bool showUnObscure,
  //   required BuildContext context,
  //   required double bubbleWidth,
  //   required bool hasPasteButton,
  // }){
  //
  //   final double fieldHeight = BldrsTextField.getFieldHeight(
  //     context: context,
  //     minLines: 1,
  //     textSize: 2,
  //     scaleFactor: 1,
  //     withBottomMargin: false,
  //     withCounter: false,
  //   );
  //
  //
  //   final double _leadingIconSize = leadingIcon == null ? 0 : fieldHeight;
  //   final double _leadingAndFieldSpacing = leadingIcon == null ? 0 : 5;
  //   final double _obscureBtSize = showUnObscure == false ? 0 : fieldHeight;
  //   final double _obscureBtSpacing = showUnObscure == false ? 0 : 5;
  //   final double _pasteButtonWidthAndSpacing = hasPasteButton == true ? pasteButtonWidth + 5 : 0;
  //   final double _bubbleClearWidth = Bubble.clearWidth(context: context, bubbleWidthOverride: bubbleWidth);
  //   final double _fieldWidth = _bubbleClearWidth - _leadingIconSize
  //       - _leadingAndFieldSpacing - _obscureBtSize - _obscureBtSpacing - _pasteButtonWidthAndSpacing;
  //
  //   return _fieldWidth;
  // }
  // -----------------------------------------------------------------------------
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _textFieldPadding = BldrsText.superVerseSidePaddingValues(context, textSize);
    final EdgeInsets _scrollPadding = BldrsTextField.getFieldScrollPadding(
      context: context,
      appBarType: appBarType,
    );

    final double _verseSizeValue = BldrsText.superVerseSizeValue(context, textSize, 1) * 1.4;

    return TextFieldBubble(
      key: const ValueKey<String>('BldrsTextFieldBubble'),
      bubbleHeaderVM: bubbleHeaderVM,
      errorTextColor: Colorz.red255,
      enabledBorderColor: Colorz.nothing,
      focusedBorderColor: Colorz.yellow80,
      // errorBorderColor: Colorz.red125,
      focusedErrorBorderColor: Colorz.yellow80,
      // fieldColor: ,
      cursorColor: Colorz.yellow255,
      bubbleWidth: bubbleWidth,
      bubbleColor: bubbleColor,
      validator: validator,
      autoValidate: autoValidate,
      focusNode: focusNode,
      minLines: minLines,
      maxLength: maxLength,
      maxLines: maxLines,
      isObscured: isObscured,
      formKey: formKey,
      isFormField: isFormField ?? true,
      keyboardTextInputAction: keyboardTextInputAction,
      onSubmitted: onSubmitted,
      keyboardTextInputType: keyboardTextInputType,
      pasteFunction: pasteFunction,
      textController: textController,
      autoFocus: autoFocus,
      bulletPoints: Verse.bakeVerses(verses: bulletPoints),
      bulletPointsFont: BldrsText.superVerseFont(VerseWeight.thin),
      columnChildren: columnChildren,
      counterIsOn: counterIsOn,
      // fieldScrollController: null,
      fieldScrollPadding: _scrollPadding,
      // fieldTextCentered: false,
      // fieldTextColor: Colorz.white255,
      fieldTextDirection: textDirection ?? UiProvider.getAppTextDir(),
      fieldTextHeight: BldrsText.superVerseRealHeight(context: context, size: textSize, sizeFactor: 1, hasLabelBox: false),
      // fieldTextItalic: false,
      fieldTextPadding: EdgeInsets.all(_textFieldPadding),
      fieldTextWeight: BldrsText.superVerseWeight(VerseWeight.thin),
      hintText: Verse.bakeVerseToString(verse: hintVerse),
      initialText: initialText,
      // isError: isError,
      isLoading: isLoading,
      leadingIcon: leadingIcon,
      leadingIconSizeFactor: _leadingIconSizeFactor(leadingIcon),
      loadingColor: Colorz.yellow255,
      obscuredActiveColor: Colorz.yellow255,
      // obscuredIcon: Iconz.viewsIcon,
      onBubbleTap: onBubbleTap,
      onFieldTap: onFieldTap,
      onSavedForForm: onSavedForForm,
      onTextChanged: onTextChanged,
      pasteText: Verse.transBake('phid_paste'),

      fieldLetterSpacing: BldrsText.superVerseLetterSpacing(VerseWeight.thin, _verseSizeValue),
      fieldTextFont: BldrsText.superVerseFont(VerseWeight.thin),
      // fieldCorners: 0,
      fieldWordSpacing: BldrsText.superVerseWordSpacing(_verseSizeValue),
    );

    // --------------------
    // final double fieldHeight = BldrsTextField.getFieldHeight(
    //   context: context,
    //   minLines: 1,
    //   textSize: 2,
    //   scaleFactor: 1,
    //   withBottomMargin: false,
    //   withCounter: false,
    // );
    // final double leadingIconSize = leadingIcon == null ? 0 : fieldHeight;
    // final double obscureBtSize = isObscured == null ? 0 : fieldHeight;
    // final double fieldWidth = getFieldWidth(
    //   context: context,
    //   bubbleWidth: bubbleWidth,
    //   leadingIcon: leadingIcon,
    //   showUnObscure: isObscured != null,
    //   hasPasteButton: pasteFunction != null,
    // );
    // // --------------------
    // final double _bubbleWidth = Bubble.bubbleWidth(
    //     context: context,
    //     bubbleWidthOverride: bubbleWidth,
    // );
    // // --------------------
    //
    // return Bubble(
    //     bubbleColor: Formers.validatorBubbleColor(
    //       // canErrorize: true,
    //       defaultColor: bubbleColor,
    //       validator: () => Formers.bakeValidator(
    //         validator: validator,
    //         text: textController?.text,
    //         keepEmbeddedBubbleColor: true,
    //       ),
    //     ),
    //   bubbleHeaderVM: bubbleHeaderVM.copyWith(
    //     headerWidth: _bubbleWidth - 20,
    //   ),
    //     // headerViewModel: BubbleHeaderVM(
    //     //   headerWidth: _bubbleWidth - 20,
    //     //   headlineVerse: titleVerse,
    //     //   redDot: fieldIsRequired,
    //     //   leadingIcon: actionBtIcon,
    //     //   onLeadingIconTap: onHeaderLeadinIconTap,
    //     // ),
    //     width: _bubbleWidth,
    //     onBubbleTap: onBubbleTap,
    //     columnChildren: <Widget>[
    //
    //       /// BULLET POINTS
    //       if (Mapper.checkCanLoopList(bulletPoints) == true)
    //         BldrsBulletPoints(
    //           bubbleWidth: bubbleWidth,
    //           bulletPoints: bulletPoints,
    //         ),
    //
    //       /// TEXT FIELD ROW
    //       Stack(
    //         alignment: Aligners.superInverseTopAlignment(context),
    //         children: <Widget>[
    //
    //           /// TEXT FIELD
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //
    //               /// LEADING ICON
    //               if (leadingIcon != null)
    //                 DreamBox(
    //                   height: leadingIconSize,
    //                   width: leadingIconSize,
    //                   icon: leadingIcon,
    //                   iconSizeFactor: _leadingIconSizeFactor(leadingIcon),
    //                 ),
    //
    //               /// SPACER
    //               if (leadingIcon != null)
    //                 const SizedBox(width: 5,),
    //
    //               /// TEXT FIELD
    //               BldrsTextField(
    //                 appBarType: appBarType,
    //                 globalKey: formKey,
    //                 titleVerse: Verse.plain(bubbleHeaderVM.headlineText),
    //                 width: fieldWidth,
    //                 isFormField: isFormField,
    //                 textDirection: textDirection,
    //                 hintVerse: hintVerse,
    //                 counterIsOn: counterIsOn,
    //                 textInputType: keyboardTextInputType,
    //                 maxLines: maxLines,
    //                 maxLength: maxLength,
    //                 textController: textController,
    //                 onChanged: onTextChanged,
    //                 onSubmitted: onSubmitted,
    //                 onSavedForForm: onSavedForForm,
    //                 textInputAction: keyboardTextInputAction,
    //                 initialValue: initialText,
    //                 validator: validator,
    //                 focusNode: focusNode,
    //                 autofocus: autoFocus,
    //                 isFloatingField : isFloatingField,
    //                 textSize: textSize,
    //                 minLines: minLines,
    //                 onTap: onFieldTap,
    //                 isObscured: isObscured,
    //                 autoValidate: autoValidate,
    //               ),
    //
    //               /// SPACER
    //               if (isObscured != null)
    //                 const SizedBox(width: 5,),
    //
    //               /// OBSCURE BUTTON
    //               if (isObscured != null)
    //                 ValueListenableBuilder(
    //                   valueListenable: isObscured,
    //                   builder: (_, bool obscured, Widget child){
    //
    //                     return DreamBox(
    //                       height: obscureBtSize,
    //                       width: obscureBtSize,
    //                       color: obscured ? Colorz.nothing : Colorz.yellow200,
    //                       icon: Iconz.viewsIcon,
    //                       iconColor: obscured ? Colorz.white20 : Colorz.black230,
    //                       iconSizeFactor: 0.7,
    //                       bubble: false,
    //                       corners: SuperVerse.superVerseLabelCornerValue(context, 3),
    //                       onTap: (){
    //                         setNotifier(notifier: isObscured, mounted: true, value: !obscured);
    //                       },
    //                       // boxFunction: horusOnTapCancel== null ? (){} : horusOnTapCancel, // this prevents keyboard action from going to next field in the form
    //                     );
    //
    //                   },
    //                 ),
    //
    //             ],
    //           ),
    //
    //           /// LOADING INDICATOR
    //           if (isLoading == true)
    //           Loading(
    //             size: 35,
    //             loading: isLoading,
    //           ),
    //
    //           /// TASK : MOVE PASTE BUTTON TO BE INSIDE THE ROW ABOVE JUST LIKE CONTACTS BUBBLE
    //           if (pasteFunction != null)
    //             DreamBox(
    //               height: fieldHeight,
    //               width: pasteButtonWidth,
    //               verse: const Verse(
    //                 id: 'phid_paste',
    //                 translate: true,
    //               ),
    //               verseScaleFactor: 0.5,
    //               verseWeight: VerseWeight.thin,
    //               verseItalic: true,
    //               color: Colorz.white10,
    //               onTap: pasteFunction,
    //             ),
    //
    //         ],
    //       ),
    //
    //       if (Mapper.checkCanLoopList(columnChildren) == true)
    //       ...columnChildren,
    //
    //     ]
    // );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
