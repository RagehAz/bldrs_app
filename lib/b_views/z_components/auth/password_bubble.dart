import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PasswordBubbles({
    @required this.passwordController,
    @required this.showPasswordOnly,
    @required this.passwordValidator,
    @required this.onObscureTap,
    @required this.onSubmitted,
    @required this.passwordConfirmationController,
    @required this.passwordConfirmationValidator,
    this.boxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final TextEditingController passwordController;
  final bool showPasswordOnly;
  final String Function() passwordValidator;
  final Function onObscureTap;
  final ValueChanged<String> onSubmitted;
  final TextEditingController passwordConfirmationController;
  final String Function() passwordConfirmationValidator;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<UiProvider, bool>(
        selector: (_, UiProvider uiProvider) => uiProvider.textFieldsObscured,
        builder: (_, bool isObscured, Widget child){

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
                title: superPhrase(context, 'phid_password'),
                validator: passwordValidator,
                comments: <String>[superPhrase(context, 'phid_min6Char')],
                obscured: isObscured,
                showUnObscure: true,
                onObscureTap: onObscureTap,
                onSubmitted: onSubmitted,
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
                  title: superPhrase(context, 'phid_confirmPassword'),
                  validator: passwordConfirmationValidator,
                  comments: <String>[superPhrase(context, 'phid_min6Char')],
                  obscured: isObscured,
                  showUnObscure: true,
                  onObscureTap: onObscureTap,
                  onSubmitted: onSubmitted,
                ),

            ],

          );

        }
    );
  }
}
