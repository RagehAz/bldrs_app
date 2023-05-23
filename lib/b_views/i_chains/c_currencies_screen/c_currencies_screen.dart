import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/b_views/i_chains/c_currencies_screen/x_currencies_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/currencies/currency_list_builder.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/xx_currency_button.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:mapper/mapper.dart';
import 'package:provider/provider.dart';
import 'package:scale/scale.dart';

class CurrenciesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CurrenciesScreen({
    this.countryIDCurrencyOverride,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String countryIDCurrencyOverride;
  /// --------------------------------------------------------------------------
  @override
  _CurrenciesScreenState createState() => _CurrenciesScreenState();
  /// --------------------------------------------------------------------------
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  // -----------------------------------------------------------------------------
  final TextEditingController _searchController = TextEditingController();
  // --------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  // --------------------
  final ValueNotifier<List<CurrencyModel>> _foundCurrencies = ValueNotifier([]);
  // --------------------
  final ValueNotifier<bool> _showAllCurrencies = ValueNotifier<bool>(false);
  // --------------------
  // final PageController _pageController = PageController();
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// XXXX
  @override
  void dispose() {
    // _loading.dispose();
    _searchController.dispose();
    _isSearching.dispose();
    _showAllCurrencies.dispose();
    // _pageController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _onSearch(String text){
    onSearchCurrencies(
      context: context,
      searchController: _searchController,
      isSearching: _isSearching,
      foundCurrencies: _foundCurrencies,
      pageController: null, //_pageController,
      mounted: mounted,
    );
  }
  // --------------------
  double _getScrollableHeight(double screenHeight){
    return PageBubble.height(
      appBarType: AppBarType.search,
      context: context,
      screenHeight: screenHeight,
    )
        - 20 // page bubble pading
        - SeparatorLine.getTotalHeight * 3
        - CurrencyButton.standardHeight * 3;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.screenHeight(context);
    final double _scrollableHeight = _getScrollableHeight(_screenHeight);
    // --------------------
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final List<CurrencyModel> _allCurrencies = _zoneProvider.allCurrencies;
    // --------------------
    final CurrencyModel _currencyOverride = ZoneProvider.proGetCurrencyByCountryID(
      countryID: widget.countryIDCurrencyOverride,
      listen: false,
    );
    final CurrencyModel _currentCurrency = _currencyOverride ?? _zoneProvider.currentCurrency;
    // --------------------
    blog('_currentCurrency : ${_currentCurrency.id}');
    _currentCurrency.blogCurrency();
    // --------------------
    return MainLayout(
      title: const Verse(
        id: 'phid_select_currency',
        translate: true,
      ),
      searchHintVerse: const Verse(
        id: 'phid_search_currencies',
        translate: true,
      ),
      appBarType: AppBarType.search,
      searchController: _searchController,
      onSearchChanged: _onSearch,
      onSearchSubmit: _onSearch,
      // loading: _loading,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      onSearchCancelled: (){

        // _searchController.text = '';
        setNotifier(
            notifier: _isSearching,
            mounted: mounted,
            value: false,
        );

      },
      child: ValueListenableBuilder(
        valueListenable: _isSearching,
        builder: (_, bool isSearching, Widget child){

          /// SEARCHING
          if (isSearching == true){
            return PageBubble(
              screenHeightWithoutSafeArea: _screenHeight,
              appBarType: AppBarType.search,
              color: Colorz.white20,
              child: ValueListenableBuilder(
                  valueListenable: _foundCurrencies,
                  builder: (_, List<CurrencyModel> foundCurrencies, Widget child){

                    /// NO RESULT FOUND
                    if (Mapper.checkCanLoopList(foundCurrencies) == false){

                      return const NoResultFound();

                    }

                    /// FOUND RESULTS
                    else {
                      return CurrencyListBuilder(
                        width: PageBubble.width(context),
                        height: PageBubble.height(
                            appBarType: AppBarType.search,
                            context: context,
                            screenHeight: _screenHeight
                        ),
                        currencies: foundCurrencies,
                        onCurrencyTap: (CurrencyModel currency) => onSelectCurrency(
                          context: context,
                          currency: currency,
                        ),
                        searchController: _searchController,
                      );
                    }

                  }
              ),
            );
          }

          /// BROWSING
          else {

            return PageBubble(
              screenHeightWithoutSafeArea: _screenHeight,
              appBarType: AppBarType.search,
              color: Colorz.white20,
              child: SizedBox(
                width: PageBubble.width(context),
                height: PageBubble.height(
                    appBarType: AppBarType.search,
                    context: context,
                    screenHeight: _screenHeight
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: Ratioz.appBarPadding,
                  ),
                  children: <Widget>[

                    /// CURRENT CURRENCY
                    CurrencyButton(
                      currency: _currentCurrency,
                      countryID: widget.countryIDCurrencyOverride ?? _zoneProvider.currentZone.countryID,
                      onTap: (CurrencyModel currency) => onSelectCurrency(
                        context: context,
                        currency: _currentCurrency,
                      ),
                    ),

                    const SeparatorLine(withMargins: true, color: Colorz.yellow200),

                    /// USA DOLLAR
                    if (_currentCurrency?.id != CurrencyModel.usaCurrencyID)
                      CurrencyButton(
                        currency: CurrencyModel.getCurrencyByID(
                          allCurrencies: _allCurrencies,
                          currencyID: CurrencyModel.usaCurrencyID,
                        ),
                        countryID: CurrencyModel.usaCountryID,
                        onTap: (CurrencyModel currency) => onSelectCurrency(
                          context: context,
                          currency: currency,
                        ),
                      ),

                    /// EURO
                    if (_currentCurrency?.id != CurrencyModel.euroCurrencyID)
                      CurrencyButton(
                        currency: CurrencyModel.getCurrencyByID(
                          allCurrencies: _allCurrencies,
                          currencyID: CurrencyModel.euroCurrencyID,
                        ),
                        countryID: CurrencyModel.euroCountryID,
                        onTap: (CurrencyModel currency) => onSelectCurrency(
                          context: context,
                          currency: currency,
                        ),
                      ),

                    const SeparatorLine(withMargins: true,),

                    /// REMAINING CURRENCIES
                    ValueListenableBuilder(
                        valueListenable: _showAllCurrencies,
                        builder: (_, bool showAll, Widget child){

                          if (showAll == true){

                            final List<CurrencyModel> _remainingCurrencies = CurrencyModel.removeCurrencies(
                              currencies: _allCurrencies,
                              removeIDs: <String>[
                                _currentCurrency?.id,
                                CurrencyModel.usaCurrencyID,
                                CurrencyModel.euroCurrencyID,
                              ],
                            );

                            return CurrencyListBuilder(
                              width: PageBubble.clearWidth(context),
                              height: _scrollableHeight,
                              currencies: _remainingCurrencies,
                              onCurrencyTap: (CurrencyModel currency) => onSelectCurrency(
                                context: context,
                                currency: currency,
                              ),
                            );

                            // return Center(
                            //   child: SizedBox(
                            //     width: PageBubble.clearWidth(context),
                            //     height: _scrollableHeight,
                            //     child: ListView.builder(
                            //       itemCount: _remainingCurrencies.length,
                            //       padding: const EdgeInsets.symmetric(vertical: 10),
                            //       physics: const BouncingScrollPhysics(),
                            //       itemBuilder: (_, index){
                            //
                            //         final CurrencyModel _currency = _remainingCurrencies[index];
                            //
                            //         return CurrencyButton(
                            //           width: PageBubble.clearWidth(context) - 20,
                            //           currency: _currency,
                            //           countryID: _currency.countriesIDs.first,
                            //           onTap: () => onSelectCurrency(
                            //             context: context,
                            //             currency: _currentCurrency,
                            //           ),
                            //         );
                            //
                            //       },
                            //     ),
                            //   ),
                            // );

                          }

                          else {
                            return WideButton(
                              width: PageBubble.clearWidth(context) - 20,
                              verse: const Verse(
                                id: 'phid_show_all_currencies',
                                translate: true,
                              ),
                              onTap: (){

                                setNotifier(
                                    notifier: _showAllCurrencies,
                                    mounted: mounted,
                                    value: !_showAllCurrencies.value
                                );

                              },
                            );
                          }

                        }
                    ),

                    const SeparatorLine(withMargins: true,),

                  ],
                ),
              ),
            );
          }

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
