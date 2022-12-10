import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// => TAMAM
class ComposeUserProtocols {
  // -----------------------------------------------------------------------------

  const ComposeUserProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
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
      UserModel _userModel = await _createInitialUserModel(
        context: context,
        authType: authType,
        userCredential: userCredential,
      );

      /// CREATE USER IMAGE FROM URL
      _userModel = await _composeUserImageFromUserPicURL(
        userID: _userModel.id,
        picURL: userCredential.user.photoURL,
        userModel: _userModel,
      );

      /// CREATE FIRE USER
      await UserFireOps.createUser(
        userModel: _userModel,
        authBy: authType,
      );

      /// UPDATE AUTH MODEL
      _authModel = _authModel.copyWith(
        userModel: _userModel,
      );

      await Future.wait(<Future>[

        /// CENSUS
        CensusListener.onComposeUser(_userModel),

        /// INSERT IN LDB
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<UserModel> _composeUserImageFromUserPicURL({
    @required String picURL,
    @required String userID,
    @required UserModel userModel,
  }) async {

    UserModel _output = userModel;

    if (TextCheck.isEmpty(picURL) == false){

      final Uint8List _bytes = await Storage.readBytesByURL(picURL);

      if (Mapper.checkCanLoopList(_bytes) == true){

        final Dimensions _dims = await Dimensions.superDimensions(_bytes);
        final String _picPath = Storage.generateUserPicPath(userID);

        await PicProtocols.composePic(
            PicModel(
              bytes: _bytes,
              path: _picPath,
              meta: PicMetaModel(
                ownersIDs: [userID],
                dimensions: _dims,
              ),
            )
        );

        _output = _output.copyWith(
          picPath: _picPath,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
