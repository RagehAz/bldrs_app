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
  }) async {

    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
        context: getMainContext(),
        listen: false,
    );
    final MirageModel _mirageX0 = allMirages[0];
    final MirageModel _mirageX1 = allMirages[1];

    await MirageModel.hideMiragesAbove(
        index: 0,
        mounted: mounted
    );

    // /// ALREADY SELECTED
    // if (_mirageX0.selectedButton.value == BldrsTabs.bidProfile){
    //   // _mirageX0.clearButton(mounted: mounted);
    // }
    //
    // /// SHOULD SELECT
    // else {

    HomeProvider.proSelectMirageButton(
      mirageIndex: 1,
      mounted: mounted,
      button: BldrsTabber.bidProfileInfo,
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
    required String bid,
  }) async {

    HomeProvider.proSelectMirageButton(
        mirageIndex: 1,
        mounted: mounted,
        button: bid
    );

    await BldrsTabber.goToTab(
        tab: BldrsTabber.getTabByBid(bid),
    );

  }
  // -----------------------------------------------------------------------------
}
