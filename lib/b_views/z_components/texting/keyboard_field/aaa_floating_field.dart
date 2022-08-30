import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FloatingField extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FloatingField({
    @required this.model,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final KeyboardModel model;
  /// --------------------------------------------------------------------------
  static int textSize = 3;

  @override
  Widget build(BuildContext context) {

    return TextFieldBubble(
      appBarType: AppBarType.non,
      textController: model?.controller,
      bubbleWidth: BldrsAppBar.width(context) - 20,
      bubbleColor: Colorz.nothing,
      textSize: textSize,
      minLines: model?.minLines,
      maxLines: 6, //model?.maxLines,
      maxLength: model?.maxLength,
      keyboardTextInputAction: model?.textInputAction,
      keyboardTextInputType: model?.textInputType,
      hintText: model?.hintVerse,
      autoFocus: true,
      focusNode: model?.focusNode,
      isFloatingField: model?.isFloatingField,
      canObscure: model?.canObscure,
      onSubmitted: model?.onSubmitted,
      onSavedForForm: model?.onSavedForForm,
      textOnChanged: model?.onChanged,
      isFormField: model?.isFormField,
      counterIsOn: model?.counterIsOn,

    );

  }
}
