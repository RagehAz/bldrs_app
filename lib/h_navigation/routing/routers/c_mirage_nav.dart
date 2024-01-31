part of bldrs_routing;

class _MirageNav {
  // -----------------------------------------------------------------------------

  const _MirageNav();

  // -----------------------------------------------------------------------------

  /// MAIN

  // --------------------
  static Future<void> _goHome() async {

    await _goToMainPages(
      bid: TabName.bid_Home,
    );

    final MirageModel mirage1 = HomeProvider.proGetMirageByIndex(
        context: getMainContext(),
        listen: false,
        index: 1
    );

    /// SHOW MIRAGE 1
    mirage1.show(mounted: true);

  }
  // --------------------
  static Future<void> _goZone() => _goToMainPages(
    bid: TabName.bid_Zone,
  );
  // --------------------
  static Future<void> _goAuth() => _goToMainPages(
    bid: TabName.bid_Auth,
  );
  // --------------------
  static Future<void> _goAppSettings() => _goToMainPages(
    bid: TabName.bid_AppSettings,
  );
  // --------------------
  static Future<void> _goToMainPages({
    required String bid,
  }) async {

    const bool mounted = true;

    final List<MirageModel> allMirages = HomeProvider.proGetMirages(
      context: getMainContext(),
      listen: false,
    );

    final List<MirageModel> _miragesAbove = MirageModel.getMiragesAbove(
      allMirages: allMirages,
      aboveIndex: 0,
    );

    /// CLOSE ALL MIRAGES ABOVE 0
    MirageModel.hideMirages(
      models: _miragesAbove,
      mounted: mounted,
    );

    /// SELECT THE BUTTON IN MIRAGE 0
    HomeProvider.proSelectMirageButton(
      mirageIndex: 0,
      mounted: mounted,
      button: bid,
    );

    /// GO TO TAB
    await BldrsTabber.goToTab(bid: bid);

    /// SHOW MIRAGE 1
    allMirages[0].show(mounted: mounted);
    allMirages[0].hidePyramid(mounted: mounted);

    /// SCROLL TO
    await allMirages[0].scrollTo(
      buttonIndex: BldrsTabber.getButtonIndexInMainMirage(bid: bid),
      listLength: BldrsTabber.mainButtonsLength,
    );

  }
  // -----------------------------------------------------------------------------

  /// PROFILE

  // --------------------
  static Future<void> _goMyInfo() => _goToAUserTab(
    bid: TabName.bid_My_Info,
  );
  // --------------------
  static Future<void> _goMySaves() => _goToAUserTab(
    bid: TabName.bid_My_Saves,
  );
  // --------------------
  static Future<void> _goMyNotes() => _goToAUserTab(
    bid: TabName.bid_My_Notes,
  );
  // --------------------
  static Future<void> _goMyFollows() => _goToAUserTab(
    bid: TabName.bid_My_Follows,
  );
  // --------------------
  static Future<void> _goMySettings() => _goToAUserTab(
    bid: TabName.bid_My_Settings,
  );
  // --------------------
  static Future<void> _goToAUserTab({
    required String bid,
  }) async {

    if (UsersProvider.proCheckIsSignedUp() == true){

      const bool mounted = true;

      final List<MirageModel> allMirages = HomeProvider.proGetMirages(
        context: getMainContext(),
        listen: false,
      );

      final List<MirageModel> _miragesAbove = MirageModel.getMiragesAbove(
        allMirages: allMirages,
        aboveIndex: 1,
      );

      /// CLOSE ALL MIRAGES ABOVE 0
      MirageModel.hideMirages(
        models: _miragesAbove,
        mounted: mounted,
      );

      /// SELECT THE BUTTON IN MIRAGE 0
      HomeProvider.proSelectMirageButton(
        mirageIndex: 0,
        mounted: mounted,
        button: TabName.bid_MyProfile,
      );

      /// SELECT THE BUTTON IN MIRAGE 1
      HomeProvider.proSelectMirageButton(
        mirageIndex: 1,
        mounted: mounted,
        button: bid,
      );

      /// GO TO TAB
      await BldrsTabber.goToTab(bid: bid);

      /// SHOW MIRAGES
      if (Mapper.boolIsTrue(allMirages[0].pyramidIsOn?.value) == true){
        allMirages[0].hidePyramid(mounted: mounted);
        await Future.delayed(const Duration(milliseconds: 300));
      }
      if (allMirages[0].checkIsClosed()){
        allMirages[0].show(mounted: mounted);
        await Future.delayed(const Duration(milliseconds: 300));
      }
      if (allMirages[1].checkIsClosed()){
        allMirages[1].show(mounted: mounted);
        await Future.delayed(const Duration(milliseconds: 300));
      }

      /// SCROLL TO

      await allMirages[0].scrollTo(
        buttonIndex: BldrsTabber.getButtonIndexInMainMirage(bid: TabName.bid_MyProfile,),
        listLength: BldrsTabber.mainButtonsLength,
      );

      await allMirages[1].scrollTo(
        buttonIndex: BldrsTabber.getButtonIndexInProfileMirage(bid: bid),
        listLength: BldrsTabber.profileButtonsLength,
      );


    }

  }
  // -----------------------------------------------------------------------------

