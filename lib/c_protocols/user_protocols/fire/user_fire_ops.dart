import 'dart:async';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:filers/filers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';
/// => TAMAM
class UserFireOps {
  // -----------------------------------------------------------------------------

  const UserFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createUser({
    @required UserModel userModel,
    @required SignInMethod signInMethod,
  }) async {

    await OfficialFire.updateDoc(
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

    final Map<String, dynamic> _userMap = await OfficialFire.readDoc(
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
  /// TESTED : WORKS PERFECT
  static Future<UserModel> updateUser({
    @required UserModel oldUser,
    @required UserModel newUser,
  }) async {
    UserModel _output;

    final bool _userModelsAreIdentical = UserModel.usersAreIdentical(
      user1: oldUser,
      user2: newUser,
    );

    if (_userModelsAreIdentical == false){

      final UserModel _finalUserModel = await _updateUserEmailIfChanged(
        oldUser: oldUser,
        newUser: newUser,
      );

      await OfficialFire.updateDoc(
        collName: FireColl.users,
        docName: newUser.id,
        input: _finalUserModel.toMap(toJSON: false),
      );

      _output = _finalUserModel;

    }

    return _output;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> _updateUserEmailIfChanged({
    @required UserModel oldUser,
    @required UserModel newUser,
  }) async {

    UserModel _output = newUser.copyWith();

    final bool _emailChanged = ContactModel.checkEmailChanged(
      oldContacts: oldUser?.contacts,
      newContacts: newUser?.contacts,
    );

    if (_emailChanged == true){

      final String _newEmail = ContactModel.getValueFromContacts(
        contacts: newUser.contacts,
        contactType: ContactType.email,
      );

      if (TextCheck.isEmpty(_newEmail) == false){

        final bool _success = await OfficialEmailAuthing.updateUserEmail(
          newEmail: _newEmail,
        );

        /// EMAIL CHANGED
        if (_success == true){
          /// keep new UserModel as is with the new email defined in it
        }

        else {
          /// refactor the new UserModel with the old email
          final ContactModel _oldEmailContact = ContactModel.getContactFromContacts(
            contacts: oldUser.contacts,
            type: ContactType.email,
          );

          final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
            contacts: newUser.contacts,
            contactToReplace: _oldEmailContact,
          );

          _output = newUser.copyWith(
            contacts: _contacts,
          );

        }

      }

    }


    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE USER APP STATE

  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<void> updateUserAppState({
    @required AppState newAppState,
    @required String userID
  }) async {

    await OfficialFire.updateDocField(
      collName: FireColl.users,
      docName: userID,
      field: 'appState',
      input: newAppState.toMap(),
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMyUser(BuildContext context) async {

    blog('deleteMyUser : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    /// DELETE USER
    await OfficialFire.deleteDoc(
      collName: FireColl.users,
      docName: _userModel.id,
    );

    blog('deleteMyUser : deleteDoc done');


    /// DELETE FIREBASE USER
    await OfficialAuthing.deleteUser();

    blog('deleteMyUser : END');

    // return _success;
  }
  // --------------------
}
