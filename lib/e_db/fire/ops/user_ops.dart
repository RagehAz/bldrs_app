import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/methods/storage.dart' as Storage;
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as FireBzOps;
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// -----------------------------------------------------------------------------

/// REFERENCES

// ---------------------------------------------------
/// users firestore collection reference getter
CollectionReference<Object> collRef() {
  final CollectionReference<Object> _usersCollectionRef =
      Fire.getCollectionRef(FireColl.users);
  return _usersCollectionRef;
}

// ---------------------------------------------------
/// user firestore document reference
DocumentReference<Object> docRef(String userID) {
  return Fire.getDocRef(
    collName: FireColl.users,
    docName: userID,
  );
}
// -----------------------------------------------------------------------------

/// CREATE

// ---------------------------------------------------
/// create or update user document
Future<void> _createOrUpdateUserDoc(
    {@required BuildContext context, @required UserModel userModel}) async {
  await Fire.updateDoc(
    context: context,
    collName: FireColl.users,
    docName: userModel.id,
    input: userModel.toMap(toJSON: false),
  );
}

// ---------------------------------------------------
Future<UserModel> createUser({
  @required BuildContext context,
  @required UserModel userModel,
  @required AuthBy authBy,
}) async {
  // ----------
  /// this creates :-
  /// 1 - JPG in : storage/userPics/userID.jpg if userModel.pic is File no URL
  /// 2 - userModel in : firestore/users/userID
  // ----------

  /// check if user pic is file to upload or URL from facebook to keep
  /// TASK : TRANSFORM FACEBOOK PICS TO LOCAL PICS U KNO
  String _userPicURL;
  if (ObjectChecker.objectIsFile(userModel.pic) == true) {
    _userPicURL = await Storage.createStoragePicAndGetURL(
      context: context,
      inputFile: userModel.pic,
      picName: userModel.id,
      docName: StorageDoc.users,
      ownerID: userModel.id,
    );
  }

  /// if from google or facebook url pics
  else if (ObjectChecker.objectIsURL(userModel.pic) == true) {
    /// TASK : this facebook / google image thing is not tested
    if (authBy == AuthBy.facebook || authBy == AuthBy.google) {
      final File _picFile = await Imagers.getFileFromURL(userModel.pic);
      _userPicURL = await Storage.createStoragePicAndGetURL(
        context: context,
        inputFile: _picFile,
        picName: userModel.id,
        docName: StorageDoc.users,
        ownerID: userModel.id,
      );
    }
  }

  /// create final UserModel
  final UserModel _finalUserModel = UserModel(
    id: userModel.id,
    authBy: userModel.authBy,
    createdAt: DateTime.now(),
    status: userModel.status,
    // -------------------------
    name: userModel.name,
    trigram: userModel.trigram,
    pic: _userPicURL ?? userModel.pic,
    title: userModel.title,
    company: userModel.company,
    gender: userModel.gender,
    zone: userModel.zone,
    language: userModel.language,
    position: userModel.position,
    contacts: userModel.contacts,
    // -------------------------
    myBzzIDs: userModel.myBzzIDs,
    isAdmin: userModel.isAdmin,
    emailIsVerified: userModel.emailIsVerified,
    fcmToken: userModel.fcmToken,
    followedBzzIDs: <String>[],
    savedFlyersIDs: <String>[],
  );

  /// create user doc in fireStore
  await _createOrUpdateUserDoc(
    context: context,
    userModel: _finalUserModel,
  );

  return _finalUserModel;
}

