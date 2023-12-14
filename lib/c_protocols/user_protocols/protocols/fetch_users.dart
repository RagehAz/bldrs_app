import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';

class FetchUserProtocols {
  // -----------------------------------------------------------------------------

  const FetchUserProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> fetchUser({
    required String? userID
  }) async {

    /// 1 - GET USER FROM LDB
    UserModel? _userModel= await UserLDBOps.readUserOps(
      userID: userID,
    );

    if (_userModel != null){
      // blog('FetchUserProtocols.fetchUser : ($userID) UserModel FOUND in LDB');
    }

    else {

      /// 2.1 read firebase UserOps
      _userModel = await UserFireOps.readUser(
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
    else {
      _userModel = _userModel.copyWith(
        zone: await ZoneProtocols.completeZoneModel(
          invoker: 'fetchUser',
          incompleteZoneModel: _userModel.zone,
        ),
      );
    }

    return _userModel;
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<UserModel>> fetchUsers({
    required List<String> usersIDs,
  }) async {
    blog('FetchUserProtocols.fetchUsers : START');

    final List<UserModel> _userModels = <UserModel>[];

    if (Lister.checkCanLoopList(usersIDs) == true){

      for (final String userID in usersIDs){

        final UserModel? _userModel = await fetchUser(
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

  /// RE-FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> refetch({
    required String? userID
  }) async {
    await UserLDBOps.deleteUserOps(userID);
    final UserModel? _user = await fetchUser(userID: userID);
    return _user;
  }
  // -----------------------------------------------------------------------------
}
