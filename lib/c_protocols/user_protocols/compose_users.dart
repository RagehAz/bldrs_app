import 'dart:async';

import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/user_fire_ops.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ComposeUserProtocols {
  // -----------------------------------------------------------------------------

  const ComposeUserProtocols();

  // -----------------------------------------------------------------------------
  static Future<AuthModel> compose({
    @required BuildContext context,
    @required bool authSucceeds,
    @required String authError,
    @required UserCredential userCredential,
    @required AuthType authType,
  }) async {
    // -----------------------------
    AuthModel _authModel = AuthModel.create(
      authSucceeds: authSucceeds,
      authError: authError,
      userCredential: userCredential,
      firstTimer: true,
    );
    // -----------------------------
    /// CREATE USER MODEL IS AUTH SUCCEEDS
    if (_authModel.authSucceeds == true) {

      final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
      );

      final UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
        context: context,
        user: userCredential.user,
        zone: _currentZone,
        authBy: authType,
      );

      /// create a new firestore document for the user with the userID
      final UserModel _uploadedUserModel = await UserFireOps.createUser(
        context: context,
        userModel: _initialUserModel,
        authBy: authType,
      );

      _authModel = _authModel.copyWith(
        userModel: _uploadedUserModel,
      );

      /// TASK WILL COME TO THIS LATER,,, THIS SHOULD UPDATE LDB
      // /// INSERT AUTH AND USER MODEL IN LDB
      // await AuthLDBOps.updateAuthModel(_authModel);
      // await UserLDBOps.updateUserModel(_authModel.userModel);

    }
    // -----------------------------
    _authModel.blogAuthModel(methodName: 'ComposeUserProtocols.compose');
    // -----------------------------
    return _authModel;
  }
// -----------------------------------------------------------------------------
}
