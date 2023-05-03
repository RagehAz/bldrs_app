import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class AccountModel {
  // -----------------------------------------------------------------------------
  const AccountModel({
    @required this.id,
    @required this.email,
    @required this.password,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final String email;
  final String password;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'email': email,
      'password': password,
    };

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AccountModel decipher(Map<String, dynamic> map){
    if(map == null){
      return null;
    }
    else {
      return AccountModel(
        id: map['id'],
        email: map['email'],
        password: map['password'],
      );
    }
  }
  // -----------------------------------------------------------------------------
  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAccountsAreIdentical({
    @required AccountModel account1,
    @required AccountModel account2,
  }){
    bool _identical;

    if (account1 == null && account2 == null){
      _identical = true;
    }
    else if (account1 == null || account2 == null){
      _identical = false;
    }
    else if (account1 != null && account2 != null){

      if (
          account1.id == account2.id &&
          account1.email == account2.email &&
          account1.password == account2.password
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
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
      password.hashCode;
  // -----------------------------------------------------------------------------
}
