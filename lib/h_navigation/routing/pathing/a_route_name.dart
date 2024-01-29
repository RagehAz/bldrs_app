part of bldrs_routing;

class ScreenName {
  // -----------------------------------------------------------------------------

  const ScreenName();

  // -----------------------------------------------------------------------------

  /// ROUTE NAMES : ROUTES_LIST

  // --------------------
  /// LOADING
  static const String staticLogo = '/'; /// ---> [static route]
  // --------------------
  /// MAIN
  static const String home = '/home'; /// ---> [static route]
  // --------------------
  /// PREVIEWS
  static const String userPreview = '/userPreview';
  static const String bzPreview = '/bzPreview';
  static const String flyerPreview = '/flyerPreview';
  static const String flyerReviews = '/flyerPreview/flyerReviews';
  // static const String countryPreview = '/countryPreview'; /// ---> [static route]
  // --------------------
  /// WEB
  static const String underConstruction = '/underConstruction';
  static const String banner = '/banner';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
  static const String deleteMyData = '/deleteMyData';
  // --------------------
  /// DASHBOARD
  static const String dashboard = '/dashboard';
  // -----------------------------------------------------------------------------
}
