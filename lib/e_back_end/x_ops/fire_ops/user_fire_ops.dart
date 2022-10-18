import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/storage.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserFireOps {
  // -----------------------------------------------------------------------------

  const UserFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// create or update user document
  static Future<void> _createOrUpdateUserDoc({
    @required UserModel userModel,
  }) async {

    await Fire.updateDoc(
      collName: FireColl.users,
      docName: userModel.id,
      input: userModel.toMap(toJSON: false),
    );

  }
  // --------------------
  static Future<UserModel> createUser({
    @required UserModel userModel,
    @required AuthType authBy,
  }) async {
    // ----------
    /// this creates :-
    /// 1 - JPG in : storage/userPics/userID.jpg if userModel.pic is File no URL
    /// 2 - userModel in : firestore/users/userID
    // ----------

    /// check if user pic is file to upload or URL from facebook to keep
    String _userPicURL;
    if (ObjectCheck.objectIsFile(userModel.pic) == true) {
      _userPicURL = await Storage.createStoragePicAndGetURL(
        inputFile: userModel.pic,
        fileName: userModel.id,
        docName: StorageDoc.users,
        ownersIDs: <String>[userModel.id],
      );
    }

    /// TASK : TRANSFORM FACEBOOK PICS TO LOCAL PICS U KNO
    /// if from google or facebook url pics
    else if (ObjectCheck.isAbsoluteURL(userModel.pic) == true) {
      /// TASK : this facebook / google image thing is not tested
      if (authBy == AuthType.facebook || authBy == AuthType.google) {
        final File _picFile = await Filers.getFileFromURL(userModel.pic);
        _userPicURL = await Storage.createStoragePicAndGetURL(
          inputFile: _picFile,
          fileName: userModel.id,
          docName: StorageDoc.users,
          ownersIDs: <String>[userModel.id],
        );
      }
    }

    /// create final UserModel
    final UserModel _finalUserModel = userModel.copyWith(
        createdAt: DateTime.now(),
        pic: _userPicURL ?? userModel.pic,

    );

    /// create user doc in fireStore
    await _createOrUpdateUserDoc(
      userModel: _finalUserModel,
    );

    return _finalUserModel;
  }
  // --------------------
  static Future<UserModel> getOrCreateUserModelFromUser({
    @required BuildContext context,
    @required User user,
    @required ZoneModel zone,
    @required AuthType authBy,
  }) async {
    // ----------
    /// E - read user ops if existed
    ///    Ex - if new user (userModel == null)
    ///       E1 - create initial user model
    ///       E2 - create user ops
    ///       E3 - return new userModel in AuthModel
    ///    Ex - if user has existing user model
    ///       E3 - return existing userMode in AuthModel
    // ----------

    /// E - read user ops if existed
    final UserModel _existingUserModel = await readUser(
      userID: user.uid,
    );
    // blog('lng : ${Wordz.languageCode(context)}');

    /// Ex - if new user (userModel == null)
    if (_existingUserModel == null) {
      // blog('lng : ${Wordz.languageCode(context)}');

      /// E1 - create initial user model
      final UserModel _initialUserModel = await UserModel.createInitialUserModelFromUser(
        context: context,
        user: user,
        zone: zone,
        authBy: authBy,
      );
      blog('googleSignInOps : _initialUserModel : $_initialUserModel');

      /// E2 - create user ops
      final UserModel _finalUserModel = await createUser(
        userModel: _initialUserModel,
        authBy: authBy,
      );

      blog('googleSignInOps : createUserOps : _finalUserModel : $_finalUserModel');

      /// E3 - return new userModel inside userModel-firstTimer map
      return _finalUserModel;

    }

    /// Ex - if user has existing user model
    else {

      /// E3 - return existing userMode inside userModel-firstTimer map
      return _existingUserModel;

    }
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  static Future<UserModel> readUser({
    @required String userID,
  }) async {

    UserModel _user;

    blog('readUserOps : Start reading user $userID,');

    final Map<String, dynamic> _userMap = await Fire.readDoc(
      collName: FireColl.users,
      docName: userID,
    );

    if (_userMap != null) {
      blog("readUserOps : _userMap _userMap['userID'] is : ${_userMap['id']}");
      // blog('lng : ${Wordz.languageCode(context)}');

      _user = _userMap == null ? null :
      UserModel.decipherUser(
        map: _userMap,
        fromJSON: false,
      );

    }

    // blog('_userModel is : $_user');
    // blog('lng : ${Wordz.languageCode(context)}');

    return _user;
  }
  // -----------------------------------------------------------------------------
  /// auth change user stream
  Stream<UserModel> streamInitialUser() {

    final FirebaseAuth _auth = FirebaseAuth?.instance;

    return _auth
        .authStateChanges()
        .map((User user) => UserModel.initializeUserModelStreamFromUser());

    //     .map(
    //     UserModel.initializeUserModelStreamFromUser); // different syntax than previous snippet
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> updateUser({
    @required BuildContext context,
    @required UserModel oldUserModel,
    @required UserModel newUserModel,
  }) async {

    // ----------
    /// UPDATE USER OPS
    /// A - if user pic changed
    ///   A1 - update pic to fireStorage/usersPics/userID and get new URL
    /// B - create final UserModel
    /// C - update firestore/users/userID
    // ----------

    /// A - if user pic changed
    String _userPicURL;
    if (ObjectCheck.objectIsFile(newUserModel.pic) == true) {

      final FileModel _oldFile = FileModel.initializePicForEditing(
          pic: oldUserModel.pic,
          fileName: oldUserModel.id,
      );

      /// A1 - update pic to fireStorage/usersPics/userID and get new URL
      _userPicURL = await Storage.createOrUpdatePic(
        context: context,
        oldURL: _oldFile?.url,
        newPic: newUserModel.pic,
        picName: newUserModel.id,
        ownersIDs: <String>[newUserModel.id],
        docName: StorageDoc.users,
      );

    }

    /// B - create final UserModel
    UserModel _finalUserModel = newUserModel.copyWith(
      pic: _userPicURL ?? oldUserModel.pic,
    );

    final bool _userModelsAreIdentical = UserModel.checkUsersAreIdentical(
      user1: oldUserModel,
      user2: _finalUserModel,
    );

    if (_userModelsAreIdentical == false){

      _finalUserModel = await updateUserEmailIfChanged(
        oldUserModel: oldUserModel,
        newUserModel: _finalUserModel,
      );

      await Fire.updateDoc(
        collName: FireColl.users,
        docName: newUserModel.id,
        input: _finalUserModel.toMap(toJSON: false),
      );


    }

    return _finalUserModel;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> updateUserEmailIfChanged({
    @required UserModel oldUserModel,
    @required UserModel newUserModel,
  }) async {

    UserModel _output = newUserModel.copyWith();

    final bool _emailChanged = ContactModel.checkEmailChanged(
      oldContacts: oldUserModel.contacts,
      newContacts: newUserModel.contacts,
    );

    if (_emailChanged == true){

      final String _newEmail = ContactModel.getValueFromContacts(
        contacts: newUserModel.contacts,
        contactType: ContactType.email,
      );

      if (TextCheck.isEmpty(_newEmail) == false){

        final bool _success = await AuthFireOps.updateUserEmail(
          newEmail: _newEmail,
        );

        /// EMAIL CHANGED
        if (_success == true){
          /// keep newUserModel as is with the new email defined in it
        }
        else {
          /// refactor the newUserModel with the old email
          final ContactModel _oldEmailContact = ContactModel.getContactFromContacts(
            contacts: oldUserModel.contacts,
            type: ContactType.email,
          );

          final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
            contacts: newUserModel.contacts,
            contactToReplace: _oldEmailContact,
          );

          _output = newUserModel.copyWith(
            contacts: _contacts,
          );

        }

      }

    }


    return _output;
  }
  // -----------------------------------------------------------------------------

  /// USER FIELD MODIFIERS

  // --------------------
  /// returns new pic url
  static Future<String> updateUserPic({
    @required BuildContext context,
    @required String oldURL,
    @required File newPic,
    @required String userID,
  }) async {

    final String _newURL = await Storage.updateExistingPic(
      context: context,
      oldURL: oldURL,
      newPic: newPic,
    );

    await Fire.updateDocField(
      collName: FireColl.users,
      docName: userID,
      field: 'pic',
      input: _newURL,
    );

    return _newURL;
  }
  // --------------------
  static Future<void> addFlyerIDToSavedFlyersIDs({
    @required BuildContext context,
    @required String flyerID,
    @required List<String> savedFlyersIDs,
    @required String userID,
  }) async {

    final List<String> _savedFlyersIDs = <String>[];

    if (Mapper.checkCanLoopList(savedFlyersIDs)) {
      _savedFlyersIDs.addAll(savedFlyersIDs);
    }

    _savedFlyersIDs.add(flyerID);

    await Fire.updateDocField(
      collName: FireColl.users,
      docName: userID,
      field: 'savedFlyersIDs',
      input: _savedFlyersIDs,
    );

  }
  // --------------------
  static Future<void> removeFlyerIDFromSavedFlyersIDs({
    @required String flyerID,
    @required String userID,
    @required List<String> savedFlyersIDs,
  }) async {

    final int _index = savedFlyersIDs.indexWhere((String id) => id == flyerID);

    if (_index >= 0) {
      savedFlyersIDs.remove(flyerID);

      await Fire.updateDocField(
        collName: FireColl.users,
        docName: userID,
        field: 'savedFlyersIDs',
        input: savedFlyersIDs,
      );
    }
  }
  // --------------------
  static Future<UserModel> addBzIDToUserBzzIDs({
    @required BuildContext context,
    @required String bzID,
    @required UserModel oldUserModel,
  }) async {

    final UserModel _updatedUserModel = UserModel.addBzIDToUserBzz(
      userModel: oldUserModel,
      bzIDToAdd: bzID,
    );

    final UserModel _uploadedModel = await updateUser(
      context: context,
      oldUserModel: oldUserModel,
      newUserModel: _updatedUserModel,
    );

    return _uploadedModel;
  }
  // --------------------
  static Future<void> removeBzIDFromUserBzzIDs({
    @required String bzID,
    @required UserModel oldUserModel,
  }) async {

    final List<dynamic> _modifiedMyBzzIDs = Stringer.removeStringsFromStrings(
      removeFrom: oldUserModel.myBzzIDs,
      removeThis: <String>[bzID],
    );

    await Fire.updateDocField(
      collName: FireColl.users,
      docName: oldUserModel.id,
      field: 'myBzzIDs',
      input: _modifiedMyBzzIDs,
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /*
static Future<dynamic> deleteUserOps({
  @required BuildContext context,
  @required UserModel userModel,
}) async {
  // ----------
  /// TASK : CLOUD FUNCTION : delete user ops should trigger a cloud function instead of firing these entire functions from client
  /// for now this :-
  /// A - if user stops return 'stop
  /// A - if user continue :-
  /// B - if user is Author :-
  ///   C - read And Filter Teamless Bzz By then show its dialog
  ///   D - return 'stop' or continue ops
  ///   E - show flyers that will be DELETED
  ///   F - return 'stop' or continue ops
  ///   G - DELETE all deactivable bzz : firestore/bzz/bzID
  ///   I - DELETE user image : storage/usersPics/userID
  ///   J - DELETE user doc : firestore/users/userID
  ///   L - DELETE firebase user : auth/userID
  ///   K - SIGN OUT
  ///   M - return 'deleted'
  ///
  /// B - if user is not Author
  ///   I - DELETE user image : storage/usersPics/userID
  ///   J - DELETE user doc : firestore/users/userID
  ///   L - DELETE firebase user : auth/userID
  ///   K - SIGN OUT
  ///   M - return 'deleted'
  // ----------

  /// A - initial bool dialog alert
  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'This will Delete all your data',
    body: 'all pictures, flyers, businesses, your user records will be deleted for good\nDo you want to proceed ?',
    boolDialog: true,
  );

  /// A - if user stops
  if (_result == false) {
    blog('A - user stops delete user ops ');
    return 'stop';
  }

  /// A - if user continues
  else {
    blog('A - starting superDeleteUserOps()');

    /// B - if user is author
    if (UserModel.userIsAuthor(userModel) == true) {

      /// WAITING DIALOG
      unawaited(CenterDialog.showCenterDialog(
        context: context,
        title: '',
        boolDialog: null,
        body: 'Waiting',
        child: const Loading(
          loading: true,
        ),
      ));

      /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
      final Map<String, dynamic> _userBzzMap = await BzFireOps.readAndFilterTeamlessBzzByUserModel(
        context: context,
        userModel: userModel,
      );
      final List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
      final List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

      /// CLOSE WAITING DIALOG
      Nav.goBack(context);

      /// C - show deactivable bzz dialog
      final bool _bzzReviewResult = await Dialogz.bzzDeactivationDialog(
        context: context,
        bzzToDeactivate: _bzzToDeactivate,
        bzzToKeep: _bzzToKeep,
      );

      /// D - if user wants to stop
      if (_bzzReviewResult == false) {
        // do nothing
        blog('D - user stops delete user ops ');
        return 'stop';
      }

      /// D - if user wants to continue
      else {
        final List<FlyerModel> _bzzFlyers = await FireFlyerOps.readBzzFlyers(
          context: context,
          bzzModels: _bzzToDeactivate,
        );

        /// E - show flyers that will be DELETED
        final bool _flyersReviewResult = await Dialogz.flyersDeactivationDialog(
          context: context,
          bzzToDeactivate: _bzzToDeactivate,
          flyers: _bzzFlyers,
        );

        /// F - if user wants to stop
        if (_flyersReviewResult == false) {
          blog('F - user stops delete user ops ');
          return 'stop';
        }

        /// F - if user wants to continue
        else {
          /// SHOW WAITING DIALOG
          unawaited(CenterDialog.showCenterDialog(
            context: context,
            title: '',
            boolDialog: null,
            body: 'Waiting',
            child: const Loading(
              loading: true,
            ),
          ));

          /// G - DELETE all deactivable bzz : firestore/bzz/bzID
          for (final BzModel bz in _bzzToDeactivate) {
            await BzFireOps.deleteBzOps(
              context: context,
              bzModel: bz,
            );

            blog('G - DELETED : from ${userModel.id} : bz :  ${bz.id} successfully');
          }

          /// I - DELETE user image : storage/usersPics/userID
          blog('I - deleting user pic');
          await Storage.deleteStoragePic(
            context: context,
            docName: StorageDoc.users,
            picName: userModel.id,
          );

          /// J - DELETE user doc : firestore/users/userID
          blog('J - deleting user doc');
          await Fire.deleteDoc(
            context: context,
            collName: FireColl.users,
            docName: userModel.id,
          );

          /// L - DELETE firebase user : auth/userID
          blog('L - deleting firebase user');

          /// TASK : NEED TO MANAGE IF THIS FAILS
          await AuthFireOps.deleteFirebaseUser(
              context: context,
              userID: userModel.id,
          );

          /// K - SIGN OUT
          blog('K - user is signing out');
          await AuthFireOps.signOut(
              context: context,
              routeToUserChecker: false,
          );

          /// CLOSE WAITING DIALOG
          Nav.goBack(context);

          /// M - return 'deleted'
          return 'deleted';
        }
      }
    }

    /// B - if user is not author
    else {
      /// SHOW WAITING DIALOG
      unawaited(CenterDialog.showCenterDialog(
        context: context,
        title: '',
        boolDialog: null,
        body: 'Waiting',
        child: const Loading(
          loading: true,
        ),
      ));

      /// I - DELETE user image : storage/usersPics/userID
      blog('I - deleting user pic');
      await Storage.deleteStoragePic(
        context: context,
        docName: StorageDoc.users,
        picName: userModel.id,
      );

      /// J - DELETE user doc : firestore/users/userID
      blog('J - deleting user doc');
      await Fire.deleteDoc(
        context: context,
        collName: FireColl.users,
        docName: userModel.id,
      );

      /// L - DELETE firebase user : auth/userID
      blog('L - deleting firebase user');

      /// TASK : NEED TO MANAGE IF THIS FAILS
      await AuthFireOps.deleteFirebaseUser(
          context: context,
          userID: userModel.id,
      );

      /// K - SIGN OUT
      blog('K - user is signing out');
      await AuthFireOps.signOut(
          context: context,
          routeToUserChecker: false,
      );

      /// CLOSE WAITING DIALOG
      Nav.goBack(context);

      /// M - return 'deleted'
      return 'deleted';
    }
  }
}
 */
  // --------------------
  /// TESTED :
  static Future<bool> deleteNonAuthorUserOps({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('deleteNonAuthorUserOps : start');

    final bool _success = await tryCatchAndReturnBool(
        methodName: 'deleteNonAuthorUserOps',
        functions: () async {

          /// SHOULD BE DELETED BEFORE DELETING USER DOC
          blog('UserFireOps : deleteNonAuthorUserOps : deleting user received notes');
          await NoteProtocols.wipeAllNotes(
            context: context,
            partyType: PartyType.user,
            id: userModel.id,
          );

          /// DELETE user image : storage/usersPics/userID
          blog('UserFireOps : deleteNonAuthorUserOps : deleting user pic');
          await Storage.deleteStoragePic(
            storageDocName: StorageDoc.users,
            fileName: userModel.id,
          );

          /// DELETE user doc : firestore/users/userID
          blog('UserFireOps : deleteNonAuthorUserOps : deleting user doc');
          await Fire.deleteDoc(
            collName: FireColl.users,
            docName: userModel.id,
          );

          /// DELETE firebase user : auth/userID
          blog('UserFireOps : deleteNonAuthorUserOps : deleting firebase user');
          await AuthFireOps.deleteFirebaseUser(
            userID: userModel.id,
          );

        }
    );

    blog('deleteNonAuthorUserOps : end');

    return _success;
  }
  // --------------------
}
