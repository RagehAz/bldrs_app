part of bldrs_engine;
/// => TAMAM
class _UserSpawner {
  // -----------------------------------------------------------------------------

  const _UserSpawner();

  // -----------------------------------------------------------------------------

  /// SIGN OPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signByALocalSignedUpAccount() async {
    bool _success = false;

    final List<AccountModel> _accounts = await AccountLDBOps.readAllAccounts();
    final List<AccountModel> _withoutAnonymous = AccountModel.removeAnonymousAccounts(
      accounts: _accounts,
    );

    if (Lister.checkCanLoop(_withoutAnonymous) == true){
      _success = await _signInAccount(account: _withoutAnonymous.first);
    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signBySameDeviceSignedUpUser() async {

    final List<UserModel> _deviceUsers = await UserFireOps.readDeviceSignedUpUsers();

    if (Lister.checkCanLoop(_deviceUsers) == true){

      await AccountLDBOps.insertUserModels(
        users: _deviceUsers,
      );

      await Routing.goTo(route: TabName.bid_Auth);

    }

    return false;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signByLocalAnonymousAccount() async {
    bool _success = false;

    final List<AccountModel> _accounts = await AccountLDBOps.readAllAccounts();
    final AccountModel? _anonymousAccount = AccountModel.getAnonymousAccountFromAccounts(
      accounts: _accounts,
    );

    if (_anonymousAccount != null){
      _success = await _signInAccount(account: _anonymousAccount);
    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> signBySameDeviceAnonymousUser() async {
    bool _success = false;

    final List<UserModel> _deviceUsers = await UserFireOps.readDeviceAnonymousUsers();

    final UserModel? _anonymousUser = UserModel.getFirstAnonymousUserFromUsers(
      users: _deviceUsers,
    );

    final AccountModel? _account = AccountModel.createAccountFromAnonymousUser(
      userModel: _anonymousUser,
    );

    if (_account != null){

      _success = await _signInAccount(account: _account);

    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> createAnonymousAccount() async {
    bool _success = false;

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

        _success = await _signInAccount(
          account: _newAccount,
        );

      }

    }

    return _success;
  }
  // -----------------------------------------------------------------------------

  /// SIGN

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

        unawaited(AccountLDBOps.insertAccount(
          account: account,
        ));

        _continue = await _UserSpawner.fetchSetUser(
          userID: account.id,
        );



      }

    }

    return _continue;
  }
  // -----------------------------------------------------------------------------

  /// SET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> fetchSetUser({
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

        unawaited(RecorderProtocols.onStartSession());

      }

    }

    return _continue;
  }
  // -----------------------------------------------------------------------------
}
