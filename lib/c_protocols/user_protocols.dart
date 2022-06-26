import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:flutter/material.dart';

/// PROTOCOLS ARE SET OF OPS CALLED BY CONTROLLERS TO LAUNCH ( FIRE - LDB - PRO ) OPS.

class UserProtocol {

  UserProtocol();

// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------
  static Future<void> createUserProtocol() async {

  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> updateMyUserEverywhereProtocol({
    @required BuildContext context,
    @required UserModel newUserModel,
  }) async {


    /// UPDATE USER IN FIRE STORE
    final UserModel _uploadedModel = await UserFireOps.updateUser(
        context: context,
        newUserModel: newUserModel,
        oldUserModel: UsersProvider.proGetMyUserModel(
            context: context,
            listen: false,
        ),
    );

    /// UPDATE USER AND AUTH IN PRO
    UsersProvider.proUpdateUserAndAuthModels(
      context: context,
      userModel: _uploadedModel,
      notify: true,
    );

    /// UPDATE USER MODEL IN LDB
    await UserLDBOps.updateUserModel(_uploadedModel);

    /// UPDATE AUTH MODEL IN LDB
    final AuthModel _authModel = UsersProvider.proGetAuthModel(
      context: context,
      listen: false,
    );
    await AuthLDBOps.updateAuthModel(_authModel);

    return _uploadedModel;
  }
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------
  static Future<void> deleteUserProtocol() async {

  }
// -----------------------------------------------------------------------------
}
