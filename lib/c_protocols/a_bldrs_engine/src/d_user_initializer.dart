part of bldrs_engine;
/// => TAMAM
class UserInitializer {
  // -----------------------------------------------------------------------------

  const UserInitializer();

  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<void> _unKnownUser() async {

    /// FIND LOCAL SIGNED ACCOUNTS
    bool _success = await _UserSpawner.signByALocalSignedUpAccount();
    // blog('SSS : LOCAL SIGNED USER : $_success');

    /// OR FIND FIRE ACCOUNTS BY DEVICE
    if (_success == false){
      _success = await _UserSpawner.signBySameDeviceSignedUpUser();
      // blog('SSS : SIGNED USER BY DEVICE : $_success');
    }

    /// OR FIND LOCAL ANONYMOUS ACCOUNT
    if (_success == false){
      _success = await _UserSpawner.signByLocalAnonymousAccount();
      // blog('SSS : LOCAL ANONYMOUS USER : $_success');
    }

    /// OR FIND FIRE ANONYMOUS ACCOUNT
    if (_success == false){
      _success = await _UserSpawner.signBySameDeviceAnonymousUser();
      // blog('SSS : ANONYMOUS USER BY DEVICE : $_success');
    }

    /// OR CREATE ANONYMOUS ACCOUNT
    if (_success == false){
      _success = await _UserSpawner.createAnonymousAccount();
      // blog('SSS : NEW ANONYMOUS USER : $_success');
    }

    /// SOMETHING IS TERRIBLY WRONG
    if (_success == false){
      await UserSessionStarter.signOutAndRestart();
      // blog('SSS : SOMETHING IS VERY WRONG : USERID : ${Authing.getUserID()}');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _knownUser() async {

    /// FETCH
    final bool _success = await _UserSpawner.fetchSetUser(userID: Authing.getUserID());

    /// INITIALIZE USER SESSION
    if (_success == true){
      await UserSessionStarter.renovationCheckups();
      // blog('SSS : RENOVATION DONE');
    }

    /// NOT FOUND => SIGN OUT & RESTART
    else {
      // blog('SSS : THERE YOU ARE BITCH : USERID : ${Authing.getUserID()}');
      await UserSessionStarter.signOutAndRestart();
    }

  }
  // -----------------------------------------------------------------------------
}
