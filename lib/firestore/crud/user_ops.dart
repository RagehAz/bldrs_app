import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firestore.dart';
/// Should include all user firestore operations
/// except reading data for widgets injection
class UserCRUD{
// ---------------------------------------------------------------------------
  /// users collection reference
  CollectionReference userCollectionRef(){
    return
      getFirestoreCollectionReference(FireStoreCollection.users);
  }
// ---------------------------------------------------------------------------
  DocumentReference userDocRef(String userID){
    return
      getFirestoreDocumentReference(FireStoreCollection.users, userID);
  }
// ---------------------------------------------------------------------------
  final CollectionReference _usersCollectionRef = getFirestoreCollectionReference(FireStoreCollection.users);
// ---------------------------------------------------------------------------
  /// create user document
  /// or update user document
  Future<void> createUserDoc({UserModel userModel}) async {
    await _usersCollectionRef.doc(userModel.userID).set(userModel.toMap());
}
// ---------------------------------------------------------------------------
  /// delete user document and its consequences
  Future<void> deleteUserDoc(String userID) async {
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
    /// all flyer records including saves, shares, views, calls, and bzJoints records) or
    /// 'migrate to other author' his published flyers (if publishedFlyersIDs.length > 0)
    /// & Joints (if joints.length > 0) in [choice dialog]
    ///
    /// 3. according to 1 & 2 :-
    ///     - migrate published flyers & joints to another author
    ///       + change authorID in all these flyers
    ///       + change requesterID or responderID in all his joint records
    ///     - delete published flyers
    /// 4. delete author doc from authors collection in bz doc
  }
}
