import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/protocols/census_listeners.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths_generators.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:mediators/mediators.dart';
import 'package:stringer/stringer.dart';

/// => TAMAM
class ComposeUserProtocols {
  // -----------------------------------------------------------------------------

  const ComposeUserProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> compose({
    @required BuildContext context,
    @required AuthModel authModel,
  }) async {
    UserModel _output;

    if (authModel != null){

      /// CREATE INITIAL USER MODEL
      _output = await _createInitialUserModel(
        context: context,
        authModel: authModel,
      );

      /// CREATE USER IMAGE FROM URL
      _output = await _composeUserImageFromUserPicURL(
        userID: _output.id,
        picURL: authModel.imageURL,
        userModel: _output,
      );

      /// CREATE FIRE USER
      await UserFireOps.createUser(
        userModel: _output,
        signInMethod: authModel.signInMethod,
      );

      await Future.wait(<Future>[

        /// CENSUS
        CensusListener.onComposeUser(_output),

        /// INSERT IN LDB
        AuthLDBOps.insertAuthModel(authModel),
        UserLDBOps.insertUserModel(_output),

      ]);
      UsersProvider.proSetMyAuthModel(
        context: context,
        authModel: authModel,
        notify: false,
      );
      UsersProvider.proSetMyUserModel(
        context: context,
        userModel: _output,
        notify: true,
      );

    }

    AuthModel.blogAuthModel(
      authModel: authModel,
      invoker: 'ComposeUserProtocols.compose',
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> _createInitialUserModel({
    @required BuildContext context,
    @required AuthModel authModel,
  }) async {

    final UserModel _initialUserModel = await UserModel.createNewUserModelFromAuthModel(
      context: context,
      authModel: authModel,
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

      final Uint8List _bytes = await Storage.readBytesByURL(
        url: picURL,
      );

      if (Mapper.checkCanLoopList(_bytes) == true){

        final Dimensions _dims = await Dimensions.superDimensions(_bytes);
        final String _picPath = BldrStorage.generateUserPicPath(userID);
        final double _mega = Filers.calculateSize(_bytes.length, FileSizeUnit.megaByte);

        await PicProtocols.composePic(
            PicModel(
              bytes: _bytes,
              path: _picPath,
              meta: StorageMetaModel(
                sizeMB: _mega,
                ownersIDs: [userID],
                width: _dims?.width,
                height: _dims?.height,
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
