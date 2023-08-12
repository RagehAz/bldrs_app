import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/widgets/sensors/app_version_builder.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/b_auth/b_email_auth_screen/a_email_auth_screen.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:fire/super_fire.dart';

class UserInitializer {
  // -----------------------------------------------------------------------------

  const UserInitializer();

  // -----------------------------------------------------------------------------

  /// USER MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> initializeUser() async {

    /// CREATE - FETCH USER MODEL
    final bool _continue = await _initializeUserModel();

    if (_continue == true){

      /// GET USER MODEL
      final UserModel? _old = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
      );

      /// USER DEVICE MODEL
      UserModel? _new = await _userDeviceModelOps(
        userModel: _old,
      );

      /// USER APP STATE
      _new = await _userAppStateOps(
        userModel: _new,
      );

      /// IDENTICAL ?
      final bool _identical = UserModel.usersAreIdentical(
          user1: _old,
          user2: _new,
      );

      /// RENOVATE USER MODEL
      if (_identical == false){

        await UserProtocols.renovate(
          invoker: 'UserInitializer.initializeUser',
          oldUser: _old,
          newUser: _new,
        );

      }

    }

    return _continue;
  }
  // -----------------------------------------------------------------------------

  /// USER MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _initializeUserModel() async {
    bool _continue = false;

    _report('start : Authing.getUserID() : ${Authing.getUserID()}');

    /// USER HAS ID
    if (Authing.getUserID() != null){

      _continue = await _fetchSetUser(
        userID: Authing.getUserID(),
      );

    }

    /// USER HAS NO ID
    else {

      final List<AccountModel> _accounts = await AccountLDBOps.readAllAccounts();
      final List<AccountModel> _withoutAnonymous = AccountModel.removeAnonymousAccounts(
          accounts: _accounts,
      );
      final AccountModel? _anonymousAccount = AccountModel.getAnonymousAccountFromAccounts(
          accounts: _accounts,
      );

      _report('noID : _accounts : ${_accounts.length}');
      _report('noID : _withoutAnonymous : ${_withoutAnonymous.length}');

      /// HAS NORMAL ACCOUNT IN LDB ALREADY
      if (Mapper.checkCanLoopList(_withoutAnonymous) == true){
        _continue = await _signInAccount(account: _withoutAnonymous.first);
      }

      _report('noID : _withoutAnonymous _continue : $_continue');

      /// HAS ANONYMOUS ACCOUNT IN LDB
      if (_continue == false && _anonymousAccount != null){
        _continue = await _signInAccount(account: _anonymousAccount);
      }

      _report('noID : _anonymousAccount _continue : $_continue');


      /// NO ACCOUNTS IN LDB FOUND
      if (_continue == false){

        final List<UserModel> _deviceUsers = await UserFireOps.readDeviceUsers();
        final List<UserModel> _signedUpUsers = UserModel.getSignedUpUsersOnly(
          users: _deviceUsers,
        );
        // final UserModel? _anonymousUserOfThisDevice = await UserFireOps.readAnonymousUserByDeviceID();

        _report('noLDB : _deviceUsers _continue : ${_deviceUsers.length}');
        _report('noLDB : _signedUpUsers _continue : ${_signedUpUsers.length}');

        /// HAS A FIRE USER MODELS LOST FROM LDB
        if (Mapper.checkCanLoopList(_signedUpUsers) == true){

          await AccountLDBOps.insertUserModels(
            users: _signedUpUsers,
          );

          _continue = await Nav.goToNewScreen(
              context: getMainContext(),
              screen: const EmailAuthScreen(),
          );

        }

        _report('noID : bardo _continue : $_continue');

        /// DID NOT SIGN IN BY SIGNUP ACCOUNTS
        if (_continue == false){

          final UserModel? _anonymousUser = UserModel.getFirstAnonymousUserFromUsers(
            users: _deviceUsers,
          );

          /// NO ANON. ACCOUNT FOUND IN FIREBASE
          if (_anonymousUser == null){
            _continue = await _composeNewAnonymousUser();
          }

          /// FOUND ANON. ACCOUNT IN FIREBASE
          else {
            _continue = await _reSignInAnonymousUser(
              userModel: _anonymousUser,
            );
          }

        }

        _report('noID : fi eh _continue : $_continue');

      }

    }

    return _continue;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _composeNewAnonymousUser() async {
    bool _continue = false;

    /// DEPRECATED
    // final AuthModel? _anonymousAuth = await Authing.anonymousSignin();
    //
    // final UserModel? _anonymousUser = await UserModel.anonymousUser(
    //   authModel: _anonymousAuth,
    // );

    final String _email = UserModel.createAnonymousEmail();
    final String? _password = UserModel.createAnonymousPassword(
      anonymousEmail: _email,
    );

    final AuthModel? _authModel = await EmailAuthing.register(
      email: _email,
      password: _password,
      autoSendVerificationEmail: false,
    );

    if (_authModel != null){

      final UserModel? userModel = await UserProtocols.composeAnonymous(
        authModel: _authModel,
      );

      if (userModel != null){

        final AccountModel _newAccount = AccountModel(
            id: userModel.id,
            email: _email,
            password: _password,
          );

        _continue = await _signInAccount(
          account: _newAccount,
        );

      }

    }

    return _continue;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _reSignInAnonymousUser({
    required UserModel? userModel,
  }) async {
    bool _continue = false;

    if (userModel != null){

      final String? _email = ContactModel.getValueFromContacts(
        contacts: userModel.contacts,
        contactType: ContactType.email,
      );

      final String? _password = UserModel.createAnonymousPassword(
        anonymousEmail: _email,
      );

      final AccountModel _account = AccountModel(
        id: userModel.id,
        email: _email,
        password: _password,
      );

      _continue = await _signInAccount(account: _account);

    }

    return _continue;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _signInAccount({
    required AccountModel? account,
  }) async {
    bool _continue = false;

    if (AccountModel.checkCanTrySign(account) == true){

      final bool _success = await AuthProtocols.signInBldrsByEmail(
        email: account!.email,
        password: account.password,

      );

      if (_success == true){

         await AccountLDBOps.insertAccount(
            account: account,
        );

        _continue = await _fetchSetUser(
          userID: account.id,
        );

      }

    }

    return _continue;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _fetchSetUser({
    required String? userID,
  }) async {
    bool _continue = false;

    if (userID != null){

      final UserModel? _userModel = await UserProtocols.fetch(
        userID: userID,
        );

      if (_userModel != null){

        UsersProvider.proSetMyUserModel(
          userModel: _userModel,
          notify: true,
        );

        _continue = true;

      }

    }

    return _continue;
  }
  // -----------------------------------------------------------------------------

  /// USER DEVICE MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> _userDeviceModelOps({
    required UserModel? userModel,
  }) async {
    UserModel? _output = userModel;

    if (_output != null){

      /// THIS DEVICE MODEL
      final DeviceModel _thisDevice = await DeviceModel.generateDeviceModel();

      /// UNSUBSCRIBING FROM TOKEN INSTRUCTIONS
      /*
          - Unsubscribe stale tokens from topics
          Managing topics subscriptions to remove stale registration
          tokens is another consideration. It involves two steps:

          - Your app should resubscribe to topics once per month and/or
           whenever the registration token changes. This forms a self-healing
           solution, where the subscriptions reappear automatically
           when an app becomes active again.

          - If an app instance is idle for 2 months (or your own staleness window)
          you should unsubscribe it from topics using the Firebase Admin
          SDK to delete the token/topic mapping from the FCM backend.

          - The benefit of these two steps is that your fan outs will occur
          faster since there are fewer stale tokens to fan out to, and your
           stale app instances will automatically resubscribe once they are active again.

      */

      bool _shouldRefreshDevice = _output.device == null;
      if (_shouldRefreshDevice == false){
        _shouldRefreshDevice = !DeviceModel.checkDevicesAreIdentical(
          device1: _thisDevice,
          device2: _output.device,
        );
      }

      /// REFRESH DEVICE MODEL
      if (_shouldRefreshDevice == true){

        /// SHOULD REFETCH, and I will explain why
        /// user using device A renovated his user model and updated firebase
        /// closed device A and opens device B
        /// which did not listen to firebase but has an old model in LDB
        /// while checking this device has been changed
        /// we should get the most updated version of his model
        /// so we refetch model
        /// cheers
        _output = await UserProtocols.refetch(
            userID: _output.id,
        );

        if (_output != null){

          _output = _output.copyWith(
            device: _thisDevice,
          );

          /// TAKES TOO LONG AND NOTHING DEPENDS ON IT
          unawaited(_resubscribeToAllMyTopics(
            myUserModel: _output,
          ));

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _resubscribeToAllMyTopics({
    required UserModel? myUserModel,
  }) async {

    if (myUserModel != null){

      final List<String>? _userTopics = myUserModel.fcmTopics;

      final List<String> _topicsIShouldSubscribeTo = <String>[];
      for (final String topicID in [...?_userTopics]){

        final bool _containUnderscore = TextCheck.stringContainsSubString(
          string: topicID,
          subString: '_',
        );

        if (_containUnderscore == true){
          _topicsIShouldSubscribeTo.add(topicID);
        }

      }

      if (Mapper.checkCanLoopList(_topicsIShouldSubscribeTo) == true){

        /// UNSUBSCRIBE
        await Future.wait(<Future>[

          ...List.generate(_topicsIShouldSubscribeTo.length, (index){

            return FCM.unsubscribeFromTopic(
              topicID: _topicsIShouldSubscribeTo[index],
            );

          }),

        ]);

        /// SUBSCRIBE AGAIN
        await Future.wait(<Future>[

          ...List.generate(_topicsIShouldSubscribeTo.length, (index){

            return FCM.subscribeToTopic(
              topicID: _topicsIShouldSubscribeTo[index],
            );

          }),

        ]);

      }

    }

  }
    // -----------------------------------------------------------------------------

  /// USER APP STATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> _userAppStateOps({
    required UserModel? userModel,
  }) async {
    UserModel? _output = userModel;
    // AppStateModel? _userState = _output?.appState;

    if (_output != null){

      /// GET GLOBAL STATE
      final AppStateModel? _globalState = await AppStateProtocols.fetchGlobalAppState();

      if (_globalState != null){

        final String _detectedVersion = await AppVersionBuilder.detectAppVersion();

        _output = _output.copyWith(
          appState: _globalState.copyWith(
            appVersion: _detectedVersion,
          ),
        );

        // /// STATES IDENTICAL
        // final bool _statesAreIdentical = AppStateModel.checkAppStatesAreIdentical(
        //     state1: _userState,
        //     state2: _globalState,
        // );
        // if (_statesAreIdentical == false){
        //
        //   /// LDB CHECK
        //   if (_globalState.ldbVersion != _userState?.ldbVersion){
        //
        //     unawaited(LDBDoc.wipeOutEntireLDB());
        //
        //     _userState = _userState.copyWith(
        //       ldbVersion: _globalState.ldbVersion,
        //     );
        //
        //     _output = _output.copyWith(
        //       appState: _userState,
        //     );
        //
        //   }
        //
        //   /// APP VERSION CHECK
        //   final String _detectedVersion = await AppVersionBuilder.detectAppVersion();
        //   if (_detectedVersion != _userState.appVersion){
        //
        //     _userState = _userState.copyWith(
        //       appVersion: _detectedVersion,
        //       minVersion: _detectedVersion,
        //     );
        //
        //     _output = _output.copyWith(
        //       appState: _userState,
        //     );
        //
        //   }
        //
        // }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  static void _report(String text){
    blog('  User--> $text');
  }
  // -----------------------------------------------------------------------------
}

/*
02 2308 5290

we complain
444-11-36

we complain #2
2296-294

 */
