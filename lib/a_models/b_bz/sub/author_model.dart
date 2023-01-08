import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
/// => TAAMAM
@immutable
class AuthorModel {
  /// --------------------------------------------------------------------------
  const AuthorModel({
    @required this.userID,
    @required this.name,
    @required this.picPath,
    @required this.title,
    @required this.role,
    @required this.contacts,
    @required this.flyersIDs,
    this.picModel,
  });
  /// --------------------------------------------------------------------------
  final String userID;
  final String name;
  final String picPath;
  final String title;
  final AuthorRole role;
  final List<ContactModel> contacts;
  final List<String> flyersIDs;
  final PicModel picModel;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthorModel> prepareAuthorForEditing({
    @required AuthorModel oldAuthor,
    @required BzModel bzModel,
  }) async {

    final AuthorModel _tempAuthor = oldAuthor.copyWith(
      picModel: await PicProtocols.fetchPic(oldAuthor.picPath),
      contacts: ContactModel.prepareContactsForEditing(
        contacts: oldAuthor.contacts,
        countryID: bzModel.zone.countryID,
      ),
    );

    return _tempAuthor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel bakeEditorVariablesToUpload({
    @required AuthorModel draftAuthor,
    @required AuthorModel oldAuthor,
    @required BzModel bzModel,
  }){

    return draftAuthor.copyWith(
      contacts: ContactModel.bakeContactsAfterEditing(
        contacts: draftAuthor.contacts,
        countryID: bzModel.zone.countryID,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  AuthorModel copyWith({
    String userID,
    String name,
    String picPath,
    String title,
    AuthorRole role,
    List<ContactModel> contacts,
    List<String> flyersIDs,
    PicModel picModel,
  }){
    return AuthorModel(
      userID: userID ?? this.userID,
      name: name ?? this.name,
      picPath: picPath ?? this.picPath,
      title: title ?? this.title,
      role: role ?? this.role,
      contacts: contacts ?? this.contacts,
      flyersIDs: flyersIDs ?? this.flyersIDs,
      picModel: picModel ?? this.picModel,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthorModel> createAuthorFromUserModel({
    @required UserModel userModel,
    @required String bzID,
    @required bool isCreator,
  }) async {

    final PicModel _userPic = await PicProtocols.fetchPic(Storage.generateUserPicPath(userModel.id));

    final AuthorModel _author = AuthorModel(
      userID: userModel.id,
      name: userModel.name,
      picPath: Storage.generateAuthorPicPath(bzID: bzID, authorID: userModel.id),
      title: userModel.title,
      role: isCreator ? AuthorRole.creator : AuthorRole.teamMember,
      contacts: userModel.contacts,
      flyersIDs: const <String>[],
      picModel: _userPic.copyWith(
        path: Storage.generateAuthorPicPath(
          bzID: bzID,
          authorID: userModel.id,
        ),
      ),
    );

    return _author;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    bool includePicModel = false,
  }) {

    Map<String, dynamic> _map =  <String, dynamic>{
      'userID': userID,
      'name': name,
      'picPath': picPath,
      'title': title,
      'role': cipherAuthorRole(role),
      'contacts': ContactModel.cipherContacts(contacts),
      'flyersIDs': flyersIDs,
    };

    if (includePicModel == true){

      _map = Mapper.insertPairInMap(
          map: _map,
          key: 'picModel',
          value: PicModel.cipherToLDB(picModel),
      );

    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel decipherAuthor(Map<String, dynamic> map) {
    return AuthorModel(
      userID: map['userID'],
      name: map['name'],
      picPath: map['picPath'],
      title: map['title'],
      role: decipherAuthorRole(map['role']),
      contacts: ContactModel.decipherContacts(map['contacts']),
      flyersIDs: Stringer.getStringsFromDynamics(dynamics: map['flyersIDs']),
      picModel: PicModel.decipherFromLDB(map['picModel']),
    );
  }
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> decipherAuthors(Map<String, dynamic> maps) {
    final List<AuthorModel> _authors = <AuthorModel>[];

    if (maps != null){

      final List<String> _keys = maps.keys.toList();

      if (Mapper.checkCanLoopList(_keys)) {
        for (final String key in _keys) {
          final AuthorModel _author = decipherAuthor(maps[key]);
          _authors.add(_author);
        }
      }

    }

    return _authors;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherAuthorRole(AuthorRole role){
    switch (role){
      case AuthorRole.creator: return 'creator'; break;
      case AuthorRole.moderator: return 'moderator'; break;
      case AuthorRole.teamMember: return 'teamMember'; break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorRole decipherAuthorRole(String role){
    switch (role){
      case 'creator'     : return AuthorRole.creator   ; break;
      case 'moderator'   : return AuthorRole.moderator ; break;
      case 'teamMember'  : return AuthorRole.teamMember; break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static AuthorModel getAuthorWhosePicIsFile({
    @required List<AuthorModel> authors,
  }){
    AuthorModel _output;

    if (Mapper.checkCanLoopList(authors) == true){

      _output = authors.firstWhere(
              (element) => ObjectCheck.objectIsFile(element.pic) == true,
          orElse: () => null
      );

    }

    return _output;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAuthorPicOwnersIDs({
    @required BzModel bzModel,
    @required AuthorModel authorModel,
  }){

    /// NOTE : GETS ONLY THE CREATOR ID AND THE AUTHOR ID IF NOT IDNETICAL

    List<String> _ownersIDs = <String>[];

    if (bzModel != null && authorModel != null){

      final AuthorModel _creatorAuthor = getCreatorAuthorFromAuthors(bzModel.authors);

      _ownersIDs.add(_creatorAuthor.userID);

      _ownersIDs = Stringer.addStringToListIfDoesNotContainIt(
        strings: _ownersIDs,
        stringToAdd: authorModel.userID,
      );

    }

    return _ownersIDs;
  }
  // --------------------
  /// DEPRECATED
  /*
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

   */
  // --------------------
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
  // --------------------
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
  // --------------------
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
  // --------------------
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
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel getCreatorAuthorFromAuthors(List<AuthorModel> authors) {

    if (Mapper.checkCanLoopList(authors) == true){

      final AuthorModel _masterAuthor = authors.firstWhere(
              (AuthorModel author) => author.role == AuthorRole.creator,
          orElse: () => null
      );

      return _masterAuthor;
    }
    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel getFlyerAuthor({
    @required List<AuthorModel> authors,
    @required String flyerID,
  }){

    AuthorModel _author;

    if (Mapper.checkCanLoopList(authors) == true){

      _author = authors.firstWhere((AuthorModel authorModel){

        final bool _found = Stringer.checkStringsContainString(
          strings: authorModel.flyersIDs,
          string: flyerID,
        );

        return _found;
      });

    }

    return _author;
  }
  // --------------------
  /*
  static List<PicModel> getPicModels(List<AuthorModel> authors){
    final List<PicModel> _output = <PicModel>[];

    if (Mapper.checkCanLoopList(authors) == true){

      for (final AuthorModel author in authors){

        if (author.picModel != null){
          _output.add(author.picModel);
        }

      }

    }

    return _output;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAuthorsPicsPaths(List<AuthorModel> authors){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(authors) == true){

      for (final AuthorModel author in authors){

        if (author.picModel != null){
          _output.add(author.picPath);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel replaceAuthorModelInBzModel({
    @required BzModel oldBz,
    @required AuthorModel newAuthor,
  }) {

    final List<AuthorModel> _modifiedAuthorsList = replaceAuthorModelInAuthorsListByID(
      authors: oldBz.authors,
      authorToReplace: newAuthor,
    );

    final BzModel _newBz = oldBz.copyWith(
      authors: _modifiedAuthorsList,
    );

    return _newBz;
  }
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AuthorModel>> addNewUserToAuthors({
    @required List<AuthorModel> authors,
    @required UserModel newUser,
    @required String bzID,
  }) async {

    final List<AuthorModel> _output = <AuthorModel>[...authors];

    if (newUser != null){

      final AuthorModel _newAuthor = await AuthorModel.createAuthorFromUserModel(
        userModel: newUser,
        bzID: bzID,
        isCreator: false,
      );

      _output.add(_newAuthor);

    }

    return _output;
  }
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> addFlyerIDToAuthor({
    @required String flyerID,
    @required String authorID,
    @required List<AuthorModel> oldAuthors,
  }){

    List<AuthorModel> _output = oldAuthors;

    if (
    Mapper.checkCanLoopList(oldAuthors) == true
        &&
        flyerID != null
        &&
        authorID != null
    ){

      // blog('addFlyerIDToAuthor : flyerID $flyerID : authorID $authorID : authors count : ${authors.length}');

      final AuthorModel _oldAuthor = getAuthorFromAuthorsByID(
          authors: oldAuthors,
          authorID: authorID
      );

      // blog('addFlyerIDToAuthor : author $authorID flyers was ${_oldAuthor.flyersIDs} ');

      final List<String> _newFlyersIDs = Stringer.putStringInStringsIfAbsent(
          strings: _oldAuthor.flyersIDs,
          string: flyerID
      );

      // blog('addFlyerIDToAuthor : author $authorID flyers should be $_newFlyersIDs ');

      final AuthorModel _newAuthor = _oldAuthor.copyWith(
        flyersIDs: _newFlyersIDs,
      );

      // blog('addFlyerIDToAuthor : author $authorID flyers is now ${_newAuthor.flyersIDs} ');


      _output = replaceAuthorModelInAuthorsListByID(
        authors: oldAuthors,
        authorToReplace: _newAuthor,
      );


    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> removeFlyerIDFromAuthor({
    @required String flyerID,
    @required String authorID,
    @required List<AuthorModel> oldAuthors,
  }){

    List<AuthorModel> _newAuthors = oldAuthors;

    if (
        Mapper.checkCanLoopList(oldAuthors) == true
        &&
        flyerID != null
        &&
        authorID != null
    ){

      blog('removeFlyerIDToAuthor : flyerID : $flyerID : authorID : $authorID');

      final AuthorModel _oldAuthor = getAuthorFromAuthorsByID(
          authors: oldAuthors,
          authorID: authorID
      );

      blog('removeFlyerIDToAuthor : author flyers was : ${_oldAuthor.flyersIDs}');

      final List<String> _updatedFlyersIDs = Stringer.removeStringsFromStrings(
        removeFrom: _oldAuthor.flyersIDs,
        removeThis: <String>[flyerID],
      );

      blog('removeFlyerIDToAuthor : author flyers is : $_updatedFlyersIDs');

      final AuthorModel _newAuthor = _oldAuthor.copyWith(
        flyersIDs: _updatedFlyersIDs,
      );

      _newAuthors = replaceAuthorModelInAuthorsListByID(
        authors: oldAuthors,
        authorToReplace: _newAuthor,
      );

      final bool _authorsAreIdentical = AuthorModel.checkAuthorsListsAreIdentical(
        authors1: oldAuthors,
        authors2: _newAuthors,
      );

      blog('removeFlyerIDToAuthor : author are identical : $_authorsAreIdentical');

    }

    return _newAuthors;
  }
  // --------------------
  /*
  static List<AuthorModel> removeFlyerIDFromAuthors({
    @required String flyerID,
    @required List<AuthorModel> authors,
  }){

    List<AuthorModel> _output = authors;

    if (flyerID != null && Mapper.checkCanLoopList(authors) == true){

      final AuthorModel _ownerOfFlyer = getFlyerAuthor(
        authors: authors,
        flyerID: flyerID,
      );

      if (_ownerOfFlyer != null){

        _output = AuthorModel.removeFlyerIDFromAuthor(
            flyerID: flyerID,
            authorID: _ownerOfFlyer.userID,
            authors: authors
        );

      }

    }

    return _output;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> overrideAuthorsBzID({
    @required List<AuthorModel> authors,
    @required String bzID,
  }){
    final List<AuthorModel> _output = <AuthorModel>[];

    if (Mapper.checkCanLoopList(authors) == true){

      for (final AuthorModel author in authors){

        final String _picPath = Storage.generateAuthorPicPath(
          bzID: bzID,
          authorID: author.userID,
        );

        final AuthorModel _overridden = author.copyWith(
          picPath: _picPath,
          picModel: author.picModel?.copyWith(
            path: _picPath,
          ),
        );

        _output.add(_overridden);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserIsCreatorAuthor({
    @required String userID,
    @required BzModel bzModel,
  }){

    bool _isCreator = false;

    final AuthorModel _author = getAuthorFromBzByAuthorID(
      authorID: userID,
      bz: bzModel,
    );

    if (_author != null){
      _isCreator = _author.role == AuthorRole.creator;
    }

    return _isCreator;
  }
  // --------------------
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
  // --------------------
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
          author1.picPath == author2.picPath &&
          author1.title == author2.title &&
          author1.role == author2.role &&
          Mapper.checkListsAreIdentical(
            list1: author1.flyersIDs,
            list2: author2.flyersIDs,
          ) == true &&
          ContactModel.checkContactsListsAreIdentical(
            contacts1: author1.contacts,
            contacts2: author2.contacts,
          ) == true &&
          PicModel.checkPicsAreIdentical(
              pic1: author1.picModel,
              pic2: author2.picModel
          ) == true

      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------
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
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkImCreatorInThisBz({
    @required BzModel bzModel,
  }){
    bool _imCreator = false;

    if (bzModel != null){

      final AuthorModel _myAuthorModel = getAuthorFromBzByAuthorID(
        bz: bzModel,
        authorID: AuthFireOps.superUserID(),
      );

      if (_myAuthorModel != null){
        _imCreator = _myAuthorModel.role == AuthorRole.creator;
      }

    }

    return _imCreator;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkImAuthorInBzOfThisFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
  }){

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    return Stringer.checkStringsContainString(
      strings: _myUserModel?.myBzzIDs,
      string: flyerModel.bzID,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkUserImageIsAuthorImage({
    @required  BuildContext context,
    @required AuthorModel authorModel,
    @required UserModel userModel,
  }) async {
    bool _areIdentical = false;

    if (authorModel != null && userModel != null){

      if (authorModel.userID == userModel.id){
        _areIdentical = authorModel.picPath == userModel.picPath;
      }

    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorCanDeleteFlyer({
    @required String myID,
    @required FlyerModel flyer,
    @required BzModel bzModel,
  }){
    bool _canDelete = false;

    if (flyer != null && bzModel != null && myID != null){

      final bool _thisIsMyFlyer = flyer.authorID == myID;

      if (_thisIsMyFlyer == true){
        _canDelete = true;
      }

      else {

        final bool _iHaveHigherRankThanFlyerAuthor = checkAuthorHasHigherRank(
          theDoer: getAuthorFromBzByAuthorID(bz: bzModel, authorID: myID),
          theDoneWith: getAuthorFromBzByAuthorID(bz: bzModel, authorID: flyer.authorID),
        );

        if (_iHaveHigherRankThanFlyerAuthor == true){
          _canDelete = true;
        }

      }

    }

    return _canDelete;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserIsAuthorInThisBz({
    @required String bzID,
    @required UserModel userModel,
  }){
    bool _isAuthor = false;

    if (bzID != null && userModel != null){

      _isAuthor = Stringer.checkStringsContainString(
          strings: userModel.myBzzIDs,
          string: bzID,
      );

    }

    return _isAuthor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkImALoneAuthor({
    @required BuildContext context,
    @required String bzID,
  }) async {
    bool _aLoneAuthor;

    if (bzID != null){

      final BzModel _bzModel = await BzProtocols.fetchBz(context: context, bzID: bzID);
      _aLoneAuthor = _bzModel?.authors?.length == 1;

    }

    return _aLoneAuthor;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// DEPRECATED
  static String generateAuthorPicID({
    @required String authorID,
    @required String bzID
  }) {
    final String _authorPicID = '$authorID---$bzID';
    return _authorPicID;
  }
  // --------------------
  /*
  static String generateMasterAuthorsNamesString({
    @required BuildContext context,
    @required BzModel bzModel,
}){

    String _string = superPhrase(context, 'phid_account_admin');

    final List<AuthorModel> _masterAuthors = getCreatorAuthorsFromBz(bzModel);

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
   */
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel dummyAuthor() {
    return AuthorModel(
      userID: 'author_dummy_id',
      picPath: Iconz.dvRageh,
      role: AuthorRole.creator,
      name: 'Rageh Author',
      contacts: ContactModel.dummyContacts(),
      title: 'The CEO And Founder of this',
      flyersIDs: const <String>[],
    );
  }
  // --------------------
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

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogAuthor({
    String invoker = '',
  }) {

    blog('$invoker : BLOGGING AUTHOR ---------------- START -- ');

    blog('userID : $userID');
    blog('name : $name');
    blog('pic : $picPath');
    blog('title : $title');
    blog('role : $role');
    blog('contacts : $contacts');
    blog('flyersID : $flyersIDs');

    blog('$invoker : BLOGGING AUTHOR ---------------- END -- ');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogAuthors({
    @required List<AuthorModel> authors,
    String invoker,
  }){

    if (Mapper.checkCanLoopList(authors) == true){

      for (final AuthorModel author in authors){
        author.blogAuthor(
          invoker: invoker,
        );
      }

    }
    else {
      blog('no Authors to blog here : $invoker');
    }

  }
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getAuthorRolePhid({
    @required BuildContext context,
    @required AuthorRole role,
  }){
    switch (role){
      case AuthorRole.creator: return 'phid_creator'; break;
      case AuthorRole.moderator: return 'phid_moderator'; break;
      case AuthorRole.teamMember: return 'phid_teamMember'; break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// AUTHOR ROLES

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorAbility({
    @required AuthorModel theDoer,
    @required AuthorModel theDoneWith,
    @required AuthorAbility ability,
  }){

    final bool _higherRank = checkAuthorHasHigherRank(
      theDoer: theDoer,
      theDoneWith: theDoneWith,
    );

    final bool _sameRank = checkAuthorHasSameRank(
        theDoer: theDoer,
        theDoneWith: theDoneWith
    );

    switch (theDoer.role){
    /// CREATOR -------------
      case AuthorRole.creator:
        switch (ability) {
          case AuthorAbility.canChangeOthersRoles :     return true; break;
          case AuthorAbility.canChangeSelfRole :        return false; break;
          case AuthorAbility.canEditOtherAuthor :       return true; break;
          case AuthorAbility.canRemoveOtherAuthor :     return true; break;
          case AuthorAbility.canSendAuthorships :       return true; break;
          case AuthorAbility.canRemoveSelf :            return false; break;
          default: return false;
        } break;
    /// MODERATOR -------------
      case AuthorRole.moderator:
        switch (ability) {
          case AuthorAbility.canChangeOthersRoles :     return _higherRank; break;
          case AuthorAbility.canChangeSelfRole :        return true; break;
          case AuthorAbility.canEditOtherAuthor :       return _higherRank || _sameRank; break;
          case AuthorAbility.canRemoveOtherAuthor :     return false; break;
          case AuthorAbility.canSendAuthorships :       return true; break;
          case AuthorAbility.canRemoveSelf :            return true; break;
          default: return false;
        } break;
    /// TEAM MEMBER -------------
      case AuthorRole.teamMember:
        switch (ability) {
          case AuthorAbility.canChangeOthersRoles :     return _higherRank; break;
          case AuthorAbility.canChangeSelfRole :        return true; break;
          case AuthorAbility.canEditOtherAuthor :       return _higherRank || _sameRank; break;
          case AuthorAbility.canRemoveOtherAuthor :     return false; break;
          case AuthorAbility.canSendAuthorships :       return false; break;
          case AuthorAbility.canRemoveSelf :            return true; break;
          default: return false;
        } break;
    /// DEFAULT -------------
      default: return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorHasHigherRank({
    @required AuthorModel theDoer, // the current user doing stuff
    @required AuthorModel theDoneWith, // the author whos done with
  }){

    bool _hasHigherRank = false;

    if (theDoer != null && theDoneWith != null){

      final int _doerRank = getRoleRank(theDoer.role);
      final int _theDoneWithRank = getRoleRank(theDoneWith.role);

      _hasHigherRank = _doerRank > _theDoneWithRank;

    }

    return _hasHigherRank;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorHasSameRank({
    @required AuthorModel theDoer, // the current user doing stuff
    @required AuthorModel theDoneWith, // the author whos done with
  }){

    bool _hasHigherRank = false;

    if (theDoer != null && theDoneWith != null){

      final int _doerRank = getRoleRank(theDoer.role);
      final int _theDoneWithRank = getRoleRank(theDoneWith.role);

      _hasHigherRank = _doerRank == _theDoneWithRank;

    }

    return _hasHigherRank;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getRoleRank(AuthorRole role){

    switch (role){
      case AuthorRole.creator: return 3; break;
      case AuthorRole.moderator: return 2; break;
      case AuthorRole.teamMember: return 1; break;
      default: return 0;
    }

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is AuthorModel){
      _areIdentical = checkAuthorsAreIdentical(
        author1: this,
        author2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      userID.hashCode^
      name.hashCode^
      picPath.hashCode^
      title.hashCode^
      role.hashCode^
      contacts.hashCode^
      flyersIDs.hashCode;
// -----------------------------------------------------------------------------
}

enum AuthorRole {
  creator,
  moderator,
  teamMember,
}

enum AuthorAbility {
  canChangeOthersRoles,
  canChangeSelfRole,
  canEditOtherAuthor,
  // canEditSelf, // keda keda
  canRemoveOtherAuthor,
  canSendAuthorships,
  canRemoveSelf,
}
