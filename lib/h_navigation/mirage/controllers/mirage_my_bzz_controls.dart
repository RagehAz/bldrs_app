part of mirage;

class _MirageMyBzzControls {
  // -----------------------------------------------------------------------------

  const _MirageMyBzzControls();

  // -----------------------------------------------------------------------------

  /// MIRAGE 0

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onMyBzzButtonTap({
    required bool mounted,
  }) async {

    // final List<MirageModel> allMirages = HomeProvider.proGetMirages(
    //     context: getMainContext(),
    //     listen: false,
    // );
    //
    // final MirageModel _mirageX0 = allMirages[0];
    // final MirageModel _mirageX1 = allMirages[1];
    //
    // await MirageModel.hideMiragesAbove(
    //     index: 0,
    //     mounted: mounted
    // );
    //
    //   await _mirageX1.reShow(
    //     mounted: mounted,
    //     onBetweenReShow: () => _mirageX0.selectButton(
    //       button: BldrsTabber.bidMyBzz,
    //       mounted: mounted,
    //     ),
    //   );

    await Routing.goTo(
      route: TabName.bid_MyBz_Info,
      arg: UsersProvider.proGetMyBzzIDs(context: getMainContext(), listen: false).first,
    );

  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 1

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onBzTap({
    required String bzID,
    required bool mounted,
    required int mirageIndex,
  }) async {

    // final List<MirageModel> allMirages = HomeProvider.proGetMirages(
    //     context: getMainContext(),
    //     listen: false,
    // );
    //
    // await HomeProvider.proSetActiveBzByID(
    //     bzID: bzID,
    //     context: getMainContext(),
    //     notify: true,
    // );
    //
    // final String _bidBz = BldrsTabber.generateBzBid(
    //   bzID: bzID,
    //   bid: BldrsTabber.bidMyBzInfo,
    // );
    //
    // await MirageModel.hideMiragesAbove(
    //     index: mirageIndex,
    //     mounted: mounted
    // );
    //
    // final MirageModel _nextMirage = allMirages[mirageIndex+1];
    //
    // HomeProvider.proSelectMirageButton(
    //     mirageIndex: mirageIndex,
    //     mounted: mounted,
    //     button: _bidBz
    // );
    //
    // await _nextMirage.reShow(
    //   mounted: mounted,
    //   onBetweenReShow: () => _nextMirage.selectButton(
    //     button: _bidBz,
    //     mounted: mounted,
    //   ),
    // );
    //
    // await BldrsTabber.goToTab(tab: BldrsTab.myBzInfo);

    await Routing.goTo(
      route: TabName.bid_MyBz_Info,
      arg: bzID,
    );

  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 2

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onBzTabChanged({
    required bool mounted,
    required String bid,
    required int mirageIndex,
  }) async {

    await Routing.goTo(
      route: bid,
      arg: HomeProvider.proGetActiveBzModel(context: getMainContext(), listen: false)!.id!,
    );

  }
  // -----------------------------------------------------------------------------
}
