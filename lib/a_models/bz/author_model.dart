import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_generators.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class AuthorModel {
  /// --------------------------------------------------------------------------
  AuthorModel({
    this.userID,
    this.name,
    this.pic,
    this.title,
    this.isMaster,
    this.contacts,
  });
  /// --------------------------------------------------------------------------
  final String userID;
  final String name;
  final dynamic pic;
  final String title;
  final bool isMaster;
  final List<ContactModel> contacts;
// -----------------------------------------------------------------------------

  /// CREATORS

// ----------------------------------
  AuthorModel copyWith({
    String userID,
    String name,
    dynamic pic,
    String title,
    bool isMaster,
    List<ContactModel> contacts,
}){
    return AuthorModel(
      userID: userID ?? this.userID,
      name: name ?? this.name,
      pic: pic ?? this.pic,
      title: title ?? this.title,
      isMaster: isMaster ?? this.isMaster,
      contacts: contacts ?? this.contacts,
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
    );
    return _author;
  }
// ----------------------------------
  static List<AuthorModel> combineAllBzzAuthors(List<BzModel> allBzz) {
    final List<AuthorModel> _allAuthors = <AuthorModel>[];

    if (Mapper.canLoopList(allBzz)) {
      for (final BzModel bz in allBzz) {
        _allAuthors.addAll(bz.authors);
      }
    }

    return _allAuthors;
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// ----------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'name': name,
      'pic': pic,
      'title': title,
      'isMaster': isMaster,
      'contacts': ContactModel.cipherContacts(contacts),
    };
  }
// ----------------------------------
  static AuthorModel decipherAuthor(Map<String, dynamic> map) {
    return AuthorModel(
      userID: map['userID'],
      name: map['name'],
      pic: map['pic'],
      title: map['title'],
      isMaster: map['isMaster'],
      contacts: ContactModel.decipherContacts(map['contacts']),
    );
  }
// ----------------------------------
  static Map<String, Object> cipherAuthors(List<AuthorModel> authors) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.canLoopList(authors)) {
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
  static List<AuthorModel> decipherAuthors(Map<String, dynamic> maps) {
    final List<AuthorModel> _authors = <AuthorModel>[];

    final List<String> _keys = maps.keys.toList();

    if (Mapper.canLoopList(_keys)) {
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
  static int getAuthorGalleryCountFromBzModel({
    @required BzModel bzModel,
    @required AuthorModel author,
    @required List<FlyerModel> bzFlyers
  }) {
    final String _authorID = author.userID;

    final List<String> _authorFlyersIDs = <String>[];

    if (Mapper.canLoopList(_authorFlyersIDs)){
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
  static List<String> getAuthorsIDsFromAuthors(List<AuthorModel> authors) {
    final List<String> _authorsIDs = <String>[];

    for (final AuthorModel author in authors) {
      _authorsIDs.add(author.userID);
    }

    return _authorsIDs;
  }
// ----------------------------------
  static List<AuthorModel> getAuthorsFromAuthorsByAuthorsIDs({
    @required List<AuthorModel> allAuthors,
    @required List<String> authorsIDs,
  }) {
    final List<AuthorModel> _bzAuthors = <AuthorModel>[];

    if (Mapper.canLoopList(allAuthors) && Mapper.canLoopList(authorsIDs)) {
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
        );

    return _masterAuthor;
  }
// ----------------------------------
  static List<String> getAuthorsNames({List<AuthorModel> authors}){
    final List<String> _names = <String>[];

    if (Mapper.canLoopList(authors) == true){

      for (final AuthorModel author in authors){
        _names.add(author.name);
      }

    }

    return _names;
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// ----------------------------------
  static BzModel replaceAuthorModelInBzModel({
    @required BzModel bzModel,
    @required AuthorModel oldAuthor,
    @required AuthorModel newAuthor
  }) {

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
      id: bzModel.id,
      bzTypes: bzModel.bzTypes,
      bzForm: bzModel.bzForm,
      createdAt: bzModel.createdAt,
      accountType: bzModel.accountType,
      name: bzModel.name,
      trigram: bzModel.trigram,
      logo: bzModel.logo,
      scope: bzModel.scope,
      zone: bzModel.zone,
      about: bzModel.about,
      position: bzModel.position,
      contacts: bzModel.contacts,
      authors: _modifiedAuthorsList,
      showsTeam: bzModel.showsTeam,
      isVerified: bzModel.isVerified,
      bzState: bzModel.bzState,
      totalFollowers: bzModel.totalFollowers,
      totalSaves: bzModel.totalSaves,
      totalShares: bzModel.totalShares,
      totalSlides: bzModel.totalSlides,
      totalViews: bzModel.totalViews,
      totalCalls: bzModel.totalCalls,
      flyersIDs: bzModel.flyersIDs,
      totalFlyers: bzModel.totalFlyers,
    );
  }
// -----------------------------------------------------------------------------
  static List<AuthorModel> replaceAuthorModelInAuthorsList({
    @required List<AuthorModel> originalAuthors,
    @required AuthorModel oldAuthor,
    @required AuthorModel newAuthor
  }) {
    List<AuthorModel> _modifiedAuthorsList;

    final List<AuthorModel> _originalAuthors = originalAuthors;

    final int _indexOfOldAuthor = getAuthorIndexByAuthorID(
        authors: _originalAuthors,
        authorID: oldAuthor.userID,
    );

    if (_indexOfOldAuthor != -1) {
      _originalAuthors.removeAt(_indexOfOldAuthor);
      _originalAuthors.insert(_indexOfOldAuthor, newAuthor);
      _modifiedAuthorsList = _originalAuthors;
    }

    return _modifiedAuthorsList;
  }
// -----------------------------------------------------------------------------
  static List<String> replaceAuthorIDInAuthorsIDsList({
    @required List<AuthorModel> originalAuthors,
    @required AuthorModel oldAuthor,
    @required AuthorModel newAuthor
  }) {
    List<String> _modifiedAuthorsIDsList;

    final List<String> _originalAuthorsIDs = getAuthorsIDsFromAuthors(originalAuthors);

    blog('getAuthorsIDsFromAuthors : _originalAuthorsIDs : $_originalAuthorsIDs');

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
// -----------------------------------------------------------------------------

  /// MODIFIERS

// ----------------------------------
  static bool userIsMasterAuthor({
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
// -----------------------------------------------------------------------------

  /// GENERATORS

// ----------------------------------
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

    if (Mapper.canLoopList(_masterAuthors) == true){

      final List<String> _names = getAuthorsNames(
        authors: _masterAuthors,
      );

      if (Mapper.canLoopList(_names) == true){

        _string = generateStringFromStrings(
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
  static AuthorModel dummyAuthor() {
    return AuthorModel(
      userID: 'author_dummy_id',
      pic: Iconz.dvRageh,
      isMaster: true,
      name: 'Rageh Author',
      contacts: [],
      title: 'The CEO And Founder of this'
    );
  }
// -----------------------------------------------------------------------------
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
  void blogAuthor({String methodName}) {
    final String _methodName = methodName ?? 'AUTHOR';

    blog('$_methodName : PRINTING BZ MODEL ---------------- START -- ');

    blog('userID : $userID');
    blog('name : $name');
    blog('pic : $pic');
    blog('title : $title');
    blog('isMaster : $isMaster');
    blog('contacts : $contacts');

    blog('$_methodName : PRINTING BZ MODEL ---------------- END -- ');
  }
// -----------------------------------------------------------------------------
}
