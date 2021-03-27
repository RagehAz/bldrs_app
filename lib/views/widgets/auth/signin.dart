import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/s16_user_editor_screen.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:email_validator/email_validator.dart';
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
  final Function fieldOnTap;


  SignIn({
    @required this.switchToSignIn,
    @required this.email,
    @required this.password,
    @required this.emailTextOnChanged,
    @required this.passwordTextOnChanged,
    @required this.fieldOnTap,
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
  // String error = '';
  bool loading = false;
  bool showPassword = false;
  bool _passwordObscured = true;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING') : print('LOADING COMPLETE');
  }
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

          SizedBox(
            height: 20,
          ),

          // --- ENTER E-MAIL
          TextFieldBubble(
            fieldOnTap: widget.fieldOnTap,
            textController: _emailController,
            loading: _loading,
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
            fieldOnTap: widget.fieldOnTap,
            textController: _passWordController,
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
                boxFunction: widget.switchToSignIn,
              ),

              DreamBox(
                height: 50,
                verseScaleFactor: 0.7,
                color: Colorz.Yellow,
                verse: Wordz.signIn(context),
                verseWeight: VerseWeight.black,
                verseColor: Colorz.BlackBlack,
                boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin),
                boxFunction: () async {
                  minimizeKeyboardOnTapOutSide(context);

                  _triggerLoading();

                  await tryAndCatch(
                    context: context,
                    functions: () async {
                      if(_formKey.currentState.validate()){
                        // ---------------------
                        dynamic result = await _auth.signInWithEmailAndPassword(_emailController.text, _passWordController.text);
                        // ---------------------
                        if ('$result' == '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                          await superDialog(context, Wordz.wrongPassword(context), 'Ops!');
                          _triggerLoading();
                        }
                        // ---------------------
                        else if ('$result' == '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
                          await superDialog(context, Wordz.emailNotFound(context), 'Ops!');
                          _triggerLoading();
                        }
                        // ---------------------
                        else if('$result' == '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
                          await superDialog(context, 'No Internet connection available', 'Ops!');
                          _triggerLoading();
                        }
                        // ---------------------
                        else if('$result' == '[firebase_auth/invalid-email] The email address is badly formatted.') {
                          await superDialog(context, Wordz.emailWrong(context), 'Ops!');
                          _triggerLoading();
                        }
                        // ---------------------
                        else if(result == null){
                          await superDialog(context, Wordz.signInFailure(context), 'Ops!');
                          _triggerLoading();
                        }
                        // ---------------------
                        /// if user signed up but did not properly complete userdata
                        /// then need to fill these fields ( name, pic, title, company, Zone)
                        /// to be able to go to home screen
                        else if(result.runtimeType == UserModel) {
                          UserModel userModel = result;

                          if (
                              userModel.name == null ||
                              userModel.pic == null ||
                              userModel.title == null ||
                              userModel.company == null
                          // TASK : need to rethink which fields are required by user
                          ){
                            await superDialog(context, 'You have to complete your profile info', '');
                            _triggerLoading();
                            goToNewScreen(context, EditProfileScreen(user: result, firstTimer: false,),);
                          } else {
                          _triggerLoading();
                          goToRoute(context, Routez.Home);

                          }

                        }
                        // ---------------------
                      }
                    }
                  );

                },
              ),

            ],
          ),

        ],
      ),
    );
  }
}

