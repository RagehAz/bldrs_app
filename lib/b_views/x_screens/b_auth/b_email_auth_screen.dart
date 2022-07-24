import 'dart:async';

import 'package:bldrs/b_views/x_screens/b_auth/bb_email_auth_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_controllers/b_auth_controllers/auth_controllers.dart';
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
  // -----------------------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController(); /// tamam disposed
  final TextEditingController _passwordController = TextEditingController(); /// tamam disposed
  final TextEditingController _passwordConfirmationController = TextEditingController(); /// tamam disposed
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSigningIn = ValueNotifier(true); /// tamam disposed
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _isSigningIn.dispose();

    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  void _switchSignIn() {
    _formKey.currentState.reset();
    _isSigningIn.value = !_isSigningIn.value;
  }
// -----------------------------------------------------------------------------
  String _validateEmail(){
    return emailValidation(
        context: context,
        val: _emailController.text,
    );
  }
// -----------------------------------------------------------------------------
  String _validatePassword(){
    return passwordValidation(
        context: context,
        password: _passwordController.text,
    );
  }
// -----------------------------------------------------------------------------
  String _validatePasswordConfirmation(){
    return passwordConfirmationValidation(
        context: context,
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmationController.text,
    );
  }
// -----------------------------------------------------------------------------
//   bool _canSignIn = true;
  Future<void> _onSignin() async {

    closeKeyboard(context);

    if (
    mounted == true
        // &&
        // _canSignIn == true
    ){
      // _canSignIn = false;
      await authByEmailSignIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        formKey: _formKey,
      );

    }

  }
// -----------------------------------------------------------------------------
//   bool _canSignUp = true;
  Future<void> _onSignup() async {

    closeKeyboard(context);

    if (
    mounted == true
        // &&
        // _canSignUp == true
    ){
      // _canSignUp = false;
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      scaffoldKey: _scaffoldKey,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.non,
      layoutWidget: EmailAuthScreenView(
        formKey: _formKey,
        emailController: _emailController,
        passwordController: _passwordController,
        passwordConfirmationController: _passwordConfirmationController,
        validateEmail: _validateEmail,
        passwordValidator: _validatePassword,
        passwordConfirmationValidator: _validatePasswordConfirmation,
        switchSignIn: _switchSignIn,
        onSignin: _onSignin,
        onSignup: _onSignup,
        isSigningIn: _isSigningIn,
      ),

    );
  }
}
