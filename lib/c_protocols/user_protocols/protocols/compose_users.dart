import 'dart:async';
import 'dart:typed_data';

import 'package:basics/helpers/files/file_size_unit.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/models/file_typer.dart';
import 'package:basics/mediator/models/media_meta_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
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

    if (TextCheck.isEmpty(picURL) == false){

      final Uint8List? _bytes = await Storage.readBytesByURL(
        url: picURL,
      );

      if (Lister.checkCanLoop(_bytes) == true){

        final Dimensions? _dims = await Dimensions.superDimensions(_bytes);
        final String? _picPath = StoragePath.users_userID_pic(userID);
        final double? _mega = Filers.calculateSize(_bytes!.length, FileSizeUnit.megaByte);

        await PicProtocols.composePic(
            MediaModel(
              bytes: _bytes,
              meta: MediaMetaModel(
                fileType: FileType.jpeg,
                sizeMB: _mega,
                ownersIDs: userID == null ? [] : [userID],
                width: _dims?.width,
                height: _dims?.height,
                uploadPath: _picPath,
              ),
            )
        );

        _output = _output?.copyWith(
          picPath: _picPath,
        );

      }

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
