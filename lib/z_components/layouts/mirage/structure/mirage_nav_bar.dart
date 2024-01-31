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
  // -----------------------------------------------------------------------------
  Map<String, dynamic>? _keywordsMap;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        // blog('xxx -> started fetching keywords map');
        final Map<String, dynamic>? _theKeywordsMap = await KeywordsProtocols.fetch();
        // blog('xxx -> finished fetching keywords map _theKeywordsMap : ${_theKeywordsMap?.keys.length}');

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
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return LayoutVisibilityListener(
      isOn: true,
      child: Stack(
        children: <Widget>[

          /// MIRAGE 4
          MirageStrip(
            index: 4,
            mounted: mounted,
            child: Mirage4StripSwitcher(
              keywordsMap: _keywordsMap,
              onPhidTap: (String path) => MirageKeywordsControls.onPhidTap(
                mirageIndex: 4,
                path: path,
                keywordsMap: _keywordsMap,
                mounted: mounted,
              ),
            ),
          ),

          /// MIRAGE 3
          MirageStrip(
            index: 3,
            mounted: mounted,
            child: Mirage3StripSwitcher(
              keywordsMap: _keywordsMap,
              onPhidTap: (String path) => MirageKeywordsControls.onPhidTap(
                mirageIndex: 3,
                path: path,
                keywordsMap: _keywordsMap,
                mounted: mounted,
              ),
            ),
          ),

          /// MIRAGE 2
          MirageStrip(
            index: 2,
            mounted: mounted,
            child: Mirage2StripSwitcher(
              keywordsMap: _keywordsMap,
              onPhidTap: (String path) => MirageKeywordsControls.onPhidTap(
                mirageIndex: 2,
                path: path,
                keywordsMap: _keywordsMap,
                mounted: mounted,
              ),
              onBzTabChanged: (String bid) => _MirageMyBzzControls.onBzTabChanged(
                mounted: mounted,
                mirageIndex: 2,
                bid: bid,
              ),
            ),
          ),

          /// MIRAGE 1
          MirageStrip(
            index: 1,
            mounted: mounted,
            child: Mirage1StripSwitcher(
              keywordsMap: _keywordsMap,
              onSelectFlyerType: (String path) => MirageKeywordsControls.onSelectFlyerType(
                path: path,
                mounted: mounted,
                keywordsMap: _keywordsMap,
              ),
              onUserTabChanged: (String bid) => _MirageMyUserControls.onUserTabChanged(
                mounted: mounted,
                bid: bid,
              ),
              onBzTabChanged: (String bid) => _MirageMyBzzControls.onBzTabChanged(
                mounted: mounted,
                mirageIndex: 1,
                bid: bid,
              ),
              onBzTap: (String bzID) => _MirageMyBzzControls.onBzTap(
                bzID: bzID,
                mounted: mounted,
                mirageIndex: 1,
              ),
            ),

          ),

          /// MIRAGE 0
          MirageStrip(
            index: 0,
            mounted: mounted,
            child: MainMirageStrip(
              onSectionsTap: () => MirageKeywordsControls.onSectionsButtonTap(
                mounted: mounted,
              ),
              onZoneButtonTap: () async {

                await Routing.goTo(
                    route: TabName.bid_Zone,
                );

              },
              onSignInButtonTap: () async {

                await Routing.goTo(
                  route: TabName.bid_Auth,
                );

              },
              onMyBzzTap: () => _MirageMyBzzControls.onMyBzzButtonTap(
                mounted: mounted,
              ),
              onMyBzTap: (BzModel bzModel) async {

                await Routing.goTo(
                  route: TabName.bid_MyBz_Info,
                  arg: bzModel.id,
                );

              },
              onUserProfileButtonTap: () => _MirageMyUserControls.onUserProfileButtonTap(
                mounted: mounted,
              ),
              onSettingsButtonTap: () async {

                await Routing.goTo(
                  route: TabName.bid_AppSettings,
                );

              },
            ),
          ),

          /// PYRAMID
          _MiragePyramid(
            mounted: mounted,
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