// ---------------------------------------------------
Future<Map<String, dynamic>> getOrCreateUserModelFromUser({
  @required BuildContext context,
  @required User user,
  @required ZoneModel zone,
  @required AuthBy authBy,
}) async {
  // ----------
  /// E - read user ops if existed
  ///    Ex - if new user (userModel == null)
  ///       E1 - create initial user model
  ///       E2 - create user ops
  ///       E3 - return new userModel inside userModel-firstTimer map
  ///    Ex - if user has existing user model
  ///       E3 - return existing userMode inside userModel-firstTimer map
  // ----------

  /// E - read user ops if existed
  final UserModel _existingUserModel = await UserFireOps.readUser(
    context: context,
    userID: user.uid,
  );
  // blog('lng : ${Wordz.languageCode(context)}');

  /// Ex - if new user (userModel == null)
  if (_existingUserModel == null) {
    // blog('lng : ${Wordz.languageCode(context)}');

    /// E1 - create initial user model
    final UserModel _initialUserModel =
        await UserModel.createInitialUserModelFromUser(
      context: context,
      user: user,
      zone: zone,
      authBy: authBy,
    );
    blog('googleSignInOps : _initialUserModel : $_initialUserModel');

    /// E2 - create user ops
    final UserModel _finalUserModel = await UserFireOps.createUser(
      context: context,
      userModel: _initialUserModel,
      authBy: authBy,
    );

    blog(
        'googleSignInOps : createUserOps : _finalUserModel : $_finalUserModel');

    /// E3 - return new userModel inside userModel-firstTimer map
    return <String, dynamic>{
      'userModel': _finalUserModel,
      'firstTimer': true,
    };
  }

  /// Ex - if user has existing user model
  else {
    /// E3 - return existing userMode inside userModel-firstTimer map
    return <String, dynamic>{
      'userModel': _existingUserModel,
      'firstTimer': false,
    };
  }
}
// -----------------------------------------------------------------------------

/// READ

// ---------------------------------------------------
Future<UserModel> readUser(
    {@required BuildContext context, @required String userID}) async {
  UserModel _user;

  blog('readUserOps : Start reading user $userID,');

  final Map<String, dynamic> _userMap = await Fire.readDoc(
    context: context,
    collName: FireColl.users,
    docName: userID,
  );

  if (_userMap != null) {
    blog("readUserOps : _userMap _userMap['userID'] is : ${_userMap['id']}");
    // blog('lng : ${Wordz.languageCode(context)}');

    _user = _userMap == null
        ? null
        : UserModel.decipherUserMap(
            map: _userMap,
            fromJSON: false,
          );
  }

  // blog('_userModel is : $_user');
  // blog('lng : ${Wordz.languageCode(context)}');

  return _user;
}

// -----------------------------------------------------------------------------
/// auth change user stream
Stream<UserModel> streamInitialUser() {
  final FirebaseAuth _auth = FirebaseAuth?.instance;

  return _auth
      .authStateChanges()
      .map((User user) => UserModel.initializeUserModelStreamFromUser());

  //     .map(
  //     UserModel.initializeUserModelStreamFromUser); // different syntax than previous snippet
}
// -----------------------------------------------------------------------------

/// UPDATE

// ---------------------------------------------------
Future<void> updateUser(
    {@required BuildContext context,
    @required UserModel oldUserModel,
    @required UserModel updatedUserModel}) async {
  // ----------
  /// UPDATE USER OPS
  /// A - if user pic changed
  ///   A1 - update pic to fireStorage/usersPics/userID and get new URL
  /// B - create final UserModel
  /// C - update firestore/users/userID
  // ----------

  /// A - if user pic changed
  String _userPicURL;
  if (ObjectChecker.objectIsFile(updatedUserModel.pic) == true) {
    /// A1 - update pic to fireStorage/usersPics/userID and get new URL
    _userPicURL = await Storage.updatePic(
      context: context,
      oldURL: oldUserModel.pic,
      newPic: updatedUserModel.pic,
    );
  }

  /// B - create final UserModel
  final UserModel _finalUserModel = UserModel(
    id: updatedUserModel.id,
    authBy: oldUserModel.authBy,
    createdAt: oldUserModel.createdAt,
    status: updatedUserModel.status,
    // -------------------------
    name: updatedUserModel.name,
    trigram: updatedUserModel.trigram,
    pic: _userPicURL ?? oldUserModel.pic,
    title: updatedUserModel.title,
    company: updatedUserModel.company,
    gender: updatedUserModel.gender,
    zone: updatedUserModel.zone,
    language: updatedUserModel.language,
    position: updatedUserModel.position,
    contacts: updatedUserModel.contacts,
    // -------------------------
    myBzzIDs: updatedUserModel.myBzzIDs,
    isAdmin: updatedUserModel.isAdmin,
    emailIsVerified: updatedUserModel.emailIsVerified,
    fcmToken: updatedUserModel.fcmToken,
    savedFlyersIDs: updatedUserModel.savedFlyersIDs,
    followedBzzIDs: updatedUserModel.followedBzzIDs,
  );

  await Fire.updateDoc(
    context: context,
    collName: FireColl.users,
    docName: updatedUserModel.id,
    input: _finalUserModel.toMap(toJSON: false),
  );
}

