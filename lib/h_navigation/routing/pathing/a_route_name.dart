part of bldrs_routing;

class ScreenName {
  // -----------------------------------------------------------------------------

  const ScreenName();

  // -----------------------------------------------------------------------------

  /// ROUTE NAMES

  // --------------------
  /// LOADING
  static const String logo = '/';
  // --------------------
  /// MAIN
  static const String home = '/home';
  // --------------------
  /// PREVIEWS
  static const String userPreview = '/userPreview';
  static const String bzPreview = '/bzPreview';
  static const String flyerPreview = '/flyerPreview';
  static const String flyerReviews = '/flyerPreview/flyerReviews';
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

  /// CHECKER

  // --------------------
  static const List<String> allScreens = [
    logo,
    home,
    userPreview,
    bzPreview,
    flyerPreview,
    flyerReviews,
    underConstruction,
    banner,
    privacy,
    terms,
    deleteMyData,
    dashboard,
  ];
  // --------------------
  ///
  static bool checkIsScreen({
    required String? routeName,
  }){

    return TextCheck.checkStringContainAnyOfSubStrings(
        string: routeName,
        subStrings: allScreens,
    );

  }
  // -----------------------------------------------------------------------------
}
