import 'dart:async';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/y_views/b_auth/b_1_email_auth_screen_view.dart';
import 'package:bldrs/c_controllers/b_0_auth_controller.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // -----------------------------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSigningIn = ValueNotifier(true);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    if (TextChecker.textControllerIsEmpty(_emailController)) {
      _emailController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_passwordController)) {
      _passwordController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_passwordConfirmationController)) {
      _passwordConfirmationController.dispose();
    }

    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _switchSignIn() {
    _formKey.currentState.reset();
    _isSigningIn.value = !_isSigningIn.value;
  }
// -----------------------------------------------------------------------------
  String _validateEmail(String val){
    return emailValidation(context: context, val: val);
  }
// -----------------------------------------------------------------------------
  String _validatePassword(String val){
    return passwordValidation(
        context: context,
        password: val,
    );
  }
// -----------------------------------------------------------------------------
  String _validatePasswordConfirmation(String val){
    return passwordConfirmationValidation(
        context: context,
        password: _passwordController.text,
        passwordConfirmation: val,
    );
  }
// -----------------------------------------------------------------------------
  void _onObscureTap(){
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.triggerTextFieldsObscured();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSignin() async {
    await authByEmailSignIn(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      formKey: _formKey,
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _onSignup() async {
    await authByEmailRegister(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      passwordConfirmation: _passwordConfirmationController.text,
      formKey: _formKey,
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.non,
      layoutWidget: EmailAuthScreenView(
        formKey: _formKey,
        emailController: _emailController,
        passwordController: _passwordController,
        passwordConfirmationController: _passwordConfirmationController,
        validateEmail: _validateEmail,
        validatePassword: _validatePassword,
        validatePasswordConfirmation: _validatePasswordConfirmation,
        onObscureTap: _onObscureTap,
        switchSignIn: _switchSignIn,
        onSignin: _onSignin,
        onSignup: _onSignup,
        isSigningIn: _isSigningIn,
      ),

    );
  }
}
