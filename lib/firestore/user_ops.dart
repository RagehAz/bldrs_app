import 'package:bldrs/controllers/drafters/file_formatters.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/flyers_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
      Fire.getDocRef(FireCollection.users, userID);
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
      country : userModel.country,
      province : userModel.province,
      area : userModel.area,
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

    print('Start reading user $userID while lang is : ${Wordz.languageCode(context)},');

    Map<String, dynamic> _userMap = await Fire().readDoc(
      context: context,
      collName: FireCollection.users,
      docName: userID,
    );

    print('_userMap is : $_userMap');
    // print('lng : ${Wordz.languageCode(context)}');

    UserModel _user = _userMap == null ? null : UserModel.decipherUserMap(_userMap);

    print('_userModel is : $_user');
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
  Future<void> updateUserOps({BuildContext context, UserModel oldUserModel, UserModel updatedUserModel}) async {

    /// update picture if changed or continue without changing pic
    String _userPicURL;
    if (ObjectChecker.objectIsFile(updatedUserModel.pic) == true){
      _userPicURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: updatedUserModel.pic,
          fileName: updatedUserModel.userID,
          picType: PicType.userPic
      );
    }

    /// create final UserModel
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
      country : updatedUserModel.country,
      province : updatedUserModel.province,
      area : updatedUserModel.area,
      language : updatedUserModel.language,
      position : updatedUserModel.position,
      contacts : updatedUserModel.contacts,
      // -------------------------
      myBzzIDs : updatedUserModel.myBzzIDs,
    );

    /// update firestore user doc
    await _createOrUpdateUserDoc(
      context: context,
      userModel: _finalUserModel,
    );


    /// update tiny user if changed:-
    if (
    oldUserModel.name != updatedUserModel.name ||
    oldUserModel.title != updatedUserModel.title ||
    oldUserModel.pic != updatedUserModel.pic ||
    oldUserModel.userStatus != updatedUserModel.userStatus
    ){
      await Fire.updateDoc(
        context: context,
        collName: FireCollection.tinyUsers,
        docName: updatedUserModel.userID,
        input: TinyUser.getTinyUserFromUserModel(_finalUserModel).toMap(),
      );
    }

  }
// -----------------------------------------------------------------------------
  /// deacvtivate user account
  Future<void> deactivateUserOps({BuildContext context, UserModel userModel}) async {
    /// x. Alert user that he will forever lose his (name, pic, title, contacts,
    /// status, company, gender, zone, position, saved flyers, followed bzz) in
    /// [bool dialog]

    bool _result = await superDialog(
      context: context,
      title: 'Watch Out !',
      body: 'Your data can not be retrieved after deactivating your account\nAre you sure you want to proceed ?',
      boolDialog: true,
    );

    if (_result == false){
      // do nothing
      print('no Do not deactivate ');
    }
    else {

      print('CRUD OPS');

      /// A. if user is Author :-
      if (userModel.myBzzIDs.length != 0){

        /// WAITING DIALOG
        superDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: Loading(loading: true,),
        );

        FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

        /// a - get user tiny bzz
        List<BzModel> _bzzToDeactivate = new List();
        List<BzModel> _bzzToKeep = new List();
        for (var id in userModel.myBzzIDs){

          BzModel _bz = await BzOps.readBzOps(
            context: context,
            bzID: id,
          );

          if (_bz.bzAuthors.length == 1){
            _bzzToDeactivate.add(_bz);
          } else{
            _bzzToKeep.add(_bz);
          }

        }

        /// CLOSE WAITING DIALOG
        Nav.goBack(context);

        /// b - show dialog
        bool _bzzReviewResult = await bzzDeactivationDialog(
          context: context,
          bzzToDeactivate: _bzzToDeactivate,
          bzzToKeep: _bzzToKeep,
        );

        if (_bzzReviewResult == false) {
          // do nothing
          print('no Do not deactivate ');
        } else {

          /// b - show dialog
          bool _flyersReviewResult = await flyersDeactivationDialog(
            context: context,
            bzzToDeactivate: _bzzToDeactivate,
          );

          if (_flyersReviewResult == false){
            // do nothing
            print('no Do not deactivate ');
          } else {

            /// SHOW WAITING DIALOG
            superDialog(
              context: context,
              title: '',
              boolDialog: null,
              height: null,
              body: 'Waiting',
              child: Loading(loading: true,),
            );

            for (var bz in _bzzToDeactivate){

              /// de-activate bz
             await BzOps().deactivateBzOps(
               context: context,
               bzModel: bz,
             );

            }

            /// CLOSE WAITING DIALOG
            Nav.goBack(context);


          }

        }





      }

      /// change user status in user doc to deactivated
      await Fire.updateDocField(
        context: context,
        collName: FireCollection.users,
        docName: userModel.userID,
        field: 'userStatus',
        input: UserModel.cipherUserStatus(UserStatus.Deactivated),
      );

      /// change user status in TinyUser doc to deactivated
      await Fire.updateDocField(
        context: context,
        collName: FireCollection.tinyUsers,
        docName: userModel.userID,
        field: 'userStatus',
        input: UserModel.cipherUserStatus(UserStatus.Deactivated),
      );

      superDialog(
        context: context,
        title: '',
        boolDialog: false,
        height: null,
        body: 'Done',
      );

      /// CLOSE WAITING DIALOG
      Nav.goBack(context);


    }

  }
