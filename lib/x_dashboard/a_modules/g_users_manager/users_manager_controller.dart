import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/methods/cloud_functions.dart' as CloudFunctionz;
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/b_widgets/user_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
Future<void> readMoreUsers({
  @required BuildContext context,
  @required ValueNotifier<QueryDocumentSnapshot<Object>> lastSnapshot,
  @required ValueNotifier<List<UserModel>> usersModels,
  @required ScrollController scrollController,
}) async {

  final List<dynamic> _maps = await Fire.readCollectionDocs(
    collName: FireColl.users,
    orderBy: 'id',
    limit: 5,
    startAfter: lastSnapshot?.value,
    addDocSnapshotToEachMap: true,
  );

  /// WHEN FOUND MORE USERS
  if (Mapper.canLoopList(_maps) == true){

    final List<UserModel> _fetchedModel = UserModel.decipherUsersMaps(
      maps: _maps,
      fromJSON: false,
    );


    lastSnapshot?.value = _maps[_maps.length - 1]['docSnapshot'];
    final List<UserModel> _newUsers = <UserModel>[...usersModels.value, ..._fetchedModel];
    usersModels.value = _newUsers;


    await Future<void>.delayed(const Duration(milliseconds: 400),
            () async {
          await Scrollers.scrollToEnd(
            controller: scrollController,
          );
        }
    );

  }

  /// WHEN NO MORE USERS FOUND
  else {

    await TopDialog.showTopDialog(
        context: context,
        title: 'No More Users Found',
    );

  }


}
// -----------------------------------------------------------------------------
Future<void> onDeleteUser({
  @required ValueNotifier<List<UserModel>> usersModels,
  @required String userID,
}) async {

  final String _result = await CloudFunctionz.deleteFirebaseUser(
      userID: userID,
  );

  if (_result == 'stop') {
    blog('operation stopped');
  }

  else if (_result == 'deleted') {

    final int _userIndex = usersModels.value.indexWhere(
            (UserModel user) => user.id == userID);

    if (_userIndex != -1){
      final List<UserModel> _newUsers = <UserModel>[...usersModels.value];
      _newUsers.removeAt(_userIndex);
      usersModels.value = _newUsers;
    }

  }
}
// -----------------------------------------------------------------------------
