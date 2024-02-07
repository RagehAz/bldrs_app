part of bldrs_engine;

class UserInitializer {
  // -----------------------------------------------------------------------------

  const UserInitializer();

  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  ///
  static Future<void> initialize() async {

    final String? _userID = Authing.getUserID();

    if (_userID == null){
      await _unKnownUser();
    }

    else {
      await _knownUser();
    }

  }
  // --------------------
  ///
  static Future<void> _unKnownUser() async {

    /// FIND LOCAL SIGNED ACCOUNTS
    bool _success = await _UserSpawner.signByALocalSignedUpAccount();

    /// OR FIND FIRE ACCOUNTS BY DEVICE
    if (_success == false){
      _success = await _UserSpawner.signBySameDeviceSignedUpUser();
    }

    /// OR FIND LOCAL ANONYMOUS ACCOUNT
    if (_success == false){
      _success = await _UserSpawner.signByLocalAnonymousAccount();
    }

    /// OR FIND FIRE ANONYMOUS ACCOUNT
    if (_success == false){
      _success = await _UserSpawner.signBySameDeviceAnonymousUser();
    }

    /// OR CREATE ANONYMOUS ACCOUNT
    if (_success == false){
      _success = await _UserSpawner.createAnonymousAccount();
    }

  }
  // --------------------
  ///
  static Future<void> _knownUser() async {

    /// FETCH
    final bool _success = await _UserSpawner.fetchSetUser(userID: Authing.getUserID());

    /// INITIALIZE USER SESSION
    if (_success == true){
      await _UserSessionStarter.renovationCheckups();
    }

    /// NOT FOUND => SIGN OUT & RESTART
    else {
      await _UserSessionStarter.signOutAndRestart();
    }

  }
  // -----------------------------------------------------------------------------
}
