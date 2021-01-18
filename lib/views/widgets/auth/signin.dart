

import 'package:email_validator/email_validator.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/text_field_bubble.dart';
import 'package:flutter/material.dart';

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
  String _email;
  String _password;
  bool signingIn = true;
  final _formKey = GlobalKey<FormState>();
  String error = '';


  @override
  void initState() {
    _email = widget.email;
    _password = widget.password;
    super.initState();
  }

  void _emailTextOnChanged(String val){
    setState(() {
      _email = val;
    });
    print('email : $_email, pass : $_password');
  }

  void _passwordTextOnChanged(String val){
    setState(() {
      _password = val;
    });
    print('email : $_email, pass : $_password');
  }



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

          TextFieldBubble(
            fieldIsFormField: true,
            keyboardTextInputType: TextInputType.emailAddress,
            keyboardTextInputAction: TextInputAction.next,
            title: 'E-mail Address',
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLines: 1,
            maxLength: 100,
            obscured: false,
            initialTextValue: _email,
            textOnChanged: (val) => widget.emailTextOnChanged(val),
            validator: (val){
              if (val.isEmpty){return 'Enter E-mail';}
              else {
                return EmailValidator.validate(val) == true ? null : 'E-mail is not valid';
              }
            },
          ),

          TextFieldBubble(
            fieldIsFormField: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            title: 'Password',
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLines: 1,
            maxLength: 100,
            obscured: true,
            initialTextValue: _password,
            textOnChanged: (val) => widget.passwordTextOnChanged(val),
            validator: (val){
              return
                val.isEmpty ? 'Enter password' :
                val.length < 6 ? 'Password can not be less than 6 characters long' :
                null;
            },

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SuperVerse(
                verse: 'Create a new account',
                color: Colorz.BabyBlue,
                size: 2,
                labelColor: Colorz.WhiteAir,
                margin: 0,
                labelTap: widget.switchToSignIn,
              ),

              DreamBox(
                height: 50,
                verseScaleFactor: 0.7,
                verse: 'Sign In    ',
                boxMargins: EdgeInsets.all(20),
                boxFunction: () async {
                  // blah
                  if (widget.email == '' || widget.password == '')
                  {print('no email nor password entered bitch');}
                  else
                  {print('email : ${widget.email}, password : ${widget.password}');}
                },
              ),

            ],
          ),



        ],
      ),
    );
  }
}