// -----------------------------------------------------------------------------
/// returns new pic url
Future<String> updateUserPic({
  @required BuildContext context,
  @required String oldURL,
  @required File newPic,
  @required String userID,
}) async {
  final String _newURL =
      await Storage.updatePic(context: context, oldURL: oldURL, newPic: newPic);

  await Fire.updateDocField(
    context: context,
    collName: FireColl.users,
    docName: userID,
    field: 'pic',
    input: _newURL,
  );

  return _newURL;
}

// ---------------------------------------------------
Future<void> addFlyerIDToSavedFlyersIDs(
    {@required BuildContext context,
    @required String flyerID,
    @required List<String> savedFlyersIDs,
    @required String userID}) async {
  final List<String> _savedFlyersIDs = <String>[];

  if (Mapper.canLoopList(savedFlyersIDs)) {
    _savedFlyersIDs.addAll(savedFlyersIDs);
  }

  _savedFlyersIDs.add(flyerID);

  await Fire.updateDocField(
    context: context,
    collName: FireColl.users,
    docName: userID,
    field: 'savedFlyersIDs',
    input: _savedFlyersIDs,
  );
}

// ---------------------------------------------------
Future<void> removeFlyerIDFromSavedFlyersIDs(
    {@required BuildContext context,
    @required String flyerID,
    @required String userID,
    @required List<String> savedFlyersIDs}) async {
  final int _index = savedFlyersIDs.indexWhere((String id) => id == flyerID);

  if (_index >= 0) {
    savedFlyersIDs.remove(flyerID);

    await Fire.updateDocField(
      context: context,
      collName: FireColl.users,
      docName: userID,
      field: 'savedFlyersIDs',
      input: savedFlyersIDs,
    );
  }
}
// -----------------------------------------------------------------------------

/// DELETE

