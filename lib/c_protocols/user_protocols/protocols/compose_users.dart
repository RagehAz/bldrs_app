import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_byte_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ComposeUserProtocols {
  // -----------------------------------------------------------------------------

  const ComposeUserProtocols();

  // -----------------------------------------------------------------------------
  /// TASK : TEST ME
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

      /// CREATE INITIAL USER MODEL
      final UserModel _userModel = await _createInitialUserModel(
        context: context,
        authType: authType,
        userCredential: userCredential,
      );

      /// UPDATE AUTH MODEL
      _authModel = _authModel.copyWith(
        userModel: _userModel,
      );

      await Future.wait(<Future>[

        /// CREATE FIRE USER
        UserFireOps.createUser(
          userModel: _userModel,
          authBy: authType,
        ),

        /// CREATE USER IMAGE FROM URL
        _composeUserImageFromUserPicURL(
          userID: _userModel.id,
          picURL: userCredential.user.photoURL,
        ),

      ]);

      /// INSERT IN LDB
      await Future.wait(<Future>[
        AuthLDBOps.insertAuthModel(_authModel),
        UserLDBOps.insertUserModel(_authModel.userModel),
      ]);

    }
    // -----------------------------
    _authModel.blogAuthModel(invoker: 'ComposeUserProtocols.compose');
    // -----------------------------
    return _authModel;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<UserModel> _createInitialUserModel({
    @required BuildContext context,
    @required UserCredential userCredential,
    @required AuthType authType,
  }) async {

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: false,
    );

    final UserModel _initialUserModel = await UserModel.fromFirebaseUser(
      context: context,
      user: userCredential.user,
      zone: _currentZone,
      authBy: authType,
    );

    return _initialUserModel;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _composeUserImageFromUserPicURL({
    @required String picURL,
    @required String userID,
  }) async {

    if (TextCheck.isEmpty(picURL) == false){

      final Uint8List _bytes = await StorageByteOps.readBytesByURL(picURL);
      final Dimensions _dims = await Dimensions.superDimensions(_bytes);

      await PicProtocols.composePic(PicModel(
        bytes: _bytes,
        path: StorageColl.getUserPicPath(userID),
        meta: PicMetaModel(
          ownersIDs: [userID],
          dimensions: _dims,
        ),
      ));

    }

  }
  // -----------------------------------------------------------------------------
}
