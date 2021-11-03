import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/db/fire/auth_ops.dart';
import 'package:bldrs/db/fire/bz_ops.dart';
import 'package:bldrs/db/fire/firestore.dart';
import 'package:bldrs/db/fire/flyer_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// Should include all user firestore operations
/// except reading data for widgets injection
abstract class UserOps{
// -----------------------------------------------------------------------------
  /// users firestore collection reference getter
  static CollectionReference userCollectionRef(){
    final CollectionReference _usersCollectionRef = Fire.getCollectionRef(FireColl.users);
    return
      _usersCollectionRef;
  }
// -----------------------------------------------------------------------------
  /// user firestore document reference
  DocumentReference userDocRef(String userID){
    return
      Fire.getDocRef(
          collName: FireColl.users,
          docName: userID,
      );
  }
// -----------------------------------------------------------------------------
  /// create or update user document
  static Future<void> _createOrUpdateUserDoc({@required BuildContext context, @required UserModel userModel}) async {

    await Fire.updateDoc(
      context: context,
      collName: FireColl.users,
      docName: userModel.id,
      input: userModel.toMap(toJSON: false),
    );

  }
// -----------------------------------------------------------------------------
  /// this creates :-
  /// 1 - JPG in : storage/userPics/userID.jpg if userModel.pic is File no URL
  /// 2 - userModel in : firestore/users/userID
  static Future<UserModel> createUserOps({
    @required BuildContext context,
    @required UserModel userModel,
    @required AuthBy authBy,
  }) async {

    /// check if user pic is file to upload or URL from facebook to keep
    /// TASK : TRANSFORM FACEBOOK PICS TO LOCAL PICS U KNO
    String _userPicURL;
    if (ObjectChecker.objectIsFile(userModel.pic) == true){
      _userPicURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: userModel.pic,
          fileName: userModel.id,
          picType: PicType.userPic,
      );
    }

    /// if from google or facebook url pics
    else if (ObjectChecker.objectIsURL(userModel.pic) == true){

      if (authBy == AuthBy.facebook || authBy == AuthBy.google ){
        File _picFile = await Imagers.urlToFile(userModel.pic);
        _userPicURL = await Fire.createStoragePicAndGetURL(
            context: context,
            inputFile: _picFile,
            fileName: userModel.id,
            picType: PicType.userPic,
        );
      }

    }

    /// create final UserModel
    final UserModel _finalUserModel = UserModel(
      id : userModel.id,
      authBy: userModel.authBy,
      createdAt : DateTime.now(),
      status : userModel.status,
      // -------------------------
      name : userModel.name,
      trigram: userModel.trigram,
      pic : _userPicURL ?? userModel.pic,
      title : userModel.title,
      company : userModel.company,
      gender : userModel.gender,
      zone : userModel.zone,
      language : userModel.language,
      position : userModel.position,
      contacts : userModel.contacts,
      // -------------------------
      myBzzIDs : userModel.myBzzIDs,
      isAdmin: userModel.isAdmin,
      emailIsVerified: userModel.emailIsVerified,
      fcmToken: userModel.fcmToken,
      followedBzzIDs: [],
      savedFlyersIDs: [],
    );

    /// create user doc in fireStore
    await _createOrUpdateUserDoc(
      context: context,
      userModel: _finalUserModel,
    );


    return _finalUserModel;

  }
// -----------------------------------------------------------------------------
  static Future<UserModel> readUserOps({@required BuildContext context, @required String userID}) async {

    UserModel _user;

    print('readUserOps : Start reading user $userID,');

    final Map<String, dynamic> _userMap = await Fire.readDoc(
      context: context,
      collName: FireColl.users,
      docName: userID,
    );

    if (_userMap != null){

      print('readUserOps : _userMap _userMap[\'userID\'] is : ${_userMap['id']}');
      // print('lng : ${Wordz.languageCode(context)}');

      _user = _userMap == null ? null : UserModel.decipherUserMap(
        map: _userMap,
        fromJSON: false,
      );

    }

    // print('_userModel is : $_user');
    // print('lng : ${Wordz.languageCode(context)}');

    return _user;
  }
// -----------------------------------------------------------------------------
  /// auth change user stream
  static Stream<UserModel> streamInitialUser(){
    final FirebaseAuth _auth = FirebaseAuth?.instance;

    return _auth.authStateChanges()
        .map((User user) => UserModel.initializeUserModelStreamFromUser());

    //     .map(
    //     UserModel.initializeUserModelStreamFromUser); // different syntax than previous snippet
  }
