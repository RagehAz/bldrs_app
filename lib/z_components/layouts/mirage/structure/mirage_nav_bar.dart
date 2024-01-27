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

        blog('xxx -> started fetching keywords map');
        final Map<String, dynamic>? _theKeywordsMap = await KeywordsProtocols.fetch();
        blog('xxx -> finished fetching keywords map _theKeywordsMap : ${_theKeywordsMap?.keys.length}');

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
              onPhidTap: (String path) => _MirageKeywordsControls.onPhidTap(
                index: 4,
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
              onPhidTap: (String path) => _MirageKeywordsControls.onPhidTap(
                index: 3,
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
              onPhidTap: (String path) => _MirageKeywordsControls.onPhidTap(
                index: 2,
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
              onSelectFlyerType: (String path) => _MirageKeywordsControls.onSelectFlyerType(
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
              onSectionsTap: () => _MirageKeywordsControls.onSectionsButtonTap(
                mounted: mounted,
              ),
              onZoneButtonTap: () async {

                // HomeProvider.proSelectMirageButton(
                //   mirageIndex: 0,
                //   mounted: mounted,
                //   button: BldrsTabber.bidZone,
                // );
                //
                // await MirageModel.hideMiragesAbove(
                //     index: 0,
                //     mounted: mounted
                // );
                //
                // await BldrsTabber.goToTab(tab: BldrsTab.zone);

                await MirageNav.goTo(
                    tab: BldrsTab.zone,
                );

              },
              onSignInButtonTap: () async {

                // HomeProvider.proSelectMirageButton(
                //   mirageIndex: 0,
                //   mounted: mounted,
                //   button: BldrsTabber.bidAuth,
                // );
                //
                // await MirageModel.hideMiragesAbove(
                //     index: 0,
                //     mounted: mounted
                // );
                //
                // await BldrsTabber.goToTab(tab: BldrsTab.auth);

                await MirageNav.goTo(
                  tab: BldrsTab.auth,
                );

              },
              onMyBzzTap: () => _MirageMyBzzControls.onMyBzzButtonTap(
                mounted: mounted,
              ),
              onMyBzTap: (BzModel bzModel) async {

                // HomeProvider.proSetActiveBzModel(
                //     bzModel: bzModel,
                //     context: context,
                //     notify: true
                // );
                //
                // final String _bidBz = BldrsTabber.generateBzBid(
                //   bzID: bzModel.id!,
                //   bid: BldrsTabber.bidMyBzInfo,
                // );
                //
                // HomeProvider.proSelectMirageButton(
                //   mirageIndex: 0,
                //   mounted: mounted,
                //   button: _bidBz,
                // );
                //
                // await MirageModel.hideMiragesAbove(
                //   index: 0,
                //   mounted: mounted,
                // );

                await MirageNav.goTo(
                  tab: BldrsTab.myBzInfo,
                  bzID: bzModel.id,
                );

              },
              onUserProfileButtonTap: () => _MirageMyUserControls.onUserProfileButtonTap(
                mounted: mounted,
              ),
              onSettingsButtonTap: () async {

                // HomeProvider.proSelectMirageButton(
                //     mirageIndex: 0,
                //     mounted: mounted,
                //     button: BldrsTabber.bidAppSettings
                // );
                //
                // await BldrsTabber.goToTab(tab: BldrsTab.appSettings);
                //
                // await MirageModel.hideMiragesAbove(
                //   index: 0,
                //   mounted: mounted,
                // );

                await MirageNav.goTo(
                  tab: BldrsTab.appSettings,
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
