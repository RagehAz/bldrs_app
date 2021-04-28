import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/s00_user_checker_widget.dart';
import 'package:bldrs/views/screens/s16_user_editor_screen.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
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
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthOps _authOps = AuthOps();
  // String _email;
  // String _password;
  bool signingIn = true;
  final _formKey = GlobalKey<FormState>();
  // String error = '';
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

  // void _emailTextOnChanged(String val){
  //   setState(() {_email = val;});
  //   print('email : $_email, pass : $_password');
  // }
// -----------------------------------------------------------------------------
//   void _passwordTextOnChanged(String val){
//     setState(() {_password = val;});
//     print('email : $_email, pass : $_password');
//   }
// -----------------------------------------------------------------------------
  void _horusOnTapDown(){
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }
// -----------------------------------------------------------------------------
  void _horusOnTapUp(){
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }
// -----------------------------------------------------------------------------
  void _horusOnTapCancel(){
    setState(() {
      _passwordObscured = true;
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

    /// minimize keyboard
    minimizeKeyboardOnTapOutSide(context);

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
        UserModel _userModel = _result;

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
            bubbleColor: Colorz.WhiteGlass,
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
            bubbleColor: Colorz.WhiteGlass,
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
            horusOnTapDown: _horusOnTapDown,
            horusOnTapUp: _horusOnTapUp,
            horusOnTapCancel: _horusOnTapCancel,
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

              Expanded(child: Container(),),

              DreamBox(
                height: 50,
                width: 150,
                verseMaxLines: 2,
                verseScaleFactor: 0.55,
                verse: 'Create',
                secondLine: 'New Account',
                color: Colorz.WhiteGlass,
                boxMargins: EdgeInsets.all(0),
                boxFunction: () => widget.switchSignIn(_emailController.text, _passwordController.text),
              ),

              DreamBox(
                height: 50,
                verseScaleFactor: 0.7,
                color: Colorz.Yellow,
                verse: Wordz.signIn(context),
                verseWeight: VerseWeight.black,
                verseColor: Colorz.BlackBlack,
                boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin),
                boxFunction: _signInOnTap,
              ),

            ],
          ),

        ],
      ),
    );
  }
}