// -----------------------------------------------------------------------------
  /// UPDATE USER OPS
  /// A - if user pic changed
  ///   A1 - save pic to fireStorage/usersPics/userID and get URL
  /// B - create final UserModel
  /// C - update firestore/users/userID
  static Future<void> updateUserOps({@required BuildContext context, @required UserModel oldUserModel, @required UserModel updatedUserModel}) async {

    /// A - if user pic changed
    String _userPicURL;
    if (ObjectChecker.objectIsFile(updatedUserModel.pic) == true){

      /// A1 - save pic to fireStorage/usersPics/userID and get URL
      _userPicURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: updatedUserModel.pic,
          fileName: updatedUserModel.id,
          picType: PicType.userPic
      );
    }

    /// B - create final UserModel
    final UserModel _finalUserModel = UserModel(
      id : updatedUserModel.id,
      authBy: oldUserModel.authBy,
      createdAt : oldUserModel.createdAt,
      status : updatedUserModel.status,
      // -------------------------
      name : updatedUserModel.name,
      trigram: updatedUserModel.trigram,
      pic : _userPicURL ?? oldUserModel.pic,
      title : updatedUserModel.title,
      company : updatedUserModel.company,
      gender : updatedUserModel.gender,
      zone : updatedUserModel.zone,
      language : updatedUserModel.language,
      position : updatedUserModel.position,
      contacts : updatedUserModel.contacts,
      // -------------------------
      myBzzIDs : updatedUserModel.myBzzIDs,
      isAdmin: updatedUserModel.isAdmin,
      emailIsVerified: updatedUserModel.emailIsVerified,
      fcmToken: updatedUserModel.fcmToken,
      savedFlyersIDs: updatedUserModel.savedFlyersIDs,
      followedBzzIDs: updatedUserModel.followedBzzIDs,
    );

    /// C - update firestore/users/userID
    await _createOrUpdateUserDoc(
      context: context,
      userModel: _finalUserModel,
    );


  }
