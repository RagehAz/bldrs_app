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

    // final List<MirageModel> allMirages = HomeProvider.proGetMirages(
    //     context: getMainContext(),
    //     listen: false,
    // );
    // final MirageModel _mirageX0 = allMirages[0];
    // final MirageModel _mirageX1 = allMirages[1];
    //
    // await MirageModel.hideMiragesAbove(
    //     index: 0,
    //     mounted: mounted
    // );
    //
    // HomeProvider.proSelectMirageButton(
    //   mirageIndex: 1,
    //   mounted: mounted,
    //   button: BldrsTabber.bidMyInfo,
    // );
    //
    // await BldrsTabber.goToTab(tab: BldrsTab.myInfo);
    //
    // await _mirageX1.reShow(
    //   mounted: mounted,
    //   onBetweenReShow: () => _mirageX0.selectButton(
    //     button: BldrsTabber.bidMyProfile,
    //     mounted: mounted,
    //   ),
    // );

    await MirageNav.goTo(tab: BldrsTab.myInfo);

  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 1

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onUserTabChanged({
    required bool mounted,
    required String bid,
  }) async {

    // HomeProvider.proSelectMirageButton(
    //     mirageIndex: 1,
    //     mounted: mounted,
    //     button: bid
    // );
    //
    // await BldrsTabber.goToTab(
    //     tab: BldrsTabber.getTabByBid(bid),
    // );

    await MirageNav.goTo(
      tab: BldrsTabber.getTabByBid(bid),
    );

  }
  // -----------------------------------------------------------------------------
}
