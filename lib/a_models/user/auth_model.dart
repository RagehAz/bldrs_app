import 'package:bldrs/a_models/user/user_model.dart';
import 'package:flutter/foundation.dart';

// -----------------------------------------------------------------------------
enum AuthBy {
  email,
  facebook,
  google,
  apple,
}
// -----------------------------------------------------------------------------
class AuthModel {
  /// --------------------------------------------------------------------------
  const AuthModel({
    @required this.userModel,
    @required this.firstTimer,
  });
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final bool firstTimer;
// -----------------------------------------------------------------------------
  static AuthBy decipherAuthBy(String authBy) {
    switch (authBy) {
      case 'email':     return AuthBy.email;    break;
      case 'facebook':  return AuthBy.facebook; break;
      case 'apple':     return AuthBy.apple;    break;
      case 'google':    return AuthBy.google;   break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherAuthBy(AuthBy authBy) {
    switch (authBy) {
      case AuthBy.email:    return 'email';     break;
      case AuthBy.facebook: return 'facebook';  break;
      case AuthBy.apple:    return 'apple';     break;
      case AuthBy.google:   return 'google';    break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------

}
