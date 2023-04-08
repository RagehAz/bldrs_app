import 'dart:async';

import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/b_views/b_auth/b_email_auth_screen/aa_email_auth_screen_view.dart';
import 'package:bldrs/b_views/b_auth/x_auth_controllers.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:filers/filers.dart';
import 'package:layouts/layouts.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

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
    if (mounted == true){
      if (_canValidate != true){
        setState(() {
          _canValidate = true;
        });
      }
    }
  }
  // --------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  // --------------------
  final ValueNotifier<bool> _isRememberingMe = ValueNotifier(true);
  List<AccountModel> _myAccounts = [];

  final ValueNotifier<bool> _isObscured = ValueNotifier(true);
  // --------------------
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();
  // --------------------
  final ValueNotifier<bool> _isSigningIn = ValueNotifier(true);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        final List<AccountModel> myAccounts = await AccountLDBOps.realAllAccounts();

        if (Mapper.checkCanLoopList(myAccounts) == true){

          setNotifier(
              notifier: _isRememberingMe,
              mounted: mounted,
              value: true,
          );

          _setAccount(myAccounts[0]);

          setState(() {
            _myAccounts = myAccounts;
          });

        }

        // -------------------------------
        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _isSigningIn.dispose();
    _loading.dispose();
    _isRememberingMe.dispose();
    _isObscured.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _switchSignIn() {
    _formKey.currentState.reset();

    setNotifier(
        notifier: _isSigningIn,
        mounted: mounted,
        value: !_isSigningIn.value,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSignin() async {

    Keyboard.closeKeyboard(context);

    if (mounted == true){

      _switchOnValidation();

      await authByEmailSignIn(
        email: _emailController.text,
        password: _passwordController.text,
        formKey: _formKey,
        mounted: mounted,
        rememberMe: _isRememberingMe.value,
      );


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSignup() async {

    Keyboard.closeKeyboard(context);

    if (mounted == true){

      _switchOnValidation();

      await authByEmailRegister(
        email: _emailController.text,
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
        formKey: _formKey,
        rememberMe: _isRememberingMe.value,
        mounted: mounted,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onSwitchRememberMe(bool value) {

    setNotifier(
        notifier: _isRememberingMe,
        mounted: mounted,
        value: value,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onSelectAccount(int index){
    if (Mapper.checkCanLoopList(_myAccounts) == true){
      _setAccount(_myAccounts[index]);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setAccount(AccountModel account){

    _emailController.text = account.email;
    _passwordController.text = account.password;

    setNotifier(
        notifier: _isSigningIn,
        mounted: mounted,
        value: true,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      scaffoldKey: _scaffoldKey,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      onBack: () async {

        if (_isSigningIn.value == true){
          await Nav.goBack(context: context);
        }

        else {
          _switchSignIn();
        }

      },
      child: EmailAuthScreenView(
        appBarType: AppBarType.non,
        formKey: _formKey,
        emailController: _emailController,
        passwordController: _passwordController,
        passwordConfirmationController: _confirmPasswordController,
        passwordNode: _passwordNode,
        confirmPasswordNode: _confirmPasswordNode,
        emailValidator: (String text) => Formers.emailValidator(
          context: context,
          email: _emailController.text,
          canValidate: _canValidate,
        ),
        passwordValidator: (String text) => Formers.passwordValidator(
          context: context,
          password: _passwordController.text,
          canValidate: _canValidate,
        ),
        passwordConfirmationValidator: (String text) => Formers.passwordConfirmationValidation(
          context: context,
          password: _passwordController.text,
          passwordConfirmation: _confirmPasswordController.text,
          canValidate: _canValidate,
        ),
        switchSignIn: _switchSignIn,
        onSignin: _onSignin,
        onSignup: _onSignup,
        isSigningIn: _isSigningIn,
        isRememberingMe: _isRememberingMe,
        onSwitchRememberMe: _onSwitchRememberMe,
        onSelectAccount: _onSelectAccount,
        myAccounts: _myAccounts,
        isObscured: _isObscured,
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
