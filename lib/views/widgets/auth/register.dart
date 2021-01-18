import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/textings/text_field_bubble.dart';
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
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.emailAddress,
            keyboardTextInputAction: TextInputAction.next,
            title: 'E-mail Address',
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLength: 100,
            obscured: false,
            initialTextValue: _email,
            textOnChanged: (val){
              widget.emailTextOnChanged(val);
              _emailTextOnChanged(val);
            },
            validator: (val){
              if (val.isEmpty){return 'Enter E-mail';}
              else {
               return EmailValidator.validate(val) == true ? null : 'E-mail is not valid';
              }
            },
          ),

          TextFieldBubble(
            loading: loading,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.next,
            title: 'Password',
            comments: 'minimum 6 characters long',
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLines: 1,
            maxLength: 100,
            obscured: true,
            initialTextValue: _password,
            textOnChanged: (val){
              widget.passwordTextOnChanged(val);
              _passwordTextOnChanged(val);
            },
            validator: (val){
              return
              val.isEmpty ? 'Enter password' :
              val.length < 6 ? 'Password should at least be 6 characters long' :
              null;
            },
          ),

          TextFieldBubble(
            loading: loading,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            title: 'Confirm Password',
            hintText: '...',
            onSaved: (){print('onSaved');},
            maxLines: 1,
            maxLength: 100,
            obscured: true,
            initialTextValue: null,
            textOnChanged: (val) => _confirmPasswordOnChanged(val),
            validator: (val){
              return
                val.isEmpty ? 'Confirm password' :
                _confirmPassword != _password ? 'passwords don\'t match' :
              null;

            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SuperVerse(
                verse: 'Sign in Existing Account',
                color: Colorz.BabyBlue,
                size: 2,
                labelColor: Colorz.WhiteAir,
                margin: 0,
                labelTap: widget.switchToSignIn,
              ),

              DreamBox(
                height: 50,
                verseScaleFactor: 0.7,
                verse: 'Register    ',
                boxMargins: EdgeInsets.all(20),
                boxFunction: () async {
                  if(_formKey.currentState.validate()){
                    _triggerLoading();
                    dynamic result = await _auth.registerWithEmailAndPassword(_email, _password);
                    print('register result is : $result');
                    if ('$result' == '[firebase_auth/email-already-in-use] The email address is already in use by another account.')
                    {setState(() {error = 'E-mail is Already registered';}); _triggerLoading();}
                    else if(result == null){setState(() {error = 'something is wrong';}); _triggerLoading();}
                    else if(result.runtimeType == UserModel)
                    {
                      setState(() {error = ''; _triggerLoading();});
                      goToRoute(context, Routez.Home); // should go to data entry page then confirm then homepage
                    }
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

// ---------------------------------------------------------------------------
