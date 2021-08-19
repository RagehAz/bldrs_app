import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// Should include all user firestore operations
/// except reading data for widgets injection
class UserOps{
// =============================================================================
  /// user firestore collection reference
  final CollectionReference _usersCollectionRef = Fire.getCollectionRef(FireCollection.users);
// -----------------------------------------------------------------------------
  /// users firestore collection reference getter
  CollectionReference userCollectionRef(){
    return
      _usersCollectionRef;
  }
// -----------------------------------------------------------------------------
  /// user firestore document reference
  DocumentReference userDocRef(String userID){
    return
      Fire.getDocRef(
          collName: FireCollection.users,
          docName: userID,
      );
  }
// -----------------------------------------------------------------------------
  /// create or update user document
  Future<void> _createOrUpdateUserDoc({BuildContext context, UserModel userModel}) async {

    await Fire.updateDoc(
      context: context,
      collName: FireCollection.users,
      docName: userModel.userID,
      input: userModel.toMap(),
    );

  }
// -----------------------------------------------------------------------------
  /// this creates :-
  /// 1 - JPG in : storage/userPics/userID.jpg if userModel.pic is File no URL
  /// 2 - userModel in : firestore/users/userID
  /// 3 - tinyUser in : firestore/tinyUsers/userID
  Future<UserModel> createUserOps({BuildContext context, UserModel userModel}) async {

    /// check if user pic is file to upload or URL from facebook to keep
    String _userPicURL;
    if (ObjectChecker.objectIsFile(userModel.pic) == true){
      _userPicURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: userModel.pic,
          fileName: userModel.userID,
          picType: PicType.userPic
      );
    }

    /// create final UserModel
    UserModel _finalUserModel = UserModel(
      userID : userModel.userID,
      authBy: userModel.authBy,
      joinedAt : DateTime.now(),
      userStatus : userModel.userStatus,
      // -------------------------
      name : userModel.name,
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
    );

    /// create user doc in fireStore
    await _createOrUpdateUserDoc(
      context: context,
      userModel: _finalUserModel,
    );

    /// create TinyUser in firestore
    await Fire.createNamedDoc(
      context: context,
      collName: FireCollection.tinyUsers,
      docName: userModel.userID,
      input: TinyUser.getTinyUserFromUserModel(_finalUserModel).toMap(),
    );

    return _finalUserModel;

  }
// -----------------------------------------------------------------------------
  Future<UserModel> readUserOps({BuildContext context, String userID}) async {

    print('readUserOps : Start reading user $userID while lang is : ${Wordz.languageCode(context)},');

    Map<String, dynamic> _userMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.users,
      docName: userID,
    );

    print('readUserOps : _userMap _userMap[\'userID\'] is : ${_userMap['userID']}');
    // print('lng : ${Wordz.languageCode(context)}');

    UserModel _user = _userMap == null ? null : UserModel.decipherUserMap(_userMap);

    // print('_userModel is : $_user');
    // print('lng : ${Wordz.languageCode(context)}');

    return _user;
  }
// -----------------------------------------------------------------------------
  /// auth change user stream
  Stream<UserModel> streamInitialUser(){
    final FirebaseAuth _auth = FirebaseAuth?.instance;

    return _auth.authStateChanges()
        .map((User user) => UserModel.initializeUserModelStreamFromUser(user,));

    //     .map(
    //     UserModel.initializeUserModelStreamFromUser); // different syntax than previous snippet
  }
