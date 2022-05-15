import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/methods/cloud_functions.dart' as CloudFunctionz;
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
Future<void> onSelectUser({
  @required BuildContext context,
  @required UserModel userModel,
  @required PageController pageController,
  @required ValueNotifier<UserModel> selectedUserModel,
  @required ValueNotifier<ZoneModel> selectedUserZone,
}) async {

  selectedUserModel.value = userModel;

  selectedUserZone.value = await ZoneProvider.proGetCompleteZoneModel(
    context: context,
    incompleteZoneModel: userModel.zone,
  );

  await slideToNext(
      pageController: pageController,
      numberOfSlides: 2,
      currentSlide: 0,
  );

}
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
  @required BuildContext context,
  @required ValueNotifier<List<UserModel>> usersModels,
  @required UserModel userModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete User ?',
    body: '${userModel.name} : id ( ${userModel.id} ) will be deleted for good, are you sure ?',
    confirmButtonText: 'Yes, Delete This Fucker',
    boolDialog: true,
  );

  if (_result == true){

    final String cloudFunctionResponse = await CloudFunctionz.deleteFirebaseUser(
      userID: userModel.id,
    );

    if (cloudFunctionResponse == 'stop') {
      blog('operation stopped');
    }

    else if (cloudFunctionResponse == 'deleted') {

      final int _userIndex = usersModels.value.indexWhere(
              (UserModel user) => user.id == userModel.id);

      if (_userIndex != -1){
        final List<UserModel> _newUsers = <UserModel>[...usersModels.value];
        _newUsers.removeAt(_userIndex);
        usersModels.value = _newUsers;
      }

    }

  }


}
// -----------------------------------------------------------------------------
Future<void> onSelectedUserOptions({
  @required BuildContext context,
  @required UserModel userModel,
  @required ValueNotifier<List<UserModel>> usersModels,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 40,
      numberOfWidgets: 2,
    builder: (_ , PhraseProvider pro){

        return <Widget>[

          BottomDialog.wideButton(
              context: context,
              verse: 'Fuck ${userModel.name}',
          ),


          BottomDialog.wideButton(
            context: context,
            verse: 'Delete this Bitch : ${userModel.name}',
            onTap: () => onDeleteUser(
                context: context,
                usersModels: usersModels,
                userModel: userModel
            ),
          ),


        ];

    }
  );

}
// -----------------------------------------------------------------------------
