import 'dart:async';

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/x_logo_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/foundation/storage.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
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
    context: context,
    collName: FireColl.users,
    orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
    limit: 10,
    startAfter: lastSnapshot?.value,
    addDocSnapshotToEachMap: true,
  );

  /// WHEN FOUND MORE USERS
  if (Mapper.checkCanLoopList(_maps) == true){

    final List<UserModel> _fetchedModel = UserModel.decipherUsers(
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
      firstVerse: Verse.plain('No More Users Found'),
    );

  }


}
// -----------------------------------------------------------------------------
Future<void> onSelectUser({
  @required BuildContext context,
  @required UserModel userModel,
  @required PageController pageController,
  @required ValueNotifier<UserModel> selectedUserModel,
}) async {

  userModel.blogUserModel(methodName: 'Dashboard onSelectUser');

  selectedUserModel.value = await completeUserZoneModel(
    context: context,
    userModel: userModel,
  );

  await Sliders.slideToNext(
    pageController: pageController,
    numberOfSlides: 2,
    currentSlide: 0,
  );

}
// -----------------------------------------------------------------------------

/// USER OPTIONS

// --------------------
Future<void> onSelectedUserOptions({
  @required BuildContext context,
  @required UserModel userModel,
  @required ValueNotifier<List<UserModel>> usersModels,
  @required PageController pageController,
  @required ValueNotifier<UserModel> selectedUserModel,
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
            verse: Verse.plain('Fuck ${userModel.name}'),
          ),


          BottomDialog.wideButton(
            context: context,
            verse: Verse.plain('Delete this Bitch : ${userModel.name}'),
            onTap: () => onDeleteUser(
              context: context,
              usersModels: usersModels,
              userModel: userModel,
              pageController: pageController,
              selectedUserModel: selectedUserModel,
            ),
          ),


        ];

      }
  );

}
// --------------------
Future<void> onDeleteUser({
  @required BuildContext context,
  @required ValueNotifier<List<UserModel>> usersModels,
  @required UserModel userModel,
  @required PageController pageController,
  @required ValueNotifier<UserModel> selectedUserModel,
}) async {

  if (Mapper.checkCanLoopList(userModel.myBzzIDs) == true){
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('User is Author !'),
      bodyVerse: Verse.plain('For now, we can not delete this User from here'),
      confirmButtonVerse: Verse.plain('Mashi'),
    );
  }

  else {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('Delete User ?'),
      bodyVerse: Verse.plain('${userModel.name} : id ( ${userModel.id} ) will be deleted for good, are you sure ?'),
      confirmButtonVerse: Verse.plain('Delete Fucker'),
      boolDialog: true,
    );

    if (_result == true){

      const bool _credentialsAreGood = true;
      // await _doYouKnowThePassword(
      //     context: context,
      //     userModel: userModel
      // );

      blog('_credentialsAreGood : $_credentialsAreGood ');

      if (_credentialsAreGood == true){

        /// CLOSE BOTTOM DIALOG
        await Nav.goBack(
          context: context,
          invoker: 'onDeleteUser',
        );

        /// START WAITING
        unawaited(WaitDialog.showWaitDialog(
          context: context,
          loadingVerse: Verse.plain('Deleting ${userModel.name} : ${userModel.id}'),
        ));

        /// DELETE firebase user : auth/userID
        final bool _firebaseSuccess = await AuthFireOps.deleteFirebaseUser(
          context: context,
          userID: userModel.id,
        );
        blog('onDeleteUser : deleted firebase user : operation success is : $_firebaseSuccess');

        /// WHEN COULD DELETE FIREBASE USER
        if (_firebaseSuccess == true){

          /// DELETE user image : storage/usersPics/userID
          await Storage.deleteStoragePic(
            context: context,
            storageDocName: StorageDoc.users,
            fileName: userModel.id,
          );
          blog('onDeleteUser : deleted user pic : [storage/usersPics/${userModel.id}]');

          /// DELETE user doc : firestore/users/userID
          await Fire.deleteDoc(
            context: context,
            collName: FireColl.users,
            docName: userModel.id,
          );
          blog('onDeleteUser : deleted user doc : [firestore/users/${userModel.id}]');


          /// DELETE USER FROM USERS MODELS NOTIFIER
          final int _userIndex = usersModels.value.indexWhere((UserModel user) => user.id == userModel.id);
          if (_userIndex != -1){
            final List<UserModel> _newUsers = <UserModel>[...usersModels.value];
            _newUsers.removeAt(_userIndex);
            usersModels.value = _newUsers;
          }

          /// CLOSE WAITING
          await WaitDialog.closeWaitDialog(context);

          await Sliders.slideToBackFrom(
            pageController: pageController,
            currentSlide: 1,
          );

          selectedUserModel.value = null;

        }

        /// WHEN DELETING FIREBASE USER FAILED\
        else {

          await CenterDialog.showCenterDialog(
            context: context,
            titleVerse: Verse.plain('Failed'),
            bodyVerse: Verse.plain('Could not Delete this User'),
          );

          /// CLOSE WAITING
          await WaitDialog.closeWaitDialog(context);

        }

      }

    }

  }

}
// --------------------
/*
Future<bool> _doYouKnowThePassword({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  bool _passwordIsGood = false;
  String _password;

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'Do you know the password ?',
    onOk: () async {

      _passwordIsGood = await _couldGetCredentials(
        context: context,
        password: _password,
        userModel: userModel,
      );

    },
    child: SuperTextField(
      width: CenterDialog.getWidth(context),
      keyboardTextInputType: TextInputType.visiblePassword,
      keyboardTextInputAction: TextInputAction.go,
      onChanged: (String text){
        _password = text;
      },
      onSubmitted: (String text) async {

        _passwordIsGood = await _couldGetCredentials(
            context: context,
            password: _password,
            userModel: userModel,
        );

      },
    ),
  );

  return _passwordIsGood;
}
 */
// --------------------
/*
Future<bool> _couldGetCredentials({
  @required BuildContext context,
  @required String password,
  @required UserModel userModel,
}) async {

  final bool _credentialsAreGood = await tryCatchAndReturnBool(
      context: context,
      functions: () async {

        final UserCredential _credential = await FirebaseAuth
            .instance
            .signInWithEmailAndPassword(
          password: password,
          email: ContactModel.getAContactValueFromContacts(
              contacts: userModel.contacts,
              contactType: ContactType.email,
          ),
        );

        blog('_credential token : ${_credential.credential.token}');

      }
  );

  /// IF COULD SIGN IN
  if (_credentialsAreGood == true){
    /// CLOSE CENTER DIALOG
    Nav.goBack(context);
  }
  /// WHEN SIGN IN FAILED
  else {
    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Wrong Password',
      secondLine: 'Can not delete this user',
    );
  }

  return _credentialsAreGood;
}
 */
// -----------------------------------------------------------------------------
