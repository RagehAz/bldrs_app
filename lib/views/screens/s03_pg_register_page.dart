import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/models/user_model.dart';

class Register extends StatefulWidget {
  final Function switchToSignIn;
  String email;
  String password;
  final Function emailTextOnChanged;
  final Function passwordTextOnChanged;


  Register({
    @required this.switchToSignIn,
    @required this.email,
    @required this.password,
    @required this.emailTextOnChanged,
    @required this.passwordTextOnChanged,
  });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String _email;
  String _password;
  String _confirmPassword;
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool showPassword = false;
  bool _passwordObscured = true;

// ---------------------------------------------------------------------------
  @override
  void initState() {
    _email = widget.email;
    _password = widget.password;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _emailTextOnChanged(String val){
    setState(() {
      _email = val;
    });
    print('email : $_email, pass : $_password, conf : $_confirmPassword');
  }
// ---------------------------------------------------------------------------
  void _passwordTextOnChanged(String val){
    setState(() {
      _password = val;
    });
    print('email : $_email, pass : $_password, conf : $_confirmPassword');
  }
// ---------------------------------------------------------------------------
  void _confirmPasswordOnChanged(String val){
    setState(() {
      _confirmPassword = val;
    });
    print('email : $_email, pass : $_password, conf : $_confirmPassword');
  }
// ---------------------------------------------------------------------------
  void _triggerLoading(){
    setState(() {
      loading = !loading;
    });
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

          // LogoSlogan(
          //   sizeFactor: 0.8,
          // ),

          SizedBox(
            height: 20,
          ),

          TextFieldBubble(
            loading: loading,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.emailAddress,
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.emailAddress(context),
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLength: 100,
            initialTextValue: _email,
            textOnChanged: (val){
              widget.emailTextOnChanged(val);
              _emailTextOnChanged(val);
            },
            validator: (val){
              if (val.isEmpty){return Wordz.enterEmail(context);}
              else {
               return EmailValidator.validate(val) == true ? null : Wordz.emailInvalid(context);
              }
            },
          ),

          TextFieldBubble(
            loading: loading,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.password(context),
            comments: Wordz.min6Char(context),
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLines: 1,
            maxLength: 100,
            obscured: _passwordObscured,
            horusOnTapDown: _horusOnTapDown,
            horusOnTapUp: _horusOnTapUp,
            horusOnTapCancel: _horusOnTapCancel,
            initialTextValue: _password,
            textOnChanged: (val){
              widget.passwordTextOnChanged(val);
              _passwordTextOnChanged(val);
            },
            validator: (val){
              return
              val.isEmpty ? Wordz.enterPassword(context) :
              val.length < 6 ? Wordz.min6CharError(context) :
              _confirmPassword != _password ? Wordz.passwordMismatch(context) :
              null;
            },
          ),

          TextFieldBubble(
            loading: loading,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            title: Wordz.confirmPassword(context),
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLines: 1,
            maxLength: 100,
            obscured: _passwordObscured,
            horusOnTapDown: _horusOnTapDown,
            horusOnTapUp: _horusOnTapUp,
            horusOnTapCancel: _horusOnTapCancel,
            initialTextValue: null,
            textOnChanged: (val) => _confirmPasswordOnChanged(val),
            validator: (val){
              return
                val.isEmpty ? Wordz.confirmPassword(context) :
                _confirmPassword != _password ? Wordz.passwordMismatch(context) :
                val.length < 6 ? Wordz.min6CharError(context) :
              null;

            },
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SuperVerse(
                verse: error,
                color: Colorz.BloodRed,
              ),

              DreamBox(
                height: 50,
                verseScaleFactor: 0.7,
                verse: Wordz.register(context),
                boxMargins: EdgeInsets.all(10),
                boxFunction: () async {
                  if(_formKey.currentState.validate()){
                    _triggerLoading();
                    dynamic result = await _auth.registerWithEmailAndPassword(_email, _password);
                    print('register result is : $result');
                    if ('$result' == '[firebase_auth/email-already-in-use] The email address is already in use by another account.')
                    {setState(() {error = Wordz.emailAlreadyRegistered(context);}); _triggerLoading();}
                    else if('$result' == '[firebase_auth/invalid-email] The email address is badly formatted.')
                    {setState(() {error = Wordz.emailWrong(context);}); _triggerLoading();}
                    else if(result == null){setState(() {error = 'something is wrong';}); _triggerLoading();}
                    else if(result.runtimeType == UserModel)
                    {
                      setState(() {error = ''; _triggerLoading();});
                      goToRoute(context, Routez.Home); // should go to data entry page then confirm then homepage
                    }
                  }
                },
              ),

              SuperVerse(
                verse: Wordz.signInExisting(context),
                color: Colorz.BabyBlue,
                size: 2,
                labelColor: Colorz.WhiteAir,
                margin: 0,
                labelTap: widget.switchToSignIn,
              ),

            ],
          ),

        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
