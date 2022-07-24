import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

class RenovateUserProtocols {
// -----------------------------------------------------------------------------

  RenovateUserProtocols();

// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> renovateMyUserModel({
    @required BuildContext context,
    @required UserModel newUserModel,
  }) async {

    blog('RenovateUserProtocols.renovateMyUserModel : START');

    UserModel _uploadedModel;

    final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _modelsAreIdentical = UserModel.checkUsersAreIdentical(
        user1: newUserModel,
        user2: _oldUserModel
    );

    if (_modelsAreIdentical == false){

      /// UPDATE USER IN FIRE STORE
      _uploadedModel = await UserFireOps.updateUser(
        context: context,
        newUserModel: newUserModel,
        oldUserModel: _oldUserModel,
      );

      await updateLocally(
        context: context,
        newUserModel: _uploadedModel,
      );

    }

    blog('UserProtocol.updateMyUserEverywhereProtocol : END');

    return _uploadedModel ?? newUserModel;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    @required UserModel newUserModel,
    @required BuildContext context,
  }) async {

    blog('RenovateUserProtocols.updateLocally : START');

    final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _modelsAreIdentical = UserModel.checkUsersAreIdentical(
        user1: newUserModel,
        user2: _oldUserModel
    );

    if (_modelsAreIdentical == false){

      /// UPDATE USER AND AUTH IN PRO
      UsersProvider.proUpdateUserAndAuthModels(
        context: context,
        userModel: newUserModel,
        notify: true,
      );

      /// UPDATE USER MODEL IN LDB
      await UserLDBOps.updateUserModel(newUserModel);

      /// UPDATE AUTH MODEL IN LDB
      final AuthModel _authModel = UsersProvider.proGetAuthModel(
        context: context,
        listen: false,
      );
      await AuthLDBOps.updateAuthModel(_authModel);

    }

    blog('UserProtocol.updateLocally : END');

  }
// ----------------------------------
}
