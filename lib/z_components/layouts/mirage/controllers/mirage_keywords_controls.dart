part of mirage;
// ignore_for_file: unused_element

class _MirageKeywordsControls {
  // -----------------------------------------------------------------------------

  const _MirageKeywordsControls();

  // -----------------------------------------------------------------------------

  /// MIRAGE 0

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSectionsButtonTap({
    required bool mounted,
  }) async {

    // await BldrsTabber.goToTab(tab: BldrsTab.home);
    //
    // final List<MirageModel> allMirages = HomeProvider.proGetMirages(
    //   context: getMainContext(),
    //   listen: false,
    // );
    //
    // final MirageModel _mirage1 = allMirages[0];
    // final MirageModel _mirage2 = allMirages[1];
    //
    // await MirageModel.hideMiragesAbove(
    //     index: 0,
    //     mounted: mounted
    // );
    //
    //   await _mirage2.reShow(
    //     mounted: mounted,
    //     onBetweenReShow: () => _mirage1.selectButton(
    //       button: BldrsTabber.bidHome,
    //       mounted: mounted,
    //     ),
    //   );

    await MirageNav.goTo(
      tab: BldrsTab.home,
    );

  }
  // -----------------------------------------------------------------------------

  /// MIRAGE 1

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSelectFlyerType({
    required String path,
    required bool mounted,
    required Map<String, dynamic>? keywordsMap,
  }) async {

    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
        context: getMainContext(),
        listen: false,
    );
    final MirageModel _mirageX1 = allMirages[1];
    final MirageModel _mirageX2 = allMirages[2];

    final String? _phid = Pathing.getLastPathNode(path);

    if (_phid != null){

      if (Pathing.getLastPathNode(_mirageX1.selectedButton.value) == _phid){

        await MirageModel.hideMiragesAbove(
          index: 1,
          mounted: mounted,
        );

        _mirageX1.clearButton(mounted: mounted,);
      }

      else {

        await MirageModel.hideMiragesAbove(
          mounted: mounted,
          index: 1,
        );

        await _mirageX2.reShow(
          mounted: mounted,
          onBetweenReShow: () => _mirageX1.selectButton(
            button: path,
            mounted: mounted,
          ),
        );

      }

    }


  }
  // -----------------------------------------------------------------------------

  /// ON PHID TAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onPhidTap({
    required int index,
    required String path,
    required Map<String, dynamic>? keywordsMap,
    required bool mounted,
  }) async {

    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
        context: getMainContext(),
        listen: false,
    );
    final MirageModel thisMirage = allMirages[index];
    final MirageModel? mirageAbove = index >= 4 ? null : allMirages[index+1];


    final String? _phid = Pathing.getLastPathNode(path);

    /// ALREADY SELECTED
    if (thisMirage.selectedButton.value == _phid){

      await MirageModel.hideMiragesAbove(
        mounted: mounted,
        index: thisMirage.index,
      );

      thisMirage.clearButton(mounted: mounted,);

    }

    /// NOT SELECTED
    else {

      await MirageModel.hideMiragesAbove(
        mounted: mounted,
        index: thisMirage.index,
      );

      final dynamic _son = MapPathing.getNodeValue(
          path: path,
          map: keywordsMap
      );

      if (_son is bool){

        await setPhidAndCloseMirages(
          path: path,
          mounted: mounted,
          allMirages: allMirages,
        );

      }

      else {

        /// NO MORE MIRAGES ABOVE
        if (mirageAbove == null){
          thisMirage.selectButton(
            button: path,
            mounted: mounted,
          );
        }

        /// SELECT THE PHID AND SHOW NEXT MIRAGE
        else {
          await mirageAbove.reShow(
            mounted: mounted,
            onBetweenReShow: () => thisMirage.selectButton(
              button: path,
              mounted: mounted,
            ),
          );
        }

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// PHIDS DIALOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> showPhidsDialog({
    required Map<String, dynamic>? keywordsMap,
    required String? path,
    required List<MirageModel> allMirages,
    required MirageModel thisMirage,
    required bool mounted,
  }) async {

    await MirageModel.hideMiragesAbove(
        index: thisMirage.index,
        mounted: mounted
    );

    if (path != null){

      final Map<String, dynamic>? _sonMap = MapPathing.getNodeValue(
        path: path,
        map: keywordsMap,
      );


      final List<String> _phids = _sonMap?.keys.toList() ?? [];

      if (Lister.checkCanLoop(_phids) == true){

        final FlyerType? flyerType = FlyerTyper.concludeFlyerTypeByChainID(
            chainID: Pathing.getFirstPathNode(path: path)
        );

        final String? _selectedPhid = await Dialogs.phidsDialogs(
          phids: _phids,
          headline: Verse(
            id: FlyerTyper.getFlyerTypePhid(flyerType: flyerType),
            translate: true,
          ),
        );

        thisMirage.clearButton(mounted: mounted,);

        if (_selectedPhid != null){

          await setPhidAndCloseMirages(
            allMirages: allMirages,
            mounted: mounted,
            path: '$path$_selectedPhid/',
          );

        }

      }

    }


  }
  // -----------------------------------------------------------------------------

  /// SETTING PHID

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> setPhidAndCloseMirages({
    required String? path,
    required bool mounted,
    required List<MirageModel> allMirages,
  }) async {

    if (TextCheck.isEmpty(path) == false){

      final FlyerType? flyerType = FlyerTyper.concludeFlyerTypeByChainID(
          chainID: Pathing.getFirstPathNode(path: path)
      );

      await MirageModel.hideMiragesAbove(
          index: 0,
          mounted: mounted
      );

      await setActivePhidK(
        phidK: Pathing.getLastPathNode(path),
        flyerType: flyerType,
      );

      MirageModel.clearAllMirageButtons(
        mirages: allMirages,
        mounted: mounted,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
