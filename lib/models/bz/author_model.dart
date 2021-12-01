import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class AuthorModel{
  final String userID;
  final String name;
  final dynamic pic;
  final String title;
  bool isMaster;
  final List<ContactModel> contacts;

  AuthorModel({
    this.userID,
    this.name,
    this.pic,
    this.title,
    this.isMaster,
    this.contacts,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'name' : name,
      'pic' : pic,
      'title' : title,
      'isMaster' : isMaster,
      'contacts' : ContactModel.cipherContacts(contacts),
    };
  }
// -----------------------------------------------------------------------------
  static Map<String,Object> cipherAuthors(List<AuthorModel> authors){
    Map<String, dynamic> _map = {};

    if (Mapper.canLoopList(authors)){

      for (AuthorModel author in authors){

        _map = Mapper.insertPairInMap(
          map: _map,
          key: author.userID,
          value: author.toMap(),
        );

      }

    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static AuthorModel decipherAuthor(Map<String, dynamic> map){
    return AuthorModel(
      userID : map['userID'],
      name : map['name'],
      pic : map['pic'],
      title : map['title'],
      isMaster : map['isMaster'],
      contacts : ContactModel.decipherContacts(map['contacts']),
    );
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> decipherAuthors(Map<String, dynamic> maps){
    final List<AuthorModel> _authors = <AuthorModel>[];

    final List<String> _keys = maps.keys.toList();

    if (Mapper.canLoopList(_keys)){

      for (String key in _keys){

        AuthorModel _author = decipherAuthor(maps[key]);
        _authors.add(_author);
      }

    }

    return _authors;
  }
// -----------------------------------------------------------------------------
  static int getAuthorGalleryCountFromBzModel({@required BzModel bzModel, @required  AuthorModel author, @required  List<FlyerModel> bzFlyers}){
    final String _authorID = author.userID;

    final List<String> _authorFlyersIDs = <String>[];

    for (var flyerModel in bzFlyers){
      if(flyerModel.authorID == _authorID){
        _authorFlyersIDs.add(flyerModel.id);
      }
    }

    int _authorGalleryCount = _authorFlyersIDs.length;

    return _authorGalleryCount;
  }
// -----------------------------------------------------------------------------
  static AuthorModel getAuthorFromBzByAuthorID(BzModel bz, String authorID){
    final AuthorModel author = bz?.authors?.singleWhere((AuthorModel au) => au.userID == authorID, orElse: ()=> null );
    return author;
  }
// -----------------------------------------------------------------------------
  /// temp
  static AuthorModel createAuthorModelFromUserModelAndBzModel(UserModel user, BzModel bz){
    final String authorID = user?.id;
    final AuthorModel authorFromBz = getAuthorFromBzByAuthorID(bz, authorID);
    final AuthorModel author = AuthorModel(
      userID: user?.id,
      // bzID: bz?.bzID,
      name: user?.name,
      pic: user?.pic,
      title: user?.title,
      contacts: user?.contacts,
      isMaster: authorFromBz?.isMaster,
    );
    return author;
  }
// -----------------------------------------------------------------------------
  static AuthorModel createMasterAuthorModelFromUserModel(UserModel userModel){
    return
      AuthorModel(
        userID: userModel.id,
        name: userModel.name,
        pic: userModel.pic,
        title: userModel.title,
        contacts: userModel.contacts,
        isMaster: true, // need to make sure about this
      );
  }
// -----------------------------------------------------------------------------
  static int getAuthorIndexByAuthorID(List<AuthorModel> authors, String authorID){
    final int _currentAuthorIndex = authors.indexWhere((AuthorModel au) => authorID == au.userID);
    return _currentAuthorIndex;
  }
// -----------------------------------------------------------------------------
  static BzModel replaceAuthorModelInBzModel({@required BzModel bzModel, @required AuthorModel oldAuthor, @required AuthorModel newAuthor}){

    final List<AuthorModel> _modifiedAuthorsList =
    replaceAuthorModelInAuthorsList(
      originalAuthors: bzModel.authors,
      oldAuthor: oldAuthor,
      newAuthor: newAuthor,
    );

    // final List<String> _modifiedAuthorsIDsList =
    // replaceAuthorIDInAuthorsIDsList(
    //     originalAuthors: bzModel.authors,
    //     oldAuthor: oldAuthor,
    //     newAuthor: newAuthor,
    // );

    return BzModel(
      id : bzModel.id,
      bzType : bzModel.bzType,
      bzForm : bzModel.bzForm,
      createdAt : bzModel.createdAt,
      accountType : bzModel.accountType,
      name : bzModel.name,
      trigram: bzModel.trigram,
      logo : bzModel.logo,
      scope : bzModel.scope,
      zone : bzModel.zone,
      about : bzModel.about,
      position : bzModel.position,
      contacts : bzModel.contacts,
      authors : _modifiedAuthorsList,
      showsTeam : bzModel.showsTeam,
      isVerified : bzModel.isVerified,
      bzState : bzModel.bzState,
      totalFollowers : bzModel.totalFollowers,
      totalSaves : bzModel.totalSaves,
      totalShares : bzModel.totalShares,
      totalSlides : bzModel.totalSlides,
      totalViews : bzModel.totalViews,
      totalCalls : bzModel.totalCalls,
      flyersIDs : bzModel.flyersIDs,
      totalFlyers: bzModel.totalFlyers,
    );
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> replaceAuthorModelInAuthorsList({@required List<AuthorModel> originalAuthors, @required AuthorModel oldAuthor, @required AuthorModel newAuthor}){
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
  static List<String> replaceAuthorIDInAuthorsIDsList({@required List<AuthorModel> originalAuthors, @required AuthorModel oldAuthor, @required AuthorModel newAuthor}){
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
  static String generateAuthorPicID({@required String authorID, @required String bzID}){
    final String _authorPicID = '$authorID---$bzID';
    return _authorPicID;
  }
// -----------------------------------------------------------------------------
  static AuthorModel getAuthorModelFromUserModel({@required UserModel userModel}){
    final AuthorModel _author = AuthorModel(
      userID : userModel.id,
      name : userModel.name,
      pic : userModel.pic,
      title : userModel.title,
      isMaster : false,
      contacts : userModel.contacts,
    );
    return _author;
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> getAuthorsFromAuthorsByAuthorsIDs(List<AuthorModel> allAuthors, List<String> authorsIDs){
    List<AuthorModel> _bzAuthors = <AuthorModel>[];

    if (Mapper.canLoopList(allAuthors) && Mapper.canLoopList(authorsIDs)){

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

    if (Mapper.canLoopList(allBzz)){

      for (BzModel bz in allBzz){

        _allAuthors.addAll(bz.authors);

      }

    }

    return _allAuthors;
  }
// -----------------------------------------------------------------------------
  static AuthorModel dummyAuthor(){
    return null;
  }
// -----------------------------------------------------------------------------
  void printAuthor({String methodName}){

    String _methodName = methodName ?? 'AUTHOR';

    print('$_methodName : PRINTING BZ MODEL ---------------- START -- ');

    print('userID : ${userID}');
    print('name : ${name}');
    print('pic : ${pic}');
    print('title : ${title}');
    print('isMaster : ${isMaster}');
    print('contacts : ${contacts}');

    print('$_methodName : PRINTING BZ MODEL ---------------- END -- ');

  }
// -----------------------------------------------------------------------------
  static AuthorModel getMasterAuthorFromBzModel(BzModel bzModel){
    AuthorModel _masterAuthor = bzModel.authors.firstWhere((author) => author.isMaster == true, orElse: () => null);
    return _masterAuthor;
  }
// -----------------------------------------------------------------------------
}