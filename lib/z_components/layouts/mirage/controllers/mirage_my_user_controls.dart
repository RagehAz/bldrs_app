part of mirage;

class _MirageMyUserControls {
  // -----------------------------------------------------------------------------

  const _MirageMyUserControls();

  // -----------------------------------------------------------------------------

  /// MIRAGE 0

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUserProfileButtonTap({
    required bool mounted,
    required List<_MirageModel> allMirages,
  }) async {

    // await _MirageModel.hideAllAndShowPyramid(
    //   models: allMirages,
    //   mounted: mounted,
    //   mirage0: allMirages[0],
    // );
    //
    // await Nav.goToRoute(context, RouteName.myUserProfile);

    final _MirageModel _mirageX0 = allMirages[0];
    final _MirageModel _mirageX1 = allMirages[1];

    await _MirageModel.hideMiragesAbove(
        allMirages: allMirages,
        aboveThisMirage: allMirages[0],
        mounted: mounted
    );

    // /// ALREADY SELECTED
    // if (_mirageX0.selectedButton.value == BldrsTabs.bidProfile){
    //   // _mirageX0.clearButton(mounted: mounted);
    // }
    //
    // /// SHOULD SELECT
    // else {

      _mirageX1.selectButton(
        button: BldrsTabber.bidProfileInfo,
        mounted: mounted,
      );

      await BldrsTabber.goToTab(tab: BldrsTab.myProfile);

      await _mirageX1.reShow(
        mounted: mounted,
        onBetweenReShow: () => _mirageX0.selectButton(
          button: BldrsTabber.bidProfile,
          mounted: mounted,
        ),
      );
    // }

  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 1

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUserTabChanged({
    required bool mounted,
    required List<_MirageModel> allMirages,
    required String bid,
  }) async {

    final _MirageModel _mirage1 = allMirages[1];

    _mirage1.selectButton(
      button: bid,
      mounted: mounted,
    );

    await BldrsTabber.goToTab(
        tab: BldrsTabber.getTabByBid(bid),
    );

  }
  // -----------------------------------------------------------------------------
}
