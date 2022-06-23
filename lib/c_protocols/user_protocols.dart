import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart';

/// PROTOCOLS ARE SET OF OPS CALLED BY CONTROLLERS TO LAUNCH FIRE OPS AND LDB OPS.

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
  static Future<void> updateMyUserEverywhereProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    /// UPDATE IN FIRE STORE
    await UserFireOps.updateUser(
        context: context,
        newUserModel: userModel,
        oldUserModel: UsersProvider.proGetMyUserModel(
            context: context,
            listen: false,
        ),
    );

    /// UPDATE IN LDB
    await UserLDBOps.updateUserModel(userModel);

    /// UPDATE IN PRO
    UsersProvider.proUpdateUserModel(
      context: context,
      userModel: userModel,
      notify: true,
    );

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------
  static Future<void> deleteUserProtocol() async {

  }
// -----------------------------------------------------------------------------
}
