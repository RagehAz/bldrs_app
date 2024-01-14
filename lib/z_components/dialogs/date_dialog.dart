import 'package:flutter/material.dart';

Future<void> showDatePickerDialog(BuildContext context) async {

  FocusScope.of(context).requestFocus(FocusNode());

  await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(DateTime.now().year),
    lastDate: DateTime(DateTime.now().year + 50),
  );

}
