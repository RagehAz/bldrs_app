import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_screens/e_currencies_screen/b_currencies_list_builder.dart';
import 'package:bldrs/b_screens/e_currencies_screen/x_currencies_screen_controllers.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class CurrenciesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CurrenciesScreen({
    required this.selectedCurrencyID,
    this.viewerCountryID,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? viewerCountryID;
  final String? selectedCurrencyID;
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
  List<Phrase> _allCurrenciesPhrases = [];
  List<CurrencyModel> _allCurrencies = [];
  // --------------------
  // final PageController _pageController = PageController();
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
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
      _isInit = false; // good

      asyncInSync(() async {

        await _initialize();

      });


    }
    super.didChangeDependencies();
  }
  // --------------------
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

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _initialize() async {

    final List<Phrase> _enPhrases = await _loadEnCurrencyPhrases();

    final List<Phrase> _otherPhrases = await _loadCurrentLangCurrencyPhrases();

    final List<CurrencyModel> _all = ZoneProtocols.fetchCurrencies();

    final List<String> _idsOnTop = _getCurrenciesIDsToPutOnTop(
      all: _all,
    );

    final List<CurrencyModel> _currencies = _organizeCurrencies(
      phrases: _otherPhrases.isNotEmpty == true ? _otherPhrases : _enPhrases,
      all: _all,
      currenciesIDsOnTop: _idsOnTop,
    );

    setState(() {
      _allCurrenciesPhrases = [..._otherPhrases, ..._enPhrases];
      _allCurrencies = _currencies;
    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Phrase>> _loadEnCurrencyPhrases() async {

    final List<Phrase> _enPhrases = await CurrencyModel.getCurrenciesPhrasesFromLangMap(
      langCode: 'en',
    );

    return _enPhrases;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Phrase>> _loadCurrentLangCurrencyPhrases() async {
    List<Phrase> _output = [];

    final String _currentLangCode = Localizer.getCurrentLangCode();
    if (_currentLangCode != 'en') {
      _output = await CurrencyModel.getCurrenciesPhrasesFromLangMap(
        langCode: _currentLangCode,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> _getCurrenciesIDsToPutOnTop({
    required List<CurrencyModel> all,
  }){

      final List<String> _putOnTop = ['usa', 'euz'];
      if (
          widget.viewerCountryID != null &&
          widget.viewerCountryID != 'usa' &&
          widget.viewerCountryID != 'euz' &&
          America.checkCountryIDIsStateID(widget.viewerCountryID) == false
      ){
        _putOnTop.insert(0, widget.viewerCountryID!);
      }

      return CurrencyModel.getCurrenciesIDsByCountriesIDs(
        countriesIDs: _putOnTop,
        allCurrencies: all,
      );
    }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<CurrencyModel> _organizeCurrencies({
    required List<String> currenciesIDsOnTop,
    required List<CurrencyModel> all,
    required List<Phrase> phrases,
  }){

    _allCurrencies = CurrencyModel.removeCurrencies(
      currencies: all,
      removeIDs: currenciesIDsOnTop,
    );

    _allCurrencies = CurrencyModel.sortCurrenciesByCurrentLang(
      currencies: _allCurrencies,
      phrases: phrases,
    );

    final List<CurrencyModel> _reAddThose = CurrencyModel.getCurrenciesByIDs(
      allCurrencies: all,
      currenciesIDs: currenciesIDsOnTop,
    );

    return [..._reAddThose, ..._allCurrencies];
  }
  // -----------------------------------------------------------------------------

  /// SEARCHING

  // --------------------
  /// TESTED : WORKS PERFECT
  void _onSearch(String? text){
    onSearchCurrencies(
      searchController: _searchController,
      isSearching: _isSearching,
      foundCurrencies: _foundCurrencies,
      mounted: mounted,
      allCurrenciesPhrases: _allCurrenciesPhrases,
      allCurrencies: _allCurrencies,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onSearchCancelled() {
    _searchController.clear();
    setNotifier(
      notifier: _isSearching,
      mounted: mounted,
      value: false,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCurrencyTap(CurrencyModel? currency) async {

    await Nav.goBack(
      context: context,
      passedData: currency,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final CurrencyModel? _selectedCurrency = CurrencyModel.getCurrencyByID(
        allCurrencies: _allCurrencies,
        currencyID: widget.selectedCurrencyID,
    );
    // --------------------
    return MainLayout(
      canSwipeBack: true,
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
      skyType: SkyType.grey,
      onSearchCancelled: _onSearchCancelled,
      child: ValueListenableBuilder(
        valueListenable: _isSearching,
        builder: (_, bool isSearching, Widget? child){

          if (isSearching == true){

            return ValueListenableBuilder(
              valueListenable: _foundCurrencies,
              builder: (context, List<CurrencyModel> found, Widget? child) {

                /// NO RESULT FOUND
                if (Lister.checkCanLoop(found) == false){
                  return const Center(
                      child: NoResultFound(),
                  );
                }

                /// FOUND CURRENCIES
                else {
                  return CurrenciesBuilder(
                      currencies: found,
                      selectedCurrency: _selectedCurrency,
                      highlightController: _searchController,
                      onTap: _onCurrencyTap,
                  );
                }

              }
            );
          }

          else {
            return CurrenciesBuilder(
                currencies: _allCurrencies,
                selectedCurrency: _selectedCurrency,
                highlightController: _searchController,
                onTap: _onCurrencyTap,
            );
          }

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
