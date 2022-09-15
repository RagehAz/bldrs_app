import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:flutter/material.dart';

class PasswordBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PasswordBubbles({
    @required this.appBarType,
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
  final String Function(String) passwordValidator;
  final ValueChanged<String> onSubmitted;
  final TextEditingController passwordConfirmationController;
  final String Function(String) passwordConfirmationValidator;
  final bool isTheSuperKeyboardField;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(

      children: <Widget>[

        /// PASSWORD
        TextFieldBubble(
          appBarType: appBarType,
          bubbleWidth: boxWidth,
          isFormField: true,
          key: const ValueKey<String>('password'),
          textController: passwordController,
          textDirection: TextDirection.ltr,
          fieldIsRequired: true,
          keyboardTextInputType: TextInputType.visiblePassword,
          keyboardTextInputAction: showPasswordOnly ? TextInputAction.go : TextInputAction.next,
          titleVerse: const Verse(text: 'phid_password', translate: true),
          validator: passwordValidator,
          bulletPoints: const <Verse>[
            Verse(text: 'phid_min6Char', translate: true,),
          ],
          canObscure: true,
          onSubmitted: onSubmitted,
          isFloatingField: isTheSuperKeyboardField,
        ),

        /// CONFIRM PASSWORD
        if (showPasswordOnly == false)
          TextFieldBubble(
            appBarType: appBarType,
            isFormField: true,
            key: const ValueKey<String>('confirm'),
            textController: passwordConfirmationController,
            textDirection: TextDirection.ltr,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            titleVerse: const Verse(
              text: 'phid_confirmPassword',
              translate: true,
            ),
            validator: passwordConfirmationValidator,
            bulletPoints: const <Verse>[
              Verse(text: 'phid_min6Char', translate: true),
            ],
            canObscure: true,
            onSubmitted: onSubmitted,
          ),

      ],

    );
  }
  /// --------------------------------------------------------------------------
}
