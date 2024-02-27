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
  // --------------------
}
