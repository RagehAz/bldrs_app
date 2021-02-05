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
  Map<String, Object> toMap(){
    return {
      'userID' : userID,
      'authorName' : authorName,
      'authorPic' : authorPic,
      'authorTitle' : authorTitle,
      'publishedFlyersIDs' : publishedFlyersIDs,
      'authorContacts' : moldContactModelsIntoListOfMaps(authorContacts),
    };
  }
// ###############################
}