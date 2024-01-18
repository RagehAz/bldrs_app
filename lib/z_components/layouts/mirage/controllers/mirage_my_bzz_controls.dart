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
    required List<MirageModel> allMirages,
  }) async {

    blog('wtffff is going onnn');

    final MirageModel _mirageX0 = allMirages[0];
    final MirageModel _mirageX1 = allMirages[1];

    await MirageModel.hideMiragesAbove(
        allMirages: allMirages,
        aboveThisMirage: allMirages[0],
        mounted: mounted
    );

    // /// ALREADY SELECTED
    // if (_mirageX0.selectedButton.value == BldrsTabber.bidBzz){
    //   // _mirageX0.clearButton(mounted: mounted);
    // }
    //
    // /// SHOULD SELECT
    // else {

      await _mirageX1.reShow(
        mounted: mounted,
        onBetweenReShow: () => _mirageX0.selectButton(
          button: BldrsTabber.bidBzz,
          mounted: mounted,
        ),
      );

    // }

  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 1

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onBzTap({
    required String bzID,
    required bool mounted,
    required List<MirageModel> allMirages,
    required MirageModel thisMirage,
  }) async {

    await HomeProvider.proSetActiveBzByID(
        bzID: bzID,
        context: getMainContext(),
        notify: false,
    );

    final String _bidBz = BldrsTabber.generateBzBid(
      bzID: bzID,
      bid: BldrsTabber.bidMyBzAbout,
    );

    await MirageModel.hideMiragesAbove(
        allMirages: allMirages,
        aboveThisMirage: thisMirage,
        mounted: mounted
    );

    final MirageModel _nextMirage = allMirages[thisMirage.index+1];

    thisMirage.selectButton(
      button: _bidBz,
      mounted: mounted,
    );

    await _nextMirage.reShow(
      mounted: mounted,
      onBetweenReShow: () => _nextMirage.selectButton(
        button: _bidBz,
        mounted: mounted,
      ),
    );


    await BldrsTabber.goToTab(tab: BldrsTab.myBzProfile);


  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 2

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onBzTabChanged({
    required bool mounted,
    required List<MirageModel> allMirages,
    required MirageModel thisMirage,
    required String bid,
  }) async {


    final String _bidBz = BldrsTabber.generateBzBid(
      bzID: HomeProvider.proGetActiveBzModel(context: getMainContext(), listen: false)!.id!,
      bid: bid,
    );

    thisMirage.selectButton(
      button: _bidBz,
      mounted: mounted,
    );

    await MirageModel.hideMiragesAbove(
        allMirages: allMirages,
        aboveThisMirage: thisMirage,
        mounted: mounted
    );

    final BldrsTab _tab = BldrsTabber.getTabByBid(bid);

    await BldrsTabber.goToTab(tab: _tab);

  }
  // -----------------------------------------------------------------------------
}
