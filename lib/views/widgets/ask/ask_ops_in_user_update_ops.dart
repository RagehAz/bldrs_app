// /// PLAN : while update user Ops ,, get all asks IDs in a list
// List<String> _userAsksIDs = new List();
// List<QueryDocumentSnapshot> _asksMaps = await getFireStoreSubCollectionMaps(
//   collectionName: FireStoreCollection.users,
//   docName: oldUserModel.userID,
//   subCollectionName: FireStoreCollection.subUserAsks,
// );
// for (var map in _asksMaps){_userAsksIDs.add(map.id);}

/// for all asks IDs update the the tiny user
// if (_userAsksIDs.length > 0){
//   TinyUser _newTinyUser = getTinyUserFromUserModel(newUserModel);
//   for (var id in _userAsksIDs){
//     await updateFieldOnFirestore(
//       context: context,
//       collectionName: FireStoreCollection.users,
//       documentName: id,
//       field: 'tinyUser',
//       input: _newTinyUser,
//       // TASK : check dialogs as they will pop with each ask doc update loop
//     );
//   }
//
// }