  /// BZ

  // --------------------
  static Future<void> _goMyBzInfo({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: TabName.bid_MyBz_Info,
  );
  // --------------------
  static Future<void> _goMyBzFlyers({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: TabName.bid_MyBz_Flyers,
  );
  // --------------------
  static Future<void> _goMyBzTeam({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: TabName.bid_MyBz_Team,
  );
  // --------------------
  static Future<void> _goMyBzNotes({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: TabName.bid_MyBz_Notes,
  );
  // --------------------
  static Future<void> _goMyBzSettings({required String? bzID}) => _goToABzTab(
    bzID: bzID,
    bid: TabName.bid_MyBz_Settings,
  );
  // --------------------
  static Future<void> _goToABzTab({
    required String? bzID,
    required String bid,
  }) async {

    if (bzID != null){

      final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(
        context: getMainContext(),
        listen: false,
      );

      final bool _isMyBz = Stringer.checkStringsContainString(
        strings: _myBzzIDs,
        string: bzID,
      );

      if (_isMyBz == true){

        final bool _isSingleBz = _myBzzIDs.length == 1;

        await HomeProvider.proSetActiveBzByID(
          bzID: bzID,
          context: getMainContext(),
          notify: true,
        );

        final int tabsMirageIndex = _isSingleBz ? 1 : 2;

        const bool mounted = true;

        final List<MirageModel> allMirages = HomeProvider.proGetMirages(
          context: getMainContext(),
          listen: false,
        );

        final List<MirageModel> _miragesAbove = MirageModel.getMiragesAbove(
          allMirages: allMirages,
          aboveIndex: tabsMirageIndex,
        );

        /// CLOSE ALL MIRAGES ABOVE THE TABS MIRAGE
        MirageModel.hideMirages(
          models: _miragesAbove,
          mounted: mounted,
        );

        final String _bidBz = TabName.generateBzBid(
            bzID: bzID,
            bid: bid
        );

        /// SELECT THE BUTTON IN MIRAGE 0
        HomeProvider.proSelectMirageButton(
          mirageIndex: 0,
          mounted: mounted,
          button: _isSingleBz == true ? _bidBz : TabName.bid_MyBzz,
        );

        /// SELECT THE BUTTON IN MIRAGE 1
        HomeProvider.proSelectMirageButton(
          mirageIndex: 1,
          mounted: mounted,
          button: _bidBz,
        );

        /// SELECT THE BUTTON IN MIRAGE 2
        if (_isSingleBz == false){
          HomeProvider.proSelectMirageButton(
            mirageIndex: 2,
            mounted: mounted,
            button: _bidBz,
          );
        }

        /// GO TO TAB
        await BldrsTabber.goToTab(bid: bid);

        /// SHOW MIRAGES
        if (_isSingleBz == false){
          allMirages[2].show(mounted: mounted);
          await Future.delayed(const Duration(milliseconds: 300));
        }

        if (Mapper.boolIsTrue(allMirages[0].pyramidIsOn?.value) == true){
          allMirages[0].hidePyramid(mounted: mounted);
          await Future.delayed(const Duration(milliseconds: 300));
        }
        if (allMirages[0].checkIsClosed()){
          allMirages[0].show(mounted: mounted);
          await Future.delayed(const Duration(milliseconds: 300));
        }
        if (allMirages[1].checkIsClosed()){
          allMirages[1].show(mounted: mounted);
          await Future.delayed(const Duration(milliseconds: 300));
        }


        /// MIRAGE 0
        await allMirages[0].scrollTo(
          buttonIndex: BldrsTabber.getButtonIndexInMainMirage(bid: TabName.bid_MyBzz),
          listLength: BldrsTabber.mainButtonsLength,
        );


        /// MIRAGE 1 [ WHEN HAS 1 BZ => BZ TABS ]
        if (_isSingleBz == true){
          await allMirages[1].scrollTo(
            buttonIndex: BldrsTabber.getButtonIndexInBzProfileMirage(bid: bid),
            listLength: BldrsTabber.bzButtonsLength,
          );
        }

        /// MIRAGE 1 [ WHEN HAS MANY BZZ => BZ BUTTON ]
        if (_isSingleBz == false){
          await allMirages[1].scrollTo(
            buttonIndex: BldrsTabber.getButtonIndexInMyBzzMirage(bzID: bzID),
            listLength: _myBzzIDs.length,
          );
        }

        /// MIRAGE 2 [ WHEN HAS MANY BZZ => BZ TABS ]
        if (_isSingleBz == false){
          await allMirages[2].scrollTo(
            buttonIndex: BldrsTabber.getButtonIndexInBzProfileMirage(bid: bid),
            listLength: BldrsTabber.bzButtonsLength,
          );
        }


      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SWITCHER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goTo({
    required String bid,
    String? bzID,
  }) async {

    switch (bid){

      /// MAIN
      case TabName.bid_Home:           await _goHome();
      case TabName.bid_Zone:           await _goZone();
      case TabName.bid_Auth:           await _goAuth();
      case TabName.bid_AppSettings:    await _goAppSettings();

      case TabName.bid_MyProfile:      await _goMyInfo();
      case TabName.bid_MyBzz:          await _goMyBzInfo(bzID: bzID);

      /// USER
      case TabName.bid_My_Info:         await _goMyInfo();
      case TabName.bid_My_Saves:        await _goMySaves();
      case TabName.bid_My_Notes:        await _goMyNotes();
      case TabName.bid_My_Follows:      await _goMyFollows();
      case TabName.bid_My_Settings:     await _goMySettings();

      /// BZ
      case TabName.bid_MyBz_Info:       await _goMyBzInfo(bzID: bzID);
      case TabName.bid_MyBz_Flyers:     await _goMyBzFlyers(bzID: bzID);
      case TabName.bid_MyBz_Team:       await _goMyBzTeam(bzID: bzID);
      case TabName.bid_MyBz_Notes:      await _goMyBzNotes(bzID: bzID);
      case TabName.bid_MyBz_Settings:   await _goMyBzSettings(bzID: bzID);

      default: await _goHome();

    }

  }
  // -----------------------------------------------------------------------------

  /// GO TO KEYWORD

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToKeyword({
    required String phid,
  }) async {

    final Map<String, dynamic>? _keywordsMap = await KeywordsProtocols.fetch();

    if (_keywordsMap != null){

      final List<String> _foundPaths = Keyworder.findPathsContainingPhid(
        phid: phid,
        keywordsMap: _keywordsMap,
      );

      if (Lister.checkCanLoop(_foundPaths) == true){

        final String _path = _foundPaths.first;
        final List<String> _nodes = Pathing.splitPathNodes(_path);

        // thing/aaa/bbb/xxx
        // 0 : thing/
        // 1 : thing/aaa/
        // 2 : thing/aaa/bbb
        // 3 : thing/aaa/bbb/xxx

        await _goHome();

        final List<MirageModel> _allMirages = HomeProvider.proGetMirages(context: getMainContext(), listen: false);

        String _nodePath = '';
        for (int i = 0; i < _nodes.length; i++){

          final String node = _nodes[i];
          _nodePath = '$_nodePath$node/';
          final int _mirageIndex = i + 1;
          // final int _buttonIndex = MapPathing.getNodeOrderIndexByPath(path: _nodePath, map: _keywordsMap);
          // final int _listLength = MapPathing.getBrothersLength(path: _nodePath, map: _keywordsMap);

          final bool _hasSons = MapPathing.checkNodeHasSons(
            nodeValue: MapPathing.getNodeValue(
                path: _nodePath,
                map: _keywordsMap,
            ),
          );

          if (_hasSons == true){

            await MirageKeywordsControls.onPhidTap(
                mirageIndex: _mirageIndex,
                path: _nodePath,
                keywordsMap: _keywordsMap,
                mounted: true,
            );

          }

          else {

            await _allMirages[_mirageIndex].scrollTo(
              buttonIndex: MapPathing.getNodeOrderIndexByPath(path: _nodePath, map: _keywordsMap),
              listLength: MapPathing.getBrothersLength(path: _nodePath, map: _keywordsMap),
            );
            await Future.delayed(const Duration(milliseconds: 300));

          }

          // blog('_nodePath : $_nodePath : _mirageIndex : $_mirageIndex : _buttonIndex : $_buttonIndex : _listLength : $_listLength');

        }

      }

    }

  }
  // -----------------------------------------------------------------------------
}
