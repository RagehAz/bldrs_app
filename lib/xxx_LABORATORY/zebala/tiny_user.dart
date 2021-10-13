
// -----------------------------------------------------------------------------
// class TinyUser {
//   final String userID;
//   final String name;
//   final String title;
//   final dynamic pic;
//   final UserStatus userStatus;
//   final String email;
//   final String phone;
//
//   const TinyUser({
//     this.userID,
//     this.name,
//     this.title,
//     this.pic,
//     this.userStatus,
//     this.email,
//     this.phone,
//   });
// // -----------------------------------------------------------------------------
//   Map<String, dynamic> toMap(){
//     return {
//       'userID' : userID,
//       'name' : name,
//       'title' : title,
//       'pic' : pic,
//       'userStatus' : UserModel.cipherUserStatus(userStatus),
//       'email' : email,
//       'phone' : phone,
//     };
//   }
// // -----------------------------------------------------------------------------
//   TinyUser clone(){
//     return TinyUser(
//       userID: userID,
//       name: name,
//       title: title,
//       pic: pic,
//       userStatus: userStatus,
//       email: email,
//       phone: phone,
//     );
//   }
// // -----------------------------------------------------------------------------
//   static TinyUser decipherTinyUserMap(Map<String, dynamic> map){
//     TinyUser _tinyUser;
//
//     if(map != null){
//       _tinyUser = TinyUser(
//         userID: map['userID'],
//         name: map['name'],
//         title: map['title'],
//         pic: map['pic'],
//         userStatus: UserModel.decipherUserStatus(map['userStatus']),
//         email: map['email'],
//         phone: map['phone'],
//       );
//     }
//
//     return _tinyUser;
//   }
// // -----------------------------------------------------------------------------
//   static TinyUser getTinyUserFromUserModel(UserModel userModel){
//     return TinyUser(
//         userID: userModel.userID,
//         name: userModel.name,
//         title: userModel.title,
//         pic: userModel.pic,
//         userStatus: userModel.userStatus,
//         email: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Email),
//         phone: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Phone),
//     );
//   }
// // -----------------------------------------------------------------------------
//   static TinyUser getTinyAuthorFromAuthorModel(AuthorModel author){
//     return TinyUser(
//       userID: author.userID,
//       name: author.authorName,
//       title: author.authorTitle,
//       pic: author.authorPic,
//       userStatus: UserStatus.BzAuthor,
//       email: ContactModel.getAContactValueFromContacts(author.authorContacts, ContactType.Email),
//       phone: ContactModel.getAContactValueFromContacts(author.authorContacts, ContactType.Phone),
//     );
//   }
// // -----------------------------------------------------------------------------
//   static TinyUser getTinyAuthorFromBzModel({BzModel bzModel, String authorID}){
//     final AuthorModel _author = bzModel.bzAuthors.singleWhere((au) => au.userID == authorID, orElse: ()=> null);
//     final TinyUser _tinyAuthor = getTinyAuthorFromAuthorModel(_author);
//     return _tinyAuthor;
//   }
// // -----------------------------------------------------------------------------
//   static bool tinyUsersAreTheSame({UserModel finalUserModel, UserModel originalUserModel}){
//     bool _tinyUsersAreTheSame;
//
//     if (originalUserModel.name == finalUserModel.name
//         &&
//         originalUserModel.title == finalUserModel.title
//         &&
//         originalUserModel.pic == finalUserModel.pic
//         &&
//         originalUserModel.userStatus == finalUserModel.userStatus
//     ){
//
//       _tinyUsersAreTheSame = true;
//
//     } else {
//
//       _tinyUsersAreTheSame = false;
//
//     }
//
//     return _tinyUsersAreTheSame;
//   }
// // -----------------------------------------------------------------------------
//   static TinyUser dummyTinyUser(){
//     return
//       TinyUser(
//         userID: 'r1dqipDtBmRzK6HzL8Ug2vmcYVl1',
//         name: 'User fucking name',
//         title: 'super fucking user title',
//         pic: Iconz.DumAuthorPic, // 'https://lh3.googleusercontent.com/a-/AOh14Gj3FAh76iQck0pD8EkRGraEP1OsElK8HysuToZp_A=s96-c'
//         email: 'fuckyou@hotmail.com',
//         phone: '1234567',
//         userStatus: UserStatus.Building,
//       );
//   }
//
//   static TinyUser dummyTinyAuthor(){
//     return
//       TinyUser(
//         userID: '60a1SPzftGdH6rt15NF96m0j9Et2',
//         name: 'Author name',
//         title: 'super fucking user title',
//         pic: Iconz.DumAuthorPic,
//         email: 'fuckyou@hotmail.com',
//         phone: '1234567',
//         userStatus: UserStatus.Building,
//       );
//   }
// // -----------------------------------------------------------------------------
//   static List<TinyUser> dummyTinyUsers({int numberOfUsers}){
//
//     List<TinyUser> _users = const <TinyUser>[
//       const TinyUser(
//         name: 'Ahmad Ali',
//         pic: Iconz.DumAuthorPic,
//         userID: '1',
//         title: 'CEO and Founder',
//       ),
//       const TinyUser(
//         name: 'Morgan Darwish',
//         pic: Dumz.XXabohassan_author,
//         userID: '2',
//         title: 'Chairman',
//       ),
//       const TinyUser(
//         name: 'Zahi Fayez',
//         pic: Dumz.XXzah_author,
//         userID: '3',
//         title: ' Marketing Director',
//       ),
//       const TinyUser(
//         name: 'Hani Wani',
//         pic: Dumz.XXhs_author,
//         userID: '4',
//         title: 'Operations Manager',
//       ),
//       const TinyUser(
//         name: 'Nada Mohsen',
//         pic: Dumz.XXmhdh_author,
//         userID: '5',
//         title: 'Planning and cost control engineer',
//       ),
//     ];
//
//     if (numberOfUsers != null){
//       final List<int> _randomIndexes = Numeric.getRandomIndexes(numberOfIndexes: numberOfUsers, maxIndex: _users.length - 1);
//       final List<TinyUser> _finalList = <TinyUser>[];
//
//       for (int i = 0; i < _randomIndexes.length; i++){
//         _finalList.add(_users[_randomIndexes[i]]);
//       }
//
//       _users = _finalList;
//     }
//
//     return _users;
//   }
// // -----------------------------------------------------------------------------
// }


