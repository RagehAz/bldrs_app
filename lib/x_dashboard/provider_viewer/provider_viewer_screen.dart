import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';


import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvidersViewerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ProvidersViewerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ProvidersViewerScreenState createState() => _ProvidersViewerScreenState();
  /// --------------------------------------------------------------------------
}

class _ProvidersViewerScreenState extends State<ProvidersViewerScreen> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  UsersProvider _usersProvider;
  ZoneProvider _zoneProvider;
  FlyersProvider _flyersProvider;
  ChainsProvider _chainsProvider;
  AnimationController _animationController;
  UiProvider _uiProvider;
  PhraseProvider _phraseProvider;
  BzzProvider _bzzProvider;
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    // _loading.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      // loading: _loading,
      appBarRowWidgets: const <Widget>[],
      child: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          children: <Widget>[

            const Stratosphere(),

            const SeparatorLine(),

            /// AUTH -------------------------------------------------------------
            const SuperVerse(
              verse: Verse(
                text: 'Auth',
                translate: false,
              ),
            ),

            /// SUPER USER ID
            ProviderTestButton(
              title: 'AuthOps.superUserID()',
              value: AuthFireOps.superUserID(),
            ),

            /// SUPER FIREBASE USER
            ProviderTestButton(
              title: 'AuthOps.superFirebaseUser()',
              value: AuthFireOps.superFirebaseUser(),
            ),

            /// AUTH MODEL
            ProviderTestButton(
              title: 'usersProvider?.myAuthModel',
              value: _usersProvider?.myAuthModel,
              onTap: () => _usersProvider?.myAuthModel?.blogAuthModel(),
            ),

            const SeparatorLine(),

            /// USER -------------------------------------------------------------
            const SuperVerse(
              verse: Verse(
                text: 'User',
                translate: false,
              ),
            ),

            /// MY USER MODEL
            ProviderTestButton(
              title: 'usersProvider?.myUserModel',
              value: _usersProvider?.myUserModel,
              onTap: () => _usersProvider?.myUserModel?.blogUserModel(),
            ),

            /// MY USER COUNTRY
            ProviderTestButton(
              title: 'usersProvider?.myUserModel?.zone?.countryModel',
              value: _usersProvider?.myUserModel?.zone?.countryModel,
              onTap: () => _usersProvider?.myUserModel?.zone?.countryModel?.blogCountry(),
            ),

            /// MY USER CITY
            ProviderTestButton(
              title: 'usersProvider?.myUserModel?.zone?.cityModel',
              value: _usersProvider?.myUserModel?.zone?.cityModel,
              onTap: () => _usersProvider?.myUserModel?.zone?.cityModel?.blogCity(),
            ),

            const SeparatorLine(),

            /// BZZ -------------------------------------------------------------
            const SuperVerse(
              verse: Verse(
                text: 'Bzz',
                translate: false,
              ),
            ),

            /// MY BZZ
            ProviderTestButton(
              title: 'bzzProvider.myBzz = ${_bzzProvider?.myBzz?.length} bzz',
              value: _bzzProvider.myBzz,
              onTap: () => BzModel.blogBzz(
                bzz: _bzzProvider.myBzz,
              ),
            ),

            /// FOLLOWED BZZ
            ProviderTestButton(
              title: 'bzzProvider.followedBzz = ${_bzzProvider.followedBzz.length} bzz',
              value: _bzzProvider.followedBzz,
              onTap: () => BzModel.blogBzz(
                bzz: _bzzProvider.followedBzz,
              ),
            ),

            /// SPONSORS BZZ
            ProviderTestButton(
              title: 'bzzProvider.sponsors = ${_bzzProvider.sponsors.length} bzz',
              value: _bzzProvider.sponsors,
              onTap: () => BzModel.blogBzz(
                bzz: _bzzProvider.sponsors,
              ),
            ),

            /// ACTIVE BZ
            ProviderTestButton(
              title: 'bzzProvider.myActiveBz',
              value: _bzzProvider.myActiveBz,
              onTap: () => _bzzProvider.myActiveBz?.blogBz(),
            ),

            /// ACTIVE BZ COUNTRY
            ProviderTestButton(
              title: 'bzzProvider.myActiveBz?.zone?.countryModel',
              value: _bzzProvider.myActiveBz?.zone?.countryModel,
              onTap: () => _bzzProvider.myActiveBz?.zone?.countryModel?.blogCountry(),
            ),

            /// ACTIVE BZ CITY
            ProviderTestButton(
              title: 'bzzProvider.myActiveBz?.zone?.cityModel',
              value: _bzzProvider.myActiveBz?.zone?.cityModel,
              onTap: () => _bzzProvider.myActiveBz?.zone?.cityModel?.blogCity(),
            ),

            const SeparatorLine(),

            /// ZONE -------------------------------------------------------------
            const SuperVerse(
              verse: Verse(
                text: 'Zone',
                translate: false,
              ),
            ),

            /// CURRENT ZONE
            ProviderTestButton(
              title: 'zoneProvider.currentZone',
              value: _zoneProvider.currentZone,
              onTap: () => _zoneProvider.currentZone?.blogZone(),
            ),

            /// CURRENT CONTINENT
            ProviderTestButton(
              title: 'zoneProvider.currentContinent',
              value: _zoneProvider.currentContinent,
              onTap: () => _zoneProvider.currentContinent?.blogContinent(),
            ),

            /// CURRENT COUNTRY
            ProviderTestButton(
              title: 'zoneProvider.currentZone.countryModel',
              value: _zoneProvider.currentZone?.countryModel,
              onTap: () => _zoneProvider.currentZone?.countryModel?.blogCountry(),
            ),

            /// CURRENT CITY
            ProviderTestButton(
              title: 'zoneProvider.currentZone?.cityModel',
              value: _zoneProvider.currentZone?.cityModel,
              onTap: () => _zoneProvider.currentZone?.cityModel?.blogCity(),
            ),

            /// CURRENT CURRENCY
            ProviderTestButton(
              title: 'zoneProvider.currentCurrency',
              value: _zoneProvider.currentCurrency,
              onTap: () => _zoneProvider.currentCurrency?.blogCurrency(),
            ),

            /// USER COUNTRY
            ProviderTestButton(
              title: 'usersProvider.myUserModel.zone.countryModel',
              value: _usersProvider?.myUserModel?.zone?.countryModel,
              onTap: () => _usersProvider?.myUserModel?.zone?.countryModel?.blogCountry(),
            ),

            /// USER COUNTRY
            ProviderTestButton(
              title: 'usersProvider?.myUserModel?.zone?.cityModel',
              value: _usersProvider?.myUserModel?.zone?.cityModel,
              onTap: () => _usersProvider?.myUserModel?.zone?.cityModel?.blogCity(),
            ),

            /// ALL CURRENCIES
            ProviderTestButton(
              title: 'zoneProvider.allCurrencies',
              value: _zoneProvider.allCurrencies,
              onTap: () => CurrencyModel.blogCurrencies(_zoneProvider.allCurrencies),
            ),

            /// PROMOTED FLYERS
            ProviderTestButton(
              title: 'flyersProvider.promotedFlyers ${_flyersProvider.promotedFlyers.length} flyers',
              value: _flyersProvider.promotedFlyers,
              onTap: () => FlyerModel.blogFlyers(
                flyers: _flyersProvider.promotedFlyers,
              ),
            ),

            const SeparatorLine(),

            /// CHAINS -------------------------------------------------------------
            const SuperVerse(
              verse: Verse(
                text: 'Chains',
                translate: false,
              ),
            ),

            /// BLDRS CHAINS
            ProviderTestButton(
              title: 'chainsProvider.bldrsChains ',
              value: _chainsProvider?.bldrsChains,
              onTap: (){
                Chain.blogChains(_chainsProvider?.bldrsChains);
              },
            ),

            /// CITY CHAIN K
            ProviderTestButton(
              title: 'chainsProvider.cityChains ',
              value: _chainsProvider?.cityChains,
              onTap: (){
                Chain.blogChains(_chainsProvider?.cityChains);
              },
            ),

            /// BLDRS CHAINS PHRASES
            ProviderTestButton(
              title: 'chainsProvider.chainsPhrases : ${_chainsProvider?.chainsPhrases?.length} phrases ',
              value: _chainsProvider?.chainsPhrases,
              onTap: (){
                Phrase.blogPhrases(_chainsProvider?.chainsPhrases);
              },
            ),

            /// CITY CHAINS PHRASES
            ProviderTestButton(
              title: 'chainsProvider.cityChainKPhrases : ${_chainsProvider?.cityChainsPhrases?.length} phrases ',
              value: _chainsProvider?.cityChainsPhrases,
              onTap: (){
                Phrase.blogPhrases(_chainsProvider?.cityChainsPhrases);
              },
            ),

            /// CITY PHID COUNTERS
            ProviderTestButton(
              title: 'chainsProvider.cityPhidCounters',
              value: _chainsProvider?.cityPhidsModel,
              onTap: (){
                _chainsProvider?.cityPhidsModel?.blogCityPhidsModel();
              },
            ),

            /// HOME WALL FLYER TYPE
            ProviderTestButton(
              title: 'chainsProvider.wallFlyerType',
              value: _chainsProvider?.wallFlyerType,
              onTap: (){
                blog(_chainsProvider?.wallFlyerType);
              },
            ),

            /// WALL PHID
            ProviderTestButton(
              title: 'chainsProvider.wallPhid',
              value: _chainsProvider?.wallPhid,
              onTap: (){
                blog(_chainsProvider?.wallPhid);
              },
            ),

            /// ALL PICKERS
            ProviderTestButton(
              title: 'chainsProvider.allPickers',
              value: _chainsProvider?.allPickers,
              onTap: (){
                Mapper.blogMap(_chainsProvider?.allPickers);
              },
            ),

            const SeparatorLine(),

            /// PHRASES -------------------------------------------------------------
            const SuperVerse(
              verse: Verse(
                text: 'Phrases',
                translate: false,
              ),
            ),

            /// CURRENT LANG CODE
            ProviderTestButton(
              title: 'phraseProvider.currentLangCode',
              value: _phraseProvider.currentLangCode,
              onTap: (){
                blog(_phraseProvider?.currentLangCode);
              },
            ),

            /// BASIC PHRASES
            ProviderTestButton(
              title: 'phraseProvider.basicPhrases',
              value: _phraseProvider.mainPhrases,
              onTap: (){
                Phrase.blogPhrases(_phraseProvider.mainPhrases);
              },
            ),

            /// USED X PHRASES
            ProviderTestButton(
              title: 'phraseProvider.usedXPhrases : ( ${_phraseProvider.usedXPhrases.length} phrases )',
              value: _phraseProvider.usedXPhrases,
              onTap: (){
                Stringer.blogStrings(
                  strings: _phraseProvider.usedXPhrases,
                  invoker: ' USED X PHRASES : phraseProvider.usedXPhrases,'
                );
              },
            ),

            const SeparatorLine(),

            /// UI -------------------------------------------------------------
            const SuperVerse(
              verse: Verse(
                text: 'UI',
                translate: false,
              ),
            ),

            /// SCREEN DIMENSIONS
            ProviderTestButton(
              title: 'uiProvider.screenDims',
              value: _uiProvider.screenDims,
              onTap: (){
                _uiProvider?.screenDims?.blogDimensions(invoker: 'ProviderViewerTestScreen');
              },
            ),

            /// BASIC PHRASES
            ProviderTestButton(
              title: 'uiProvider.localAssetsPaths',
              value: _uiProvider.localAssetsPaths,
              onTap: (){
                blogStrings(_uiProvider.localAssetsPaths);
              },
            ),

            /// BASIC PHRASES
            ProviderTestButton(
              title: 'uiProvider.afterHomeRoute',
              value: _uiProvider.afterHomeRoute,
              onTap: (){
                blog(
                    '_uiProvider.afterHomeRoute | name : ${_uiProvider.afterHomeRoute.name} | '
                    'arguments.runtimeType : ${_uiProvider.afterHomeRoute.arguments.runtimeType} | '
                    'arguments : ${_uiProvider.afterHomeRoute.arguments}');
              },
            ),

            const SeparatorLine(),

            /// CHAINS -------------------------------------------------------------
            const SuperVerse(
              verse: Verse(
                text: 'TO AVOID SET STATE TECHNIQUES',
                translate: false,
              ),
            ),

            /// AVOID SET STATE : WAY # 2
            Consumer<UiProvider>(
              builder: (BuildContext ctx, UiProvider uiProvider, Widget child) {
                final bool _loading = uiProvider.isLoading;
                return DreamBox(
                  height: 50,
                  width: 300,
                  verse:  Verse(
                    text: '_loading is : $_loading',
                    translate: false,
                  ),
                  verseScaleFactor: 0.6,
                  verseWeight: VerseWeight.black,
                  onTap: uiProvider.triggerLoading,
                );
              },
            ),

            /// AVOID SET STATE : WAY # 3
            Selector<UiProvider, bool>(
              selector: (_, UiProvider uiProvider) => uiProvider.isLoading,
              builder: (BuildContext ctx, bool isLoading, Widget child){

                return
                  DreamBox(
                    height: 50,
                    width: 300,
                    verse:  Verse(
                      text: 'isLoading is : $isLoading',
                      translate: false,
                    ),
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    onTap: () => _uiProvider.triggerLoading(
                      callerName: 'ProvidersTestScreen : AVOID SET STATE : WAY # 3',
                      notify: true,
                    ),
                  );

              },
            ),

            /// Builder child pattern
            AnimatedBuilder(
                animation: _animationController,
                child: DreamBox(
                  height: 50,
                  width: 50,
                  verse: const Verse(
                    text: 'X',
                    translate: false,
                  ),
                  verseScaleFactor: 0.6,
                  verseWeight: VerseWeight.black,
                  color: Colorz.bloodTest,
                  onTap: () => _animationController.forward(from: 0),
                ),
                builder: (BuildContext ctx, Widget child) {
                  return Transform.rotate(
                    angle: _animationController.value * 2.0 * 3.14,
                    child: child,

                    /// passing child here will prevent its rebuilding with each tick
                  );
                }),

            const SeparatorLine(),

            /// END -------------------------------------------------------------
            const Stratosphere(),

          ],
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}

class ProviderTestButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProviderTestButton({
    @required this.title,
    @required this.value,
    this.onTap,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final dynamic value;
  final Function onTap;
  final double width;
  /// --------------------------------------------------------------------------
  String valueIsNotNull(dynamic value) {
    final String _icon = value == null ? Iconz.xSmall : Iconz.check;
    return _icon;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: 25,
      corners: 5,
      width: width ?? BldrsAppBar.width(context),
      margins: const EdgeInsets.symmetric(vertical: 2.5),
      color: value == null ? Colorz.bloodTest : Colorz.green255,
      verse: Verse(
        text: title,
        translate: false,
      ),
      iconSizeFactor: 0.6,
      verseCentered: false,
      verseShadow: false,
      icon: valueIsNotNull(value),
      iconColor: Colorz.white255,
      verseColor: value == null ? Colorz.white255 : Colorz.black255,
      onTap: (){

        blog('ProviderTestButton : $title --------------------------------------------------- START');
        if (onTap == null){
          blog(value.toString());
        }
        else {
          onTap();
        }
        blog('ProviderTestButton : $title --------------------------------------------------- END');

      },
    );

  }
  // -----------------------------------------------------------------------------
}
