import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/i_chains/c_currencies_screen/x_currencies_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/currencies/currency_list_builder.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/xx_currency_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
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

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// XXXX
  @override
  void dispose() {
    _loading.dispose();
    _searchController.dispose();
    _isSearching.dispose();
    _showAllCurrencies.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _onSearch(String text){
    onSearchCurrencies(
      context: context,
      searchController: _searchController,
      isSearching: _isSearching,
      foundCurrencies: _foundCurrencies,
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
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _scrollableHeight = _getScrollableHeight(_screenHeight);
    // --------------------
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final List<CurrencyModel> _allCurrencies = _zoneProvider.allCurrencies;
    // --------------------
    final CurrencyModel _currencyOverride = ZoneProvider.proGetCurrencyByCountryID(
      context: context,
      countryID: widget.countryIDCurrencyOverride,
      listen: false,
    );
    final CurrencyModel _currentCurrency = _currencyOverride ?? _zoneProvider.currentCurrency;
    // --------------------
    blog('_currentCurrency : ${_currentCurrency.id}');
    _currentCurrency.blogCurrency();
    // --------------------
    return MainLayout(
      pageTitleVerse: const Verse(
        text: 'phid_select_currency',
        translate: true,
      ),
      searchHintVerse: const Verse(
        text: 'phid_search_currencies',
        translate: true,
      ),
      sectionButtonIsOn: false,
      appBarType: AppBarType.search,
      searchController: _searchController,
      onSearchChanged: _onSearch,
      onSearchSubmit: _onSearch,
      loading: _loading,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      onSearchCancelled: (){
        // _searchController.text = '';
        _isSearching.value = false;
      },
      layoutWidget: ValueListenableBuilder(
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
                      currency: currency,
                    ),
                  ),

                  const SeparatorLine(withMargins: true,),

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
                              text: 'phid_show_all_currencies',
                              translate: true,
                            ),
                            onTap: (){
                              _showAllCurrencies.value = !_showAllCurrencies.value;
                            },
                          );
                        }

                      }
                  ),

                  const SeparatorLine(withMargins: true,),

                ],
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