// ---------------------------------------------------
Future<dynamic> deactivateUser({
  @required BuildContext context,
  @required UserModel userModel,
}) async {
  // steps ----------
  /// de activate user account
  /// A - if dialog result is false return 'stop' - is true start ops as follow :-
  /// B - if user is author :-
  ///   C - read And Filter Teamless Bzz By then show its dialog
  ///   D - check if user wants to continue or not
  ///   E - show flyers deactivation dialog
  ///   F - check if user wants to continue or not
  ///   G - deactivate all deactivable bzz
  ///   H - change user status in user doc to deactivated
  ///   J - SIGN OUT
  ///
  /// B - if user is not author :-
  ///   H - change user status in user doc to deactivated
  ///   J - SIGN OUT
  // ----------

  /// A - initial bool dialog alert
  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Watch Out !',
    body:
        'Your data can not be retrieved after deactivating your account\nAre you sure you want to proceed ?',
    boolDialog: true,
  );

  /// A - if user stops
  if (_result == false) {
    // do nothing
    blog('no Do not deactivate ');

    return 'stop';
  }

  /// A - if user continues
  else {
    blog('starting deactivateUserOps()');

    /// B - only if user is author
    if (UserModel.userIsAuthor(userModel) == true) {
      /// WAITING DIALOG
      unawaited(CenterDialog.showCenterDialog(
        context: context,
        title: '',
        boolDialog: null,
        body: 'Waiting',
        child: const Loading(
          loading: true,
        ),
      ));

      /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
      final Map<String, dynamic> _userBzzMap =
          await FireBzOps.readAndFilterTeamlessBzzByUserModel(
        context: context,
        userModel: userModel,
      );
      final List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
      final List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

      /// CLOSE WAITING DIALOG
      Nav.goBack(context);

      /// C - show deactivable bzz dialog
      final bool _bzzReviewResult = await Dialogz.bzzDeactivationDialog(
        context: context,
        bzzToDeactivate: _bzzToDeactivate,
        bzzToKeep: _bzzToKeep,
      );

      /// D - if user wants to stop
      if (_bzzReviewResult == false) {
        // do nothing
        blog('no Do not deactivate ');
        return 'stop';
      }

      /// D - if user wants to continue
      else {
        final List<FlyerModel> _bzFlyers = await FireFlyerOps.readBzzFlyers(
          context: context,
          bzzModels: _bzzToDeactivate,
        );

        /// E - show flyers that will be DEACTIVATED
        final bool _flyersReviewResult = await Dialogz.flyersDeactivationDialog(
          context: context,
          bzzToDeactivate: _bzzToDeactivate,
          flyers: _bzFlyers,
        );

        /// F - if user wants to stop
        if (_flyersReviewResult == false) {
          blog('no Do not deactivate ');
          return 'stop';
        }

        /// F - if user wants to continue
        else {
          /// SHOW WAITING DIALOG
          unawaited(CenterDialog.showCenterDialog(
            context: context,
            title: '',
            boolDialog: null,
            body: 'Waiting',
            child: const Loading(
              loading: true,
            ),
          ));

          /// G - DEACTIVATE all deactivable bzz
          for (final BzModel bz in _bzzToDeactivate) {
            await FireBzOps.deactivateBz(
              context: context,
              bzModel: bz,
            );
          }

          /// H - change user status in user doc to deactivated
          await Fire.updateDocField(
            context: context,
            collName: FireColl.users,
            docName: userModel.id,
            field: 'userStatus',
            input: UserModel.cipherUserStatus(UserStatus.deactivated),
          );

          ///   J - SIGN OUT
          await FireAuthOps.signOut(
              context: context, routeToUserChecker: false);

          /// CLOSE WAITING DIALOG
          Nav.goBack(context);

          await CenterDialog.showCenterDialog(
            context: context,
            title: '',
            body: 'Done',
          );

          return 'deactivated';
        }
      }
    }

    /// B - if user in not Author
    else {
      /// H - change user status in user doc to deactivated
      await Fire.updateDocField(
        context: context,
        collName: FireColl.users,
        docName: userModel.id,
        field: 'userStatus',
        input: UserModel.cipherUserStatus(UserStatus.deactivated),
      );

      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Done',
      );

      /// J - SIGN OUT
      await FireAuthOps.signOut(context: context, routeToUserChecker: false);

      /// CLOSE WAITING DIALOG
      Nav.goBack(context);

      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Done',
      );

      return 'deactivated';
    }
  }
}

