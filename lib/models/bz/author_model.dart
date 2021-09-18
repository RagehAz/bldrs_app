import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/nano_flyer.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
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
    List<NanoFlyer> _nanoFlyers = bzModel.nanoFlyers;

    List<String> _authorFlyersIDs = [];

    for (var flyer in _nanoFlyers){
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
    List<AuthorModel> _authorsList = [];

    listOfMaps.forEach((map) {
      _authorsList.add(decipherBzAuthorMap(map));
    });

    return _authorsList;
  }
// -----------------------------------------------------------------------------
  static List<Map<String,Object>> cipherAuthorsModels(List<AuthorModel> authorsList){
    List<Map<String,Object>> listOfAuthorsMaps = [];
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
  static BzModel replaceAuthorModelInBzModel({BzModel bzModel, AuthorModel oldAuthor, AuthorModel newAuthor}){

    List<AuthorModel> _modifiedAuthorsList =
    replaceAuthorModelInAuthorsList(
      originalAuthors: bzModel.bzAuthors,
      oldAuthor: oldAuthor,
      newAuthor: newAuthor,
    );

    List<String> _modifiedAuthorsIDsList =
    replaceAuthorIDInAuthorsIDsList(
        originalAuthors: bzModel.bzAuthors,
        oldAuthor: oldAuthor,
        newAuthor: newAuthor,
    );

    return BzModel(
      bzID : bzModel.bzID,
      bzType : bzModel.bzType,
      bzForm : bzModel.bzForm,
      createdAt : bzModel.createdAt,
      accountType : bzModel.accountType,
      bzName : bzModel.bzName,
      bzLogo : bzModel.bzLogo,
      bzScope : bzModel.bzScope,
      bzZone : bzModel.bzZone,
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
      nanoFlyers : bzModel.nanoFlyers,
      bzTotalFlyers: bzModel.bzTotalFlyers,
      authorsIDs: _modifiedAuthorsIDsList,
    );
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> replaceAuthorModelInAuthorsList({List<AuthorModel> originalAuthors, AuthorModel oldAuthor, AuthorModel newAuthor}){
    List<AuthorModel> _modifiedAuthorsList;
    List<AuthorModel> _originalAuthors = originalAuthors;
    int _indexOfOldAuthor = getAuthorIndexByAuthorID(_originalAuthors, oldAuthor.userID);

    if (_indexOfOldAuthor != -1){

    _originalAuthors.removeAt(_indexOfOldAuthor);
    _originalAuthors.insert(_indexOfOldAuthor, newAuthor);
    _modifiedAuthorsList = _originalAuthors;

    }

    return _modifiedAuthorsList;
  }
// -----------------------------------------------------------------------------
  static List<String> replaceAuthorIDInAuthorsIDsList({List<AuthorModel> originalAuthors, AuthorModel oldAuthor, AuthorModel newAuthor}){
    List<String> _modifiedAuthorsIDsList;
    List<String> _originalAuthorsIDs = getAuthorsIDsFromAuthors(originalAuthors);
    print('getAuthorsIDsFromAuthors : _originalAuthorsIDs : $_originalAuthorsIDs');
    int _indexOfOldAuthor = getAuthorIndexByAuthorID(originalAuthors, oldAuthor.userID);

    if (_indexOfOldAuthor != -1){

    _originalAuthorsIDs.removeAt(_indexOfOldAuthor);
    _originalAuthorsIDs.insert(_indexOfOldAuthor, newAuthor.userID);
    _modifiedAuthorsIDsList = _originalAuthorsIDs;

    }

    return _modifiedAuthorsIDsList;
  }
// -----------------------------------------------------------------------------
  static List<String> getAuthorsIDsFromAuthors(List<AuthorModel> authors){
    List<String> _authorsIDs = [];

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
