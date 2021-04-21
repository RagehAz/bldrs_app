import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/screens/s16_user_editor_screen.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function switchToSignIn;
  final String email;
  final String password;
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
  bool _loading = false;
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
      _loading = !_loading;
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
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    Zone _currentZone = new Zone(
      countryID: _countryPro.currentCountryID,
      provinceID: _countryPro.currentProvinceID,
      areaID: _countryPro.currentAreaID,
    );

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
            loading: _loading,
            bubbleColor: Colorz.WhiteGlass,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.password(context),
            comments: Wordz.min6Char(context),
            hintText: '...',
            // onSaved: (){print('onSaved');},
            // maxLines: 1,
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
            loading: _loading,
            bubbleColor: Colorz.WhiteGlass,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword,
            keyboardTextInputAction: TextInputAction.done,
            title: Wordz.confirmPassword(context),
            hintText: '...',
            // onSaved: (){print('onSaved');},
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

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              DreamBox(
                height: 50,
                width: 150,
                verse: 'Sign in',
                secondLine: 'Existing account',
                verseMaxLines: 2,
                verseScaleFactor: 0.55,
                color: Colorz.WhiteGlass,
                boxFunction: widget.switchToSignIn,
              ),

              ChangeNotifierProvider.value(
                value: _countryPro,
                child: DreamBox(
                  height: 50,
                  color: Colorz.Yellow,
                  verseScaleFactor: 0.7,
                  verse: Wordz.register(context),
                  verseColor: Colorz.BlackBlack,
                  verseWeight: VerseWeight.black,
                  boxMargins: EdgeInsets.all(10),
                  boxFunction: () async {
                    minimizeKeyboardOnTapOutSide(context);

                    if(_formKey.currentState.validate()){
                      _triggerLoading();
                      // ---------------------
                      dynamic result = await _auth.registerWithEmailAndPassword(context, _currentZone, _email, _password);
                      print('register result is : $result');
                      // ---------------------
                      if ('$result' == '[firebase_auth/email-already-in-use] The email address is already in use by another account.'){
                        await superDialog(
                          context: context,
                          title: 'E-mail Taken',
                          body: Wordz.emailAlreadyRegistered(context),
                          boolDialog: false,
                        );
                        _triggerLoading();
                      }
                      // ---------------------
                      else if('$result' == '[firebase_auth/invalid-email] The email address is badly formatted.'){
                        await superDialog(
                          context: context,
                          title: 'E-mail Taken',
                          body: Wordz.emailWrong(context),
                          boolDialog: false,
                        );
                        _triggerLoading();
                      }
                      // ---------------------
                      else if(result == null){
                        await superDialog(
                          context: context,
                          title: '',
                          body: 'something is wrong',
                          boolDialog: false,
                        );
                        _triggerLoading();
                      }
                      // ---------------------
                      else if(result.runtimeType == UserModel){

                        /// create a new firestore document for the user with the userID
                        UserModel _initialUserModel = result;
                        await UserCRUD().createUserOps(userModel: _initialUserModel);


                        _triggerLoading();
                        Nav.goToNewScreen(context, EditProfileScreen(user: result, firstTimer: true,),);
                      }
                      // ---------------------
                    }

                  },
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
