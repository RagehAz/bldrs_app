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
}
