import 'dart:async';
import 'dart:ui';

import 'package:bldrs/controllers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/controllers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart' as Dialogz;
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart' show Expander;
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SignInForm({
    @required this.switchSignIn,
    @required this.email,
    @required this.password,
    @required this.fieldOnTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function switchSignIn;
  final String email;
  final String password;
  final Function fieldOnTap;
  /// --------------------------------------------------------------------------
  @override
  _SignInFormState createState() => _SignInFormState();
  /// --------------------------------------------------------------------------
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool signingIn = true;
  bool loading = false;
  bool showPassword = false;
  bool _passwordObscured = true;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    blog('LOADING--------------------------------------') : blog('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // _email = widget.email;
    // _password = widget.password;
    _emailController.text = widget.email;
    _passwordController.text = widget.password;
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    if (TextChecker.textControllerIsEmpty(_emailController)){
      _emailController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_passwordController)){
      _passwordController.dispose();
    }
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _horusOnTap(){
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }
// -----------------------------------------------------------------------------
  bool _allFieldsAreValid(){
    final bool _areValid = _formKey.currentState.validate();
    blog('_allFieldsAreValid() = $_areValid');
    return _areValid;
  }
// -----------------------------------------------------------------------------
  Future<void> _signInOnTap() async {

    setState(() {
      _passwordObscured = true;
    });

    /// minimize keyboard
    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    /// proceed with sign in if fields are valid
    if(_allFieldsAreValid() == true){

      unawaited(_triggerLoading());

      /// start sign in ops
      final dynamic _result = await FireAuthOps.emailSignInOps(
          context: context,
          email: _emailController.text,
          password: _passwordController.text,
      );

      /// pop dialog if sign in fails otherwise check user required field then route
      blog('_signInOnTap() _result.runtimeType : ${_result.runtimeType} : $_result');
      if(_result.runtimeType == String){

      unawaited(_triggerLoading());

      /// pop error dialog
      await Dialogz.authErrorDialog(context: context, result: _result);

    } else {

        /// so sign in succeeded returning a userModel
        // UserModel _userModel = _result;

        Nav.goBackToUserChecker(context);

        // /// check if user model is properly completed
        // List<String> _missingFields = UserModel.missingFields(_userModel);
        // if (_missingFields.length == 0){
        //
        //   _triggerLoading();
        //
        //   /// so userModel required fields are entered route to userChecker screen
        //   Nav.goToNewScreen(context, UserChecker());
        //
        // } else {
        //
        //   _triggerLoading();
        //
        //   /// if userModel is not completed pop Alert
        //   await superDialog(
        //     context: context,
        //     title: 'Ops!',
        //     body: 'You have to complete your profile info\n ${_missingFields.toString()}',
        //     boolDialog: false,
        //   );
        //
        //   /// and route to complete profile missing data
        //   Nav.goToNewScreen(context, EditProfileScreen(user: _userModel, firstTimer: false,),);
        // }

      }

    }

}
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          const SizedBox(
            height: 20,
          ),

          /// ENTER E-MAIL
          TextFieldBubble(
            textController: _emailController,
            fieldOnTap: widget.fieldOnTap,
            loading: _loading,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.emailAddress,
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.emailAddress(context),
            validator: (String val){

              if (val.isEmpty){
                return Wordz.enterEmail(context);
              }

              else {
                return EmailValidator.validate(val) == true ? null : Wordz.emailInvalid(context);
              }
            },
          ),

          /// ENTER PASSWORD
          TextFieldBubble(
            textController: _passwordController,
            fieldOnTap: widget.fieldOnTap,
            loading: _loading,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            title: Wordz.password(context),
            onSaved: (){blog('onSaved');},
            obscured: _passwordObscured,
            horusOnTap: _horusOnTap,
            validator: (String val){
              return
                val.isEmpty ? Wordz.enterPassword(context) :
                val.length < 6 ? Wordz.min6Char(context) :
                null;
            },

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              // BtSkipAuth(),

              const Expander(),

              DreamBox(
                height: 50,
                width: 150,
                verseMaxLines: 2,
                verseScaleFactor: 0.55,
                verse: 'Create',
                secondLine: 'New Account',
                color: Colorz.white20,
                margins: EdgeInsets.zero,
                onTap: () => widget.switchSignIn(_emailController.text, _passwordController.text),
              ),

              DreamBox(
                height: 50,
                verseScaleFactor: 0.7,
                color: Colorz.yellow255,
                verse: Wordz.signIn(context),
                verseWeight: VerseWeight.black,
                verseColor: Colorz.black230,
                margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                onTap: _signInOnTap,
              ),

            ],
          ),

        ],
      ),
    );
  }
}
