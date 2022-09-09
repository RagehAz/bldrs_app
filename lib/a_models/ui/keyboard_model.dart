import 'package:flutter/material.dart';

@immutable
class KeyboardModel {
  // -----------------------------------------------------------------------------
  const KeyboardModel({
    @required this.controller,
    @required this.titleVerse,
    this.hintVerse = '...',
    this.minLines = 1,
    this.maxLines = 2,
    this.maxLength,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.focusNode,
    this.canObscure = false,
    this.counterIsOn = false,
    this.isFormField = false,
    this.onChanged,
    this.onSubmitted,
    this.onSavedForForm,
    this.onEditingComplete,
    this.isFloatingField = true,
    this.globalKey,
  }): assert(controller != null, 'KeyboardModel controller should NEVER be null');
  // -----------------------------------------------------------------------------
  final String titleVerse;
  final String hintVerse;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode focusNode;
  final bool canObscure;
  final bool counterIsOn;
  final bool isFormField;

  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onSavedForForm;
  final Function onEditingComplete;
  final bool isFloatingField;
  final GlobalKey<FormState> globalKey;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  KeyboardModel copyWith({
    String titleVerse,
    String hintVerse,
    TextEditingController controller,
    int minLines,
    int maxLines,
    int maxLength,
    TextInputAction textInputAction,
    TextInputType textInputType,
    FocusNode focusNode,
    bool canObscure,
    bool counterIsOn,
    bool isFormField,
    ValueChanged<String> onChanged,
    ValueChanged<String> onSubmitted,
    ValueChanged<String> onSavedForForm,
    Function onEditingComplete,
    bool isFloatingField,
    GlobalKey<FormState> globalKey,
  }){
    return KeyboardModel(
      titleVerse: titleVerse ?? this.titleVerse,
      hintVerse: hintVerse ?? this.hintVerse,
      controller: controller ?? this.controller,
      minLines: minLines ?? this.minLines,
      maxLines: maxLines ?? this.maxLines,
      maxLength: maxLength ?? this.maxLength,
      textInputAction: textInputAction ?? this.textInputAction,
      textInputType: textInputType ?? this.textInputType,
      focusNode: focusNode ?? this.focusNode,
      canObscure: canObscure ?? this.canObscure,
      counterIsOn: counterIsOn ?? this.counterIsOn,
      isFormField: isFormField ?? this.isFormField,
      onChanged: onChanged ?? this.onChanged,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      onSavedForForm: onSavedForForm ?? this.onSavedForForm,
      onEditingComplete: onEditingComplete ?? this.onEditingComplete,
      isFloatingField: isFloatingField ?? this.isFloatingField,
      globalKey: globalKey ?? this.globalKey,
    );
  }
  // -----------------------------------------------------------------------------

  /// STANDARD

  // --------------------
  static KeyboardModel standardModel(){
    return KeyboardModel(
      titleVerse: null,
      // hintText: '...',
      controller: TextEditingController(),
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
    @required KeyboardModel modelA,
    @required KeyboardModel modelB,
  }){
    bool _areIdentical = false;

    if (modelA == null && modelB == null){
      _areIdentical = true;
    }
    else if (
    modelA.titleVerse == modelB.titleVerse &&
        modelA.hintVerse == modelB.hintVerse &&
        modelA.controller == modelB.controller &&
        modelA.minLines == modelB.minLines &&
        modelA.maxLines == modelB.maxLines &&
        modelA.maxLength == modelB.maxLength &&
        modelA.textInputAction == modelB.textInputAction &&
        modelA.textInputType == modelB.textInputType &&
        modelA.focusNode == modelB.focusNode &&
        modelA.canObscure == modelB.canObscure &&
        modelA.counterIsOn == modelB.counterIsOn &&
        modelA.isFormField == modelB.isFormField &&
        modelA.onChanged == modelB.onChanged &&
        modelA.onSubmitted == modelB.onSubmitted &&
        modelA.onSavedForForm == modelB.onSavedForForm &&
        modelA.onEditingComplete == modelB.onEditingComplete &&
        modelA.isFloatingField == modelB.isFloatingField &&
        modelA.globalKey == modelB.globalKey
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
      controller.hashCode^
      titleVerse.hashCode^
      hintVerse.hashCode^
      minLines.hashCode^
      maxLines.hashCode^
      maxLength.hashCode^
      textInputAction.hashCode^
      textInputType .hashCode^
      focusNode.hashCode^
      canObscure.hashCode^
      counterIsOn.hashCode^
      isFormField.hashCode^
      onChanged.hashCode^
      onSubmitted.hashCode^
      onSavedForForm.hashCode^
      onEditingComplete.hashCode^
      isFloatingField.hashCode^
      globalKey.hashCode;
  // -----------------------------------------------------------------------------
}
