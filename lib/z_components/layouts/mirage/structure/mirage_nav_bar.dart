part of mirage;

class MirageNavBar extends StatefulWidget {
  // --------------------------------------------------------------------------
  const MirageNavBar({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _MirageNavBarState createState() => _MirageNavBarState();
  // --------------------------------------------------------------------------
}

class _MirageNavBarState extends State<MirageNavBar> {

  Map<String, dynamic>? _keywordsMap;
  // -----------------------------------------------------------------------------
  final _MirageModel _mirageX0 = _MirageModel.initialize(index: 0,height: Pyramids.khafreHeight * 1.1, controlPyramid: true);
  final _MirageModel _mirageX1 = _MirageModel.initialize(index: 1,height: Pyramids.khafreHeight * 2.2);
  final _MirageModel _mirageX2 = _MirageModel.initialize(index: 2,height: Pyramids.khafreHeight * 3.3);
  final _MirageModel _mirageX3 = _MirageModel.initialize(index: 3,height: Pyramids.khafreHeight * 4.4);
  final _MirageModel _mirageX4 = _MirageModel.initialize(index: 4,height: Pyramids.khafreHeight * 5.5);
  late List<_MirageModel> _allMirages;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _allMirages = [_mirageX0, _mirageX1, _mirageX2, _mirageX3, _mirageX4];
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        final Map<String, dynamic>? _theKeywordsMap = await KeywordsProtocols.fetch();

        setState(() {
          _keywordsMap = _theKeywordsMap;
        });

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _MirageModel.disposeMirages(
      models: [_mirageX0, _mirageX1, _mirageX2, _mirageX3, _mirageX4],
    );
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Stack(
      children: <Widget>[

        /// MIRAGE 4
        _MirageStrip(
          mirage: _mirageX4,
          mounted: mounted,
          miragesAbove: const [],
          onHide: () async {
            await _MirageModel.waitAnimation();
            _mirageX3.clearButton(mounted: mounted);
          },
          child: _Mirage4StripSwitcher(
            keywordsMap: _keywordsMap,
            mirageX3: _mirageX3,
            mirageX4: _mirageX4,
            mounted: mounted,
            allMirages: _allMirages,
            onPhidTap: (String path) => _MirageKeywordsControls.onPhidTap(
              mirageAbove: null,
              thisMirage: _mirageX4,
              mirageBelow: _mirageX3,
              path: path,
              keywordsMap: _keywordsMap,
              mounted: mounted,
              allMirages: _allMirages,
            ),
          ),
        ),

        /// MIRAGE 3
        _MirageStrip(
          mirage: _mirageX3,
          mounted: mounted,
          miragesAbove: [_mirageX4],
          onHide: () async {
            await _MirageModel.waitAnimation();
            _mirageX2.clearButton(mounted: mounted);
          },
          child: _Mirage3StripSwitcher(
            mounted: mounted,
            keywordsMap: _keywordsMap,
            mirageX2: _mirageX2,
            mirageX3: _mirageX3,
            mirageX4: _mirageX4,
            allMirages: _allMirages,
            onPhidTap: (String path) => _MirageKeywordsControls.onPhidTap(
              mirageAbove: _mirageX4,
              thisMirage: _mirageX3,
              mirageBelow: _mirageX2,
              path: path,
              keywordsMap: _keywordsMap,
              mounted: mounted,
              allMirages: _allMirages,
            ),
          ),
        ),

        /// MIRAGE 2
        _MirageStrip(
          mirage: _mirageX2,
          mounted: mounted,
          miragesAbove: [_mirageX3, _mirageX4],
          onHide: () async {
            await _MirageModel.waitAnimation();
            _mirageX1.clearButton(mounted: mounted);
          },
          child: _Mirage2StripSwitcher(
            allMirages: _allMirages,
            mirageX3: _mirageX3,
            mirageX2: _mirageX2,
            mirageX1: _mirageX1,
            mounted: mounted,
            keywordsMap: _keywordsMap,
            onPhidTap: (String path) => _MirageKeywordsControls.onPhidTap(
              mirageBelow: _mirageX1,
              thisMirage: _mirageX2,
              path: path,
              keywordsMap: _keywordsMap,
              mounted: mounted,
              allMirages: _allMirages,
              mirageAbove: _mirageX3,
            ),
            onBzTabChanged: (String tab) => _MirageMyBzzControls.onBzTabChanged(
              mounted: mounted,
              allMirages: _allMirages,
              tab: tab,
            ),
          ),
        ),

        /// MIRAGE 1
        _MirageStrip(
          mirage: _mirageX1,
          mounted: mounted,
          miragesAbove: [_mirageX2, _mirageX3, _mirageX4],
          onHide: () async {
            await _MirageModel.waitAnimation();
            _mirageX0.clearButton(mounted: mounted);
          },
          child: _Mirage1StripSwitcher(
            mirage0: _mirageX0,
            mirage1: _mirageX1,
            mirage2: _mirageX2,
            allMirages: _allMirages,
            mounted: mounted,
            keywordsMap: _keywordsMap,
            onSelectFlyerType: (String path) => _MirageKeywordsControls.onSelectFlyerType(
              path: path,
              allMirages: _allMirages,
              mounted: mounted,
              keywordsMap: _keywordsMap,
            ),
            onUserTabChanged: (String tab) => _MirageMyUserControls.onUserTabChanged(
              mounted: mounted,
              allMirages: _allMirages,
              tab: tab,
            ),
            onBzTap: (String bzID) => _MirageMyBzzControls.onBzTap(
              bzID: bzID,
              mounted: mounted,
              allMirages: _allMirages,
            ),
          ),

        ),

        /// MIRAGE 0
        _MirageStrip(
          mirage: _mirageX0,
          mounted: mounted,
          miragesAbove: [_mirageX1, _mirageX2, _mirageX3, _mirageX4],
          onHide: (){
            blog('a7axx');
          },
          child: _MainMirageStrip(
            mirage0: _mirageX0,
            allMirages: _allMirages,
            mounted: mounted,
            onSectionsTap: () => _MirageKeywordsControls.onSectionsButtonTap(
              mounted: mounted,
              allMirages: _allMirages,
            ),
            onZoneButtonTap: () async {

              await _MirageModel.hideAllAndShowPyramid(
                models: _allMirages,
                mounted: mounted,
                mirage0: _mirageX0,
              );

              final UserModel? _userModel = UsersProvider.proGetMyUserModel(
                context: context,
                listen: false,
              );

              await ZoneSelection.goBringAZone(
                depth: ZoneDepth.city,
                zoneViewingEvent: ViewingEvent.homeView,
                settingCurrentZone: true,
                viewerZone: _userModel?.zone,
                selectedZone: ZoneProvider.proGetCurrentZone(context: context, listen: false),
              );

            },
            onMyBzzTap: () => _MirageMyBzzControls.onMyBzzButtonTap(
                mounted: mounted,
                allMirages: _allMirages,
            ),
            onMyBzTap: (BzModel bzModel) async {

              await _MirageModel.hideAllAndShowPyramid(
                models: _allMirages,
                mounted: mounted,
                mirage0: _mirageX0,
              );
              HomeProvider.proSetActiveBzModel(
                  bzModel: bzModel,
                  context: context,
                  notify: true
              );

              await Nav.goToRoute(context, RouteName.myBzFlyersPage);

              },
            onSignInButtonTap: () async {

              await _MirageModel.hideAllAndShowPyramid(
                models: _allMirages,
                mounted: mounted,
                mirage0: _mirageX0,
              );

              await Nav.goToRoute(context, RouteName.auth);

            },
            onUserProfileButtonTap: () => _MirageMyUserControls.onUserProfileButtonTap(
              mounted: mounted,
              allMirages: _allMirages,
            ),
            onSettingsButtonTap: () async {

              _mirageX0.selectButton(
                button: _MirageModel.appSettingsID,
                mounted: mounted,
              );

              await BldrsTabs.goToTab(tab: BldrsTab.appSettings);

              await _MirageModel.hideMiragesAbove(
                  allMirages: _allMirages,
                  aboveThisMirage: _mirageX0,
                  mounted: mounted
              );

              },
          ),
        ),

        /// PYRAMID
        _MiragePyramid(
          mounted: mounted,
          mirage1: _mirageX0,
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
