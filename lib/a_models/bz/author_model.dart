import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
@immutable
class AuthorModel {
  /// --------------------------------------------------------------------------
  const AuthorModel({
    @required this.userID,
    @required this.name,
    @required this.pic,
    @required this.title,
    @required this.isMaster,
    @required this.contacts,
    @required this.flyersIDs,
  });
  /// --------------------------------------------------------------------------
  final String userID;
  final String name;
  final dynamic pic;
  final String title;
  final bool isMaster;
  final List<ContactModel> contacts;
  final List<String> flyersIDs;
// -----------------------------------------------------------------------------

  /// CREATORS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  AuthorModel copyWith({
    String userID,
    String name,
    dynamic pic,
    String title,
    bool isMaster,
    List<ContactModel> contacts,
    List<String> flyersIDs,
}){
    return AuthorModel(
      userID: userID ?? this.userID,
      name: name ?? this.name,
      pic: pic ?? this.pic,
      title: title ?? this.title,
      isMaster: isMaster ?? this.isMaster,
      contacts: contacts ?? this.contacts,
      flyersIDs: flyersIDs ?? this.flyersIDs,
    );
  }
// ----------------------------------
  static AuthorModel createAuthorFromUserModel({
    @required UserModel userModel,
    @required bool isMaster,
  }) {
    final AuthorModel _author = AuthorModel(
      userID: userModel.id,
      name: userModel.name,
      pic: userModel.pic,
      title: userModel.title,
      isMaster: isMaster,
      contacts: userModel.contacts,
      flyersIDs: const <String>[],
    );
    return _author;
  }
