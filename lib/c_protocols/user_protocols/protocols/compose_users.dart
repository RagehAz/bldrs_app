import 'dart:async';
import 'dart:typed_data';

import 'package:basics/helpers/classes/files/file_size_unit.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:fire/super_fire.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:mediators/mediators.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:mediators/models/dimension_model.dart';

/// => TAMAM
class ComposeUserProtocols {
  // -----------------------------------------------------------------------------

  const ComposeUserProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> compose({
    required AuthModel authModel,
  }) async {
    UserModel _output;

    if (authModel != null){

      /// CREATE INITIAL USER MODEL
      _output = await _createInitialUserModel(
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
        UserLDBOps.insertUserModel(_output),

      ]);

      UsersProvider.proSetMyUserModel(
        userModel: _output,
        notify: true,
      );

    }

    // AuthModel.blogAuthModel(
    //   authModel: authModel,
    //   invoker: 'ComposeUserProtocols.compose',
    // );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> _createInitialUserModel({
    required AuthModel authModel,
  }) async {

    final UserModel _initialUserModel = await UserModel.createNewUserModelFromAuthModel(
      authModel: authModel,
    );

    return _initialUserModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> _composeUserImageFromUserPicURL({
    required String picURL,
    required String userID,
    required UserModel userModel,
  }) async {

    UserModel _output = userModel;

    if (TextCheck.isEmpty(picURL) == false){

      final Uint8List? _bytes = await Storage.readBytesByURL(
        url: picURL,
      );

      if (Mapper.checkCanLoopList(_bytes) == true){

        final Dimensions? _dims = await Dimensions.superDimensions(_bytes);
        final String _picPath = StoragePath.users_userID_pic(userID);
        final double? _mega = Filers.calculateSize(_bytes!.length, FileSizeUnit.megaByte);

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
