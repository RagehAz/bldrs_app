import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/g_user/g_x_user_editor_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  final Function switchSignIn;
  final String email;
  final String password;
  // final Function emailTextOnChanged;
  // final Function passwordTextOnChanged;


  const RegisterForm({
    @required this.switchSignIn,
    @required this.email,
    @required this.password,
    // @required this.emailTextOnChanged,
    // @required this.passwordTextOnChanged,
    Key key,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordObscured = true;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _passwordController.text = widget.password;

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    if (TextChecker.textControllerIsEmpty(_emailController))
      _emailController.dispose();
    if (TextChecker.textControllerIsEmpty(_passwordController))
      _passwordController.dispose();
    if (TextChecker.textControllerIsEmpty(_confirmPasswordController))
      _confirmPasswordController.dispose();
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
    final bool _areValid = _formKey.currentState.validate();
    print('_allFieldsAreValid() = $_areValid');
    return _areValid;
  }
// -----------------------------------------------------------------------------
  Future<void> _registerOnTap({ZoneModel currentZone}) async {

    setState(() {
      _passwordObscured = true;
    });


    /// minimize keyboard
    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    /// proceed with register if fields are valid
    if(_allFieldsAreValid() == true){

      _triggerLoading();

      /// start register ops
      final dynamic _result = await FireAuthOps.emailRegisterOps(
          context: context,
          currentZone: currentZone,
          email: _emailController.text,
          password: _passwordController.text
      );

      /// pop dialog if sign in fails otherwise check user required field then route
      print('_registerOnTap() _result.runtimeType : ${_result.runtimeType} : $_result');
      if(_result.runtimeType == String){

        _triggerLoading();

        /// pop error dialog
        await Dialogz.authErrorDialog(context: context, result: _result);

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

    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: true);
    final ZoneModel _currentZone = _zoneProvider.currentZone;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          const SizedBox(
            height: 20,
          ),

          /// ENTER E-MAIL
          TextFieldBubble(
            key: const ValueKey<String>('email'),
            textController: _emailController,
            loading: _loading,
            bubbleColor: Colorz.white20,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.emailAddress,
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.emailAddress(context),
            hintText: '...',
            maxLength: 100,
            validator: (String val) => _emailValidator(val),
          ),

          /// ENTER PASSWORD
          TextFieldBubble(
            key: const ValueKey<String>('password'),
            textController: _passwordController,
            loading: _loading,
            bubbleColor: Colorz.white20,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword, // ----------------------------------------------------------
            keyboardTextInputAction: TextInputAction.next,
            title: Wordz.password(context),
            hintText: '...',
            maxLength: 100,
            validator: (String val) => _passwordValidator(val),
            comments: Wordz.min6Char(context),
            maxLines: 1,
            obscured: _passwordObscured,
            horusOnTap: _horusOnTap,
          ),

          /// ENTER CONFIRM PASSWORD
          TextFieldBubble(
            key: const ValueKey<String>('confirm'),
            textController: _confirmPasswordController,
            loading: _loading,
            bubbleColor: Colorz.white20,
            textDirection: TextDirection.ltr,
            fieldIsFormField: true,
            fieldIsRequired: true,
            keyboardTextInputType: TextInputType.visiblePassword, // ----------------------------------------------------------
            keyboardTextInputAction: TextInputAction.done, // ----------------------------------------------------------
            title: Wordz.confirmPassword(context),
            hintText: '...',
            maxLength: 100,
            validator: (String val) => _confirmPasswordValidator(val),
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
                color: Colorz.white20,
                onTap: () => widget.switchSignIn(_emailController.text, _passwordController.text),
              ),

              ChangeNotifierProvider.value(
                value: _zoneProvider,
                child: DreamBox(
                  height: 50,
                  color: Colorz.yellow255,
                  verseScaleFactor: 0.7,
                  verse: Wordz.register(context),
                  verseColor: Colorz.black230,
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