// ----------------------------------
  static List<AuthorModel> combineAllBzzAuthors(List<BzModel> allBzz) {
    final List<AuthorModel> _allAuthors = <AuthorModel>[];

    if (Mapper.checkCanLoopList(allBzz)) {
      for (final BzModel bz in allBzz) {
        _allAuthors.addAll(bz.authors);
      }
    }

    return _allAuthors;
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'name': name,
      'pic': pic,
      'title': title,
      'isMaster': isMaster,
      'contacts': ContactModel.cipherContacts(contacts),
      'flyersIDs': flyersIDs,
    };
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel decipherAuthor(Map<String, dynamic> map) {
    return AuthorModel(
      userID: map['userID'],
      name: map['name'],
      pic: map['pic'],
      title: map['title'],
      isMaster: map['isMaster'],
      contacts: ContactModel.decipherContacts(map['contacts']),
      flyersIDs: Mapper.getStringsFromDynamics(dynamics: map['flyersIDs']),
    );
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Map<String, Object> cipherAuthors(List<AuthorModel> authors) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.checkCanLoopList(authors)) {
      for (final AuthorModel author in authors) {
        _map = Mapper.insertPairInMap(
          map: _map,
          key: author.userID,
          value: author.toMap(),
        );
      }
    }

    return _map;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> decipherAuthors(Map<String, dynamic> maps) {
    final List<AuthorModel> _authors = <AuthorModel>[];

    final List<String> _keys = maps.keys.toList();

    if (Mapper.checkCanLoopList(_keys)) {
      for (final String key in _keys) {
        final AuthorModel _author = decipherAuthor(maps[key]);
        _authors.add(_author);
      }
    }

    return _authors;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static int getAuthorGalleryCountFromBzModel({
    @required BzModel bzModel,
    @required AuthorModel author,
    @required List<FlyerModel> bzFlyers
  }) {
    final String _authorID = author.userID;

    final List<String> _authorFlyersIDs = <String>[];

    if (Mapper.checkCanLoopList(_authorFlyersIDs)){
      for (final FlyerModel flyerModel in bzFlyers) {
        if (flyerModel.authorID == _authorID) {
          _authorFlyersIDs.add(flyerModel.id);
        }
      }
    }

    final int _authorGalleryCount = _authorFlyersIDs.length;

    return _authorGalleryCount;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel getAuthorFromBzByAuthorID({
    @required BzModel bz,
    @required String authorID,
  }) {
    final AuthorModel author = bz?.authors?.singleWhere(
        (AuthorModel au) => au?.userID == authorID,
        orElse: () => null);
    return author;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static int getAuthorIndexByAuthorID({
    @required List<AuthorModel> authors,
    @required String authorID,
  }) {
    final int _currentAuthorIndex = authors.indexWhere(
            (AuthorModel au) => authorID == au.userID
    );

    return _currentAuthorIndex;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAuthorsIDsFromAuthors({
    @required List<AuthorModel> authors,
  }) {
    final List<String> _authorsIDs = <String>[];

    for (final AuthorModel author in authors) {
      _authorsIDs.add(author.userID);
    }

    return _authorsIDs;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel getAuthorFromAuthorsByID({
    @required List<AuthorModel> authors,
    @required String authorID,
  }){

    AuthorModel _author;

    if (Mapper.checkCanLoopList(authors) == true){

      final AuthorModel _found = authors.firstWhere(
              (au) => au.userID == authorID, orElse: ()=> null
      );

      _author = _found;

    }

    return _author;
  }
// ----------------------------------
  static List<AuthorModel> getAuthorsFromAuthorsByAuthorsIDs({
    @required List<AuthorModel> allAuthors,
    @required List<String> authorsIDs,
  }) {
    final List<AuthorModel> _bzAuthors = <AuthorModel>[];

    if (Mapper.checkCanLoopList(allAuthors) && Mapper.checkCanLoopList(authorsIDs)) {
      for (final String id in authorsIDs) {
        final AuthorModel _author = allAuthors.singleWhere(
                (AuthorModel author) => author.userID == id,
            orElse: () => null);

        if (_author != null) {
          _bzAuthors.add(_author);
        }
      }
    }

    return _bzAuthors;
  }
// ----------------------------------
  static List<AuthorModel> getMasterAuthorsFromBz(BzModel bzModel) {

    final List<AuthorModel> _masterAuthor = bzModel.authors.where(
            (AuthorModel author) => author.isMaster == true,
        ).toList();

    return _masterAuthor;
  }
// ----------------------------------
  static List<String> getAuthorsNames({
    @required List<AuthorModel> authors
  }){
    final List<String> _names = <String>[];

    if (Mapper.checkCanLoopList(authors) == true){

      for (final AuthorModel author in authors){
        _names.add(author.name);
      }

    }

    return _names;
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static BzModel replaceAuthorModelInBzModel({
    @required BzModel bzModel,
    @required AuthorModel newAuthor,
  }) {

    final List<AuthorModel> _modifiedAuthorsList = replaceAuthorModelInAuthorsListByID(
      authors: bzModel.authors,
      authorToReplace: newAuthor,
    );

    final BzModel _updatedBzModel = bzModel.copyWith(
      authors: _modifiedAuthorsList,
    );

    return _updatedBzModel;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> replaceAuthorModelInAuthorsListByID({
    @required List<AuthorModel> authors,
    @required AuthorModel authorToReplace,
  }) {

    List<AuthorModel> _output = <AuthorModel>[];

    if (Mapper.checkCanLoopList(authors) == true){
      _output = <AuthorModel>[...authors];
    }

    final int _index = getAuthorIndexByAuthorID(
        authors: _output,
        authorID: authorToReplace.userID,
    );

    if (_index != -1){

      _output.removeAt(_index);
      _output.insert(_index, authorToReplace);
    }

    return _output;
  }
// ----------------------------------

  static List<String> replaceAuthorIDInAuthorsIDsList({
    @required List<AuthorModel> originalAuthors,
    @required AuthorModel oldAuthor,
    @required AuthorModel newAuthor
  }) {
    List<String> _modifiedAuthorsIDsList;

    final List<String> _originalAuthorsIDs = getAuthorsIDsFromAuthors(
      authors: originalAuthors,
    );

    // blog('getAuthorsIDsFromAuthors : _originalAuthorsIDs : $_originalAuthorsIDs');

    final int _indexOfOldAuthor = getAuthorIndexByAuthorID(
        authors: originalAuthors,
        authorID: oldAuthor.userID,
    );

    if (_indexOfOldAuthor != -1) {
      _originalAuthorsIDs.removeAt(_indexOfOldAuthor);
      _originalAuthorsIDs.insert(_indexOfOldAuthor, newAuthor.userID);
      _modifiedAuthorsIDsList = _originalAuthorsIDs;
    }

    return _modifiedAuthorsIDsList;
  }
// ----------------------------------
  static List<AuthorModel> addNewUserToAuthors({
    @required List<AuthorModel> authors,
    @required UserModel newUserModel,
  }){

    final List<AuthorModel> _output = <AuthorModel>[...authors];

    if (newUserModel != null){

      final AuthorModel _newAuthor = AuthorModel.createAuthorFromUserModel(
        userModel: newUserModel,
        isMaster: false,
      );

      _output.add(_newAuthor);

    }

    return _output;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> removeAuthorFromAuthors({
    @required List<AuthorModel> authors,
    @required String authorIDToRemove,
  }){

    List<AuthorModel> _output;

    if (Mapper.checkCanLoopList(authors) == true && authorIDToRemove != null){

      _output = <AuthorModel>[...authors];

      final int _index = authors.indexWhere((a) => a.userID == authorIDToRemove);

      if (_index != -1){
        _output.removeAt(_index);
      }
      else {
        _output = null;
      }

    }

    return _output ?? authors;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> addFlyerIDToAuthor({
    @required String flyerID,
    @required String authorID,
    @required List<AuthorModel> authors,
}){

    List<AuthorModel> _output = authors;

    if (
    Mapper.checkCanLoopList(authors) == true
    &&
    flyerID != null
    &&
    authorID != null
    ){

      // blog('addFlyerIDToAuthor : flyerID $flyerID : authorID $authorID : authors count : ${authors.length}');

      final AuthorModel _author = getAuthorFromAuthorsByID(
          authors: authors,
          authorID: authorID
      );

      // blog('addFlyerIDToAuthor : author $authorID flyers was ${_author.flyersIDs} ');

      final List<String> _updatedFlyersIDs = Mapper.putStringInStringsIfAbsent(
          strings: _author.flyersIDs,
          string: flyerID
      );

      // blog('addFlyerIDToAuthor : author $authorID flyers should be $_updatedFlyersIDs ');

      final AuthorModel _updatedAuthor = _author.copyWith(
        flyersIDs: _updatedFlyersIDs,
      );

      // blog('addFlyerIDToAuthor : author $authorID flyers is now ${_updatedAuthor.flyersIDs} ');


      _output = replaceAuthorModelInAuthorsListByID(
          authors: authors,
          authorToReplace: _updatedAuthor,
      );


    }

    return _output;
}
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> removeFlyerIDToAuthor({
    @required String flyerID,
    @required String authorID,
    @required List<AuthorModel> authors,
  }){

    List<AuthorModel> _output = authors;

    if (
    Mapper.checkCanLoopList(authors) == true
        &&
        flyerID != null
        &&
        authorID != null
    ){

      blog('removeFlyerIDToAuthor : flyerID : $flyerID : authorID : $authorID');

      final AuthorModel _author = getAuthorFromAuthorsByID(
          authors: authors,
          authorID: authorID
      );

      blog('removeFlyerIDToAuthor : author flyers was : ${_author.flyersIDs}');

      final List<String> _updatedFlyersIDs = Mapper.removeStringsFromStrings(
          removeFrom: _author.flyersIDs,
          removeThis: <String>[flyerID],
      );

      blog('removeFlyerIDToAuthor : author flyers is : $_updatedFlyersIDs');

      final AuthorModel _updatedAuthor = _author.copyWith(
        flyersIDs: _updatedFlyersIDs,
      );

      _output = replaceAuthorModelInAuthorsListByID(
        authors: authors,
        authorToReplace: _updatedAuthor,
      );

      final bool _authorsAreIdentical = AuthorModel.checkAuthorsListsAreIdentical(
          authors1: authors,
          authors2: _output,
      );

      blog('removeFlyerIDToAuthor : author are identical : $_authorsAreIdentical');


    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// CHECKER

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserIsMasterAuthor({
    @required String userID,
    @required BzModel bzModel,
  }){

    bool _isMaster = false;

    final AuthorModel _author = getAuthorFromBzByAuthorID(
        authorID: userID,
        bz: bzModel,
    );

    if (_author != null){
      _isMaster = _author.isMaster ?? false;
    }

    return _isMaster;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorsListsAreIdentical({
    @required List<AuthorModel> authors1,
    @required List<AuthorModel> authors2
  }){
    bool _output = false;

    if (authors1 == null && authors2 == null){
      _output = true;
    }
    else if (authors1.isEmpty && authors2.isEmpty){
      _output = true;
    }
    else if (authors1 != null && authors2 != null){

      if (authors1.length != authors2.length){
        _output = false;
      }

      else {

        for (int i = 0; i < authors1.length; i++){

          final bool _areIdentical = checkAuthorsAreIdentical(
            author1: authors1[i],
            author2: authors2[i],
          );

          if (_areIdentical == false){
            _output = false;
            break;
          }

          else {
            _output = true;
          }

        }

      }


    }

    return _output;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorsAreIdentical({
    @required AuthorModel author1,
    @required AuthorModel author2,
  }){
    bool _areIdentical = false;

    if (author1 != null && author2 != null){

      if (

      author1.userID == author2.userID &&
      author1.name == author2.name &&
      author1.pic == author2.pic &&
      author1.title == author2.title &&
      author1.isMaster == author2.isMaster &&
      Mapper.checkListsAreTheSame(list1: author1.flyersIDs, list2: author2.flyersIDs) &&
      ContactModel.checkContactsListsAreIdentical(contacts1: author1.contacts, contacts2: author2.contacts)

      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorsContainUserID({
    @required List<AuthorModel> authors,
    @required String userID,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(authors) == true && userID != null){

      final int _index = authors.indexWhere((a) => a.userID == userID);

      if (_index == -1){
        _contains = false;
      }
      else {
        _contains = true;
      }

    }

    return _contains;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorHasFlyers({
    @required AuthorModel author,
  }){
    bool _hasFlyers = false;

    if (author != null){

      _hasFlyers = author.flyersIDs?.isNotEmpty;

    }

    return _hasFlyers;
  }
// -----------------------------------------------------------------------------

  /// GENERATORS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static String generateAuthorPicID({
    @required String authorID,
    @required String bzID
  }) {
    final String _authorPicID = '$authorID---$bzID';
    return _authorPicID;
  }
// ----------------------------------
  static String generateMasterAuthorsNamesString({
    @required BuildContext context,
    @required BzModel bzModel,
}){

    String _string = superPhrase(context, 'phid_account_admin');

    final List<AuthorModel> _masterAuthors = getMasterAuthorsFromBz(bzModel);

    if (Mapper.checkCanLoopList(_masterAuthors) == true){

      final List<String> _names = getAuthorsNames(
        authors: _masterAuthors,
      );

      if (Mapper.checkCanLoopList(_names) == true){

        _string = TextGen.generateStringFromStrings(
          strings: _names,
          stringsSeparator: ' - ',
        );

      }


    }

    return _string;
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel dummyAuthor() {
    return AuthorModel(
      userID: 'author_dummy_id',
      pic: Iconz.dvRageh,
      isMaster: true,
      name: 'Rageh Author',
      contacts: ContactModel.dummyContacts(),
      title: 'The CEO And Founder of this',
      flyersIDs: const <String>[],
    );
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> dummyAuthors() {
    return <AuthorModel>[
      dummyAuthor(),
      dummyAuthor(),
      dummyAuthor(),
      dummyAuthor(),
    ];
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// ----------------------------------
  /// TESTED : WORKS PERFECT
  void blogAuthor({
    String methodName = 'Blogging Author',
  }) {
    final String _methodName = methodName ?? 'AUTHOR';

    blog('$_methodName : PRINTING BZ MODEL ---------------- START -- ');

    blog('userID : $userID');
    blog('name : $name');
    blog('pic : $pic');
    blog('title : $title');
    blog('isMaster : $isMaster');
    blog('contacts : $contacts');
    blog('flyersID : $flyersIDs');

    blog('$_methodName : PRINTING BZ MODEL ---------------- END -- ');
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static void blogAuthors({
    @required List<AuthorModel> authors,
    String methodName,
}){

    if (Mapper.checkCanLoopList(authors) == true){

      for (final AuthorModel author in authors){
        author.blogAuthor(
          methodName: methodName,
        );
      }

    }
    else {
      blog('no Authors to blog here : $methodName');
    }

  }
// -----------------------------------------------------------------------------
}
