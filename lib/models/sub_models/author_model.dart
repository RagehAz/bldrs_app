import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import '../bz_model.dart';
import '../user_model.dart';
import 'contact_model.dart';
// -----------------------------------------------------------------------------
class AuthorModel{
  final String userID;
  final String authorName;
  final dynamic authorPic;
  final String authorTitle;
  final bool authorIsMaster;
  final List<ContactModel> authorContacts;

  AuthorModel({
    this.userID,
    this.authorName,
    this.authorPic,
    this.authorTitle,
    this.authorIsMaster,
    this.authorContacts,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'authorName' : authorName,
      'authorPic' : authorPic,
      'authorTitle' : authorTitle,
      'authorIsMaster' : authorIsMaster,
      'authorContacts' : ContactModel.cipherContactsModels(authorContacts),
    };
  }
// -----------------------------------------------------------------------------
  static int getAuthorGalleryCountFromBzModel(BzModel bzModel, AuthorModel author){
    String _authorID = author.userID;
    List<NanoFlyer> _bzFlyers = bzModel.bzFlyers;

    List<String> _authorFlyersIDs = new List();

    for (var flyer in _bzFlyers){
      if(flyer.authorID == _authorID){
        _authorFlyersIDs.add(flyer.flyerID);
      }
    }

    int _authorGalleryCount = _authorFlyersIDs.length;

    return _authorGalleryCount;
}
// -----------------------------------------------------------------------------
  static AuthorModel decipherBzAuthorMap(dynamic map){
    return AuthorModel(
      userID : map['userID'],
      authorName : map['authorName'],
      authorPic : map['authorPic'],
      authorTitle : map['authorTitle'],
      authorIsMaster : map['authorIsMaster'],
      authorContacts : ContactModel.decipherContactsMaps(map['authorContacts']),
    );
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> decipherBzAuthorsMaps(List<dynamic> listOfMaps){
    List<AuthorModel> _authorsList = new List();

    listOfMaps.forEach((map) {
      _authorsList.add(decipherBzAuthorMap(map));
    });

    return _authorsList;
  }
// -----------------------------------------------------------------------------
  static List<Map<String,Object>> cipherAuthorsModels(List<AuthorModel> authorsList){
    List<Map<String,Object>> listOfAuthorsMaps = new List();
    authorsList?.forEach((author) {
      listOfAuthorsMaps.add(author.toMap());
    });
    return listOfAuthorsMaps;
  }
// -----------------------------------------------------------------------------
  static AuthorModel getAuthorFromBzByAuthorID(BzModel bz, String authorID){
    AuthorModel author = bz?.bzAuthors?.singleWhere((au) => au.userID == authorID, orElse: ()=>null);
    return author;
  }
// -----------------------------------------------------------------------------
  /// temp
  static AuthorModel createAuthorModelFromUserModelAndBzModel(UserModel user, BzModel bz){
    String authorID = user?.userID;
    AuthorModel authorFromBz = getAuthorFromBzByAuthorID(bz, authorID);
    AuthorModel author = AuthorModel(
      userID: user?.userID,
      // bzID: bz?.bzID,
      authorName: user?.name,
      authorPic: user?.pic,
      authorTitle: user?.title,
      authorContacts: user?.contacts,
      authorIsMaster: authorFromBz?.authorIsMaster,
    );
    return author;
  }
// -----------------------------------------------------------------------------
  static AuthorModel createMasterAuthorModelFromUserModel(UserModel userModel){
    return
      AuthorModel(
        userID: userModel.userID,
        authorName: userModel.name,
        authorPic: userModel.pic,
        authorTitle: userModel.title,
        authorContacts: userModel.contacts,
        authorIsMaster: true, // need to make sure about this
      );
  }
// -----------------------------------------------------------------------------
  static int getAuthorIndexByAuthorID(List<AuthorModel> authors, String authorID){
    int _currentAuthorIndex = authors.indexWhere((au) => authorID == au.userID);
    return _currentAuthorIndex;
  }
// -----------------------------------------------------------------------------
  static BzModel replaceAuthorModelInBzModel(BzModel bzModel, AuthorModel inputAuthor){

    List<AuthorModel> _modifiedAuthorsList =
    replaceAuthorModelInAuthorsList(bzModel.bzAuthors, inputAuthor);

    return BzModel(
      bzID : bzModel.bzID,
      bzType : bzModel.bzType,
      bzForm : bzModel.bzForm,
      bldrBirth : bzModel.bldrBirth,
      accountType : bzModel.accountType,
      bzURL : bzModel.bzURL,
      bzName : bzModel.bzName,
      bzLogo : bzModel.bzLogo,
      bzScope : bzModel.bzScope,
      bzCountry : bzModel.bzCountry,
      bzProvince : bzModel.bzProvince,
      bzArea : bzModel.bzArea,
      bzAbout : bzModel.bzAbout,
      bzPosition : bzModel.bzPosition,
      bzContacts : bzModel.bzContacts,
      bzAuthors : _modifiedAuthorsList,
      bzShowsTeam : bzModel.bzShowsTeam,
      bzIsVerified : bzModel.bzIsVerified,
      bzAccountIsDeactivated : bzModel.bzAccountIsDeactivated,
      bzAccountIsBanned : bzModel.bzAccountIsBanned,
      bzTotalFollowers : bzModel.bzTotalFollowers,
      bzTotalSaves : bzModel.bzTotalSaves,
      bzTotalShares : bzModel.bzTotalShares,
      bzTotalSlides : bzModel.bzTotalSlides,
      bzTotalViews : bzModel.bzTotalViews,
      bzTotalCalls : bzModel.bzTotalCalls,
      bzFlyers : bzModel.bzFlyers,
    );
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> replaceAuthorModelInAuthorsList(List<AuthorModel> originalAuthors, AuthorModel inputAuthor){
    List<AuthorModel> _modifiedAuthorsList;
    List<AuthorModel> _originalAuthors = originalAuthors;
    int _indexOfCurrentAuthor = getAuthorIndexByAuthorID(_originalAuthors, inputAuthor.userID);
    _originalAuthors.removeAt(_indexOfCurrentAuthor);
    _originalAuthors.insert(_indexOfCurrentAuthor, inputAuthor);
    _modifiedAuthorsList = _originalAuthors;

    return _modifiedAuthorsList;
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyAuthorFromAuthorModel(AuthorModel author){
    return TinyUser(
      userID: author.userID,
      name: author.authorName,
      title: author.authorTitle,
      pic: author.authorPic,
      userStatus: UserStatus.BzAuthor,
      contact: ContactModel.getAContactValueFromContacts(author.authorContacts, ContactType.Phone),
    );
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyAuthorFromBzModel({BzModel bzModel, String authorID}){
    AuthorModel _author = bzModel.bzAuthors.singleWhere((au) => au.userID == authorID, orElse: ()=> null);
    TinyUser _tinyAuthor = getTinyAuthorFromAuthorModel(_author);
    return _tinyAuthor;
  }
// -----------------------------------------------------------------------------
  static List<String> getAuthorsIDsFromAuthors(List<AuthorModel> authors){
    List<String> _authorsIDs = new List();

    for (var author in authors){
      _authorsIDs.add(author.userID);
    }

    return _authorsIDs;
  }
// -----------------------------------------------------------------------------
  static String generateAuthorPicID(String authorID, String bzID){
    String _authorPicID = '$authorID---$bzID';
    return _authorPicID;
  }
// -----------------------------------------------------------------------------
  static AuthorModel getAuthorModelFromUserModel({UserModel userModel}){
    AuthorModel _author = AuthorModel(
      userID : userModel.userID,
      authorName : userModel.name,
      authorPic : userModel.pic,
      authorTitle : userModel.title,
      authorIsMaster : false,
      authorContacts : userModel.contacts,
    );
    return _author;
  }
// -----------------------------------------------------------------------------
}
