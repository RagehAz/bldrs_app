import 'dart:async';

import 'package:basics/components/sensors/app_version_builder.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_screens/b_user_screens/c_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabber.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
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

      /// USER ZONE
      _new = await _completeUserZone(
        userModel: _new,
      );
      _downloadUserCountryCities(
        userModel: _new,
      );

      /// USER APP STATE
      _new = await _userAppStateOps(
        userModel: _new,
      );

      /// LAST SEEN
      _new = _new?.copyWith(
        lastSeen: DateTime.now(),
      );

      /// IDENTICAL ?
      final bool _identical = UserModel.usersAreIdentical(
          user1: _old,
          user2: _new,
      );

      await Future.wait(<Future>[

        /// RENOVATE USER
        if (_identical == false)
          UserProtocols.renovate(
            invoker: 'UserInitializer.initializeUser',
            oldUser: _old,
            newUser: _new,
          ),

        RecorderProtocols.onStartSession(),

      ]);

    }

    return _continue;
  }
  // -----------------------------------------------------------------------------

  /// USER MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _initializeUserModel() async {
    bool? _continue = false;

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
      if (Lister.checkCanLoop(_withoutAnonymous) == true){
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
        if (Lister.checkCanLoop(_signedUpUsers) == true){

          await AccountLDBOps.insertUserModels(
            users: _signedUpUsers,
          );

          await MirageNav.goTo(tab: BldrsTab.auth);
          _continue = false;

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
          signInMethod: SignInMethod.anonymous,
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
        signInMethod: SignInMethod.anonymous,
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

      if (Lister.checkCanLoop(_topicsIShouldSubscribeTo) == true){

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

  /// USER ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> _completeUserZone({
    required UserModel? userModel,
  }) async {
    UserModel? _output = userModel;

    if (userModel != null){

      ZoneModel? _userZoneCompleted = userModel.zone;

      _userZoneCompleted ??= await ZoneProtocols.getZoneByIP();

      _userZoneCompleted = await ZoneProtocols.completeZoneModel(
        incompleteZoneModel: _userZoneCompleted,
        invoker: 'initializeHomeScreen.initializeUserZone',
      );

      _output = userModel.copyWith(
        zone: _userZoneCompleted,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void _downloadUserCountryCities({
    required UserModel? userModel,
  }){

    if (userModel?.zone?.countryID != null){
      unawaited(ZoneProtocols.fetchCitiesOfCountry(
        countryID: userModel!.zone!.countryID,
        // cityStageType: StageType.
      ));
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

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  static void _report(String text){
    blog('  User--> $text');
  }
  // -----------------------------------------------------------------------------

  /// USER MISSING FIELDS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> checkIfUserIsMissingFields() async {
    // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ START');

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    if (Authing.userIsSignedUp(_userModel?.signInMethod) == true){

      if (_userModel != null){
        final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
          userModel: _userModel,
        );
        /// MISSING FIELDS FOUND
        if (_thereAreMissingFields == true){
          await Formers.showUserMissingFieldsDialog(
            userModel: _userModel,
          );
          await BldrsNav.goToNewScreen(
              screen: UserEditorScreen(
                initialTab: UserEditorTab.pic,
                firstTimer: false,
                userModel: _userModel,
                reAuthBeforeConfirm: false,
                canGoBack: true,
                validateOnStartup: true,
                // checkLastSession: true,
                onFinish: () async {
                  await MirageNav.goTo(tab: BldrsTab.myInfo);
                  },
              )
          );
        }
      }

    }
    // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ END');
  }
  // -----------------------------------------------------------------------------
}
