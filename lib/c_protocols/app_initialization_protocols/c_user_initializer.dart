import 'dart:async';

import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/widgets/sensors/app_version_builder.dart';
import 'package:bldrs/a_models/a_user/account_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/b_views/b_auth/x_auth_controllers.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/cupertino.dart';

class UserInitializer {
  // -----------------------------------------------------------------------------

  const UserInitializer();

  // -----------------------------------------------------------------------------

  /// USER MODEL

  // --------------------
  ///
  static Future<void> initializeUser() async {

    final BuildContext context = getMainContext();

    /// CREATE - FETCH USER MODEL
    await _initializeUserModel();

    /// GET USER MODEL
    final UserModel? _old = UsersProvider.proGetMyUserModel(
      context: context,
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
        context: context,
        oldUser: _old,
        newUser: _new,
        newPic: null,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// USER MODEL

  // --------------------
  static Future<void> _initializeUserModel() async {

    /// USER HAS ID
    if (Authing.getUserID() != null){

      await _logInByThisID(
        userID: Authing.getUserID(),
      );

    }

    /// USER HAS NO ID
    else {

      final AccountModel? _anonymousAccount = await AccountLDBOps.readAnonymousAccount();

      if (_anonymousAccount == null){
        await _composeNewAnonymousUser();
      }

      else {
        await _logInByThisID(
          userID: _anonymousAccount.id,
        );
      }

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _logInByThisID({
    required String? userID,
  }) async {

    if (userID != null){

      final UserModel? _userModel = await UserProtocols.fetch(
        context: getMainContext(),
        userID: userID,
        );

      UsersProvider.proSetMyUserModel(
        userModel: _userModel,
        notify: true,
      );

    }


  }
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // static Future<void> _setUserModelAndCompleteUserZoneLocally({
  //   required UserModel? userModel,
  //   required bool notify,
  // }) async {
  //
  //   UsersProvider.proSetMyUserModel(
  //     userModel: userModel,
  //     notify: notify,
  //   );
  //
  //   /// INSERT AUTH AND USER MODEL IN LDB
  //   await UserLDBOps.updateUserModel(userModel);
  //
  // }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _composeNewAnonymousUser() async {

    /// DEPRECATED
    // final AuthModel? _anonymousAuth = await Authing.anonymousSignin();
    //
    // final UserModel? _anonymousUser = await UserModel.anonymousUser(
    //   authModel: _anonymousAuth,
    // );

    final String _email = UserModel.createAnonymousEmail();
    final String _password = UserModel.createAnonymousPassword();

    final AuthModel? _authModel = await EmailAuthing.register(
      email: _email,
      password: _password,
      onError: (String? error) async {
        await AuthProtocols.onAuthError(error: error,);
        },
    );

    final UserModel? userModel = await UserProtocols.composeAnonymous(
      authModel: _authModel,
    );

    if (userModel != null){
      await rememberOrForgetAccount(
        rememberMe: true,
        account: AccountModel(
          id: userModel.id,
          email: _email,
          password: _password,
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// USER DEVICE MODEL

  // --------------------
  ///
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

        final BuildContext context = getMainContext();

        /// SHOULD REFETCH, and I will explain why
        /// user using device A renovated his user model and updated firebase
        /// closed device A and opens device B
        /// which did not listen to firebase but has an old model in LDB
        /// while checking this device has been changed
        /// we should get the most updated version of his model
        /// so we refetch model
        /// cheers
        _output = await UserProtocols.refetch(
            context: context,
            userID: _output.id,
        );

        if (_output != null){

          _output = _output.copyWith(
            device: _thisDevice,
          );

          /// TAKES TOO LONG AND NOTHING DEPENDS ON IT
          unawaited(_resubscribeToAllMyTopics(
            context: context,
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
    required BuildContext context,
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
  ///
  static Future<UserModel?> _userAppStateOps({
    required UserModel? userModel,
  }) async {
    UserModel? _output = userModel;
    AppStateModel? _userState = _output?.appState;

    if (_output != null && _userState != null){

      /// GET GLOBAL STATE
      final AppStateModel? _globalState = await AppStateProtocols.fetchGlobalAppState();

      if (_globalState != null){

        /// STATES IDENTICAL
        final bool _statesAreIdentical = AppStateModel.checkAppStatesAreIdentical(
            state1: _userState,
            state2: _globalState,
        );
        if (_statesAreIdentical == false){

          /// LDB CHECK
          if (_globalState.ldbVersion != _userState.ldbVersion){

            unawaited(LDBDoc.wipeOutEntireLDB());

            _userState = _userState.copyWith(
              ldbVersion: _globalState.ldbVersion,
            );

            _output = _output.copyWith(
              appState: _userState,
            );

          }

          /// APP VERSION CHECK
          final String _detectedVersion = await AppVersionBuilder.detectAppVersion();
          if (_detectedVersion != _userState.appVersion){

            _userState = _userState.copyWith(
              appVersion: _detectedVersion,
              minVersion: _detectedVersion,
            );

            _output = _output.copyWith(
              appState: _userState,
            );

          }

        }



      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
