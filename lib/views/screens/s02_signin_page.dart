import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/view_brains/drafters/text_checkers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SignIn extends StatefulWidget {
  final Function switchToSignIn;
  final String email;
  final String password;
  final Function emailTextOnChanged;
  final Function passwordTextOnChanged;


  SignIn({
    @required this.switchToSignIn,
    @required this.email,
    @required this.password,
    @required this.emailTextOnChanged,
    @required this.passwordTextOnChanged,
  });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  final AuthService _auth = AuthService();
  // String _email;
  // String _password;
  bool signingIn = true;
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool showPassword = false;
  bool _passwordObscured = true;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    // _email = widget.email;
    // _password = widget.password;
    _emailController.text = widget.email;
    _passWordController.text = widget.password;
    super.initState();
  }
// ---------------------------------------------------------------------------
  @override
  void dispose() {
    if (textControllerHasNoValue(_emailController))_emailController.dispose();
    if (textControllerHasNoValue(_passWordController))_passWordController.dispose();
    super.dispose();
  }

  // void _emailTextOnChanged(String val){
  //   setState(() {_email = val;});
  //   print('email : $_email, pass : $_password');
  // }
// ---------------------------------------------------------------------------
//   void _passwordTextOnChanged(String val){
//     setState(() {_password = val;});
//     print('email : $_email, pass : $_password');
//   }
// ---------------------------------------------------------------------------
  void _triggerLoading(){
    setState(() {loading = !loading;});
  }
// ---------------------------------------------------------------------------
  void _horusOnTapDown(){
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }
// ---------------------------------------------------------------------------
  void _horusOnTapUp(){
    setState(() {
      _passwordObscured = !_passwordObscured;
    });
  }
// ---------------------------------------------------------------------------
  void _horusOnTapCancel(){
    setState(() {
      _passwordObscured = true;
    });
  }
// ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          LogoSlogan(
            sizeFactor: 0.8,
          ),

          SizedBox(
            height: 20,
          ),

          // --- ENTER E-MAIL
          TextFieldBubble(
            textController: _emailController,
            loading: loading,
            bubbleColor: Colorz.WhiteGlass,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.emailAddress,
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.emailAddress(context),
            hintText: '...',
            // onSaved: (){print('onSaved');},
            maxLines: 1,
            maxLength: 100,
            // initialTextValue: _email,
            textOnChanged: (val){
              widget.emailTextOnChanged(val);
              // _emailTextOnChanged(val);
            },
            validator: (val){
              if (val.isEmpty){return Wordz.enterEmail(context);}
              else {
                return EmailValidator.validate(val) == true ? null : Wordz.emailInvalid(context);
              }
            },
          ),

          // --- ENTER PASSWORD
          TextFieldBubble(
            textController: _passWordController,
            loading: loading,
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
            // initialTextValue: _password,
            horusOnTapDown: _horusOnTapDown,
            horusOnTapUp: _horusOnTapUp,
            horusOnTapCancel: _horusOnTapCancel,
            textOnChanged: (val){
              widget.passwordTextOnChanged(val);
              // _passwordTextOnChanged(val);
            },
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

              SuperVerse(
                verse: Wordz.createAccount(context),
                color: Colorz.BabyBlue,
                size: 2,
                labelColor: Colorz.WhiteGlass,
                margin: 0,
                labelTap: widget.switchToSignIn,
              ),

              DreamBox(
                height: 50,
                verseScaleFactor: 0.7,
                color: Colorz.WhiteGlass,
                verse: Wordz.signIn(context),
                boxMargins: EdgeInsets.all(20),
                boxFunction: () async {
                  minimizeKeyboardOnTapOutSide(context);
                  try{

                    if(_formKey.currentState.validate()){
                      _triggerLoading();
                      dynamic result = await _auth.signInWithEmailAndPassword(_emailController.text, _passWordController.text);
                      print('signing result is : $result');

                      if ('$result' == '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.')
                      {setState(() {error = Wordz.wrongPassword(context);}); _triggerLoading();}
                      else if ('$result' == '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.')
                      {setState(() {error = Wordz.emailNotFound(context);}); _triggerLoading();}
                      else if('$result' == '[firebase_auth/invalid-email] The email address is badly formatted.')
                      {setState(() {error = Wordz.emailWrong(context);}); _triggerLoading();}
                      else if(result == null){setState(() {error = Wordz.signInFailure(context);}); _triggerLoading();}
                      else if(result.runtimeType == UserModel)
                      {
                        setState(() {error = ''; _triggerLoading();});
                        goToRoute(context, Routez.Home);
                      }
                    }


                  }catch(error){

                    superDialog(context, error, 'Can\'t sign in');

                  }
                },
              ),

            ],
          ),


          SuperVerse(
            verse: error,
            color: Colorz.BloodRed,
          ),




        ],
      ),
    );
  }
}

