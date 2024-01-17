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
    required List<_MirageModel> allMirages,
  }) async {

    final _MirageModel _mirageX0 = allMirages[0];
    final _MirageModel _mirageX1 = allMirages[1];

    await _MirageModel.hideMiragesAbove(
        allMirages: allMirages,
        aboveThisMirage: allMirages[0],
        mounted: mounted
    );

    /// ALREADY SELECTED
    if (_mirageX0.selectedButton.value == BldrsTabber.bidBzz){
      // _mirageX0.clearButton(mounted: mounted);
    }

    /// SHOULD SELECT
    else {

      await _mirageX1.reShow(
        mounted: mounted,
        onBetweenReShow: () => _mirageX0.selectButton(
          button: BldrsTabber.bidBzz,
          mounted: mounted,
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 1

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onBzTap({
    required String bzID,
    required bool mounted,
    required List<_MirageModel> allMirages,
  }) async {

    // BzzProvider.proSetActiveBzByID(
    //     bzID: bzID,
    //     context: getMainContext(),
    //     notify: false,
    // );
    //
    // await _MirageModel.hideAllAndShowPyramid(
    //   models: allMirages,
    //   mounted: mounted,
    //   mirage0: allMirages[0],
    // );
    //
    // await Nav.goToRoute(getMainContext(), RouteName.myBzFlyersPage);

    final _MirageModel _mirageX1 = allMirages[1];
    final _MirageModel _mirageX2 = allMirages[2];

    await _MirageModel.hideMiragesAbove(
        allMirages: allMirages,
        aboveThisMirage: allMirages[1],
        mounted: mounted
    );

    /// ALREADY SELECTED
    if (_mirageX1.selectedButton.value == 'bzID_$bzID'){
      _mirageX1.clearButton(mounted: mounted);
    }

    /// SHOULD SELECT
    else {
      await _mirageX2.reShow(
        mounted: mounted,
        onBetweenReShow: () => _mirageX1.selectButton(
          button: 'bzID_$bzID',
          mounted: mounted,
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 2

  // --------------------
  ///
  static Future<void> onBzTabChanged({
    required bool mounted,
    required List<_MirageModel> allMirages,
    required String bid,
  }) async {

    final _MirageModel _mirage2 = allMirages[2];

    _mirage2.selectButton(
      button: bid,
      mounted: mounted,
    );

  }
  // -----------------------------------------------------------------------------
}
