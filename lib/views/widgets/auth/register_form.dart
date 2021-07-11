import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/screens/s16_user_editor_screen.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  final Function switchSignIn;
  final String email;
  final String password;
  // final Function emailTextOnChanged;
  // final Function passwordTextOnChanged;


  RegisterForm({
    @required this.switchSignIn,
    @required this.email,
    @required this.password,
    // @required this.emailTextOnChanged,
    // @required this.passwordTextOnChanged,
  });

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final AuthOps _auth = AuthOps();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordObscured = true;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _emailController.text = widget.email;
    _passwordController.text = widget.password;

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    if (TextChecker.textControllerHasNoValue(_emailController))_emailController.dispose();
    if (TextChecker.textControllerHasNoValue(_passwordController))_passwordController.dispose();
    if (TextChecker.textControllerHasNoValue(_confirmPasswordController))_confirmPasswordController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  String _emailValidator(String val){

    if (val.isEmpty){

      return Wordz.enterEmail(context);

    } else {

      return EmailValidator.validate(val) == true ? null : Wordz.emailInvalid(context);

    }
  }
// -----------------------------------------------------------------------------
  String _passwordValidator(String val){
    return
      val.isEmpty ? Wordz.enterPassword(context) :
      val.length < 6 ? Wordz.min6CharError(context) :
      _confirmPasswordController.text != _passwordController.text ? Wordz.passwordMismatch(context) :
      null;
  }
// -----------------------------------------------------------------------------
  String _confirmPasswordValidator(String val){
    return
      val.isEmpty ? Wordz.confirmPassword(context) :
      _confirmPasswordController.text != _passwordController.text ? Wordz.passwordMismatch(context) :
      val.length < 6 ? Wordz.min6CharError(context) :
      null;
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
  Future<void> _registerOnTap({Zone currentZone}) async {

    /// minimize keyboard
    minimizeKeyboardOnTapOutSide(context);

    /// proceed with register if fields are valid
    if(_allFieldsAreValid() == true){

      _triggerLoading();

      /// start register ops
      dynamic _result = await _auth.emailRegisterOps(context, currentZone, _emailController.text, _passwordController.text);

      /// pop dialog if sign in fails otherwise check user required field then route
      print('_registerOnTap() _result.runtimeType : ${_result.runtimeType} : $_result');
      if(_result.runtimeType == String){

        _triggerLoading();

        /// pop error dialog
        await authErrorDialog(context: context, result: _result);

      } else {

        _triggerLoading();

        /// route to edit profile screen to complete profile data
        Nav.goToNewScreen(context, EditProfileScreen(user: _result, firstTimer: true,),);

      }

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    Zone _currentZone = _countryPro.currentZone;

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
            key: ValueKey('email'),
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
            maxLength: 100,
            validator: (val) => _emailValidator(val),
          ),

          // --- ENTER PASSWORD
          TextFieldBubble(
            key: ValueKey('password'),
            textController: _passwordController,
            loading: _loading,
            bubbleColor: Colorz.WhiteGlass,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword, // ----------------------------------------------------------
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.password(context),
            hintText: '...',
            maxLength: 100,
            validator: (val) => _passwordValidator(val),
              comments: Wordz.min6Char(context),
              maxLines: 1,
              obscured: _passwordObscured,
              horusOnTap: _horusOnTap,
          ),

          // --- ENTER CONFIRM PASSWORD
          TextFieldBubble(
            key: ValueKey('confirm'),
            textController: _confirmPasswordController,
            loading: _loading,
            bubbleColor: Colorz.WhiteGlass,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword, // ----------------------------------------------------------
            keyboardTextInputAction: TextInputAction.done, // ----------------------------------------------------------
            title: Wordz.confirmPassword(context),
            hintText: '...',
            maxLength: 100,
            validator: (val) => _confirmPasswordValidator(val),
              comments: Wordz.min6Char(context),
              maxLines: 1,
              obscured: _passwordObscured,
              horusOnTap: _horusOnTap,
            initialTextValue: null,
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
                onTap: () => widget.switchSignIn(_emailController.text, _passwordController.text),
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
                  margins: const EdgeInsets.all(10),
                  onTap: () => _registerOnTap(currentZone: _currentZone),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