// -----------------------------------------------------------------------------
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
  static Future<dynamic> deactivateUserOps({@required BuildContext context, @required UserModel userModel}) async {

    /// A - initial bool dialog alert
    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Watch Out !',
      body: 'Your data can not be retrieved after deactivating your account\nAre you sure you want to proceed ?',
      boolDialog: true,
    );

    /// A - if user stops
    if (_result == false){

      // do nothing
      print('no Do not deactivate ');

      return 'stop';
    }

    /// A - if user continues
    else {

      print('starting deactivateUserOps()');

      /// B - only if user is author
      if (UserModel.userIsAuthor(userModel) == true){

        /// WAITING DIALOG
        CenterDialog.showCenterDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: const Loading(loading: true,),
        );

        /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
        final Map<String, dynamic> _userBzzMap = await BzOps.readAndFilterTeamlessBzzByUserModel(
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
          print('no Do not deactivate ');
          return 'stop';

        }

        /// D - if user wants to continue
        else  {

          List<FlyerModel> _bzFlyers = await FlyerOps.readBzzFlyers(
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
          if (_flyersReviewResult == false){

            print('no Do not deactivate ');
            return 'stop';

          }

          /// F - if user wants to continue
          else {

            /// SHOW WAITING DIALOG
            CenterDialog.showCenterDialog(
              context: context,
              title: '',
              boolDialog: null,
              height: null,
              body: 'Waiting',
              child: const Loading(loading: true,),
            );

            /// G - DEACTIVATE all deactivable bzz
            for (var bz in _bzzToDeactivate){
              await BzOps().deactivateBzOps(
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
            await AuthOps().signOut(context: context, routeToUserChecker: false);

            /// CLOSE WAITING DIALOG
            Nav.goBack(context);

            await CenterDialog.showCenterDialog(context: context, title: '', boolDialog: false, height: null, body: 'Done',);

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


        CenterDialog.showCenterDialog(context: context, title: '', boolDialog: false, height: null, body: 'Done',);

        /// J - SIGN OUT
        await AuthOps().signOut(context: context, routeToUserChecker: false);

        /// CLOSE WAITING DIALOG
        Nav.goBack(context);

        await CenterDialog.showCenterDialog(context: context, title: '', boolDialog: false, height: null, body: 'Done',);

        return 'deactivated';

      }

    }

  }
// -----------------------------------------------------------------------------
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
  static Future<dynamic> superDeleteUserOps({@required BuildContext context, @required UserModel userModel}) async {

    /// A - initial bool dialog alert
    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'This will Delete all your data',
      body: 'all pictures, flyers, businesses, your user records will be deleted for good\nDo you want to proceed ?',
      boolDialog: true,
    );

    /// A - if user stops
    if (_result == false){

      print('A - user stops delete user ops ');
      return 'stop';

    }

    /// A - if user continues
    else {

      print('A - starting superDeleteUserOps()');

      /// B - if user is author
      if (UserModel.userIsAuthor(userModel) == true){

        /// WAITING DIALOG
        CenterDialog.showCenterDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: const Loading(loading: true,),
        );

        /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
        final Map<String, dynamic> _userBzzMap = await BzOps.readAndFilterTeamlessBzzByUserModel(
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
          print('D - user stops delete user ops ');
          return 'stop';
        }

        /// D - if user wants to continue
        else {

          final List<FlyerModel> _bzzFlyers = await FlyerOps.readBzzFlyers(
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
          if (_flyersReviewResult == false){

            print('F - user stops delete user ops ');
            return 'stop';

          }

          /// F - if user wants to continue
          else {

            /// SHOW WAITING DIALOG
            CenterDialog.showCenterDialog(
              context: context,
              title: '',
              boolDialog: null,
              height: null,
              body: 'Waiting',
              child: const Loading(loading: true,),
            );

            /// G - DELETE all deactivable bzz : firestore/bzz/bzID
            for (var bz in _bzzToDeactivate){
              await BzOps().superDeleteBzOps(
                context: context,
                bzModel: bz,
              );

              print('G - DELETED : from ${userModel.id} : bz :  ${bz.id} successfully');
            }

            /// I - DELETE user image : storage/usersPics/userID
            print('I - deleting user pic');
            await Fire.deleteStoragePic(
              context: context,
              picType: PicType.userPic,
              fileName: userModel.id,
            );

            /// J - DELETE user doc : firestore/users/userID
            print('J - deleting user doc');
            await Fire.deleteDoc(
              context: context,
              collName: FireColl.users,
              docName: userModel.id,
            );

            /// L - DELETE firebase user : auth/userID
            print('L - deleting firebase user');
            /// TASK : NEED TO MANAGE IF THIS FAILS
            await AuthOps().deleteFirebaseUser(context, userModel.id);

            /// K - SIGN OUT
            print('K - user is signing out');
            await AuthOps().signOut(context: context, routeToUserChecker: false);

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
        CenterDialog.showCenterDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: const Loading(loading: true,),
        );


        /// I - DELETE user image : storage/usersPics/userID
        print('I - deleting user pic');
        await Fire.deleteStoragePic(
          context: context,
          picType: PicType.userPic,
          fileName: userModel.id,
        );

        /// J - DELETE user doc : firestore/users/userID
        print('J - deleting user doc');
        await Fire.deleteDoc(
          context: context,
          collName: FireColl.users,
          docName: userModel.id,
        );

        /// L - DELETE firebase user : auth/userID
        print('L - deleting firebase user');
        /// TASK : NEED TO MANAGE IF THIS FAILS
        await AuthOps().deleteFirebaseUser(context, userModel.id);

        /// K - SIGN OUT
        print('K - user is signing out');
        await AuthOps().signOut(context: context, routeToUserChecker: false);


        /// CLOSE WAITING DIALOG
        Nav.goBack(context);

        /// M - return 'deleted'
        return 'deleted';

      }

    }

  }
// -----------------------------------------------------------------------------
  /// E - read user ops if existed
  ///    Ex - if new user (userModel == null)
  ///       E1 - create initial user model
  ///       E2 - create user ops
  ///       E3 - return new userModel inside userModel-firstTimer map
  ///    Ex - if user has existing user model
  ///       E3 - return existing userMode inside userModel-firstTimer map
  static Future<Map<String, dynamic>> getOrCreateUserModelFromUser({
    @required BuildContext context,
    @required User user,
    @required ZoneModel zone,
    @required AuthBy authBy,
  }) async {

    /// E - read user ops if existed
    final UserModel _existingUserModel = await UserOps.readUserOps(
      context: context,
      userID: user.uid,
    );
    // print('lng : ${Wordz.languageCode(context)}');

    /// Ex - if new user (userModel == null)
    if (_existingUserModel == null) {

      // print('lng : ${Wordz.languageCode(context)}');

      /// E1 - create initial user model
      final UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
        context: context,
        user: user,
        zone: zone,
        authBy: authBy,
      );
      print('googleSignInOps : _initialUserModel : $_initialUserModel');

      /// E2 - create user ops
      final UserModel _finalUserModel = await UserOps.createUserOps(
        context: context,
        userModel: _initialUserModel,
        authBy: authBy,
      );

      print('googleSignInOps : createUserOps : _finalUserModel : $_finalUserModel');

      /// E3 - return new userModel inside userModel-firstTimer map
      return

        {
          'userModel' : _finalUserModel,
          'firstTimer' : true,
        };

    }

    /// Ex - if user has existing user model
    else {

      /// E3 - return existing userMode inside userModel-firstTimer map
      return
        {
          'userModel' : _existingUserModel,
          'firstTimer' : false,
        };
    }

  }
// -----------------------------------------------------------------------------
  static Future<void> addFlyerIDToSavedFlyersIDs({@required BuildContext context, @required String flyerID, @required List<String> savedFlyersIDs, @required String userID}) async {

    final List<String> _savedFlyersIDs = [];

    if (Mapper.canLoopList(savedFlyersIDs)){
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
// -----------------------------------------------------------------------------
  static Future<void> removeFlyerIDFromSavedFlyersIDs({@required BuildContext context, @required String flyerID, @required String userID, @required List<String> savedFlyersIDs}) async {


    final int _index = savedFlyersIDs.indexWhere((id) => id == flyerID);

    if (_index >= 0){

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
}
