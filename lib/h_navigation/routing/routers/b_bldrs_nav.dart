part of bldrs_routing;
// ignore_for_file: non_constant_identifier_names

/// => TAMAM
class BldrsNav {
  // -----------------------------------------------------------------------------

  const BldrsNav();

  // -----------------------------------------------------------------------------

  /// PUSH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> goToNewScreen({
    required Widget screen,
    PageTransitionType? pageTransitionType,
    Duration duration = const Duration(milliseconds: 300),
  }){
    return Nav.goToNewScreen(
      context: getMainContext(),
      screen: screen,
      pageTransitionType: pageTransitionType,
      duration: duration,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
    );
  }
  // -----------------------------------------------------------------------------

  /// IMAGE FULL SCREEN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToImageFullScreenByBytes({
    required Uint8List bytes,
    required Dimensions dims,
    required String title,
  }) async {

    await BldrsNav.goToNewScreen(
      screen: SlideFullScreen(
        image: bytes,
        imageSize: dims,
        filter: ImageFilterModel.noFilter(),
        title: Verse.plain(title),
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToImageFullScreenByPath({
    required String? path,
    required String? title,
  }) async {

    final PicModel? _pic = await PicProtocols.fetchPic(path);

    await BldrsNav.goToNewScreen(
      screen: SlideFullScreen(
        image: _pic?.bytes,
        imageSize: Dimensions(
          width: _pic?.meta?.width,
          height: _pic?.meta?.height,
        ),
        filter: ImageFilterModel.noFilter(),
        title: Verse.plain(title),
      ),
    );

  }


  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNootTapStartsFromHome(String? routeName){

    switch (routeName){
      /// --------------------
      // case Routing.staticLogoScreen     : return true; break;
      // case Routing.animatedLogoScreen   : return true; break;
      /// --------------------
      // case Routing.home                 : return true; break;
      // case Routing.auth                 : return true; break;
      // case RouteName.search               : return true;
      // case RouteName.appSettings          : return true;
      /// --------------------
      // case RouteName.myUserProfile              : return true;
      // case Routing.savedFlyers          : return true; break;
      // case Routing.profileEditor        : return true;
      /// --------------------
      // case RouteName.myUserNotes      : return true;
      /// --------------------
      // case Routing.bzEditor             : return true;
      // case Routing.flyerEditor          : return true;
      /// --------------------
      // case RouteName.myBzAboutPage       : return true;
      // case RouteName.myBzFlyersPage       : return true;
      // case RouteName.myBzTeamPage         : return true;
      // case RouteName.myBzNotesPage        : return true;
      /// --------------------
      case ScreenName.userPreview          : return false;
      case ScreenName.bzPreview            : return false;
      case ScreenName.flyerPreview         : return false;
      case ScreenName.flyerReviews         : return false;
      // case RouteName.countryPreview       : return false;
      /// --------------------
      default: return true;
    }

  }

}
