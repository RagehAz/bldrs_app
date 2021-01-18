


import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/text_bubbles.dart';
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

  @override
  void initState() {
    _email = widget.email;
    _password = widget.password;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Form(
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
            errorMessageIfEmpty: 'eh ya 3am',
            maxLines: 1,
            maxLength: 100,
            obscured: false,
            initialTextValue: _email,
            textOnChanged: (val) => widget.emailTextOnChanged(val),
          ),

          TextFieldBubble(
            fieldIsFormField: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            title: 'Password',
            hintText: '...',
            onSaved: (){print('onSaved');},
            errorMessageIfEmpty: 'eh ya 3am',
            maxLines: 1,
            maxLength: 100,
            obscured: true,
            initialTextValue: _password,
            textOnChanged: (val) => widget.passwordTextOnChanged(val),
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

