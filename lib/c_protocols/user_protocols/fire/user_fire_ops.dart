import 'dart:async';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

class UserFireOps {
  // -----------------------------------------------------------------------------

  const UserFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createUser({
    @required UserModel userModel,
    @required AuthType authBy,
  }) async {

    await Fire.updateDoc(
      collName: FireColl.users,
      docName: userModel.id,
      input: userModel.toMap(toJSON: false),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> readUser({
    @required String userID,
  }) async {
    UserModel _output;

    final Map<String, dynamic> _userMap = await Fire.readDoc(
      collName: FireColl.users,
      docName: userID,
    );

    if (_userMap != null) {

      _output = UserModel.decipherUser(
        map: _userMap,
        fromJSON: false,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<UserModel> updateUser({
    @required UserModel oldUserModel,
    @required UserModel newUserModel,
  }) async {
    UserModel _output;

    final bool _userModelsAreIdentical = UserModel.usersAreIdentical(
      user1: oldUserModel,
      user2: newUserModel,
    );

    if (_userModelsAreIdentical == false){

      final UserModel _finalUserModel = await _updateUserEmailIfChanged(
        oldUserModel: oldUserModel,
        newUserModel: newUserModel,
      );

      await Fire.updateDoc(
        collName: FireColl.users,
        docName: newUserModel.id,
        input: _finalUserModel.toMap(toJSON: false),
      );

      _output = _finalUserModel;

    }

    return _output;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> _updateUserEmailIfChanged({
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

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteMyUser(BuildContext context) async {

    blog('deleteMyUser : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    await Future.wait(<Future>[

      /// DELETE USER
      Fire.deleteDoc(
        collName: FireColl.users,
        docName: _userModel.id,
      ),
      /// DELETE FIREBASE USER
      AuthFireOps.deleteFirebaseUser(
        userID: _userModel.id,
      ),

    ]);

    blog('deleteMyUser : END');

    // return _success;
  }
  // --------------------
}
// -----------------------------------------------------------------------------

/// USER FIELD MODIFIERS


// --------------------
/*
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
    @required String bzID,
    @required UserModel oldUserModel,
  }) async {

    final UserModel _updatedUserModel = UserModel.addBzIDToUserBzz(
      userModel: oldUserModel,
      bzIDToAdd: bzID,
    );

    final UserModel _uploadedModel = await updateUser(
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
   */

// -----------------------------------------------------------------------------
/// DEPRECATED
/*
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
      final UserModel _initialUserModel = await UserModel.fromFirebaseUser(
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
   */
// ---------------------
/// DEPRECATED
/*
  /// auth change user stream
  Stream<UserModel> streamInitialUser() {

    final FirebaseAuth _auth = FirebaseAuth?.instance;

    return _auth
        .authStateChanges()
        .map((User user) => UserModel.initializeUserModelStreamFromUser());

    //     .map(
    //     UserModel.initializeUserModelStreamFromUser); // different syntax than previous snippet
  }

   */
// -----------------------------------------------------------------------------
