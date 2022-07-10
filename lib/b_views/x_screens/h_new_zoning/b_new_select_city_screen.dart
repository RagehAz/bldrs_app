import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_new_zoning/c_new_select_district_screen.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/bbb_select_city_screen_all_cities_view.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_city_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;

class NewSelectCityScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewSelectCityScreen({
    this.country,
    this.selectCountryAndCityOnly = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final bool selectCountryAndCityOnly;
  /// --------------------------------------------------------------------------
  @override
  State<NewSelectCityScreen> createState() => _NewSelectCityScreen();

/// --------------------------------------------------------------------------
}

class _NewSelectCityScreen extends State<NewSelectCityScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false); /// tamam disposed
  final ValueNotifier<List<CityModel>> _countryCities = ValueNotifier<List<CityModel>>(<CityModel>[]);  /// tamam disposed
  final ValueNotifier<List<CityModel>> _foundCities = ValueNotifier<List<CityModel>>(null); /// tamam disposed
  ValueNotifier<ZoneModel> _currentZone;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading({
    @required setTo,
  }) async {
    _loading.value = setTo;
    blogLoading(
      loading: _loading.value,
      callerName: 'EditProfileScreen',
    );
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
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _isSearching.dispose();
    _foundCities.dispose();
    _countryCities.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // ----------------------------------------
        /// COMPLETE CURRENT ZONE
        _currentZone.value = await ZoneProvider.proFetchCompleteZoneModel(
            context: context,
            incompleteZoneModel: _currentZone.value,
        );

        final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
        List<CityModel> _growingList = <CityModel>[];
        final List<CityModel> _fetchedCities = await _zoneProvider.fetchCitiesByIDs(
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
// -----------------------------------------------------------------------------
  Future<void> _onCityTap(String cityID) async {

    if (mounted == true){
      closeKeyboard(context);
    }

    final ZoneModel _zoneWithCity = await ZoneProvider.proFetchCompleteZoneModel(
      context: context,
      incompleteZoneModel: _currentZone.value.copyWith(
        cityID: cityID,
      ),
    );

    final bool _cityHasDistricts = Mapper.checkCanLoopList(_zoneWithCity?.cityModel?.districts);

    /// IF SELECTING COUNTY AND CITY ONLY
    if (widget.selectCountryAndCityOnly == true || _cityHasDistricts == false){
      Nav.goBack(context, passedData: _zoneWithCity);
    }

    /// IF SELECTING COUNTRY AND CITY AND DISTRICT
    else {

      final ZoneModel _zoneWithDistrict = await Nav.goToNewScreen(
          context: context,
          screen: NewSelectDistrictScreen(
            country: _zoneWithCity.countryModel,
            city: _zoneWithCity.cityModel,
          )
      );

      /// WHEN NO DISTRICT SELECTED
      if (_zoneWithDistrict == null){
        Nav.goBack(context, passedData: _zoneWithCity);
      }

      /// WHEN A DISTRICT IS SELECTED
      else {
        Nav.goBack(context, passedData: _zoneWithDistrict);
      }

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchCity(String inputText) async {

    triggerIsSearchingNotifier(
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
// -------------------------------------
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
  // -------------------------------------
  void _onBack(){

    Nav.goBack(context);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    // final List<CityModel> _selectedCountryCities = _zoneProvider.selectedCountryCities;

    // final ZoneModel _appBarZone = ZoneModel(
    //   countryID: widget.country.id,
    // );

    final String _countryName = CountryModel.getTranslatedCountryName(
      context: context,
      countryID: widget.country?.id,
    );

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      onSearchSubmit: _onSearchCity,
      onSearchChanged: _onSearchCity,
      pageTitle: '${superPhrase(context, 'phid_selectCity')} ${superPhrase(context, 'phid_inn')} $_countryName',
      pyramidsAreOn: true,
      onBack: _onBack,
      searchHint: '${superPhrase(context, 'phid_search_cities_of')} $_countryName',
      loading: _loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        // ZoneButton(
        //   zoneOverride: _appBarZone,
        //   countryOverride: widget.country,
        // ),

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
                      verse: '${cities.length} / ${widget.country.citiesIDs.length}',
                      weight: VerseWeight.thin,
                      size: 1,
                      margin: superInsets(context: context, bottom: 20, enRight: 10),
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

              return ValueListenableBuilder(
                  valueListenable: _loading,
                  builder:(_, bool loading, Widget child){

                    /// WHILE LOADING
                    if (loading == true){
                      return const LoadingFullScreenLayer();
                    }

                    /// SEARCH RESULT
                    else {

                      return ValueListenableBuilder(
                          valueListenable: _foundCities,
                          builder: (_, List<CityModel> foundCities, Widget child){

                            const EdgeInsets _topMargin = EdgeInsets.only(
                              top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
                              bottom: Ratioz.horizon,
                            );

                            /// WHEN SEARCH RESULTS
                            if (Mapper.checkCanLoopList(foundCities) == true){


                              return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: foundCities.length,
                                  padding: _topMargin,
                                  shrinkWrap: true,
                                  itemBuilder: (_, int index) {

                                    final CityModel input = foundCities[index];

                                    return WideCityButton(
                                      city: input,
                                      onTap: _onCityTap,
                                    );

                                  }
                              );

                            }

                            /// WHEN RESULT IS EMPTY
                            else {

                              return Container(
                                margin: _topMargin,
                                child: const SuperVerse(
                                  verse: 'No Result found',
                                  labelColor: Colorz.white10,
                                  size: 3,
                                  weight: VerseWeight.thin,
                                  italic: true,
                                  color: Colorz.white200,
                                ),
                              );

                            }

                          },
                      );
                    }

                  }
              );


            }

            /// NOT SEARCHING
            else {

              return ValueListenableBuilder(
                  valueListenable: _countryCities,
                  builder: (_, List<CityModel> cities, Widget child){

                    return SelectCityScreenAllCitiesView(
                      onCityChanged: _onCityTap,
                      cities: cities,
                    );

                  },
              );

            }

          },
        ),
      ),

    );

  }
}