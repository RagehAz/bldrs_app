part of bldrs_engine;

class _UserSessionStarter {
  // -----------------------------------------------------------------------------

  const _UserSessionStarter();

  // -----------------------------------------------------------------------------

  /// RENOVATION CHECK UPS

  // --------------------
  static Future<void> renovationCheckups() async {

    /// GET USER MODEL
    final UserModel? _old = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    if (_old != null){

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

  /// RESTART

  // --------------------
  ///
  static Future<void> signOutAndRestart() async {

  }
  // -----------------------------------------------------------------------------
}
