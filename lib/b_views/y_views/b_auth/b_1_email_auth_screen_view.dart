import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailAuthScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EmailAuthScreenView({
    @required this.formKey,
    @required this.emailController,
    @required this.passwordController,
    @required this.passwordConfirmationController,
    @required this.validateEmail,
    @required this.validatePassword,
    @required this.validatePasswordConfirmation,
    @required this.onObscureTap,
    @required this.switchSignIn,
    @required this.onSignin,
    @required this.onSignup,
    @required this.isSigningIn,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final String Function() validateEmail;
  final String Function() validatePassword;
  final String Function() validatePasswordConfirmation;
  final Function onObscureTap;
  final Function switchSignIn;
  final Function onSignin;
  final Function onSignup;
  final ValueNotifier<bool> isSigningIn; /// p
  /// --------------------------------------------------------------------------

  void _onSubmitted({
    @required bool signingIn,
    @required bool isOnConfirmPassword,
}){

    blog('_onSubmitted : trying to submit');

    /// WHILE SIGN IN
    if (signingIn == true){

      /// WHILE ON PASSWORD
      if (isOnConfirmPassword == false){
        onSignin();
      }
    }

    /// WHILE SIGN UP
    else {
      if (isOnConfirmPassword == true){
        onSignup();
      }

    }

  }

  @override
  Widget build(BuildContext context) {

    final bool _keyboardIsOn = Keyboarders.keyboardIsOn(context);
    const double _buttonHeight = 50;
    const double _verseScaleFactor = 0.7;

    return Form(
      key: formKey,
      child: ValueListenableBuilder(
        valueListenable: isSigningIn,
        builder: (_, bool _isSigningIn, Widget child){

          return ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// TOP SPACER
              const SizedBox(
                width: 20,
                height: 20,
              ),

              /// ENTER E-MAIL
              TextFieldBubble(
                isFormField: true,
                key: const ValueKey<String>('email'),
                textController: emailController,
                textDirection: TextDirection.ltr,
                fieldIsRequired: true,
                keyboardTextInputType: TextInputType.emailAddress,
                keyboardTextInputAction: TextInputAction.next,
                title: superPhrase(context, 'phid_emailAddress'),
                validator: validateEmail,
              ),

              /// PASSWORD - CONFIRMATION
              Selector<UiProvider, bool>(
                  selector: (_, UiProvider uiProvider) => uiProvider.textFieldsObscured,
                  builder: (_, bool isObscured, Widget child){

                    return Column(

                      children: <Widget>[

                        /// PASSWORD
                        TextFieldBubble(
                          isFormField: true,
                          key: const ValueKey<String>('password'),
                          textController: passwordController,
                          textDirection: TextDirection.ltr,
                          fieldIsRequired: true,
                          keyboardTextInputType: TextInputType.visiblePassword,
                          keyboardTextInputAction: _isSigningIn ? TextInputAction.go : TextInputAction.next,
                          title: superPhrase(context, 'phid_password'),
                          validator: validatePassword,
                          comments:superPhrase(context, 'phid_min6Char'),
                          obscured: isObscured,
                          showUnObscure: true,
                          onObscureTap: onObscureTap,
                          onSubmitted: (String text) => _onSubmitted(
                            signingIn: _isSigningIn,
                            isOnConfirmPassword: false,
                          ),
                        ),

                        /// CONFIRM PASSWORD
                        if (_isSigningIn == false)
                          TextFieldBubble(
                            isFormField: true,
                            key: const ValueKey<String>('confirm'),
                            textController: passwordConfirmationController,
                            textDirection: TextDirection.ltr,
                            fieldIsRequired: true,
                            keyboardTextInputType: TextInputType.visiblePassword,
                            keyboardTextInputAction: TextInputAction.done,
                            title: superPhrase(context, 'phid_confirmPassword'),
                            validator: validatePasswordConfirmation,
                            comments:superPhrase(context, 'phid_min6Char'),
                            obscured: isObscured,
                            showUnObscure: true,
                            onObscureTap: onObscureTap,
                            onSubmitted: (String text) => _onSubmitted(
                              signingIn: _isSigningIn,
                              isOnConfirmPassword: true,
                            ),
                          ),

                      ],

                    );

                  }
              ),

              /// SIGN IN - SIGN UP - SWITCHER BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  DreamBox(
                    height: _buttonHeight,
                    width: _buttonHeight,
                    // verse: 'Back',
                    icon: Iconizer.superBackIcon(context),
                    iconSizeFactor: 0.7,
                    margins: 10,
                    color: Colorz.white20,
                    onTap: () => Nav.goBack(context),
                  ),

                  const Expander(),

                  /// REGISTER BUTTON
                  // if (isSigningIn == true)
                  DreamBox(
                    height: _buttonHeight,
                    width: 150,
                    verseScaleFactor: _verseScaleFactor,
                    verseMaxLines: 2,
                    verse: _isSigningIn ? superPhrase(context, 'phid_create') : superPhrase(context, 'phid_register'),
                    verseColor: _isSigningIn ? Colorz.white255 : Colorz.black255,
                    secondLine: superPhrase(context, 'phid_new_account'),
                    secondLineColor: _isSigningIn ? Colorz.white255 : Colorz.black255,
                    color: _isSigningIn ? Colorz.white20 : Colorz.yellow255,
                    margins: EdgeInsets.zero,
                    onTap: _isSigningIn ? switchSignIn : onSignup,
                  ),

                  /// SIGN IN BUTTON
                  // if (isSigningIn == true)
                  DreamBox(
                    height: _buttonHeight,
                    verseScaleFactor: _verseScaleFactor,
                    color: _isSigningIn ? Colorz.yellow255 : Colorz.white20,
                    verse: superPhrase(context, 'phid_signIn'),
                    verseColor: _isSigningIn ? Colorz.black255 : Colorz.white255,
                    verseWeight: VerseWeight.black,
                    margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                    onTap: _isSigningIn ? onSignin : switchSignIn,
                  ),

                  // /// (SWITCH TO SIGN-UP) => SIGN IN EXISTING ACCOUNT BUTTON
                  // if (isSigningIn == false)
                  //   DreamBox(
                  //     height: _buttonHeight,
                  //     verseScaleFactor: _verseScaleFactor,
                  //     width: 150,
                  //     verse: 'Sign in',
                  //     secondLine: 'Existing account',
                  //     verseMaxLines: 2,
                  //     color: Colorz.white20,
                  //     onTap: switchSignIn,
                  //   ),
                  //
                  // /// SIGN-UP BUTTON
                  // if (isSigningIn == false)
                  //   DreamBox(
                  //     height: _buttonHeight,
                  //     verseScaleFactor: _verseScaleFactor,
                  //     color: Colorz.yellow255,
                  //     verse: Wordz.register(context),
                  //     verseColor: Colorz.black230,
                  //     verseWeight: VerseWeight.black,
                  //     margins: const EdgeInsets.all(10),
                  //     onTap: onSignup,
                  //   ),

                ],
              ),

              if (_keyboardIsOn == true)
                const SizedBox(
                  width: 20,
                  height: 300,
                ),

            ],
          );

        },
      ),
    );
  }
}
