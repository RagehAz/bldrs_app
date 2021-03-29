import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../firestore.dart';
/// Should include all user firestore operations
/// except reading data for widgets injection
class UserCRUD{
// ---------------------------------------------------------------------------
  /// user firestore collection reference
  final CollectionReference _usersCollectionRef = getFirestoreCollectionReference(FireStoreCollection.users);
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
      getFirestoreDocumentReference(FireStoreCollection.users, userID);
  }
// ---------------------------------------------------------------------------
  /// create or update user document
  /// or update user document
  Future<void> _createOrUpdateUserDoc({BuildContext context, UserModel userModel}) async {

    await replaceFirestoreDocument(
      context: context,
      collectionName: FireStoreCollection.users,
      docName: userModel.userID,
      input: userModel.toMap(),
    );

}
// ---------------------------------------------------------------------------
  Future<void> createUserOps({BuildContext context, UserModel userModel}) async {
    /// create user doc in fireStore
    await _createOrUpdateUserDoc(
      context: context,
      userModel: userModel,
    );

    /// create TinyUser in firestore
    await createFireStoreNamedDocument(
      context: context,
      collectionName: FireStoreCollection.tinyUsers,
      docName: userModel.userID,
      input: getTinyUserFromUserModel(userModel).toMap(),
    );

  }
// ---------------------------------------------------------------------------
  Future<void> updateUserOps({BuildContext context, UserModel oldUserModel, UserModel newUserModel}) async {

   /// update all tiny user instances in asks collection in case TinyUser is changed:-
    if (
    oldUserModel.name != newUserModel.name ||
    oldUserModel.title != newUserModel.title ||
    oldUserModel.pic != newUserModel.pic ||
    oldUserModel.userStatus != newUserModel.userStatus
    ){
      /// get all asks IDs in a list
      List<String> _userAsksIDs = new List();
      List<QueryDocumentSnapshot> _asksMaps = await getFireStoreSubCollectionMaps(
        collectionName: FireStoreCollection.users,
        docName: oldUserModel.userID,
        subCollectionName: FireStoreCollection.subUserAsks,
      );
      for (var map in _asksMaps){_userAsksIDs.add(map.id);}

      /// for all asks IDs update the the tiny user
      if (_userAsksIDs.length > 0){
        TinyUser _newTinyUser = getTinyUserFromUserModel(newUserModel);
        for (var id in _userAsksIDs){
          await updateFieldOnFirestore(
            context: context,
            collectionName: FireStoreCollection.users,
            documentName: id,
            field: 'tinyUser',
            input: _newTinyUser,
            // TASK : check dialogs as they will pop with each ask doc update loop
          );
        }

      }

    }

    /// update firestore user doc
    await _createOrUpdateUserDoc(
      context: context,
      userModel: newUserModel,
    );

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
}
