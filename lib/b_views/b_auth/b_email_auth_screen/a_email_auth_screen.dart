import 'dart:async';

import 'package:bldrs/b_views/b_auth/b_email_auth_screen/aa_email_auth_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/b_auth/x_auth_controllers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:flutter/material.dart';

class EmailAuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EmailAuthScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
  /// --------------------------------------------------------------------------
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // --------------------
  bool _canValidate = false;
  void _switchOnValidation(){
    if (_canValidate != true){
      setState(() {
        _canValidate = true;
      });
    }
  }
  // --------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  // --------------------
  final ValueNotifier<bool> _isSigningIn = ValueNotifier(true);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _isSigningIn.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _switchSignIn() {
    _formKey.currentState.reset();
    _isSigningIn.value = !_isSigningIn.value;
  }
  // --------------------
  Future<void> _onSignin() async {

    Keyboard.closeKeyboard(context);

    if (mounted == true){

      _switchOnValidation();

      await authByEmailSignIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        formKey: _formKey,
      );


    }

  }
  // --------------------
  Future<void> _onSignup() async {

    Keyboard.closeKeyboard(context);

    if (mounted == true){

      _switchOnValidation();

      await authByEmailRegister(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmationController.text,
        formKey: _formKey,
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      scaffoldKey: _scaffoldKey,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.non,
      layoutWidget: EmailAuthScreenView(
        appBarType: AppBarType.non,
        formKey: _formKey,
        emailController: _emailController,
        passwordController: _passwordController,
        passwordConfirmationController: _passwordConfirmationController,
        emailValidator: () => Formers.emailValidator(
          email: _emailController.text,
          canValidate: _canValidate,
        ),
        passwordValidator: () => Formers.passwordValidator(
          password: _passwordController.text,
          canValidate: _canValidate,
        ),
        passwordConfirmationValidator: () => Formers.passwordConfirmationValidation(
          context: context,
          password: _passwordController.text,
          passwordConfirmation: _passwordConfirmationController.text,
          canValidate: _canValidate,
        ),
        switchSignIn: _switchSignIn,
        onSignin: _onSignin,
        onSignup: _onSignup,
        isSigningIn: _isSigningIn,
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
