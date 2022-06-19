import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_separator_line.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvidersTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ProvidersTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ProvidersTestScreenState createState() => _ProvidersTestScreenState();
/// --------------------------------------------------------------------------
}

class _ProvidersTestScreenState extends State<ProvidersTestScreen> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  UsersProvider usersProvider;
  ZoneProvider zoneProvider;
  FlyersProvider flyersProvider;
  ChainsProvider _chainsProvider;
  AnimationController _animationController;
  UiProvider _uiProvider;
  PhraseProvider _phraseProvider;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzEditorScreen',
    );
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    usersProvider = Provider.of<UsersProvider>(context, listen: false);
    zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    _uiProvider = Provider.of<UiProvider>(context, listen: false);
    // final Chain _keywordsChain = _chainsProvider.keywordsChain;
    // final Chain _specsChain = _chainsProvider.specsChain;


    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    super.initState();
  }
// -----------------------------------------------------------------------------
// --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

        _triggerLoading().then((_) async {

          await _triggerLoading();
        });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // final Stream<UserModel> _myUserModelStream = _usersProvider?.myUserModelStream;
    final List<FlyerModel> _promotedFlyers = flyersProvider?.promotedFlyers;

    final Chain _keywordsChain = _chainsProvider.keywordsChain;
    final List<Phrase> _keywordsChainPhrases = _chainsProvider.keywordsChainPhrases;
    final Chain _specsChain = _chainsProvider.specsChain;

    final BzzProvider bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    // final List<BzModel> _myBzz = bzzProvider.myBzz;

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      // loading: _loading,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          children: <Widget>[

            const Stratosphere(),

            /// AUTH -------------------------------------------------------------

            const SuperVerse(verse: 'Auth',),

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
              value: usersProvider?.myAuthModel,
              onTap: () => usersProvider?.myAuthModel?.blogAuthModel(),
            ),

            /// USER -------------------------------------------------------------

            const SuperVerse(verse: 'User',),

            /// MY USER MODEL
            ProviderTestButton(
              title: 'usersProvider?.myUserModel',
              value: usersProvider?.myUserModel,
              onTap: () => usersProvider?.myUserModel?.blogUserModel(),
            ),

            /// MY USER COUNTRY
            ProviderTestButton(
              title: 'usersProvider?.myUserModel?.zone?.countryModel',
              value: usersProvider?.myUserModel?.zone?.countryModel,
              onTap: () => usersProvider?.myUserModel?.zone?.countryModel?.blogCountry(),
            ),

            /// MY USER CITY
            ProviderTestButton(
              title: 'usersProvider?.myUserModel?.zone?.cityModel',
              value: usersProvider?.myUserModel?.zone?.cityModel,
              onTap: () => usersProvider?.myUserModel?.zone?.cityModel?.blogCity(),
            ),

            /// BZZ -------------------------------------------------------------

            const SuperVerse(verse: 'Bzz',),

            /// MY BZZ
            ProviderTestButton(
              title: 'bzzProvider.myBzz = ${bzzProvider.myBzz.length} bzz',
              value: bzzProvider.myBzz,
              onTap: () => BzModel.blogBzz(
                  bzz: bzzProvider.myBzz,
              ),
            ),

            /// FOLLOWED BZZ
            ProviderTestButton(
              title: 'bzzProvider.followedBzz = ${bzzProvider.followedBzz.length} bzz',
              value: bzzProvider.followedBzz,
              onTap: () => BzModel.blogBzz(
                  bzz: bzzProvider.followedBzz,
              ),
            ),

            /// SPONSORS BZZ
            ProviderTestButton(
              title: 'bzzProvider.sponsors = ${bzzProvider.sponsors.length} bzz',
              value: bzzProvider.sponsors,
              onTap: () => BzModel.blogBzz(
                  bzz: bzzProvider.sponsors,
              ),
            ),

            const DotSeparator(),

            /// ACTIVE BZ
            ProviderTestButton(
              title: 'bzzProvider.myActiveBz',
              value: bzzProvider.myActiveBz,
              onTap: () => bzzProvider.myActiveBz?.blogBz(),
            ),

            /// ACTIVE BZ COUNTRY
            ProviderTestButton(
              title: 'bzzProvider.myActiveBz?.zone?.countryModel',
              value: bzzProvider.myActiveBz?.zone?.countryModel,
              onTap: () => bzzProvider.myActiveBz?.zone?.countryModel?.blogCountry(),
            ),

            /// ACTIVE BZ CITY
            ProviderTestButton(
              title: 'bzzProvider.myActiveBz?.zone?.cityModel',
              value: bzzProvider.myActiveBz?.zone?.cityModel,
              onTap: () => bzzProvider.myActiveBz?.zone?.cityModel?.blogCity(),
            ),

            /// ACTIVE BZ FLYERS
            ProviderTestButton(
              title: 'bzzProvider.myActiveBzFlyers',
              value: bzzProvider.myActiveBzFlyers,
              onTap: () => FlyerModel.blogFlyers(
                  flyers: bzzProvider.myActiveBzFlyers,
                  methodName: 'ProviderTestButton',
              ),
            ),

            /// ZONE -------------------------------------------------------------

            const SeparatorLine(),
            const SuperVerse(verse: 'Zone',),

            /// CURRENT ZONE
            ProviderTestButton(
              title: 'zoneProvider.currentZone',
              value: zoneProvider.currentZone,
              onTap: () => zoneProvider.currentZone?.blogZone(),
            ),

            /// CURRENT CONTINENT
            ProviderTestButton(
              title: 'zoneProvider.currentContinent',
              value: zoneProvider.currentContinent,
              onTap: () => zoneProvider.currentContinent?.blogContinent(),
            ),

            /// CURRENT COUNTRY
            ProviderTestButton(
              title: 'zoneProvider.currentCountry',
              value: zoneProvider.currentCountry,
              onTap: () => zoneProvider.currentCountry?.blogCountry(),
            ),

            /// CURRENT CITY
            ProviderTestButton(
              title: 'zoneProvider.currentCity',
              value: zoneProvider.currentCity,
              onTap: () => zoneProvider.currentCity?.blogCity(),
            ),

            /// CURRENT CURRENCY
            ProviderTestButton(
              title: 'zoneProvider.currentCurrency',
              value: zoneProvider.currentCurrency,
              onTap: () => zoneProvider.currentCurrency?.blogCurrency(),
            ),

            const DotSeparator(),

            /// SELECTED COUNTRY CITIES
            ProviderTestButton(
              title: 'zoneProvider.selectedCountryCities',
              value: zoneProvider.selectedCountryCities,
              onTap: () => CityModel.blogCities(zoneProvider.selectedCountryCities),
            ),

            /// SELECTED COUNTRY CITIES
            ProviderTestButton(
              title: 'zoneProvider.selectedCityDistricts',
              value: zoneProvider.selectedCityDistricts,
              onTap: () => DistrictModel.blogDistricts(zoneProvider.selectedCityDistricts),
            ),

            const DotSeparator(),

            /// USER COUNTRY
            ProviderTestButton(
              title: 'zoneProvider.userCountryModel',
              value: zoneProvider.userCountryModel,
              onTap: () => zoneProvider.userCountryModel?.blogCountry(),
            ),

            /// USER COUNTRY
            ProviderTestButton(
              title: 'zoneProvider.userCityModel',
              value: zoneProvider.userCityModel,
              onTap: () => zoneProvider.userCityModel?.blogCity(),
            ),

            const DotSeparator(),

            /// ALL CURRENCIES
            ProviderTestButton(
              title: 'zoneProvider.allCurrencies',
              value: zoneProvider.allCurrencies,
              onTap: () => CurrencyModel.blogCurrencies(zoneProvider.allCurrencies),
            ),

            const DotSeparator(),

            /// SEARCHED COUNTRIES
            ProviderTestButton(
              title: 'zoneProvider.searchedCountries ${zoneProvider.searchedCountries.length} phrases',
              value: zoneProvider.searchedCountries,
              onTap: () => Phrase.blogPhrases(zoneProvider.searchedCountries),
            ),

            /// SEARCHED CITIES
            ProviderTestButton(
              title: 'zoneProvider.searchedCities ${zoneProvider.searchedCities.length} cities',
              value: zoneProvider.searchedCities,
              onTap: () => CityModel.blogCities(zoneProvider.searchedCities),
            ),

            /// SEARCHED DISTRICTS
            ProviderTestButton(
              title: 'zoneProvider.searchedDistricts ${zoneProvider.searchedDistricts.length} districts',
              value: zoneProvider.searchedDistricts,
              onTap: () => DistrictModel.blogDistricts(zoneProvider.searchedDistricts),
            ),

            const DotSeparator(),

            /// FLYERS -------------------------------------------------------------

            const SuperVerse(verse: 'Flyers',),

            /// SAVED FLYERS
            ProviderTestButton(
              title: 'flyersProvider.savedFlyers ${flyersProvider.savedFlyers?.length} flyers',
              value: flyersProvider.savedFlyers,
              onTap: () => FlyerModel.blogFlyers(
                  flyers: flyersProvider.savedFlyers,
              ),
            ),

            /// PROMOTED FLYERS
            ProviderTestButton(
              title: 'flyersProvider.promotedFlyers ${flyersProvider.promotedFlyers.length} flyers',
              value: flyersProvider.promotedFlyers,
              onTap: () => FlyerModel.blogFlyers(
                flyers: flyersProvider.promotedFlyers,
              ),
            ),


            WideButton(
                color: Colorz.black255,
                verse: 'print _promotedFlyers',
                icon: Iconizer.valueIsNotNull(_promotedFlyers),
                onTap: () async {
                  unawaited(_triggerLoading());

                  FlyerModel.blogFlyers(
                    flyers: _promotedFlyers,
                    methodName: 'provider test : [_promotedFlyers button]'
                  );

                  unawaited(_triggerLoading());
                }),

            const SuperVerse(verse: 'Chains',),

            WideButton(
                color: Colorz.black255,
                verse: 'print _keywordsChain',
                icon: Iconizer.valueIsNotNull(_keywordsChain),
                onTap: () async {
                  unawaited(_triggerLoading());

                  _keywordsChain.blogChain();

                  unawaited(_triggerLoading());
                }),

            WideButton(
                color: Colorz.black255,
                verse: 'print _keywordsChainPhrases',
                icon: Iconizer.valueIsNotNull(_keywordsChainPhrases),
                onTap: () async {
                  unawaited(_triggerLoading());

                  Phrase.blogPhrases(_keywordsChainPhrases);

                  unawaited(_triggerLoading());
                }),

            WideButton(
                color: Colorz.black255,
                verse: 'print _specsChain',
                icon: Iconizer.valueIsNotNull(_specsChain),
                onTap: () async {
                  unawaited(_triggerLoading());

                  _specsChain.blogChain();

                  unawaited(_triggerLoading());
                }),

            const DotSeparator(),


            WideButton(
                color: Colorz.black255,
                verse: 'print currentLangCode',
                icon: Iconizer.valueIsNotNull(_phraseProvider.currentLangCode),
                onTap: () async {
                  unawaited(_triggerLoading());

                  blog(_phraseProvider.currentLangCode);

                  unawaited(_triggerLoading());
                }),

            WideButton(
                color: Colorz.black255,
                verse: 'print phrases',
                icon: Iconizer.valueIsNotNull(_phraseProvider.basicPhrases),
                onTap: () async {
                  unawaited(_triggerLoading());

                  Phrase.blogPhrases(_phraseProvider.basicPhrases);

                  unawaited(_triggerLoading());
                }),

            const DotSeparator(),

            WideButton(
                color: Colorz.black255,
                verse: 'print local Assets paths',
                icon: Iconizer.valueIsNotNull(_uiProvider.localAssetsPaths),
                onTap: () async {
                  unawaited(_triggerLoading());

                  blogStrings(_uiProvider.localAssetsPaths);

                  unawaited(_triggerLoading());
                }),

            const DotSeparator(),

            /// AVOID SET STATE : WAY # 2
            Consumer<UiProvider>(
              builder: (BuildContext ctx, UiProvider uiProvider, Widget child) {
                final bool _loading = uiProvider.isLoading;
                return DreamBox(
                  height: 50,
                  width: 300,
                  verse: '_loading is : $_loading',
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
                    verse: 'isLoading is : $isLoading',
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
                  verse: 'X',
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

            const DotSeparator(),

            const Stratosphere(),

          ],
        ),
      ),
    );
  }
}

class ProviderTestButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProviderTestButton({
    @required this.title,
    @required this.value,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final dynamic value;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: 25,
      corners: 5,
      width: BldrsAppBar.width(context),
      margins: const EdgeInsets.symmetric(vertical: 2.5),
      color: value == null ? Colorz.bloodTest : Colorz.green255,
      verse: title,
      iconSizeFactor: 0.6,
      verseCentered: false,
      verseShadow: false,
      icon: Iconizer.valueIsNotNull(value),
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
}
