import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/aa_cities_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/aa_cities_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/c_districts_screen/a_districts_screen.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class CitiesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreen({
    this.country,
    this.selectCountryAndCityOnly = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final bool selectCountryAndCityOnly;
  /// --------------------------------------------------------------------------
  @override
  State<CitiesScreen> createState() => _NewSelectCityScreen();
  /// --------------------------------------------------------------------------
}

class _NewSelectCityScreen extends State<CitiesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<CityModel>> _countryCities = ValueNotifier<List<CityModel>>(<CityModel>[]);
  final ValueNotifier<List<CityModel>> _foundCities = ValueNotifier<List<CityModel>>(null);
  ValueNotifier<ZoneModel> _currentZone;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SelectCityScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ZoneModel _initialZone = ZoneModel(
      countryID: widget.country?.id,
      countryModel: widget.country,
    );
    _currentZone = ValueNotifier<ZoneModel>(_initialZone);
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // ----------------------------------------
        /// COMPLETE CURRENT ZONE
        _currentZone.value = await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _currentZone.value,
        );

        List<CityModel> _growingList = <CityModel>[];
        final List<CityModel> _fetchedCities = await ZoneProtocols.fetchCities(
          context: context,
          citiesIDs: _currentZone.value.countryModel?.citiesIDs,
          onCityLoaded: (CityModel city) async {

            if (mounted == true){

              _growingList = CityModel.addCityToCities(
                cities: _countryCities.value,
                city: city,
              );

              final List<CityModel> _ordered = CityModel.sortCitiesAlphabetically(
                context: context,
                cities: _growingList,
              );

              _countryCities.value = <CityModel>[..._ordered];

            }

          },
        );

        if (mounted == true){
          final List<CityModel> _ordered = CityModel.sortCitiesAlphabetically(
            context: context,
            cities: _fetchedCities,
          );
          _countryCities.value = <CityModel>[..._ordered];
        }

        // ----------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _isSearching.dispose();
    _foundCities.dispose();
    _countryCities.dispose();
    _currentZone.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onCityTap(String cityID) async {

    if (mounted == true){
      Keyboard.closeKeyboard(context);
    }

    final ZoneModel _zoneWithCity = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _currentZone.value.copyWith(
        cityID: cityID,
      ),
    );

    final bool _cityHasDistricts = Mapper.checkCanLoopList(_zoneWithCity?.cityModel?.districts);

    /// IF SELECTING COUNTY AND CITY ONLY
    if (widget.selectCountryAndCityOnly == true || _cityHasDistricts == false){
      Nav.goBack(
        context: context,
        invoker: '_onCityTap',
        passedData: _zoneWithCity,
      );
    }

    /// IF SELECTING COUNTRY AND CITY AND DISTRICT
    else {

      final ZoneModel _zoneWithDistrict = await Nav.goToNewScreen(
          context: context,
          screen: DistrictsScreen(
            country: _zoneWithCity.countryModel,
            city: _zoneWithCity.cityModel,
          )
      );

      /// WHEN NO DISTRICT SELECTED
      if (_zoneWithDistrict == null){
        Nav.goBack(
          context: context,
          invoker: '_onCityTap',
          passedData: _zoneWithCity,
        );
      }

      /// WHEN A DISTRICT IS SELECTED
      else {
        Nav.goBack(
          context: context,
          invoker: '_onCityTap',
          passedData: _zoneWithDistrict,
        );
      }

    }

  }
  // --------------------
  Future<void> _onSearchCity(String inputText) async {

    TextCheck.triggerIsSearchingNotifier(
        text: inputText,
        isSearching: _isSearching
    );

    /// WHILE SEARCHING
    if (_isSearching.value == true){

      /// START LOADING
      await _triggerLoading(setTo: true);

      /// CLEAR PREVIOUS SEARCH RESULTS
      _foundCities.value = <CityModel>[];

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
      _foundCities.value = await searchCitiesByName(
        context: context,
        input: TextMod.fixCountryName(inputText),
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // --------------------
  Future<List<CityModel>> searchCitiesByName({
    @required BuildContext context,
    @required String input,
  }) async {

    blog('searchCitiesByName : input : $input');

    /// SEARCH SELECTED COUNTRY CITIES
    final List<CityModel> _searchResult = CityModel.searchCitiesByName(
      context: context,
      sourceCities: _countryCities.value,
      inputText: input,
    );

    CityModel.blogCities(_searchResult,);

    /// SET FOUND CITIES
    return _searchResult;

  }
  // --------------------
  void _onBack(){

    Nav.goBack(
      context: context,
      invoker: 'SelectCityScreen',
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _countryName = CountryModel.getTranslatedCountryName(
      context: context,
      countryID: widget.country?.id,
    );

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      onSearchSubmit: _onSearchCity,
      onSearchChanged: _onSearchCity,
      pageTitleVerse: 'phid_selectCity',
      pyramidsAreOn: true,
      onBack: _onBack,
      searchHintVerse:  '${xPhrase( context, 'phid_search_cities_of')} $_countryName',
      loading: _loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// LOADING COUNTER
        if (Mapper.checkCanLoopList(widget.country?.citiesIDs) == true)
          ValueListenableBuilder(
              valueListenable: _loading,
              builder: (_, bool isLoading, Widget child){

                if (isLoading == true){
                  return ValueListenableBuilder(
                    valueListenable: _countryCities,
                    builder: (_, List<CityModel> cities, Widget child){

                      return SuperVerse(
                        verse:  '${cities.length} / ${widget.country.citiesIDs.length}',
                        weight: VerseWeight.thin,
                        size: 1,
                        margin: Scale.superInsets(context: context, bottom: 20, enRight: 10),
                        labelColor: Colorz.white20,
                        color: Colorz.yellow255,
                      );

                    },
                  );
                }

                else {
                  return const SizedBox();
                }
              }
          ),

      ],
      layoutWidget: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return CitiesScreenSearchView(
                loading: _loading,
                foundCities: _foundCities,
                onCityTap: _onCityTap,
              );

            }

            /// NOT SEARCHING
            else {

              return CitiesScreenBrowseView(
                onCityChanged: _onCityTap,
                countryCities: _countryCities,
              );

            }

          },
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