// ---------------------------------------------------
Future<dynamic> deleteUser({
  @required BuildContext context,
  @required UserModel userModel,
}) async {
  // ----------
  /// TASK : CLOUD FUNCTION : delete user ops should trigger a cloud function instead of firing these entire functions from client
  /// for now this :-
  /// A - if user stops return 'stop
  /// A - if user continue :-
  /// B - if user is Author :-
  ///   C - read And Filter Teamless Bzz By then show its dialog
  ///   D - return 'stop' or continue ops
  ///   E - show flyers that will be DELETED
  ///   F - return 'stop' or continue ops
  ///   G - DELETE all deactivable bzz : firestore/bzz/bzID
  ///   I - DELETE user image : storage/usersPics/userID
  ///   J - DELETE user doc : firestore/users/userID
  ///   L - DELETE firebase user : auth/userID
  ///   K - SIGN OUT
  ///   M - return 'deleted'
  ///
  /// B - if user is not Author
  ///   I - DELETE user image : storage/usersPics/userID
  ///   J - DELETE user doc : firestore/users/userID
  ///   L - DELETE firebase user : auth/userID
  ///   K - SIGN OUT
  ///   M - return 'deleted'
  // ----------

  /// A - initial bool dialog alert
  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'This will Delete all your data',
    body:
        'all pictures, flyers, businesses, your user records will be deleted for good\nDo you want to proceed ?',
    boolDialog: true,
  );

  /// A - if user stops
  if (_result == false) {
    blog('A - user stops delete user ops ');
    return 'stop';
  }

  /// A - if user continues
  else {
    blog('A - starting superDeleteUserOps()');

    /// B - if user is author
    if (UserModel.userIsAuthor(userModel) == true) {
      /// WAITING DIALOG
      unawaited(CenterDialog.showCenterDialog(
        context: context,
        title: '',
        boolDialog: null,
        body: 'Waiting',
        child: const Loading(
          loading: true,
        ),
      ));

      /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
      final Map<String, dynamic> _userBzzMap =
          await FireBzOps.readAndFilterTeamlessBzzByUserModel(
        context: context,
        userModel: userModel,
      );
      final List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
      final List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

      /// CLOSE WAITING DIALOG
      Nav.goBack(context);

      /// C - show deactivable bzz dialog
      final bool _bzzReviewResult = await Dialogz.bzzDeactivationDialog(
        context: context,
        bzzToDeactivate: _bzzToDeactivate,
        bzzToKeep: _bzzToKeep,
      );

      /// D - if user wants to stop
      if (_bzzReviewResult == false) {
        // do nothing
        blog('D - user stops delete user ops ');
        return 'stop';
      }

      /// D - if user wants to continue
      else {
        final List<FlyerModel> _bzzFlyers = await FireFlyerOps.readBzzFlyers(
          context: context,
          bzzModels: _bzzToDeactivate,
        );

        /// E - show flyers that will be DELETED
        final bool _flyersReviewResult = await Dialogz.flyersDeactivationDialog(
          context: context,
          bzzToDeactivate: _bzzToDeactivate,
          flyers: _bzzFlyers,
        );

        /// F - if user wants to stop
        if (_flyersReviewResult == false) {
          blog('F - user stops delete user ops ');
          return 'stop';
        }

        /// F - if user wants to continue
        else {
          /// SHOW WAITING DIALOG
          unawaited(CenterDialog.showCenterDialog(
            context: context,
            title: '',
            boolDialog: null,
            body: 'Waiting',
            child: const Loading(
              loading: true,
            ),
          ));

          /// G - DELETE all deactivable bzz : firestore/bzz/bzID
          for (final BzModel bz in _bzzToDeactivate) {
            await FireBzOps.deleteBz(
              context: context,
              bzModel: bz,
            );

            blog(
                'G - DELETED : from ${userModel.id} : bz :  ${bz.id} successfully');
          }

          /// I - DELETE user image : storage/usersPics/userID
          blog('I - deleting user pic');
          await Storage.deleteStoragePic(
            context: context,
            docName: StorageDoc.users,
            picName: userModel.id,
          );

          /// J - DELETE user doc : firestore/users/userID
          blog('J - deleting user doc');
          await Fire.deleteDoc(
            context: context,
            collName: FireColl.users,
            docName: userModel.id,
          );

          /// L - DELETE firebase user : auth/userID
          blog('L - deleting firebase user');

          /// TASK : NEED TO MANAGE IF THIS FAILS
          await FireAuthOps.deleteFirebaseUser(
              context: context, userID: userModel.id);

          /// K - SIGN OUT
          blog('K - user is signing out');
          await FireAuthOps.signOut(
              context: context, routeToUserChecker: false);

          /// CLOSE WAITING DIALOG
          Nav.goBack(context);

          /// M - return 'deleted'
          return 'deleted';
        }
      }
    }

    /// B - if user is not author
    else {
      /// SHOW WAITING DIALOG
      unawaited(CenterDialog.showCenterDialog(
        context: context,
        title: '',
        boolDialog: null,
        body: 'Waiting',
        child: const Loading(
          loading: true,
        ),
      ));

      /// I - DELETE user image : storage/usersPics/userID
      blog('I - deleting user pic');
      await Storage.deleteStoragePic(
        context: context,
        docName: StorageDoc.users,
        picName: userModel.id,
      );

      /// J - DELETE user doc : firestore/users/userID
      blog('J - deleting user doc');
      await Fire.deleteDoc(
        context: context,
        collName: FireColl.users,
        docName: userModel.id,
      );

      /// L - DELETE firebase user : auth/userID
      blog('L - deleting firebase user');

      /// TASK : NEED TO MANAGE IF THIS FAILS
      await FireAuthOps.deleteFirebaseUser(
          context: context, userID: userModel.id);

      /// K - SIGN OUT
      blog('K - user is signing out');
      await FireAuthOps.signOut(context: context, routeToUserChecker: false);

      /// CLOSE WAITING DIALOG
      Nav.goBack(context);

      /// M - return 'deleted'
      return 'deleted';
    }
  }
}
// -----------------------------------------------------------------------------
