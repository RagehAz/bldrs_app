import 'package:flutter/material.dart';

class KeyboardModel {

  const KeyboardModel({
    @required this.title,
    @required this.hintText,
    @required this.controller,
    @required this.minLines,
    @required this.maxLines,
    @required this.maxLength,
    @required this.textInputAction,
    @required this.textInputType,
    @required this.focusNode,
    @required this.canObscure,
    @required this.counterIsOn,
});

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

}
