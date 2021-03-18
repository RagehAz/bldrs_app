import '../bz_model.dart';
import '../user_model.dart';
import 'contact_model.dart';
// ###############################
class AuthorModel{
  final String bzID; // temporary should delete later
  final String userID;
  final String authorName;
  final dynamic authorPic;
  final String authorTitle;
  final List<dynamic> publishedFlyersIDs;
  final List<ContactModel> authorContacts;
// ###############################
  AuthorModel({
    this.bzID,
    this.userID,
    this.authorName,
    this.authorPic,
    this.authorTitle,
    this.publishedFlyersIDs,
    this.authorContacts,
});
// ###############################
  Map<String, dynamic> toMap(){
    return {
      'bzID' : bzID,
      'userID' : userID,
      'authorName' : authorName,
      'authorPic' : authorPic,
      'authorTitle' : authorTitle,
      'publishedFlyersIDs' : publishedFlyersIDs,
      'authorContacts' : cipherContactsModels(authorContacts),
    };
  }
// ###############################
}
AuthorModel decipherBzAuthorMap(dynamic map){
  return AuthorModel(
    bzID : map['bzID'],
    userID : map['userID'],
    authorName : map['authorName'],
    authorPic : map['authorPic'],
    authorTitle : map['authorTitle'],
    publishedFlyersIDs : map['publishedFlyersIDs'],
    authorContacts : decipherContactsMaps(map['authorContacts']),
  );
}
// -----------------------------------------------------------------
List<AuthorModel> decipherBzAuthorsMaps(List<dynamic> listOfMaps){
  List<AuthorModel> _authorsList = new List();

  listOfMaps.forEach((map) {
    _authorsList.add(decipherBzAuthorMap(map));
  });

  return _authorsList;
}
// -----------------------------------------------------------------
List<Map<String,Object>> cipherAuthorsModels(List<AuthorModel> authorsList){
  List<Map<String,Object>> listOfAuthorsMaps = new List();
  authorsList?.forEach((author) {
    listOfAuthorsMaps.add(author.toMap());
  });
  return listOfAuthorsMaps;
}
// -----------------------------------------------------------------
AuthorModel getAuthorFromBzByAuthorID(BzModel bz, String authorID){
  AuthorModel author = bz?.bzAuthors?.singleWhere((au) => au.userID == authorID, orElse: ()=>null);
  return author;
}
// ----------------------------------------------------------------------------
/// temp
AuthorModel createAuthorModelFromUserModelAndBzModel(UserModel user, BzModel bz){
  String authorID = user?.userID;
  AuthorModel authorFromBz = getAuthorFromBzByAuthorID(bz, authorID);
  AuthorModel author = AuthorModel(
    userID: user?.userID,
    bzID: bz?.bzID,
    authorName: user?.name,
    authorPic: user?.pic,
    authorTitle: user?.title,
    authorContacts: user?.contacts,
    publishedFlyersIDs: authorFromBz?.publishedFlyersIDs,
  );
  return author;
}
// ----------------------------------------------------------------------------
AuthorModel createTempAuthorModelFromUserModel(UserModel userModel){
  return
    AuthorModel(
        userID: userModel.userID,
        authorName: userModel.name,
        authorPic: userModel.pic,
        authorTitle: userModel.title,
        authorContacts: userModel.contacts
    );
}
// ----------------------------------------------------------------------------