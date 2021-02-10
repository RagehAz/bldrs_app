import 'contact_model.dart';
// ###############################
class AuthorModel{
  final String bzID; // temporary should delete later
  final String userID;
  final String authorName;
  final dynamic authorPic;
  final String authorTitle;
  final List<String> publishedFlyersIDs;
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
      'authorPic' : '',//authorPic,
      'authorTitle' : authorTitle,
      'publishedFlyersIDs' : publishedFlyersIDs,
      'authorContacts' : cipherContactsModels(authorContacts),
    };
  }
// ###############################
}
AuthorModel decipherBzAuthorMap(Map<String, dynamic> map){
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
  List<Map<String,Object>> listOfAuthors = new List();
  authorsList?.forEach((author) {
    listOfAuthors.add(author.toMap());
  });
  return listOfAuthors;
}
// -----------------------------------------------------------------

