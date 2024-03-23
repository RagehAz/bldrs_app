import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:collection/collection.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/media_protocols/protocols/media_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/stringer.dart';
/// => TAMAM
@immutable
class AuthorModel {
  /// --------------------------------------------------------------------------
  const AuthorModel({
    required this.userID,
    required this.name,
    required this.picPath,
    required this.title,
    required this.role,
    required this.contacts,
    required this.flyersIDs,
    this.picModel,
  });
  /// --------------------------------------------------------------------------
  final String? userID;
  final String? name;
  final String? picPath;
  final String? title;
  final AuthorRole? role;
  final List<ContactModel>? contacts;
  final List<String>? flyersIDs;
  final MediaModel? picModel;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AuthorModel?> prepareAuthorForEditing({
    required AuthorModel? oldAuthor,
    required BzModel? bzModel,
  }) async {

    final AuthorModel? _tempAuthor = oldAuthor?.copyWith(
      picModel: await MediaProtocols.fetchMedia(oldAuthor.picPath),
      contacts: ContactModel.prepareContactsForEditing(
        contacts: oldAuthor.contacts,
        countryID: bzModel?.zone?.countryID,
      ),
    );

    return _tempAuthor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel? bakeEditorVariablesToUpload({
    required AuthorModel? draftAuthor,
    required AuthorModel? oldAuthor,
    required BzModel? bzModel,
  }){

    return draftAuthor?.copyWith(
      contacts: ContactModel.bakeContactsAfterEditing(
        contacts: draftAuthor.contacts,
        countryID: bzModel?.zone?.countryID,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  AuthorModel copyWith({
    String? userID,
    String? name,
    String? picPath,
    String? title,
    AuthorRole? role,
    List<ContactModel>? contacts,
    List<String>? flyersIDs,
    MediaModel? picModel,
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
  static Future<AuthorModel?> createAuthorFromUserModel({
    required UserModel? userModel,
    required String? bzID,
    required bool isCreator,
  }) async {
    AuthorModel? _author;

    if (userModel != null) {

      final MediaModel? _userPic = await MediaProtocols.fetchMedia(
          StoragePath.users_userID_pic(userModel.id)
      );

      _author = AuthorModel(
        userID: userModel.id,
        name: userModel.name,
        picPath: StoragePath.bzz_bzID_authorID(bzID: bzID, authorID: userModel.id),
        title: 'Bldr',
        role: isCreator ? AuthorRole.creator : AuthorRole.teamMember,
        contacts: userModel.contacts,
        flyersIDs: const <String>[],
        picModel: _userPic?.overrideUploadPath(
          uploadPath: StoragePath.bzz_bzID_authorID(
            bzID: bzID,
            authorID: userModel.id,
          ),
        ),
      );

    }

    return _author;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> combineAllBzzAuthors(List<BzModel> allBzz) {
    final List<AuthorModel> _allAuthors = <AuthorModel>[];

    if (Lister.checkCanLoop(allBzz) == true) {
      for (final BzModel bz in allBzz) {
        if (Lister.checkCanLoop(bz.authors) == true){
          _allAuthors.addAll(bz.authors!);
        }
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
        value: MediaModel.cipherToLDB(picModel),
        overrideExisting: true,
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
      flyersIDs: Stringer.getStringsFromDynamics(map['flyersIDs']),
      picModel: MediaModel.decipherFromLDB(map['picModel']),
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherAuthors(List<AuthorModel>? authors) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Lister.checkCanLoop(authors) == true) {
      for (final AuthorModel author in authors!) {
        _map = Mapper.insertPairInMap(
          map: _map,
          key: author.userID,
          value: author.toMap(),
          overrideExisting: true,
        );
      }
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel> decipherAuthors(Map<String, dynamic>? maps) {
    final List<AuthorModel> _authors = <AuthorModel>[];

    if (maps != null){

      final List<String> _keys = maps.keys.toList();

      if (Lister.checkCanLoop(_keys)) {
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
  static String? cipherAuthorRole(AuthorRole? role){
    switch (role){
      case AuthorRole.creator: return 'creator';
      case AuthorRole.moderator: return 'moderator';
      case AuthorRole.teamMember: return 'teamMember';
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorRole? decipherAuthorRole(String? role){
    switch (role){
      case 'creator'     : return AuthorRole.creator   ;
      case 'moderator'   : return AuthorRole.moderator ;
      case 'teamMember'  : return AuthorRole.teamMember;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAuthorPicOwnersIDs({
    required BzModel? bzModel,
    required AuthorModel? authorModel,
  }){

    /// NOTE : GETS ONLY THE CREATOR ID AND THE AUTHOR ID IF NOT IDNETICAL

    List<String> _ownersIDs = <String>[];

    if (bzModel != null && authorModel != null){

      final AuthorModel? _creatorAuthor = getCreatorAuthorFromAuthors(bzModel.authors);

      if (_creatorAuthor?.userID != null){
        _ownersIDs.add(_creatorAuthor!.userID!);
      }

      _ownersIDs = Stringer.addStringToListIfDoesNotContainIt(
        strings: _ownersIDs,
        stringToAdd: authorModel.userID,
      );

    }

    return _ownersIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllFlyersIDs({
    required List<AuthorModel>? authors,
  }){
    final List<String> _output = [];

    if (Lister.checkCanLoop(authors) == true){
      for (final AuthorModel author in authors!){
        _output.addAll(author.flyersIDs??[]);
      }

    }

    return _output;
  }
  // --------------------
  /// DEPRECATED
  /*
  /// TESTED : WORKS PERFECT
  static int getAuthorGalleryCountFromBzModel({
    required BzModel bzModel,
    required AuthorModel author,
    required List<FlyerModel> bzFlyers
  }) {
    final String _authorID = author.userID;

    final List<String> _authorFlyersIDs = <String>[];

    if (Lister.checkCanLoop(_authorFlyersIDs)){
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
  static AuthorModel? getAuthorFromBzByAuthorID({
    required BzModel? bz,
    required String? authorID,
  }) {
    final AuthorModel? author = bz?.authors?.singleWhereOrNull(
            (AuthorModel au) => au.userID == authorID,
        );
    return author;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getAuthorIndexByAuthorID({
    required List<AuthorModel> authors,
    required String? authorID,
  }) {
    final int _currentAuthorIndex = authors.indexWhere(
            (AuthorModel au) => authorID == au.userID
    );

    return _currentAuthorIndex;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAuthorsIDsFromAuthors({
    required List<AuthorModel>? authors,
  }) {
    final List<String> _authorsIDs = <String>[];

    if (Lister.checkCanLoop(authors) == true) {
      for (final AuthorModel author in authors!) {
        if (author.userID != null) {
          _authorsIDs.add(author.userID!);
        }
      }
    }

    return _authorsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel? getAuthorFromAuthorsByID({
    required List<AuthorModel>? authors,
    required String? authorID,
  }){

    AuthorModel? _author;

    if (Lister.checkCanLoop(authors) == true){
      _author = authors!.firstWhereOrNull((au) => au.userID == authorID);
    }

    return _author;
  }
  // --------------------
  static List<AuthorModel> getAuthorsFromAuthorsByAuthorsIDs({
    required List<AuthorModel>? allAuthors,
    required List<String>? authorsIDs,
  }) {
    final List<AuthorModel> _bzAuthors = <AuthorModel>[];

    if (
        Lister.checkCanLoop(allAuthors) == true
        &&
        Lister.checkCanLoop(authorsIDs) == true
    ) {

      for (final String id in authorsIDs!) {

        final AuthorModel? _author = allAuthors!.singleWhereOrNull(
                (AuthorModel author) => author.userID == id);

        if (_author != null) {
          _bzAuthors.add(_author);
        }

      }
    }

    return _bzAuthors;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel? getCreatorAuthorFromAuthors(List<AuthorModel>? authors) {
    return authors?.firstWhereOrNull((AuthorModel author) => author.role == AuthorRole.creator,);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAuthorsNames({
    required List<AuthorModel> authors
  }){
    final List<String> _names = <String>[];

    if (Lister.checkCanLoop(authors) == true){

      for (final AuthorModel author in authors){
        if (author.name != null){
          _names.add(author.name!);
        }
      }

    }

    return _names;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthorModel? getFlyerAuthor({
    required List<AuthorModel> authors,
    required String flyerID,
  }){
    AuthorModel? _author;

    if (Lister.checkCanLoop(authors) == true){

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

    if (Lister.checkCanLoop(authors) == true){

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
  static List<String> getAuthorsPicsPaths(List<AuthorModel>? authors){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(authors) == true){

      for (final AuthorModel author in authors!){

        if (author.picModel != null && author.picPath != null){
          _output.add(author.picPath!);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> getAuthorIDFromBzByContact({
    required String? bzID,
    required String? contact,
  }) async {
  String? _output;

  final BzModel? _bzModel = await BzProtocols.fetchBz(
    bzID: bzID,
  );

  if (_bzModel != null){

    final List<AuthorModel> _authors = _bzModel.authors ?? [];

    for (final AuthorModel author in _authors){

      final List<ContactModel> _contacts = author.contacts ?? [];

      for (final ContactModel con in _contacts){

        if (con.value == contact){
          _output = author.userID;
          break;
        }

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
    required BzModel oldBz,
    required AuthorModel newAuthor,
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
    required List<AuthorModel>? authors,
    required AuthorModel? authorToReplace,
  }) {

    List<AuthorModel> _output = <AuthorModel>[];

    if (Lister.checkCanLoop(authors) == true){
      _output = <AuthorModel>[...authors!];
    }

    final int _index = getAuthorIndexByAuthorID(
      authors: _output,
      authorID: authorToReplace?.userID,
    );

    if (_index != -1 && authorToReplace != null){

      _output.removeAt(_index);
      _output.insert(_index, authorToReplace);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String>? replaceAuthorIDInAuthorsIDsList({
    required List<AuthorModel> originalAuthors,
    required AuthorModel oldAuthor,
    required AuthorModel newAuthor
  }) {
    List<String>? _modifiedAuthorsIDsList;

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
      _originalAuthorsIDs.insert(_indexOfOldAuthor, newAuthor.userID!);
      _modifiedAuthorsIDsList = _originalAuthorsIDs;
    }

    return _modifiedAuthorsIDsList;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<AuthorModel>> addNewUserToAuthors({
    required List<AuthorModel>? authors,
    required UserModel? newUser,
    required String bzID,
  }) async {

    final List<AuthorModel> _output = <AuthorModel>[...?authors];

    if (newUser != null){

      final AuthorModel? _newAuthor = await AuthorModel.createAuthorFromUserModel(
        userModel: newUser,
        bzID: bzID,
        isCreator: false,
      );

      if (_newAuthor != null){
        _output.add(_newAuthor);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<AuthorModel>? removeAuthorFromAuthors({
    required List<AuthorModel>? authors,
    required String? authorIDToRemove,
  }){

    List<AuthorModel>? _output;

    if (Lister.checkCanLoop(authors) == true && authorIDToRemove != null){

      _output = <AuthorModel>[...authors!];

      final int _index = _output.indexWhere((a) => a.userID == authorIDToRemove);

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
    required String? flyerID,
    required String? authorID,
    required List<AuthorModel>? oldAuthors,
  }){

    List<AuthorModel> _output = [...?oldAuthors];

    if (
    Lister.checkCanLoop(oldAuthors) == true
        &&
        flyerID != null
        &&
        authorID != null
    ){

      // blog('addFlyerIDToAuthor : flyerID $flyerID : authorID $authorID : authors count : ${authors.length}');

      final AuthorModel? _oldAuthor = getAuthorFromAuthorsByID(
          authors: oldAuthors,
          authorID: authorID
      );

      // blog('addFlyerIDToAuthor : author $authorID flyers was ${_oldAuthor.flyersIDs} ');

      final List<String> _newFlyersIDs = Stringer.putStringInStringsIfAbsent(
          strings: _oldAuthor?.flyersIDs,
          string: flyerID
      );

      // blog('addFlyerIDToAuthor : author $authorID flyers should be $_newFlyersIDs ');

      final AuthorModel? _newAuthor = _oldAuthor?.copyWith(
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
  static List<AuthorModel>? removeFlyerIDFromAuthor({
    required String? flyerID,
    required String? authorID,
    required List<AuthorModel>? oldAuthors,
  }){

    List<AuthorModel>? _newAuthors = oldAuthors;

    if (
        Lister.checkCanLoop(oldAuthors) == true
        &&
        flyerID != null
        &&
        authorID != null
    ){

      blog('removeFlyerIDToAuthor : flyerID : $flyerID : authorID : $authorID');

      final AuthorModel? _oldAuthor = getAuthorFromAuthorsByID(
          authors: oldAuthors,
          authorID: authorID
      );

      blog('removeFlyerIDToAuthor : author flyers was : ${_oldAuthor?.flyersIDs}');

      final List<String> _updatedFlyersIDs = Stringer.removeStringsFromStrings(
        removeFrom: _oldAuthor?.flyersIDs,
        removeThis: <String>[flyerID],
      );

      blog('removeFlyerIDToAuthor : author flyers is : $_updatedFlyersIDs');

      final AuthorModel? _newAuthor = _oldAuthor?.copyWith(
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
    required String flyerID,
    required List<AuthorModel> authors,
  }){

    List<AuthorModel> _output = authors;

    if (flyerID != null && Lister.checkCanLoop(authors) == true){

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
  static List<AuthorModel>? overrideAuthorsBzID({
    required List<AuthorModel>? authors,
    required String bzID,
  }){
    final List<AuthorModel> _output = <AuthorModel>[];

    if (Lister.checkCanLoop(authors) == true){

      for (final AuthorModel author in authors!){

        final String? _picPath = StoragePath.bzz_bzID_authorID(
          bzID: bzID,
          authorID: author.userID,
        );

        final AuthorModel _overridden = author.copyWith(
          picPath: _picPath,
          picModel: author.picModel?.overrideUploadPath(
            uploadPath: _picPath,
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
    required String? userID,
    required BzModel? bzModel,
  }){

    bool _isCreator = false;

    final AuthorModel? _author = getAuthorFromBzByAuthorID(
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
  static bool checkAuthorsContainUserID({
    required List<AuthorModel>? authors,
    required String? userID,
  }){
    bool _contains = false;

    if (Lister.checkCanLoop(authors) == true && userID != null){

      final int? _index = authors?.indexWhere((a) => a.userID == userID);

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
    required AuthorModel? author,
  }){
    bool? _hasFlyers = false;

    if (author != null){

      _hasFlyers = author.flyersIDs?.isNotEmpty;

    }

    return _hasFlyers ?? false;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkImCreatorInThisBz({
    required BzModel? bzModel,
  }){
    bool _imCreator = false;

    if (bzModel != null){

      final AuthorModel? _myAuthorModel = getAuthorFromBzByAuthorID(
        bz: bzModel,
        authorID: Authing.getUserID(),
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
    required FlyerModel? flyerModel,
  }){

    final UserModel? _myUserModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    return Stringer.checkStringsContainString(
      strings: _myUserModel?.myBzzIDs,
      string: flyerModel?.bzID,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkUserImageIsAuthorImage({
    required AuthorModel? authorModel,
    required UserModel? userModel,
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
    required String? myID,
    required FlyerModel? flyer,
    required BzModel? bzModel,
  }){
    bool _canDelete = false;

    if (flyer != null && bzModel != null && myID != null){

      final bool _thisIsMyFlyer = flyer.authorID == myID;
      final bool _imCreator = checkImCreatorInThisBz(bzModel: bzModel);

      if (_thisIsMyFlyer == true || _imCreator == true){
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
    required String? bzID,
    required UserModel? userModel,
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
    required String? bzID,
  }) async {
    bool _aLoneAuthor = true;

    if (bzID != null){

      final BzModel? _bzModel = await BzProtocols.fetchBz(bzID: bzID);
      _aLoneAuthor = _bzModel?.authors?.length == 1;

    }

    return _aLoneAuthor;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// DEPRECATED
  static String generateAuthorPicID({
    required String authorID,
    required String bzID
  }) {
    final String _authorPicID = '$authorID---$bzID';
    return _authorPicID;
  }
  // --------------------
  /*
  static String generateMasterAuthorsNamesString({
    required BuildContext context,
    required BzModel bzModel,
}){

    String _string = superPhrase(context, 'phid_account_admin');

    final List<AuthorModel> _masterAuthors = getCreatorAuthorsFromBz(bzModel);

    if (Lister.checkCanLoop(_masterAuthors) == true){

      final List<String> _names = getAuthorsNames(
        authors: _masterAuthors,
      );

      if (Lister.checkCanLoop(_names) == true){

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
      flyersIDs: const <String>['flyer_dummy_id'],
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
    String? invoker = '',
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
    required List<AuthorModel>? authors,
    String? invoker,
  }){

    if (Lister.checkCanLoop(authors) == true){

      for (final AuthorModel author in authors!){
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
  static String? getAuthorRolePhid({
    required AuthorRole? role,
  }){
    switch (role){
      case AuthorRole.creator: return 'phid_creator';
      case AuthorRole.moderator: return 'phid_moderator';
      case AuthorRole.teamMember: return 'phid_teamMember';
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// AUTHOR ROLES

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorAbility({
    required AuthorModel? theDoer,
    required AuthorModel? theDoneWith,
    required AuthorAbility? ability,
  }){

    if (theDoer != null && ability != null){

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
            case AuthorAbility.canChangeOthersRoles :     return true;
            case AuthorAbility.canChangeSelfRole :        return false;
            case AuthorAbility.canEditOtherAuthor :       return true;
            case AuthorAbility.canRemoveOtherAuthor :     return true;
            case AuthorAbility.canSendAuthorships :       return true;
            case AuthorAbility.canRemoveSelf :            return false;
            default: return false;
          }
          /// MODERATOR -------------
        case AuthorRole.moderator:
          switch (ability) {
            case AuthorAbility.canChangeOthersRoles :     return _higherRank;
            case AuthorAbility.canChangeSelfRole :        return true;
            case AuthorAbility.canEditOtherAuthor :       return _higherRank || _sameRank;
            case AuthorAbility.canRemoveOtherAuthor :     return false;
            case AuthorAbility.canSendAuthorships :       return true;
            case AuthorAbility.canRemoveSelf :            return true;
            default: return false;
          }
          /// TEAM MEMBER -------------
        case AuthorRole.teamMember:
          switch (ability) {
            case AuthorAbility.canChangeOthersRoles :     return _higherRank;
            case AuthorAbility.canChangeSelfRole :        return true;
            case AuthorAbility.canEditOtherAuthor :       return _higherRank || _sameRank;
            case AuthorAbility.canRemoveOtherAuthor :     return false;
            case AuthorAbility.canSendAuthorships :       return false;
            case AuthorAbility.canRemoveSelf :            return true;
            default: return false;
          }
          /// DEFAULT -------------
        default: return false;
      }

    }

    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorHasHigherRank({
    required AuthorModel? theDoer, // the current user doing stuff
    required AuthorModel? theDoneWith, // the author whos done with
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
    required AuthorModel? theDoer, // the current user doing stuff
    required AuthorModel? theDoneWith, // the author whos done with
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
  static int getRoleRank(AuthorRole? role){

    switch (role){
      case AuthorRole.creator: return 3;
      case AuthorRole.moderator: return 2;
      case AuthorRole.teamMember: return 1;
      default: return 0;
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthorsListsAreIdentical({
    required List<AuthorModel>? authors1,
    required List<AuthorModel>? authors2
  }){
    bool _output = false;

    if (authors1 == null && authors2 == null){
      _output = true;
    }
    else if (authors1 != null && authors1.isEmpty && authors2 != null && authors2.isEmpty){
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
  /// TASK : TEST_ME_NOW
  static bool checkAuthorsAreIdentical({
    required AuthorModel? author1,
    required AuthorModel? author2,
  }){
    bool _identical = false;

    if (author1 == null && author2 == null){
      _identical = true;
    }
    else if (author1 == null || author2 == null){
      _identical = false;
    }
    else {

      if (

          author1.userID == author2.userID  &&
          author1.name == author2.name &&
          author1.picPath == author2.picPath &&
          author1.title == author2.title &&
          author1.role == author2.role &&
          Lister.checkListsAreIdentical(
            list1: author1.flyersIDs,
            list2: author2.flyersIDs,
          ) == true &&
          ContactModel.checkContactsListsAreIdentical(
            contacts1: author1.contacts,
            contacts2: author2.contacts,
          ) == true &&
          MediaModel.checkMediaModelsAreIdenticalSync(
              model1: author1.picModel,
              model2: author2.picModel
          ) == true
      ){
        _identical = true;
      }

    }

    // Mapper.blogMapsDifferences(
    //     map1: author1?.toMap(),
    //     map2: author2?.toMap(),
    //     invoker: 'checkAuthorsAreIdentical',
    // );

    return _identical;
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
