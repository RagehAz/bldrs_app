import 'dart:async';

import 'package:bldrs/b_views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/c_controllers/b_0_auth_controller.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailAuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EmailAuthScreen({Key key}) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
  /// --------------------------------------------------------------------------
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // -----------------------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSigningIn = ValueNotifier(true);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    if (TextChecker.textControllerIsEmpty(_emailController)) {
      _emailController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_passwordController)) {
      _passwordController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_confirmPasswordController)) {
      _confirmPasswordController.dispose();
    }

    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _switchSignIn() {
    _formKey.currentState.reset();
    _isSigningIn.value = !_isSigningIn.value;
  }
// -----------------------------------------------------------------------------
  String _validateEmail(String val){
    return emailValidation(context: context, val: val);
  }
// -----------------------------------------------------------------------------
  String _validatePassword(String val){
    return passwordValidation(
        context: context,
        password: val,
    );
  }
// -----------------------------------------------------------------------------
  String _validatePasswordConfirmation(String val){
    return passwordConfirmationValidation(
        context: context,
        password: _passwordController.text,
        passwordConfirmation: val,
    );
  }
// -----------------------------------------------------------------------------
  void _onObscureTap(){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.triggerTextFieldsObscured();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSignIn() async {
    await controlEmailSignin(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      formKey: _formKey,
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _onSignup() async {
    await controlEmailSignup(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      passwordConfirmation: _confirmPasswordController.text,
      formKey: _formKey,
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.pyramidzYellow,
      skyType: SkyType.black,
      appBarType: AppBarType.non,
      layoutWidget: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[

            /// TOP SPACER
            const SizedBox(height: 20,),

            /// ENTER E-MAIL
            TextFieldBubble(
              key: const ValueKey<String>('email'),
              textController: _emailController,
              textDirection: TextDirection.ltr,
              fieldIsFormField: true,
              fieldIsRequired: true,
              keyboardTextInputType: TextInputType.emailAddress,
              keyboardTextInputAction: TextInputAction.next,
              title: Wordz.emailAddress(context),
              validator: _validateEmail,
            ),

            /// PASSWORD - CONFIRMATION
            Selector<UiProvider, bool>(
                selector: (_, UiProvider uiProvider) => uiProvider.textFieldsObscured,
                builder: (_, bool isObscured, Widget child){

                  return Column(

                    children: <Widget>[

                      /// PASSWORD
                      TextFieldBubble(
                        key: const ValueKey<String>('password'),
                        textController: _passwordController,
                        textDirection: TextDirection.ltr,
                        fieldIsFormField: true,
                        fieldIsRequired: true,
                        keyboardTextInputType: TextInputType.visiblePassword,
                        keyboardTextInputAction: TextInputAction.next,
                        title: Wordz.password(context),
                        validator: _validatePassword,
                        comments: Wordz.min6Char(context),
                        obscured: isObscured,
                        onObscureTap: _onObscureTap,
                      ),

                      /// CONFIRM PASSWORD
                      ValueListenableBuilder(
                          valueListenable: _isSigningIn,
                          builder: (_, bool isSigningIn, Widget child){

                            if (isSigningIn == true){
                              return Container();
                            }

                            else {
                              return TextFieldBubble(
                                key: const ValueKey<String>('confirm'),
                                textController: _confirmPasswordController,
                                textDirection: TextDirection.ltr,
                                fieldIsFormField: true,
                                fieldIsRequired: true,
                                keyboardTextInputType: TextInputType.visiblePassword,
                                keyboardTextInputAction: TextInputAction.done,
                                title: Wordz.confirmPassword(context),
                                validator: _validatePasswordConfirmation,
                                comments: Wordz.min6Char(context),
                                obscured: isObscured,
                                onObscureTap: _onObscureTap,
                              );
                            }

                          }
                      ),

                    ],

                  );

                }
            ),

            /// SIGN IN - SIGN UP - SWITCHER BUTTONS
            ValueListenableBuilder(
                valueListenable: _isSigningIn,
                builder: (_, bool isSigningIn, Widget child){

                  const double _buttonHeight = 50;
                  const double _verseScaleFactor = 0.7;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      /// (SWITCH TO SIGN-IN) => CREATE NEW ACCOUNT
                      if (isSigningIn == true)
                        DreamBox(
                        height: _buttonHeight,
                        width: 150,
                        verseScaleFactor: _verseScaleFactor,
                        verseMaxLines: 2,
                        verse: 'Create',
                        secondLine: 'New Account',
                        color: Colorz.white20,
                        margins: EdgeInsets.zero,
                        onTap: _switchSignIn,
                      ),

                      /// SIGN IN BUTTON
                      if (isSigningIn == true)
                        DreamBox(
                        height: _buttonHeight,
                        verseScaleFactor: _verseScaleFactor,
                        color: Colorz.yellow255,
                        verse: Wordz.signIn(context),
                        verseWeight: VerseWeight.black,
                        verseColor: Colorz.black230,
                        margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                        onTap: _onSignIn,
                      ),

                      /// (SWITCH TO SIGN-UP) => SIGN IN EXISTING ACCOUNT BUTTON
                      if (isSigningIn == false)
                        DreamBox(
                          height: _buttonHeight,
                          verseScaleFactor: _verseScaleFactor,
                          width: 150,
                          verse: 'Sign in',
                          secondLine: 'Existing account',
                          verseMaxLines: 2,
                          color: Colorz.white20,
                          onTap: _switchSignIn,
                        ),

                      /// SIGN-UP BUTTON
                      if (isSigningIn == false)
                        DreamBox(
                          height: _buttonHeight,
                          verseScaleFactor: _verseScaleFactor,
                          color: Colorz.yellow255,
                          verse: Wordz.register(context),
                          verseColor: Colorz.black230,
                          verseWeight: VerseWeight.black,
                          margins: const EdgeInsets.all(10),
                          onTap: _onSignup,
                        ),

                    ],
                  );


                }
                ),

          ],
        ),
      ),

    );
  }
}
