import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/local_db/models/ldb_column.dart';
// -----------------------------------------------------------------------------
class AuthorModel{
  final String userID;
  final String authorName;
  final dynamic authorPic;
  final String authorTitle;
  final bool authorIsMaster;
  final List<ContactModel> authorContacts;

  const AuthorModel({
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
  static int getAuthorGalleryCountFromBzModel({BzModel bzModel, AuthorModel author, List<TinyFlyer> bzTinyFlyers}){
    final String _authorID = author.userID;

    final List<String> _authorFlyersIDs = <String>[];

    for (var tinyFlyer in bzTinyFlyers){
      if(tinyFlyer.authorID == _authorID){
        _authorFlyersIDs.add(tinyFlyer.flyerID);
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
    final List<AuthorModel> _authorsList = <AuthorModel>[];

    listOfMaps.forEach((map) {
      _authorsList.add(decipherBzAuthorMap(map));
    });

    return _authorsList;
  }
// -----------------------------------------------------------------------------
  static List<Map<String,Object>> cipherAuthorsModels(List<AuthorModel> authorsList){
    final List<Map<String,Object>> listOfAuthorsMaps = <Map<String,Object>>[];
    authorsList?.forEach((author) {
      listOfAuthorsMaps.add(author.toMap());
    });
    return listOfAuthorsMaps;
  }
// -----------------------------------------------------------------------------
  static AuthorModel getAuthorFromBzByAuthorID(BzModel bz, String authorID){
    final AuthorModel author = bz?.bzAuthors?.singleWhere((au) => au.userID == authorID, orElse: ()=> null );
    return author;
  }
// -----------------------------------------------------------------------------
  /// temp
  static AuthorModel createAuthorModelFromUserModelAndBzModel(UserModel user, BzModel bz){
    final String authorID = user?.userID;
    final AuthorModel authorFromBz = getAuthorFromBzByAuthorID(bz, authorID);
    final AuthorModel author = AuthorModel(
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
    final int _currentAuthorIndex = authors.indexWhere((au) => authorID == au.userID);
    return _currentAuthorIndex;
  }
// -----------------------------------------------------------------------------
  static BzModel replaceAuthorModelInBzModel({BzModel bzModel, AuthorModel oldAuthor, AuthorModel newAuthor}){

    final List<AuthorModel> _modifiedAuthorsList =
    replaceAuthorModelInAuthorsList(
      originalAuthors: bzModel.bzAuthors,
      oldAuthor: oldAuthor,
      newAuthor: newAuthor,
    );

    final List<String> _modifiedAuthorsIDsList =
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
      flyersIDs : bzModel.flyersIDs,
      bzTotalFlyers: bzModel.bzTotalFlyers,
      authorsIDs: _modifiedAuthorsIDsList,
    );
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> replaceAuthorModelInAuthorsList({List<AuthorModel> originalAuthors, AuthorModel oldAuthor, AuthorModel newAuthor}){
    List<AuthorModel> _modifiedAuthorsList;
    final List<AuthorModel> _originalAuthors = originalAuthors;
    final int _indexOfOldAuthor = getAuthorIndexByAuthorID(_originalAuthors, oldAuthor.userID);

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
    final List<String> _originalAuthorsIDs = getAuthorsIDsFromAuthors(originalAuthors);
    print('getAuthorsIDsFromAuthors : _originalAuthorsIDs : $_originalAuthorsIDs');
    final int _indexOfOldAuthor = getAuthorIndexByAuthorID(originalAuthors, oldAuthor.userID);

    if (_indexOfOldAuthor != -1){

    _originalAuthorsIDs.removeAt(_indexOfOldAuthor);
    _originalAuthorsIDs.insert(_indexOfOldAuthor, newAuthor.userID);
    _modifiedAuthorsIDsList = _originalAuthorsIDs;

    }

    return _modifiedAuthorsIDsList;
  }
// -----------------------------------------------------------------------------
  static List<String> getAuthorsIDsFromAuthors(List<AuthorModel> authors){
    final List<String> _authorsIDs = <String>[];

    for (var author in authors){
      _authorsIDs.add(author.userID);
    }

    return _authorsIDs;
  }
// -----------------------------------------------------------------------------
  static String generateAuthorPicID(String authorID, String bzID){
    final String _authorPicID = '$authorID---$bzID';
    return _authorPicID;
  }
// -----------------------------------------------------------------------------
  static AuthorModel getAuthorModelFromUserModel({UserModel userModel}){
    final AuthorModel _author = AuthorModel(
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
  static List<AuthorModel> getAuthorsFromAuthorsByAuthorsIDs(List<AuthorModel> allAuthors, List<String> authorsIDs){
    List<AuthorModel> _bzAuthors = <AuthorModel>[];

    if (allAuthors != null && authorsIDs != null && allAuthors.isNotEmpty && authorsIDs.isNotEmpty){

      for (String id in authorsIDs){

        final AuthorModel _author = allAuthors.singleWhere((author) => author.userID == id, orElse: () => null);

        if (_author != null){
          _bzAuthors.add(_author);
        }

      }

    }

    return _bzAuthors;
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> combineAllBzzAuthors(List<BzModel> allBzz){
    List<AuthorModel> _allAuthors = <AuthorModel>[];

    if (allBzz != null && allBzz.isNotEmpty){

      for (BzModel bz in allBzz){

        _allAuthors.addAll(bz.bzAuthors);

      }

    }

    return _allAuthors;
  }
// -----------------------------------------------------------------------------
  static List<LDBColumn> createAuthorsLDBColumns(){

    const List<LDBColumn> _authorsColumns = const <LDBColumn>[
      LDBColumn(key: 'userID', type: 'TEXT', isPrimary: true),
      LDBColumn(key: 'authorName', type: 'TEXT'),
      LDBColumn(key: 'authorPic', type: 'TEXT'),
      LDBColumn(key: 'authorTitle', type: 'TEXT'),
      LDBColumn(key: 'authorIsMaster', type: 'INTEGER'),
      LDBColumn(key: 'authorContacts', type: 'TEXT'),
    ];

    return _authorsColumns;
  }
// -----------------------------------------------------------------------------
  static Map<String, Object> sqlCipherAuthor({AuthorModel author}){

    final Map<String, Object> _authorSQLMap = {
      'userID' : author.userID,
      'authorName' : author.authorName,
      'authorPic' : Imagers.sqlCipherImage(author.authorPic),
      'authorTitle' : author.authorTitle,
      'authorIsMaster' : Numeric.sqlCipherBool(author.authorIsMaster),
      'authorContacts' : ContactModel.sqlCipherContacts(author.authorContacts),
    };

    return _authorSQLMap;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, Object>> sqlCipherAuthors({List<AuthorModel> authors}){
    List<Map<String, Object>> _authorsMaps = <Map<String, Object>>[];

    if (authors != null && authors.isNotEmpty){

      for (AuthorModel author in authors){

        final Map<String, Object> _sqlAuthorMap = sqlCipherAuthor(
          author: author,
        );

        _authorsMaps.add(_sqlAuthorMap);

      }

    }

    return _authorsMaps;
  }
// -----------------------------------------------------------------------------
  static AuthorModel sqlDecipherAuthor({Map<String, Object> map}){
    AuthorModel _author;

    if (map != null){

      _author = AuthorModel(
        userID : map['userID'],
        authorName : map['authorName'],
        authorPic : Imagers.sqlDecipherImage(map['authorPic']),
        authorTitle : map['authorTitle'],
        authorIsMaster : Numeric.sqlDecipherBool(map['authorIsMaster']),
        authorContacts : ContactModel.sqlDecipherContacts(map['authorContacts']),
      );

    }

    return _author;
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> sqlDecipherAuthors({List<Map<String, Object>> maps}){
    List<AuthorModel> _authors = <AuthorModel>[];

    if (maps != null && maps.isNotEmpty){

      for (var map in maps){

        final AuthorModel _author = sqlDecipherAuthor(map: map);

        _authors.add(_author);

      }

    }

    return _authors;
  }
// -----------------------------------------------------------------------------

}
