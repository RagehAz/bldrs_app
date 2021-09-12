import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/user/user_model.dart';

class SuperBldrsMethod{
// -----------------------------------------------------------------------------
  static Future<List<UserModel>> readAllUserModels({int limit}) async {

    List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireCollection.users,
      addDocSnapshotToEachMap: false,
      orderBy: 'userID',
    );

    List<UserModel> _allUsers = UserModel.decipherUsersMaps(_maps);

    return _allUsers;
  }
// -----------------------------------------------------------------------------

}