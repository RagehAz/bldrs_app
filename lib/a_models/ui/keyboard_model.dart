import 'package:flutter/material.dart';

class KeyboardModel {
// -----------------------------------------------------------------------------
  const KeyboardModel({
    @required this.controller,
    @required this.title,
    this.hintText = '...',
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
}): assert(controller != null, 'KeyboardModel controller should NEVER be null');
// -----------------------------------------------------------------------------
  final String title;
  final String hintText;
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
// -----------------------------------------------------------------------------
  KeyboardModel copyWith({
    String title,
    String hintText,
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
}){
    return KeyboardModel(
      title: title ?? this.title,
      hintText: hintText ?? this.hintText,
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
    );
  }
// -----------------------------------------------------------------------------
  static KeyboardModel standardModel(){
    return KeyboardModel(
      title: null,
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
}
