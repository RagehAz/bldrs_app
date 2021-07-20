import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show Expander;
import 'package:email_validator/email_validator.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SignInForm extends StatefulWidget {
  final Function switchSignIn;
  final String email;
  final String password;
  final Function fieldOnTap;


  SignInForm({
    @required this.switchSignIn,
    @required this.email,
    @required this.password,
    @required this.fieldOnTap,
  });

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final AuthOps _authOps = AuthOps();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool signingIn = true;
  bool loading = false;
  bool showPassword = false;
  bool _passwordObscured = true;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING') : print('LOADING COMPLETE');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // _email = widget.email;
    // _password = widget.password;
    _emailController.text = widget.email;
    _passwordController.text = widget.password;
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    if (TextChecker.textControllerHasNoValue(_emailController))_emailController.dispose();
    if (TextChecker.textControllerHasNoValue(_passwordController))_passwordController.dispose();
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
    bool _areValid = _formKey.currentState.validate();
    print('_allFieldsAreValid() = $_areValid');
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

      _triggerLoading();

      /// start sign in ops
      dynamic _result = await _authOps.emailSignInOps(context, _emailController.text, _passwordController.text);

      /// pop dialog if sign in fails otherwise check user required field then route
      print('_signInOnTap() _result.runtimeType : ${_result.runtimeType} : $_result');
      if(_result.runtimeType == String){

      _triggerLoading();

      /// pop error dialog
      await authErrorDialog(context: context, result: _result);

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(
            height: 20,
          ),

          // --- ENTER E-MAIL
          TextFieldBubble(
            textController: _emailController,
            fieldOnTap: widget.fieldOnTap,
            loading: _loading,
            bubbleColor: Colorz.White20,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.emailAddress,
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.emailAddress(context),
            hintText: '...',
            maxLines: 1,
            maxLength: 100,
            validator: (val){
              if (val.isEmpty){return Wordz.enterEmail(context);}
              else {
                return EmailValidator.validate(val) == true ? null : Wordz.emailInvalid(context);
              }
            },
          ),

          // --- ENTER PASSWORD
          TextFieldBubble(
            textController: _passwordController,
            fieldOnTap: widget.fieldOnTap,
            loading: _loading,
            bubbleColor: Colorz.White20,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            title: Wordz.password(context),
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLines: 1,
            maxLength: 100,
            obscured: _passwordObscured,
            horusOnTap: _horusOnTap,
            validator: (val){
              return
                val.isEmpty ? Wordz.enterPassword(context) :
                val.length < 6 ? Wordz.min6Char(context) :
                null;
            },

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              // BtSkipAuth(),

              Expander(),

              DreamBox(
                height: 50,
                width: 150,
                verseMaxLines: 2,
                verseScaleFactor: 0.55,
                verse: 'Create',
                secondLine: 'New Account',
                color: Colorz.White20,
                margins: const EdgeInsets.all(0),
                onTap: () => widget.switchSignIn(_emailController.text, _passwordController.text),
              ),

              DreamBox(
                height: 50,
                verseScaleFactor: 0.7,
                color: Colorz.Yellow255,
                verse: Wordz.signIn(context),
                verseWeight: VerseWeight.black,
                verseColor: Colorz.Black230,
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

