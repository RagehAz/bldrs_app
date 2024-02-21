part of bldrs_engine;
/// => TAMAM
class UserSessionStarter {
  // -----------------------------------------------------------------------------

  const UserSessionStarter();

  // -----------------------------------------------------------------------------

  /// RENOVATION CHECK UPS

  // --------------------
  /// TESTED : WORKS PERFECT
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

      /// RENOVATE USER
      if (_identical == false){
        await UserProtocols.renovate(
          invoker: 'UserInitializer.initializeUser',
          oldUser: _old,
          newUser: _new,
        );
      }

      unawaited(_checkIfUserIsMissingFields());

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

    if (_output != null){

      /// THIS DEVICE MODEL
      final DeviceModel _thisDevice = await DeviceModel.generateDeviceModel();

      bool _shouldRefreshDevice = _output.device == null;

      /// MAYBE DEVICE CHANGED
      if (_shouldRefreshDevice == false){
        _shouldRefreshDevice = !DeviceModel.checkDevicesAreIdentical(
          device1: _thisDevice,
          device2: _output.device,
        );
      }

      /// MAYBE IT HAS BEEN SO LONG
      if (_shouldRefreshDevice == false){
        _shouldRefreshDevice = await _itHasBeenSoLongSinceLastDeviceRefresh();
      }

      /// REFRESH DEVICE MODEL
      if (_shouldRefreshDevice == true){

        _output = await UserProtocols.refetch(
          userID: _output.id,
        );

        if (_output != null){

          _output = _output.copyWith(
            device: _thisDevice,
          );

          /// TAKES TOO LONG AND NOTHING DEPENDS ON IT
          unawaited(resubscribeToAllMyTopics(myUserModel: _output));

          await _setDeviceHasBeenRefreshed();

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> resubscribeToAllMyTopics({
    required UserModel? myUserModel,
  }) async {

    // blog('resubscribeToAllMyTopics : START : ${myUserModel?.fcmTopics}');

    if (myUserModel != null){

      final List<String> _subscribeTo = _getTopicsIShouldSubscribeTo(
        myUserModel: myUserModel,
      );

      final List<String> _unSubscribeFrom = _getAllTopicsToUnsubscribeFrom(
        myUserModel: myUserModel,
      );

      for (final String topic in _unSubscribeFrom){
        await FCM.unsubscribeFromTopic(topicID: topic);
      }
      blog('FINISHED THE UNSUBSCRIBE');
      for (final String topic in _subscribeTo){
        await FCM.subscribeToTopic(topicID: topic);
      }
      blog('FINISHED THE SUBSCRIBE');

      // /// UNSUBSCRIBE FROM ALL
      // await Future.wait(<Future>[
      //   ...List.generate(_unSubscribeFrom.length, (index){
      //     return FCM.unsubscribeFromTopic(topicID: _unSubscribeFrom[index]);
      //   }),
      // ]);
      // /// SUBSCRIBE AGAIN
      // if (Lister.checkCanLoop(_subscribeTo) == true){
      //   await Future.wait(<Future>[
      //     ...List.generate(_subscribeTo.length, (index){
      //       return FCM.subscribeToTopic(topicID: _subscribeTo[index],);
      //     }),
      //   ]);
      // }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _getTopicsIShouldSubscribeTo({
    required UserModel? myUserModel,
  }){
    final List<String> _output = <String>[];

    final List<String> _userTopics = myUserModel?.fcmTopics ?? [];

    for (final String topicID in _userTopics){

      final bool _containUnderscore = TextCheck.stringContainsSubString(
        string: topicID,
        subString: '_',
      );

      if (_containUnderscore == true){
        _output.add(topicID);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _getAllTopicsToUnsubscribeFrom({
    required UserModel? myUserModel,
  }){
    final List<String> _output = <String>[];

    final List<String> _userTopics = TopicModel.getAllPossibleUserBzAdminTopicsForAUser(
      userModel: myUserModel,
    );

    for (final String topicID in _userTopics){

      final bool _containUnderscore = TextCheck.stringContainsSubString(
        string: topicID,
        subString: '_',
      );

      if (_containUnderscore == true){
        _output.add(topicID);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DEVICE HAS BEEN REFRESHED

  // --------------------
  static const String _deviceIsRefreshedDoc = 'deviceRefreshed';
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _itHasBeenSoLongSinceLastDeviceRefresh() async {
    bool _output = true;

    final Map<String, dynamic>? _map = await LDBOps.readMap(
        docName: _deviceIsRefreshedDoc,
        id: 'id',
        primaryKey: 'id',
    );

    if (_map != null){

      final DateTime? _time = Timers.decipherTime(
          time: _map['time'],
          fromJSON: true,
      );

      if (_time != null){

        const int _numberOfDays = 20;

        _output = Timers.checkTimeDifferenceIsBiggerThan(
            time1: _time,
            time2: DateTime.now(),
            maxDifferenceInMinutes: 60 * 24 * _numberOfDays,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _setDeviceHasBeenRefreshed() async {

    await LDBOps.insertMap(
        docName: _deviceIsRefreshedDoc,
        primaryKey: 'id',
        // allowDuplicateIDs: false,
        input: {
          'id': 'id',
          'time': Timers.cipherTime(time: DateTime.now(), toJSON: true),
        },
    );

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

  /// USER MISSING FIELDS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _checkIfUserIsMissingFields() async {
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
                  await Nav.goBack(context: getMainContext());
                  await Routing.goTo(route: TabName.bid_My_Info);
                },
              )
          );
        }
      }

    }
    // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ END');
  }
  // -----------------------------------------------------------------------------

  /// RESTART

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> signOutAndRestart() async {

    /// PROVIDER
    UsersProvider.proSetMyUserModel(userModel: null, notify: false);

    await Future.wait(<Future>[

      UserLDBOps.deleteUserOps(Authing.getUserID()),
      AccountLDBOps.deleteAllAccounts(),
      AuthProtocols.signOutBldrs(),

    ]);

    await Routing.goTo(route: ScreenName.logo);

  }
  // -----------------------------------------------------------------------------
}
