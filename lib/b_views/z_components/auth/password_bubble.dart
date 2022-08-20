import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:flutter/material.dart';

class PasswordBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PasswordBubbles({
    @required this.passwordController,
    @required this.showPasswordOnly,
    @required this.passwordValidator,
    @required this.onSubmitted,
    @required this.passwordConfirmationController,
    @required this.passwordConfirmationValidator,
    this.boxWidth,
    this.isTheSuperKeyboardField = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final TextEditingController passwordController;
  final bool showPasswordOnly;
  final String Function() passwordValidator;
  final ValueChanged<String> onSubmitted;
  final TextEditingController passwordConfirmationController;
  final String Function() passwordConfirmationValidator;
  final bool isTheSuperKeyboardField;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(

      children: <Widget>[

        /// PASSWORD
        TextFieldBubble(
          bubbleWidth: boxWidth,
          isFormField: true,
          key: const ValueKey<String>('password'),
          textController: passwordController,
          textDirection: TextDirection.ltr,
          fieldIsRequired: true,
          keyboardTextInputType: TextInputType.visiblePassword,
          keyboardTextInputAction: showPasswordOnly ? TextInputAction.go : TextInputAction.next,
          title: xPhrase(context, 'phid_password'),
          validator: passwordValidator,
          comments: <String>[xPhrase(context, 'phid_min6Char')],
          canObscure: true,
          onSubmitted: onSubmitted,
          hintText: '',
          isFloatingField: isTheSuperKeyboardField,
        ),

        /// CONFIRM PASSWORD
        if (showPasswordOnly == false)
          TextFieldBubble(
            isFormField: true,
            key: const ValueKey<String>('confirm'),
            textController: passwordConfirmationController,
            textDirection: TextDirection.ltr,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            title: xPhrase(context, 'phid_confirmPassword'),
            validator: passwordConfirmationValidator,
            comments: <String>[xPhrase(context, 'phid_min6Char')],
            canObscure: true,
            onSubmitted: onSubmitted,
            hintText: '',
          ),

      ],

    );
  }
}