class OldTinyUserMethods {
// // -----------------------------------------------------------------------------
//   Future<TinyUser> readTinyUserOps({BuildContext context, String userID}) async {
//
//     print('readUserOps : Start reading user $userID while lang is : ${Wordz.languageCode(context)},');
//
//     final Map<String, dynamic> _tinyUserMap = await Fire.readDoc(
//       context: context,
//       collName: FireCollection.tinyUsers,
//       docName: userID,
//     );
//
//     print('readUserOps : _tinyUserMap _tinyUserMap[\'userID\'] is : ${_tinyUserMap['userID']}');
//     // print('lng : ${Wordz.languageCode(context)}');
//
//     final TinyUser _tinyUser = _tinyUserMap == null ? null : TinyUser.decipherTinyUserMap(_tinyUserMap);
//
//     // print('_userModel is : $_user');
//     // print('lng : ${Wordz.languageCode(context)}');
//
//     return _tinyUser;
//   }
// // -----------------------------------------------------------------------------
//   /// update user ops
//   /// D - if tinyUser is changed
//   if (
//
//   TinyUser.tinyUsersAreTheSame(
//   finalUserModel: _finalUserModel,
//   originalUserModel: oldUserModel
//   ) == false
//
//   ){
//
//   /// D1 - update fireStore/tinyUsers/userID
//   await Fire.updateDoc(
//   context: context,
//   collName: FireCollection.tinyUsers,
//   docName: updatedUserModel.userID,
//   input: TinyUser.getTinyUserFromUserModel(_finalUserModel).toMap(),
//   );
//   }
// // -----------------------------------------------------------------------------
  /// deactivate user ops
  /// I - change user status in TinyUser doc to deactivated
  // await Fire.updateDocField(
  // context: context,
  // collName: FireCollection.tinyUsers,
  // docName: userModel.userID,
  // field: 'userStatus',
  // input: UserModel.cipherUserStatus(UserStatus.Deactivated),
  // );
// // -----------------------------------------------------------------------------
//   typedef tinyUserModelWidgetBuilder = Widget Function(
//       BuildContext context,
//       TinyUser tinyUser,
//       );
// // -----------------------------------------------------------------------------
//   Widget tinyUserModelBuilder({
//     String userID,
//     BuildContext context,
//     tinyUserModelWidgetBuilder builder,
//   }){
//
//     return FutureBuilder(
//         future: Fire.readDoc(
//           context: context,
//           collName: FireCollection.tinyUsers,
//           docName: userID,
//         ),
//         builder: (ctx, snapshot){
//
//           if (StreamChecker.connectionIsLoading(snapshot) == true){
//             return Loading(loading: true,);
//           }
//
//           else {
//
//             final Map<String, dynamic> _map = snapshot.data;
//             final TinyUser tinyUser = TinyUser.decipherTinyUserMap(_map);
//
//             return builder(context, tinyUser);
//           }
//         }
//
//     );
//   }
// // -----------------------------------------------------------------------------

}