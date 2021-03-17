import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firestore.dart';
/// create, read, update, delete user doc in cloud firestore
class UserCRUD{
// ---------------------------------------------------------------------------
  /// users collection reference
  CollectionReference userCollection(){
    return
      getFirestoreCollectionReference(FireStoreCollection.users);
  }
// ---------------------------------------------------------------------------
  DocumentReference userDocument(String userID){
    return
      getFirestoreDocumentReference(FireStoreCollection.users, userID);
  }
// ---------------------------------------------------------------------------
  final CollectionReference _usersCollection = getFirestoreCollectionReference(FireStoreCollection.users);
// ---------------------------------------------------------------------------
  /// create user document
  Future<void> createUserDoc({UserModel userModel}) async {
    await _usersCollection.doc(userModel.userID).set(userModel.toMap());
}
// ---------------------------------------------------------------------------
  /// delete user document and its consequences
Future<void> deleteUserDoc({UserModel userModel}) async {
    String _userID = userModel.userID;
    DocumentReference _userDocument = userDocument(_userID);
    await _userDocument.delete();
}
// ---------------------------------------------------------------------------
Future<void> readUserDoc() async {}
// ---------------------------------------------------------------------------
// Future<void> updateUserDoc({UserModel userModel}) async {
//
// }
// ---------------------------------------------------------------------------
}
