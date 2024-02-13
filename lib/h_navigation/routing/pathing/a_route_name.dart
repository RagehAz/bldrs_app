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
  /// TESTED : WORKS PERFECT
  static bool checkIsScreen({
    required String? routeName,
  }){

    if (routeName == logo){
      return true;
    }

    else {

      final List<String> _all = [...allScreens];
      _all.remove(logo);

      return TextCheck.checkStringContainAnyOfSubStrings(
          string: routeName,
          subStrings: _all,
      );
    }

  }
  // -----------------------------------------------------------------------------
}

/*
THE REDIRECTOR
adb shell 'am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "bldrs://deep/redirect"' net.bldrs.app

 */
