import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/password_bubble/password_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class EmailAuthScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EmailAuthScreenView({
    @required this.formKey,
    @required this.emailController,
    @required this.passwordController,
    @required this.passwordConfirmationController,
    @required this.emailValidator,
    @required this.passwordValidator,
    @required this.passwordConfirmationValidator,
    @required this.switchSignIn,
    @required this.onSignin,
    @required this.onSignup,
    @required this.isSigningIn,
    @required this.appBarType,
    @required this.passwordNode,
    @required this.confirmPasswordNode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final String Function(String) emailValidator;
  final String Function(String) passwordValidator;
  final String Function(String) passwordConfirmationValidator;
  final Function switchSignIn;
  final Function onSignin;
  final Function onSignup;
  final ValueNotifier<bool> isSigningIn;
  final AppBarType appBarType;
  final FocusNode passwordNode;
  final FocusNode confirmPasswordNode;
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _buttonHeight = 50;
    const double _verseScaleFactor = 0.7;
    // --------------------
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
                bubbleHeaderVM: const BubbleHeaderVM(
                  redDot: true,
                  headlineVerse: Verse(
                    text: 'phid_emailAddress',
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
                  text: 'rageh@bldrs.net',
                  translate: false,
                ),
                validator: emailValidator,
              ),

              /// PASSWORD - CONFIRMATION
              PasswordBubbles(
                confirmPasswordNode: confirmPasswordNode,
                passwordNode: passwordNode,
                appBarType: appBarType,
                passwordController: passwordController,
                showPasswordOnly: _isSigningIn,
                passwordValidator: passwordValidator,
                passwordConfirmationController: passwordConfirmationController,
                passwordConfirmationValidator: passwordConfirmationValidator,
                onSubmitted: (String text) => _onSubmitted(
                  signingIn: _isSigningIn,
                  isOnConfirmPassword: false,
                ),
              ),

              /// SIGN IN - SIGN UP - SWITCHER BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  DreamBox(
                    height: _buttonHeight,
                    width: _buttonHeight,
                    // verse:  'Back',
                    icon: Iconizer.superBackIcon(context),
                    iconSizeFactor: 0.7,
                    margins: 10,
                    color: Colorz.white20,
                    onTap: () => Nav.goBack(
                      context: context,
                      invoker: 'EmailAuthScreenView',
                    ),
                  ),

                  const Expander(),

                  /// REGISTER BUTTON
                  // if (isSigningIn == true)
                  DreamBox(
                    height: _buttonHeight,
                    width: 150,
                    verseScaleFactor: _verseScaleFactor,
                    verseMaxLines: 2,
                    verse: Verse(
                      text: _isSigningIn ? 'phid_create' : 'phid_register',
                      translate: true,
                    ),
                    secondLine: const Verse(
                      text: 'phid_new_account',
                      translate: true,
                    ),
                    verseColor: _isSigningIn ? Colorz.white255 : Colorz.black255,
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
                    verse: const Verse(
                      text: 'phid_signIn',
                      translate: true,
                    ),
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
                  //     verse:  'Sign in',
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

              const Horizon(),

            ],
          );

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
