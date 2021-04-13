import 'package:bldrs/controllers/drafters/file_formatters.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_storage.dart';
import '../firestore.dart';
/// Should include all user firestore operations
/// except reading data for widgets injection
class UserCRUD{
// ---------------------------------------------------------------------------
  /// user firestore collection reference
  final CollectionReference _usersCollectionRef = getFireCollectionReference(FireCollection.users);
// ---------------------------------------------------------------------------
  /// users firestore collection reference getter
  CollectionReference userCollectionRef(){
    return
      _usersCollectionRef;
  }
// ---------------------------------------------------------------------------
  /// user firestore document reference
  DocumentReference userDocRef(String userID){
    return
      getFirestoreDocumentReference(FireCollection.users, userID);
  }
// ---------------------------------------------------------------------------
  /// create or update user document
  Future<void> _createOrUpdateUserDoc({BuildContext context, UserModel userModel}) async {

    await replaceFirestoreDocument(
      context: context,
      collectionName: FireCollection.users,
      docName: userModel.userID,
      input: userModel.toMap(),
    );

}
// ---------------------------------------------------------------------------
  Future<void> createUserOps({BuildContext context, UserModel userModel}) async {

    /// check if user pic is file to upload or URL from facebook to keep
    String _userPicURL;
    if (ObjectChecker.objectIsFile(userModel.pic) == true){
      _userPicURL = await savePicOnFirebaseStorageAndGetURL(
            context: context,
            inputFile: userModel.pic,
            fileName: userModel.userID,
            picType: PicType.userPic
        );
    }

    /// create final UserModel
    UserModel _finalUserModel = UserModel(
      userID : userModel.userID,
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
    await createFireStoreNamedDocument(
      context: context,
      collectionName: FireCollection.tinyUsers,
      docName: userModel.userID,
      input: TinyUser.getTinyUserFromUserModel(_finalUserModel).toMap(),
    );

  }
// ---------------------------------------------------------------------------
  Future<void> updateUserOps({BuildContext context, UserModel oldUserModel, UserModel updatedUserModel}) async {

    /// update picture if changed or continue without changing pic
    String _userPicURL;
    if (ObjectChecker.objectIsFile(updatedUserModel.pic) == true){
      _userPicURL = await savePicOnFirebaseStorageAndGetURL(
          context: context,
          inputFile: updatedUserModel.pic,
          fileName: updatedUserModel.userID,
          picType: PicType.userPic
      );
    }

    /// create final UserModel
    UserModel _finalUserModel = UserModel(
      userID : updatedUserModel.userID,
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
      await replaceFirestoreDocument(
        context: context,
        collectionName: FireCollection.tinyUsers,
        docName: updatedUserModel.userID,
        input: TinyUser.getTinyUserFromUserModel(_finalUserModel).toMap(),
      );
    }

  }
// ---------------------------------------------------------------------------
  /// delete user document and its consequences
  Future<void> _deleteUserDoc(String userID) async {
    final DocumentReference _userDocument = userDocRef(userID);
    await _userDocument.delete();
  }
// ---------------------------------------------------------------------------
  /// delete all user related data
  Future<void> deleteUserOps(String userID) async {
    /// x. Alert user that he will forever lose his (name, pic, title, contacts,
    /// status, company, gender, zone, position, saved flyers, followed bzz) in
    /// [bool dialog]

    /// A. if user is Author :-
    ///
    /// 1. if Author is alone : Alert author he will forever lose his (bz,
    /// flyers, all records, pictures) in [bool dialog]
    ///
    /// 2. if Author is not alone : Alert author to either 'delete' (will lose
    /// all flyer records including saves, shares, views, calls records) or
    /// 'migrate to other author' his published flyers (if publishedFlyersIDs.length > 0)
    /// & Joints (if joints.length > 0) in [choice dialog]
    ///
    /// 3. according to 1 & 2 :-
    ///     - migrate published flyers to another author
    ///       + change authorID in all these flyers
    ///
    ///     - delete published flyers
    /// 4. delete author doc from authors collection in bz doc
  }
// ---------------------------------------------------------------------------

}
