import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class AccountModel {
  // -----------------------------------------------------------------------------
  const AccountModel({
    required this.id,
    required this.email,
    required this.password,
    required this.signInMethod,
  });
  // -----------------------------------------------------------------------------
  final String? id;
  final String? email;
  final String? password;
  final SignInMethod? signInMethod;
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TASK : TEST ME
  static AccountModel? createAccountByUser({
    required UserModel? userModel,
    required String? passwordOverride,
  }){
    AccountModel? _output;

    if (userModel != null){

      final String? _email = UserModel.getUserEmail(userModel);
      final bool _isAnonymousEmail = UserModel.checkIsAnonymousEmail(email: _email);

      if (_isAnonymousEmail == true && userModel.signInMethod == SignInMethod.anonymous){

        final String? _password = passwordOverride ?? UserModel.createAnonymousPassword(
            anonymousEmail: _email,
        );

        _output = AccountModel(
          id: userModel.id,
          email: _email,
          password: _password,
          signInMethod: userModel.signInMethod,
        );

      }

      else {
        _output = AccountModel(
          id: userModel.id,
          email: UserModel.getUserEmail(userModel),
          password: passwordOverride,
          signInMethod: userModel.signInMethod,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AccountModel? createAccountFromAnonymousUser({
    required UserModel? userModel,
  }) {
    AccountModel? _output;

    if (userModel != null){

      final String? _email = ContactModel.getValueFromContacts(
        contacts: userModel.contacts,
        contactType: ContactType.email,
      );

      final String? _password = UserModel.createAnonymousPassword(
        anonymousEmail: _email,
      );

      _output = AccountModel(
        id: userModel.id,
        email: _email,
        password: _password,
        signInMethod: SignInMethod.anonymous,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  AccountModel copyWith({
    String? id,
    String? email,
    String? password,
    SignInMethod? signInMethod,
  }){
    return AccountModel(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        signInMethod: signInMethod ?? this.signInMethod,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'email': email,
      'password': password,
      'signInMethod': AuthModel.cipherSignInMethod(signInMethod),
    };

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AccountModel? decipher(Map<String, dynamic>? map){
    if(map == null){
      return null;
    }
    else {
      return AccountModel(
        id: map['id'],
        email: map['email'],
        password: map['password'],
        signInMethod: AuthModel.decipherSignInMethod(map['signInMethod']),
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherAccounts({
    required List<AccountModel> accounts,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (Lister.checkCanLoop(accounts) == true){

      for (final AccountModel account in accounts){

        final Map<String, dynamic> _map = account.toMap();
        _output.add(_map);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static AccountModel? getAnonymousAccountFromAccounts({
    required List<AccountModel> accounts,
  }){
    AccountModel? _output;

    if (Lister.checkCanLoop(accounts) == true){

      for (final AccountModel account in accounts){

        final bool _isAnonymous = UserModel.checkIsAnonymousEmail(
            email: account.email,
        );

        if (_isAnonymous == true){
          _output = account;
          break;
        }

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AccountModel> removeAnonymousAccounts({
    required List<AccountModel> accounts,
  }){
    final List<AccountModel> _output = [];

    if (Lister.checkCanLoop(accounts) == true){

      for (final AccountModel account in accounts){

        final bool _isAnonymous = UserModel.checkIsAnonymousEmail(
            email: account.email,
        );

        if (_isAnonymous == false){
          _output.add(account);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanTrySign(AccountModel? account){
    bool _output = false;

    if (
        account != null &&
        account.id != null &&
        account.email != null &&
        account.password != null
    ){
      _output  = true;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAccountsAreIdentical({
    required AccountModel? account1,
    required AccountModel? account2,
  }){
    bool _identical = false;

    if (account1 == null && account2 == null){
      _identical = true;
    }
    else if (account1 == null || account2 == null){
      _identical = false;
    }
    else {

      if (
          account1.id == account2.id &&
          account1.email == account2.email &&
          account1.password == account2.password &&
          account1.signInMethod == account2.signInMethod
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // --------------------
  static void blogAccounts(List<AccountModel> accounts){

    for (final AccountModel account in accounts){
      blog(account);
    }

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() => 'AccountModel(id: $id, email: $email, password: $password : signInMethod : $signInMethod)';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is AccountModel){
      _areIdentical = checkAccountsAreIdentical(
        account1: this,
        account2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      email.hashCode^
      password.hashCode^
      signInMethod.hashCode;
  // -----------------------------------------------------------------------------
}
