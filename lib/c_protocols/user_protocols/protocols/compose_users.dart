import 'dart:async';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events.dart';
import 'package:bldrs/c_protocols/media_protocols/protocols/media_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:fire/super_fire.dart';

/// => TAMAM
class ComposeUserProtocols {
  // -----------------------------------------------------------------------------

  const ComposeUserProtocols();

  // -----------------------------------------------------------------------------

  /// USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> compose({
    required AuthModel? authModel,
  }) async {
    UserModel? _output;

    if (authModel != null){

      /// CREATE INITIAL USER MODEL
      _output = await UserModel.createNewUserModelFromAuthModel(
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
      );

      await Future.wait(<Future>[

        /// CENSUS
        CensusListener.onComposeUser(_output),

        /// INSERT IN LDB
        UserLDBOps.insertUserModel(_output),

        /// SEND NOTE TO TOPIC
        NoteEvent.onUserSignUp(userModel: _output),

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
  static Future<UserModel?> _composeUserImageFromUserPicURL({
    required String? picURL,
    required String? userID,
    required UserModel? userModel,
  }) async {

    UserModel? _output = userModel;

    if (TextCheck.isEmpty(picURL) == false && TextCheck.isEmpty(userID) == false){

        final MediaModel? _mediaModel = await MediaModelCreator.fromURL(
          url: picURL,
          ownersIDs: userID == null ? [] : [userID],
          uploadPath: StoragePath.users_userID_pic(userID)!,
        );

        await MediaProtocols.composeMedia(_mediaModel);

        _output = _output?.copyWith(
          picPath: _mediaModel?.meta?.uploadPath,
        );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ANONYMOUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> composeAnonymous({
    required AuthModel? authModel,
  }) async {
    UserModel? _output;

    if (authModel != null){

      /// CREATE INITIAL USER MODEL
      _output = await UserModel.anonymousUser(
        authModel: authModel,
      );

      /// CREATE FIRE USER
      await UserFireOps.createUser(
        userModel: _output,
      );

      await Future.wait(<Future>[

        /// CENSUS
        CensusListener.onComposeUser(_output),

        /// INSERT IN LDB
        UserLDBOps.insertUserModel(_output),

        /// SEND NOTE TO TOPIC
        NoteEvent.onCreateAnonymousUser(userModel: _output),

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
  // -----------------------------------------------------------------------------
}