// -----------------------------------------------------------------------------
  /// TASK : CLOUD FUNCTION : delete user ops should trigger a cloud function instead of firing these entire functions from client
  /// for now this :-
  /// 1 - checks if user is Author, starts delete bz ops for all bzz that has no other authors sharing it
  /// 2 - deletes : firestore/tinyUsers/userID
  /// 3 - deletes : storage/usersPics/userID
  /// 4 - deletes : firestore/users/userID
  /// 5 - deletes : auth/userID TASK : deleting user authentication is not done
  Future<void> superDeleteUserOps({BuildContext context, UserModel userModel}) async {
    /// but for now : we will break the logic down

    /// 1 - if user is Author
    /// show user which bzz he will deleter
    /// and which flyers he will delete
    /// then proceed with super delete bz ops
    bool _result = await superDialog(
      context: context,
      title: 'This will Delete all your data',
      body: 'all pictures, flyers, businesses, your user records will be deleted for good\nDo you want to proceed ?',
      boolDialog: true,
    );

    /// so if user chooses not to continue, we cancel ops
    if (_result == false){
      // do nothing
      print('no Do not deactivate ');
    }

    /// if user chooses to continue delete
    else {

      print('CRUD OPS');

      /// 1. if user is Author go through dialogs to delete all bzz and their flyers if possible :-
      if (userModel.myBzzIDs.length != 0){

        /// WAITING DIALOG
        superDialog(
          context: context,
          title: '',
          boolDialog: null,
          height: null,
          body: 'Waiting',
          child: Loading(loading: true,),
        );

        FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

        /// a - get all user tiny bzz
        List<BzModel> _bzzToDeactivate = new List();
        List<BzModel> _bzzToKeep = new List();

        /// read bz ops for each bz id in userModel and filter them according to number of authors
        for (var id in userModel.myBzzIDs){
          BzModel _bz = await BzOps.readBzOps(
            context: context,
            bzID: id,
          );
          if (_bz.bzAuthors.length == 1){
            _bzzToDeactivate.add(_bz);
          } else {
            _bzzToKeep.add(_bz);
          }
        }

        /// CLOSE WAITING DIALOG
        Nav.goBack(context);

        /// b - show dialog of which bzz can and will be deleted
        bool _bzzReviewResult = await bzzDeactivationDialog(
          context: context,
          bzzToDeactivate: _bzzToDeactivate,
          bzzToKeep: _bzzToKeep,
        );

        /// so if user chooses to cancel ops
        if (_bzzReviewResult == false) {
          // do nothing
          print('no Do not deactivate ');
        }

        /// and if user chooses to continue ops
        else {

          /// b - show dialog of which flyers can and will be deleted
          bool _flyersReviewResult = await flyersDeactivationDialog(
            context: context,
            bzzToDeactivate: _bzzToDeactivate,
          );

          /// if user chooses to cancel ops
          if (_flyersReviewResult == false){
            // do nothing
            print('no Do not delete ');
          }

          /// if user chooses to continue ops
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

            /// start delete bz ops for all possible bzz
            for (var bz in _bzzToDeactivate){
              await BzOps().superDeleteBzOps(
                context: context,
                bzModel: bz,
              );
            }

            /// CLOSE WAITING DIALOG
            Nav.goBack(context);

          }

        }

        print('all ${_bzzToDeactivate.length} bzz are deleted');
      }

      /// 2 - delete tiny user
      print('deleting tinyUser');
      await Fire.deleteDoc(
        context: context,
        collName: FireCollection.tinyUsers,
        docName: userModel.userID,
      );

      /// 3 - delete user image
      print('deleting user pic');
      await Fire.deleteStoragePic(
        context: context,
        picType: PicType.userPic,
        fileName: userModel.userID,
      );

      /// 4 - delete user doc
      print('deleting user doc');
      await Fire.deleteDoc(
        context: context,
        collName: FireCollection.users,
        docName: userModel.userID,
      );

      /// 5 - delete irebase user
      await AuthOps().deleteFirebaseUser(context, userModel.userID);


    }


  }
// -----------------------------------------------------------------------------
}
