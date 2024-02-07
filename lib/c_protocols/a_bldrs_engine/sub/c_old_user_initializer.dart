part of bldrs_engine;

class OldUserInitializer {
  // -----------------------------------------------------------------------------

  const OldUserInitializer();

  // -----------------------------------------------------------------------------

  /// USER MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> initializeUser() async {

    /// CREATE - FETCH USER MODEL
    final bool _continue = await _initializeUserModel();

    if (_continue == true){

      await _UserSessionStarter.renovationCheckups();

    }

    return _continue;
  }
  // -----------------------------------------------------------------------------

  /// USER MODEL

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _initializeUserModel() async {
    bool? _continue = false;

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

      /// HAS NORMAL ACCOUNT IN LDB ALREADY
      if (Lister.checkCanLoop(_withoutAnonymous) == true){
        _continue = await _signInAccount(account: _withoutAnonymous.first);
      }

      /// HAS ANONYMOUS ACCOUNT IN LDB
      if (_continue == false && _anonymousAccount != null){
        _continue = await _signInAccount(account: _anonymousAccount);
      }

      /// NO ACCOUNTS IN LDB FOUND
      if (_continue == false){

        final List<UserModel> _deviceUsers = await UserFireOps.readDeviceUsers();
        final List<UserModel> _signedUpUsers = UserModel.getSignedUpUsersOnly(
          users: _deviceUsers,
        );
        // final UserModel? _anonymousUserOfThisDevice = await UserFireOps.readAnonymousUserByDeviceID();

        /// HAS A FIRE USER MODELS LOST FROM LDB
        if (Lister.checkCanLoop(_signedUpUsers) == true){

          await AccountLDBOps.insertUserModels(
            users: _signedUpUsers,
          );

          await Routing.goTo(route: TabName.bid_Auth);
          _continue = false;

        }

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
}