// -----------------------------------------------------------------------------
  /// UPDATE USER OPS
  /// A - if user pic changed
  ///   A1 - save pic to fireStorage/usersPics/userID and get URL
  /// B - create final UserModel
  /// C - update firestore/users/userID
  /// D - if tinyUser is changed
  ///   D1 - update fireStore/tinyUsers/userID
  Future<void> updateUserOps({BuildContext context, UserModel oldUserModel, UserModel updatedUserModel}) async {

    /// A - if user pic changed
    String _userPicURL;
    if (ObjectChecker.objectIsFile(updatedUserModel.pic) == true){

      /// A1 - save pic to fireStorage/usersPics/userID and get URL
      _userPicURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: updatedUserModel.pic,
          fileName: updatedUserModel.userID,
          picType: PicType.userPic
      );
    }

    /// B - create final UserModel
    UserModel _finalUserModel = UserModel(
      userID : updatedUserModel.userID,
      authBy: oldUserModel.authBy,
      joinedAt : oldUserModel.joinedAt,
      userStatus : updatedUserModel.userStatus,
      // -------------------------
      name : updatedUserModel.name,
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
    );

    /// C - update firestore/users/userID
    await _createOrUpdateUserDoc(
      context: context,
      userModel: _finalUserModel,
    );


    /// D - if tinyUser is changed
    if (

    TinyUser.tinyUsersAreTheSame(
        finalUserModel: _finalUserModel,
        originalUserModel: oldUserModel
    ) == false

    ){

      /// D1 - update fireStore/tinyUsers/userID
      await Fire.updateDoc(
        context: context,
        collName: FireCollection.tinyUsers,
        docName: updatedUserModel.userID,
        input: TinyUser.getTinyUserFromUserModel(_finalUserModel).toMap(),
      );
    }

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
  ///   I - change user status in TinyUser doc to deactivated
  ///   J - SIGN OUT
  ///
  /// B - if user is not author :-
  ///   H - change user status in user doc to deactivated
  ///   I - change user status in TinyUser doc to deactivated
  ///   J - SIGN OUT
  Future<dynamic> deactivateUserOps({BuildContext context, UserModel userModel}) async {

    /// A - initial bool dialog alert
    bool _result = await superDialog(
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
        superDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: Loading(loading: true,),
        );

        /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
        Map<String, dynamic> _userBzzMap = await BzOps.readAndFilterTeamlessBzzByUserModel(
          context: context,
          userModel: userModel,
        );
        List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
        List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

        /// CLOSE WAITING DIALOG
        Nav.goBack(context);

        /// C - show deactivable bzz dialog
        bool _bzzReviewResult = await bzzDeactivationDialog(
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

          /// E - show flyers that will be DEACTIVATED
          bool _flyersReviewResult = await flyersDeactivationDialog(
            context: context,
            bzzToDeactivate: _bzzToDeactivate,
          );

          /// F - if user wants to stop
          if (_flyersReviewResult == false){

            print('no Do not deactivate ');
            return 'stop';

          }

          /// F - if user wants to continue
          else {

            /// SHOW WAITING DIALOG
            superDialog(
              context: context,
              title: '',
              boolDialog: null,
              height: null,
              body: 'Waiting',
              child: Loading(loading: true,),
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
              collName: FireCollection.users,
              docName: userModel.userID,
              field: 'userStatus',
              input: UserModel.cipherUserStatus(UserStatus.Deactivated),
            );

            /// I - change user status in TinyUser doc to deactivated
            await Fire.updateDocField(
              context: context,
              collName: FireCollection.tinyUsers,
              docName: userModel.userID,
              field: 'userStatus',
              input: UserModel.cipherUserStatus(UserStatus.Deactivated),
            );

            ///   J - SIGN OUT
            await AuthOps().signOut(context: context, routeToUserChecker: false);

            /// CLOSE WAITING DIALOG
            Nav.goBack(context);

            await superDialog(context: context, title: '', boolDialog: false, height: null, body: 'Done',);

            return 'deactivated';

          }

        }


      }

      /// B - if user in not Author
      else {

        /// H - change user status in user doc to deactivated
        await Fire.updateDocField(
          context: context,
          collName: FireCollection.users,
          docName: userModel.userID,
          field: 'userStatus',
          input: UserModel.cipherUserStatus(UserStatus.Deactivated),
        );

        /// I - change user status in TinyUser doc to deactivated
        await Fire.updateDocField(
          context: context,
          collName: FireCollection.tinyUsers,
          docName: userModel.userID,
          field: 'userStatus',
          input: UserModel.cipherUserStatus(UserStatus.Deactivated),
        );

        superDialog(context: context, title: '', boolDialog: false, height: null, body: 'Done',);

        /// J - SIGN OUT
        await AuthOps().signOut(context: context, routeToUserChecker: false);

        /// CLOSE WAITING DIALOG
        Nav.goBack(context);

        await superDialog(context: context, title: '', boolDialog: false, height: null, body: 'Done',);

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
  ///   H - DELETE tiny user : firestore/tinyUsers/userID
  ///   I - DELETE user image : storage/usersPics/userID
  ///   J - DELETE user doc : firestore/users/userID
  ///   L - DELETE firebase user : auth/userID
  ///   K - SIGN OUT
  ///   M - return 'deleted'
  ///
  /// B - if user is not Author
  ///   H - DELETE tiny user : firestore/tinyUsers/userID
  ///   I - DELETE user image : storage/usersPics/userID
  ///   J - DELETE user doc : firestore/users/userID
  ///   L - DELETE firebase user : auth/userID
  ///   K - SIGN OUT
  ///   M - return 'deleted'
  Future<dynamic> superDeleteUserOps({BuildContext context, UserModel userModel}) async {

    /// A - initial bool dialog alert
    bool _result = await superDialog(
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
        superDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: Loading(loading: true,),
        );

        /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
        Map<String, dynamic> _userBzzMap = await BzOps.readAndFilterTeamlessBzzByUserModel(
          context: context,
          userModel: userModel,
        );
        List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
        List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

        /// CLOSE WAITING DIALOG
        Nav.goBack(context);

        /// C - show deactivable bzz dialog
        bool _bzzReviewResult = await bzzDeactivationDialog(
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

          /// E - show flyers that will be DELETED
          bool _flyersReviewResult = await flyersDeactivationDialog(
            context: context,
            bzzToDeactivate: _bzzToDeactivate,
          );

          /// F - if user wants to stop
          if (_flyersReviewResult == false){

            print('F - user stops delete user ops ');
            return 'stop';

          }

          /// F - if user wants to continue
          else {

            /// SHOW WAITING DIALOG
            superDialog(
              context: context,
              title: '',
              boolDialog: null,
              height: null,
              body: 'Waiting',
              child: Loading(loading: true,),
            );

            /// G - DELETE all deactivable bzz : firestore/bzz/bzID
            for (var bz in _bzzToDeactivate){
              await BzOps().superDeleteBzOps(
                context: context,
                bzModel: bz,
              );

              print('G - DELETED : from ${userModel.userID} : bz :  ${bz.bzID} successfully');
            }

            /// H - DELETE tiny user : firestore/tinyUsers/userID
            print('H - deleting tinyUser');
            await Fire.deleteDoc(
              context: context,
              collName: FireCollection.tinyUsers,
              docName: userModel.userID,
            );

            /// I - DELETE user image : storage/usersPics/userID
            print('I - deleting user pic');
            await Fire.deleteStoragePic(
              context: context,
              picType: PicType.userPic,
              fileName: userModel.userID,
            );

            /// J - DELETE user doc : firestore/users/userID
            print('J - deleting user doc');
            await Fire.deleteDoc(
              context: context,
              collName: FireCollection.users,
              docName: userModel.userID,
            );

            /// L - DELETE firebase user : auth/userID
            print('L - deleting firebase user');
            await AuthOps().deleteFirebaseUser(context, userModel.userID);

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
        superDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: Loading(loading: true,),
        );

        /// H - DELETE tiny user : firestore/tinyUsers/userID
        print('H - deleting tinyUser');
        await Fire.deleteDoc(
          context: context,
          collName: FireCollection.tinyUsers,
          docName: userModel.userID,
        );

        /// I - DELETE user image : storage/usersPics/userID
        print('I - deleting user pic');
        await Fire.deleteStoragePic(
          context: context,
          picType: PicType.userPic,
          fileName: userModel.userID,
        );

        /// J - DELETE user doc : firestore/users/userID
        print('J - deleting user doc');
        await Fire.deleteDoc(
          context: context,
          collName: FireCollection.users,
          docName: userModel.userID,
        );

        /// L - DELETE firebase user : auth/userID
        print('L - deleting firebase user');
        await AuthOps().deleteFirebaseUser(context, userModel.userID);

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
  Future<Map<String, dynamic>> getOrCreateUserModelFromUser({BuildContext context, User user,Zone zone}) async {

    /// E - read user ops if existed
    UserModel _existingUserModel = await UserOps().readUserOps(
      context: context,
      userID: user.uid,
    );
    // print('lng : ${Wordz.languageCode(context)}');

    /// Ex - if new user (userModel == null)
    if (_existingUserModel == null) {

      // print('lng : ${Wordz.languageCode(context)}');

      /// E1 - create initial user model
      UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
        context: context,
        user: user,
        zone: zone,
        authBy: AuthBy.google,
      );
      print('googleSignInOps : _initialUserModel : $_initialUserModel');

      /// E2 - create user ops
      UserModel _finalUserModel = await UserOps().createUserOps(
        context: context,
        userModel: _initialUserModel,
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
}
