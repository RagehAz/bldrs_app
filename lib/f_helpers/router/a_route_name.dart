
class RouteName {
  // -----------------------------------------------------------------------------

  const RouteName();

  // -----------------------------------------------------------------------------

  /// ROUTE NAMES : ROUTES_LIST

  // --------------------
  /// LOADING
  static const String staticLogo = '/'; /// ---> [static route]
  static const String animatedLogo = '/'; /// ---> [static route]
  // --------------------
  /// MAIN
  static const String home = '/'; /// ---> [static route]
  // static const String auth = '/auth'; /// ---> [static route]
  static const String search = '/search'; /// ---> [static route]
  static const String appSettings = '/appSettings'; /// ---> [static route]
  // --------------------
  /// PROFILE
  static const String myUserProfile = '/profile/about'; /// ---> [static route]
  static const String myUserNotes = '/profile/notifications'; /// ---> [dynamic route]
  static const String myUserFollowing = '/profile/following'; /// ---> [dynamic route]
  static const String myUserSettings = '/profile/settings'; /// ---> [dynamic route]
  static const String savedFlyers = '/profile/savedFlyers'; /// ---> [static route]
  // static const String profileEditor = '/profile/editor'; /// ---> [manual]
  // --------------------
  /// MY BZ
  static const String myBzAboutPage = '/myBz/about'; /// ---> [dynamic route]
  static const String myBzFlyersPage = '/myBz/flyers'; /// ---> [dynamic route]
  static const String myBzTeamPage = '/myBz/team'; /// ---> [dynamic route]
  static const String myBzNotesPage = '/myBz/notifications'; /// ---> [dynamic route]
  static const String myBzSettingsPage = '/myBz/settings'; /// ---> [dynamic route]
  // static const String bzEditor = '/myBz/bzEditor'; /// ---> [manual]
  // static const String flyerEditor = '/myBz/flyerEditor'; /// ---> [manual]
  // --------------------
  /// PREVIEWS
  static const String userPreview = '/userPreview'; /// ---> [static route]
  static const String bzPreview = '/bzPreview'; /// ---> [static route]
  static const String flyerPreview = '/flyerPreview'; /// ---> [static route]
  static const String flyerReviews = '/flyerPreview/flyerReviews'; /// ---> [static route]
  // static const String countryPreview = '/countryPreview'; /// ---> [static route]
  // --------------------
  /// WEB
  static const String underConstruction = '/underConstruction'; /// ---> [static route]
  static const String banner = '/banner'; /// ---> [static route]
  static const String privacy = '/privacy'; /// ---> [static route]
  static const String terms = '/terms'; /// ---> [static route]
  static const String deleteMyData = '/deleteMyData'; /// ---> [static route]
  // --------------------
  /// DASHBOARD
  static const String dashboard = '/dashboard';
  // -----------------------------------------------------------------------------

  /// DEPRECATED : OLD ROUTER MAP

  // --------------------
  /// OLD : LEFT FOR REFERENCE
  /*
  static Map<String, WidgetBuilder> routesMap = {
    Routing.staticLogoScreen: (BuildContext ctx) => const StaticLogoScreen(),
    Routing.animatedLogoScreen: (BuildContext ctx) => const AnimatedLogoScreen(),
    Routing.auth: (BuildContext ctx) => const AuthScreen(),
    Routing.home: (BuildContext ctx) => const HomeScreen(),
    Routing.savedFlyers: (BuildContext ctx) => const SavedFlyersScreen(),
    Routing.search: (BuildContext ctx) => const SuperSearchScreen(),
    Routing.appSettings: (BuildContext ctx) => const AppSettingsScreen(),
  };
   */
  // -----------------------------------------------------------------------------
}
