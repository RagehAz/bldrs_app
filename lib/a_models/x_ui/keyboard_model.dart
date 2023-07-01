import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class KeyboardModel {
  // -----------------------------------------------------------------------------
  const KeyboardModel({
    required this.titleVerse,
    this.initialText,
    this.hintVerse,
    this.minLines = 1,
    this.maxLines = 2,
    this.maxLength,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.focusNode,
    this.isObscured,
    this.counterIsOn = false,
    this.isFormField = false,
    this.onChanged,
    this.onSubmitted,
    this.onSavedForForm,
    this.onEditingComplete,
    this.isFloatingField = true,
    this.globalKey,
    this.validator,
  });
  // -----------------------------------------------------------------------------
  final Verse? titleVerse;
  final Verse? hintVerse;
  final String? initialText;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final ValueNotifier<bool>? isObscured;
  final bool? counterIsOn;
  final bool? isFormField;

  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final ValueChanged<String?>? onSavedForForm;
  final Function? onEditingComplete;
  final bool? isFloatingField;
  final GlobalKey<FormState>? globalKey;
  final String Function(String? text)? validator;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  KeyboardModel copyWith({
    Verse? titleVerse,
    Verse? hintVerse,
    String? initialText,
    int? minLines,
    int? maxLines,
    int? maxLength,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    FocusNode? focusNode,
    ValueNotifier<bool>? isObscured,
    bool? counterIsOn,
    bool? isFormField,
    ValueChanged<String?>? onChanged,
    ValueChanged<String?>? onSubmitted,
    ValueChanged<String?>? onSavedForForm,
    Function? onEditingComplete,
    bool? isFloatingField,
    GlobalKey<FormState>? globalKey,
    String Function(String? text)? validator,
  }){
    return KeyboardModel(
      titleVerse: titleVerse ?? this.titleVerse,
      hintVerse: hintVerse ?? this.hintVerse,
      initialText: initialText ?? this.initialText,
      minLines: minLines ?? this.minLines,
      maxLines: maxLines ?? this.maxLines,
      maxLength: maxLength ?? this.maxLength,
      textInputAction: textInputAction ?? this.textInputAction,
      textInputType: textInputType ?? this.textInputType,
      focusNode: focusNode ?? this.focusNode,
      isObscured: isObscured ?? this.isObscured,
      counterIsOn: counterIsOn ?? this.counterIsOn,
      isFormField: isFormField ?? this.isFormField,
      onChanged: onChanged ?? this.onChanged,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      onSavedForForm: onSavedForForm ?? this.onSavedForForm,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      isFloatingField: isFloatingField ?? this.isFloatingField,
      globalKey: globalKey ?? this.globalKey,
      validator: validator ?? this.validator,
    );
  }
  // -----------------------------------------------------------------------------

  /// STANDARD

  // --------------------
  static KeyboardModel standardModel(){
    return const KeyboardModel(
      titleVerse: null,
      hintVerse: Verse(
        id: '...',
        translate: false,
      ),
      // minLines: 1,
      maxLines: 1,
      // maxLength: null,
      // textInputAction: TextInputAction.done,
      // textInputType: TextInputType.text,
      // focusNode: null,
      // canObscure: false,
      // counterIsOn: false,
      // isFormField: false,
      // onChanged: null,
      // onSubmitted: null,
      // onSavedForForm: null,
      // onEditingComplete: null,
      isFloatingField: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkKeyboardsAreIdentical({
    required KeyboardModel? modelA,
    required KeyboardModel? modelB,
  }){
    bool _areIdentical = false;

    if (modelA == null && modelB == null){
      _areIdentical = true;
    }

    else if (
        modelA != null && modelB != null &&
        modelA.titleVerse == modelB.titleVerse &&
        modelA.hintVerse == modelB.hintVerse &&
        modelA.initialText == modelB.initialText &&
        modelA.minLines == modelB.minLines &&
        modelA.maxLines == modelB.maxLines &&
        modelA.maxLength == modelB.maxLength &&
        modelA.textInputAction == modelB.textInputAction &&
        modelA.textInputType == modelB.textInputType &&
        modelA.focusNode == modelB.focusNode &&
        modelA.isObscured == modelB.isObscured &&
        modelA.counterIsOn == modelB.counterIsOn &&
        modelA.isFormField == modelB.isFormField &&
        modelA.onChanged == modelB.onChanged &&
        modelA.onSubmitted == modelB.onSubmitted &&
        modelA.onSavedForForm == modelB.onSavedForForm &&
        modelA.onEditingComplete == modelB.onEditingComplete &&
        modelA.isFloatingField == modelB.isFloatingField &&
        modelA.globalKey == modelB.globalKey &&
        modelA.validator == modelB.validator
    ){
      _areIdentical = true;
    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is KeyboardModel){
      _areIdentical = checkKeyboardsAreIdentical(
        modelA: this,
        modelB: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      initialText.hashCode^
      titleVerse.hashCode^
      hintVerse.hashCode^
      minLines.hashCode^
      maxLines.hashCode^
      maxLength.hashCode^
      textInputAction.hashCode^
      textInputType .hashCode^
      focusNode.hashCode^
      isObscured.hashCode^
      counterIsOn.hashCode^
      isFormField.hashCode^
      onChanged.hashCode^
      onSubmitted.hashCode^
      onSavedForForm.hashCode^
      onEditingComplete.hashCode^
      isFloatingField.hashCode^
      validator.hashCode^
      globalKey.hashCode;
  // -----------------------------------------------------------------------------
}
