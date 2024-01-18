import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/password_bubble/password_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class EmailAndPasswordBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EmailAndPasswordBubbles({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.emailValidator,
    required this.passwordValidator,
    required this.isSigningIn,
    required this.appBarType,
    required this.passwordNode,
    required this.isObscured,
    required this.onSubmitted,
    required this.bubbleWidth,
    required this.onForgetPassword,
    super.key
  });
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  final ValueNotifier<bool> isSigningIn;
  final AppBarType appBarType;
  final FocusNode passwordNode;
  final ValueNotifier<bool> isObscured;
  final void Function(String?)? onSubmitted;
  final double bubbleWidth;
  final Function onForgetPassword;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[

          /// ENTER E-MAIL
          BldrsTextFieldBubble(
            formKey: formKey,
            bubbleWidth: bubbleWidth,
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              redDot: true,
              headlineVerse: const Verse(
                id: 'phid_emailAddress',
                translate: true,
              ),
            ),
            appBarType: appBarType,
            isFormField: true,
            key: const ValueKey<String>('email'),
            textController: emailController,
            textDirection: TextDirection.ltr,
            keyboardTextInputType: TextInputType.emailAddress,
            keyboardTextInputAction: TextInputAction.next,
            hintVerse: const Verse(
              id: 'rageh@bldrs.net',
              translate: false,
            ),
            validator: emailValidator,
            autoCorrect: Keyboard.autoCorrectIsOn(),
            enableSuggestions: Keyboard.suggestionsEnabled(),
          ),

          /// PASSWORD - CONFIRMATION
          PasswordBubbles(
            bubbleWidth: bubbleWidth,
            confirmPasswordNode: null,
            passwordNode: passwordNode,
            appBarType: appBarType,
            passwordController: passwordController,
            showPasswordOnly: true,
            passwordValidator: passwordValidator,
            passwordConfirmationController: null,
            passwordConfirmationValidator: null,
            onSubmitted: onSubmitted,
            isObscured: isObscured,
            onForgotPassword: onForgetPassword,
          ),

        ],
      ),
    );
    // --------------------
  }

}
