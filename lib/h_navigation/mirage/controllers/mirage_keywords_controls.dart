part of mirage;
// ignore_for_file: unused_element

class MirageKeywordsControls {
  // -----------------------------------------------------------------------------

  const MirageKeywordsControls();

  // -----------------------------------------------------------------------------

  /// MIRAGE 0

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSectionsButtonTap({
    required bool mounted,
  }) async {

    final String? _phid = HomeProvider.proGetHomeWallPhid(context: getMainContext(), listen: false);
    if (_phid != null){
      await Routing.goTo(route: _phid);
    }
    else {
      await Routing.goTo(route: TabName.bid_Home,);
    }

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
            deselectAllAbove: true,
          ),
        );

        await _mirageX1.scrollTo(
            buttonIndex: MapPathing.getNodeOrderIndexByPath(
              map: keywordsMap,
              path: path,
            ),
            listLength: 6,
        );

      }

    }


  }
  // -----------------------------------------------------------------------------

  /// ON PHID TAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onPhidTap({
    required int mirageIndex,
    required String path,
    required Map<String, dynamic>? keywordsMap,
    required bool mounted,
  }) async {

    blog('onPhidTap : path : $path');

    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
        context: getMainContext(),
        listen: false,
    );
    final MirageModel thisMirage = allMirages[mirageIndex];
    final MirageModel? mirageAbove = mirageIndex >= 4 ? null : allMirages[mirageIndex+1];


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
          thisMirage: thisMirage,
        );

      }

      else {

        /// NO MORE MIRAGES ABOVE
        if (mirageAbove == null){
          thisMirage.selectButton(
            button: path,
            mounted: mounted,
            deselectAllAbove: true,
          );
        }

        /// SELECT THE PHID AND SHOW NEXT MIRAGE
        else {

          await mirageAbove.reShow(
            mounted: mounted,
            onBetweenReShow: () => thisMirage.selectButton(
              button: path,
              mounted: mounted,
              deselectAllAbove: true,
            ),
          );

          await thisMirage.scrollTo(
            buttonIndex: MapPathing.getNodeOrderIndexByPath(path: path, map: keywordsMap),
            listLength: MapPathing.getBrothersLength(path: path, map: keywordsMap),
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

        final FlyerType? flyerType = FlyerTyper.concludeFlyerTypeByRootID(
            rootID: Pathing.getFirstPathNode(path: path)
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
            thisMirage: thisMirage,
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
    required MirageModel thisMirage,
  }) async {

    if (TextCheck.isEmpty(path) == false){



      // await MirageModel.hideMiragesAbove(
      //     index: 0,
      //     mounted: mounted
      // );

      thisMirage.selectButton(
        button: path,
        mounted: mounted,
        deselectAllAbove: true,
      );

      await _setActivePhidK(
        path: path,
      );

      // MirageModel.clearAllMirageButtons(
      //   mirages: allMirages,
      //   mounted: mounted,
      // );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _setActivePhidK({
    required String? path,
  }) async {

    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
      context: getMainContext(),
      listen: false,
    );

    final bool isActive = Keyworder.checkNodeIsActiveInZone(
      path: path,
      keywordsMap: await KeywordsProtocols.fetch(),
      zonePhidsModel: await ZonePhidsProtocols.fetch(zoneModel: _currentZone),
    );

    /// A - if section is not active * if user is author or not
    if (isActive == false) {

      await _showPhidNotActiveDialog(
        phid: Pathing.getLastPathNode(path)!,
      );

    }

    /// A - if section is active
    else {

      final HomeProvider _pro = Provider.of<HomeProvider>(getMainContext(), listen: false);
      await _pro.changeHomeWallFlyerType(
        flyerType: FlyerTyper.concludeFlyerTypeByRootID(rootID: Pathing.getFirstPathNode(path: path)),
        phid: Pathing.getLastPathNode(path)!,
        notify: true,
      );

    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _showPhidNotActiveDialog({
    required String phid,
  }) async {

    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(context: getMainContext(), listen: false);
    final String? _cityName = _currentZone?.cityName ?? _currentZone?.countryName;

    final String _title = '${getWord('phid_flyers_of')} '
        '${getWord(phid)} '
        '${getWord('phid_are_not_available')} '
        '${getWord('phid_inn')} '
        '$_cityName';

    await Dialogs.centerNotice(
      verse: getVerse('phid_no_flyers_yet')!,
      body: Verse.plain(_title),
    );

    // phid_inform_a_friend

  }
  // -----------------------------------------------------------------------------
}
