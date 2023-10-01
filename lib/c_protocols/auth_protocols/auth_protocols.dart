import 'dart:async';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:basics/helpers/classes/checks/errorize.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class AuthProtocols {
  // -----------------------------------------------------------------------------

  const AuthProtocols();

  // -----------------------------------------------------------------------------
  static const bool showSocialAuthButtons = true;
  // -----------------------------------------------------------------------------

  /// SIGN IN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signInBldrsByEmail({
    required String? email,
    required String? password,
  }) async {
    bool _success = false;
    String? _error;

    final AuthModel? _authModel = await EmailAuthing.signIn(
      email: email?.trim(),
      password: password,
      onError: (String? error){
        _error = error;
      },
    );

    if (_error != null){
      await onAuthError(
        error: _error,
        invoker: 'signInBldrsByEmail',
      );
    }

    if (_authModel != null){

      await AccountLDBOps.insertAccount(
        account: AccountModel(
          id: _authModel.id,
          email: email,
          password: password,
          signInMethod: SignInMethod.password,
        ),
      );

      final UserModel? _userModel = await UserProtocols.fetch(
        userID: _authModel.id,
      );

      UsersProvider.proSetMyUserModel(
        userModel: _userModel,
        notify: true,
      );

      _success = true;
    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// REGISTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> registerUser({
    required String email,
    required String password
  }) async {
    bool _success = false;

    // final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    //     context: getMainContext(),
    //     listen: false,
    // );

    // blog('_userModel is null : ${_userModel == null}');

    // if (_userModel != null){

    final AccountModel? _anonymousAccount = await _fetchAnonymousAccount();

    // blog('_anonymousAccount is null : ${_anonymousAccount == null}');

      /// HAS ANONYMOUS ACCOUNT
      if (_anonymousAccount != null){
        _success = await _upgradeAnonymous(
          oldAccount: _anonymousAccount,
          newAccount: _anonymousAccount.copyWith(
            email: email,
            password: password,
          ),
        );
      }

      /// NO ANONYMOUS ACCOUNTS FOUND TO UPGRADE
      else {
        _success = await _registerNewUser(
          email: email,
          password: password,
        );
      }

    // }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _upgradeAnonymous({
    required AccountModel? oldAccount,
    required AccountModel? newAccount,
  }) async {
    bool _success = false;

    if (
        oldAccount != null &&
        newAccount != null &&
        newAccount.email != null &&
        newAccount.password != null
    ){

      /// RESIGN IN TO BE ABLE TO RESET EMAIL
      final AuthModel? _authModel = await EmailAuthing.signIn(
        email: oldAccount.email?.trim(),
        password: oldAccount.password,
      );

      if (_authModel != null){

        String? _error;

        /// CHANGE EMAIL IN FIRE AUTH
        _success = await EmailAuthing.updateUserEmail(
          newEmail: newAccount.email!,
          onError: (String? error){
            _error = error;
            },
        );

        if (_error != null){
          await onAuthError(
            error: _error,
            invoker: '_upgradeAnonymous.EmailAuthing.updateUserEmail',
          );
        }

        if (_success == true){

          _success = await EmailAuthing.sendVerificationEmail(
            email: newAccount.email,
          );

          if (_success == true){

            unawaited(Dialogs.emailSentSuccessfullyDialogs(
              email: newAccount.email!,
            ));

            /// CHANGE PASSWORD IN FIRE AUTH
            _success = await EmailAuthing.updateUserPassword(
              newPassword: newAccount.password!,
              onError: (String? error) => onAuthError(
                error: error,
                invoker: '_upgradeAnonymous.EmailAuthing.updateUserPassword',
              ),
            );

            if (_success == true){

              /// CHANGE SIGNIN METHOD & EMAIL IN FIRE DOC
              final UserModel? _oldUser = await UserProtocols.fetch(
                userID: oldAccount.id,
              );

              if (_oldUser != null){

                /// UPDATE ACCOUNT MODEL IN LDB
                await AccountLDBOps.insertAccount(
                  account: newAccount,
                );

                final UserModel _newUser = _oldUser.copyWith(
                    signInMethod: SignInMethod.password,
                    contacts: ContactModel.insertOrReplaceContact(
                      contacts: _oldUser.contacts,
                      contactToReplace: ContactModel(
                        type: ContactType.email,
                        value: newAccount.email!,
                      ),
                    ),
                );

                await UserProtocols.renovate(
                  invoker: 'upgradeAnonymous',
                  oldUser: _oldUser,
                  updateEmailInAuth: false,
                  newUser: _newUser,
                );

              }
            }

          }

        }

      }
    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _registerNewUser({
    required String? email,
    required String? password,
  }) async {

    bool _success = false;

    if (email != null && password != null){

      String? _error;

      final AuthModel? _authModel = await EmailAuthing.register(
        email: email,
        password: password,
        autoSendVerificationEmail: true,
        onError: (String? error){
          _error = error;
        },
      );

      if (_error != null){
        await onAuthError(
          error: _error,
          invoker: '_registerNewUser.EmailAuthing.register'
        );
      }

      if (_authModel != null){

        final UserModel? userModel = await UserProtocols.compose(
          authModel: _authModel,
        );

        if (userModel != null){

          /// UPDATE ACCOUNT MODEL IN LDB
          await AccountLDBOps.insertAccount(
            account: AccountModel.createAccountByUser(
                userModel: userModel,
                passwordOverride: password,
            ),
          );

          await Dialogs.emailSentSuccessfullyDialogs(
            email: email,
          );
          _success = true;

        }

      }

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// SOCIAL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, bool>> socialAuth({
    required AuthModel? authModel,
  }) async {
    bool _success = false;
    bool _firstTimer = false;
    UserModel? _userModel;

    if (authModel != null){

      _userModel = await UserProtocols.fetch(
          userID: authModel.id,
        );

      /// NEW USER
      if (_userModel == null){

        _userModel = await UserProtocols.compose(
          authModel: authModel,
        );

        if (_userModel != null){
          _success = true;
          _firstTimer = true;
        }

      }
      /// OLD USER
      else {
        _success = true;
        _firstTimer = false;
      }

    }

    if (_success == true){

      /// UPDATE ACCOUNT MODEL IN LDB
     await AccountLDBOps.insertAccount(
        account: AccountModel(
          id: authModel?.id,
          email: authModel?.email,
          password: null,
          signInMethod: authModel?.signInMethod,
        ),
      );

      UsersProvider.proSetMyUserModel(
        userModel: _userModel,
        notify: true,
      );

    }

    return {
      'success': _success,
      'firstTimer': _firstTimer,
    };
  }
  // -----------------------------------------------------------------------------

  /// FETCHES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AccountModel?> _fetchAnonymousAccount() async {

    AccountModel? _output = await AccountLDBOps.readAnonymousAccount();

    if (_output == null){

      final UserModel? _user = await UserFireOps.readDeviceAnonymousUser();

      if (_user != null){

        _output = AccountModel.createAccountByUser(
          userModel: _user,
          passwordOverride: null,
        );

        await AccountLDBOps.insertAccount(
            account: _output,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// AFTER AUTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onAuthError({
    required String? error,
    required String invoker,
  }) async {

    final String _errorMessage = error ?? getWord('phid_something_went_wrong_error');
    final DeviceModel _device = await DeviceModel.generateDeviceModel();
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false
    );

    await Errorize.throwMap(
        invoker: 'onAuthError',
        map: {
          'userID': _userModel?.id,
          'userName': _userModel?.name,
          'userEmail': UserModel.getUserEmail(_userModel),
          'signInMethod': _userModel?.signInMethod,
          'zone': _userModel?.zone?.toMap(),
          'appState': _userModel?.appState?.toMap(toUserModel: true),
          'time': Timers.cipherTime(time: DateTime.now(), toJSON: false),
          'device': _device.toMap(),
          'invoker': invoker,
          'error': error,
          'errorMessage': _errorMessage,
        },
    );

    await Dialogs.authErrorDialog(
        result: _errorMessage,
    );

  }
  // -----------------------------------------------------------------------------

  /// SIGN OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signOutBldrs() async {

    final bool _success = await Authing.signOut(
        onError: (String? error) async {
          await BldrsCenterDialog.showCenterDialog(
            titleVerse: const Verse(
              id: 'phid_trouble_signing_out',
              translate: true,
            ),
            bodyVerse: Verse(
              id: error,
              translate: false,
            ),
          );
        }
        );

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// RAGEH SIGN IN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> signInAsRage7({
    required BuildContext context,
  }) async {

    final AuthModel? _authModel = await EmailAuthing.signIn(
      email: 'rageh@bldrs.net',
      password: '123456',
      onError: (String? error) =>
          AuthProtocols.onAuthError(
            error: error,
            invoker: 'signInAsRage7',
          ),
    );

    if (_authModel != null && _authModel.id != null) {
      final Map<String, dynamic>? _map = await Fire.readDoc(
        coll: FireColl.users,
        doc: _authModel.id!,
      );

      final UserModel? _userModel = UserModel.decipherUser(
        map: _map,
        fromJSON: false,
      );

      /// UPDATE LDB USER MODEL
      await UserLDBOps.updateUserModel(_userModel);

      UsersProvider.proSetMyUserModel(
        userModel: _userModel,
        notify: true,
      );
    }

  }
  // --------------------
}
