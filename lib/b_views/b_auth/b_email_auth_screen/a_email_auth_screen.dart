import 'dart:async';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/b_views/b_auth/b_email_auth_screen/aa_email_auth_screen_view.dart';
import 'package:bldrs/b_views/b_auth/x_auth_controllers.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:flutter/material.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class EmailAuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EmailAuthScreen({
    super.key
  });
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
  // --------------------
  /// KEYBOARD VISIBILITY
  StreamSubscription<bool>? _keyboardSubscription;
  final KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    _initializeKeyboard();
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        List<AccountModel> myAccounts = await AccountLDBOps.readAllAccounts();
        myAccounts = AccountModel.removeAnonymousAccounts(
          accounts: myAccounts,
        );

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
    _keyboardSubscription?.cancel();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// KEYBOARDS CONTROLLERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeKeyboard(){
    /// Subscribe
    _keyboardSubscription = Keyboard.initializeKeyboardListener(
      controller: keyboardVisibilityController,
    );
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _switchSignIn() {
    _formKey.currentState?.reset();

    setNotifier(
        notifier: _isSigningIn,
        mounted: mounted,
        value: !_isSigningIn.value,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSignin() async {

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

    await Keyboard.closeKeyboard();

    if (mounted == true){

      _switchOnValidation();

      await authByEmailRegister(
        email: _emailController.text,
        password: _passwordController.text,
        formKey: _formKey,
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
  void _setAccount(AccountModel? account){

    _emailController.text = account?.email?.toLowerCase() ?? '';
    _passwordController.text = account?.password ?? '';

    setNotifier(
        notifier: _isSigningIn,
        mounted: mounted,
        value: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onForgotPassword() async {

    if (mounted == true){

      _switchOnValidation();

      await onForgotPassword(
        formKey: _formKey,
        email: _emailController.text,
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      scaffoldKey: _scaffoldKey,
      pyramidsAreOn: true,
      skyType: SkyType.grey,
      appBarType: AppBarType.basic,
      onBack: () async {

        if (_isSigningIn.value == true){
          await Nav.goBack(
            context: context,
            passedData: false,
          );
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
        emailValidator: (String? text) => Formers.emailValidator(
          email: _emailController.text,
          canValidate: _canValidate,
        ),
        passwordValidator: (String? text) => Formers.passwordValidator(
          password: _passwordController.text,
          canValidate: _canValidate,
        ),
        passwordConfirmationValidator: (String? text) => Formers.passwordConfirmationValidation(
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
        onForgotPassword: _onForgotPassword,
        myAccounts: _myAccounts,
        isObscured: _isObscured,
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
