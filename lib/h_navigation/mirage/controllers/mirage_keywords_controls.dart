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

    await Routing.goTo(
      route: TabName.bid_Home,
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

      thisMirage.selectButton(button: path, mounted: mounted);

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

    final FlyerType? flyerType = FlyerTyper.concludeFlyerTypeByRootID(
        rootID: Pathing.getFirstPathNode(path: path)
    );

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
        flyerType: flyerType,
      );

    }

    /// A - if section is active
    else {

      final HomeProvider _pro = Provider.of<HomeProvider>(getMainContext(), listen: false);
      await _pro.changeHomeWallFlyerType(
        flyerType: flyerType,
        phid: Pathing.getLastPathNode(path)!,
        notify: true,
      );

    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _showPhidNotActiveDialog({
    required FlyerType? flyerType,
  }) async {

    /// not_active_keyword_dialog

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(getMainContext(), listen: false);
    final String? _cityName = _zoneProvider.currentZone?.cityName;

    final String? _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
        flyerType: flyerType
    );

    final String _title = '${getWord('phid_flyers_of')} '
        '${getWord(_flyerTypePhid)} '
        '${getWord('phid_are_not_available')} '
        '${getWord('phid_inn')} '
        '$_cityName';

    await BldrsCenterDialog.showCenterDialog(
      titleVerse: Verse(
        id: _title,
        translate: false,
      ),
      bodyVerse: const Verse(
        pseudo: 'The Bldrs in this city are adding flyers everyday to'
            ' properly present their markets.'
            '\nplease hold for couple of days and come back again.',
        id: 'phid_businesses_are_still_adding_flyers',
        translate: true,
      ),
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DialogButton(
            verse: const Verse(
              id: 'phid_inform_a_friend',
              translate: true,
            ),
            width: 133,
            onTap: () => Launcher.shareBldrsWebsiteURL(),
          ),

          DialogButton(
            verse: const Verse(
              id: 'phid_go_back',
              translate: true,
            ),
            color: Colorz.yellow255,
            verseColor: Colorz.black230,
            onTap: () => Nav.goBack(
              context: getMainContext(),
              invoker: '_setActivePhidK.centerDialog',
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
