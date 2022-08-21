import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/e_db/fire/ops/user_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FetchUserProtocols {
// -----------------------------------------------------------------------------

  const FetchUserProtocols();

// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> fetchUser({
    @required BuildContext context,
    @required String userID
  }) async {

    /// 1 - GET USER FROM LDB
    UserModel _userModel= await UserLDBOps.readUserOps(
      userID: userID,
    );

    if (_userModel != null){
      // blog('FetchUserProtocols.fetchUser : ($userID) UserModel FOUND in LDB');
    }

    else {

      /// 2.1 read firebase UserOps
      _userModel = await UserFireOps.readUser(
        context: context,
        userID: userID,
      );

      /// 2.2 if found on firebase, store in ldb sessionUsers
      if (_userModel != null) {
        // blog('FetchUserProtocols.fetchUser : ($userID) UserModel FOUND in FIRESTORE and inserted in LDB');
        await UserLDBOps.insertUserModel(_userModel);
      }

    }

    if (_userModel == null){
      // blog('FetchUserProtocols.fetchUser : ($userID) UserModel NOT FOUND');
    }

    return _userModel;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<UserModel>> fetchUsers({
    @required BuildContext context,
    @required List<String> usersIDs,
  }) async {
    blog('FetchUserProtocols.fetchUsers : START');

    final List<UserModel> _userModels = <UserModel>[];

    if (Mapper.checkCanLoopList(usersIDs) == true){

      for (final String userID in usersIDs){

        final UserModel _userModel = await fetchUser(
          context: context,
          userID: userID,
        );

        if (_userModel != null){

          _userModels.add(_userModel);

        }

      }

    }

    blog('FetchUserProtocols.fetchUsers : END');
    return _userModels;
  }
// -----------------------------------------------------------------------------
}
