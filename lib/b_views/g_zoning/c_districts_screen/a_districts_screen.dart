import 'package:bldrs/a_models/d_zone/city_model.dart';
import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/district_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/c_districts_screen/aa_districts_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/c_districts_screen/aa_districts_screen_search_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class DistrictsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DistrictsScreen({
    @required this.country,
    @required this.city,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final CityModel city;
  /// --------------------------------------------------------------------------
  @override
  State<DistrictsScreen> createState() => _DistrictsScreenState();
  /// --------------------------------------------------------------------------
}

class _DistrictsScreenState extends State<DistrictsScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<DistrictModel>> _cityDistricts = ValueNotifier<List<DistrictModel>>(<DistrictModel>[]);
  final ValueNotifier<List<DistrictModel>> _foundDistricts = ValueNotifier<List<DistrictModel>>(null);
  ValueNotifier<ZoneModel> _currentZone;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ZoneModel _initialZone = ZoneModel(
      countryID: widget.country.id,
      countryModel: widget.country,
      cityID: widget.city.cityID,
      cityModel: widget.city,
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

        final List<DistrictModel> _districts = _currentZone.value.cityModel.districts;
        final List<DistrictModel> _ordered = DistrictModel.sortDistrictsAlphabetically(
          context: context,
          districts: _districts,
        );
        _cityDistricts.value = _ordered;
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
    _cityDistricts.dispose();
    _foundDistricts.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onDistrictTap(String districtID) async {

    if (mounted == true){
      Keyboard.closeKeyboard(context);
    }

    final ZoneModel _zoneWithDistrict = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _currentZone.value.copyWith(
        districtID: districtID,
      ),
    );

    await Nav.goBack(
      context: context,
      invoker: 'SelectDistrictScreen',
      passedData: _zoneWithDistrict,
    );

  }
  // --------------------
  Future<void> _onSearchDistrict(String inputText) async {

    TextCheck.triggerIsSearchingNotifier(
        text: inputText,
        isSearching: _isSearching
    );

    /// WHILE SEARCHING
    if (_isSearching.value == true){

      /// START LOADING
      await _triggerLoading(setTo: true);

      /// CLEAR PREVIOUS SEARCH RESULTS
      _foundDistricts.value = <DistrictModel>[];

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
      _foundDistricts.value = DistrictModel.searchDistrictsByCurrentLingoName(
        context: context,
        sourceDistricts: _cityDistricts.value,
        inputText: TextMod.fixCountryName(inputText),
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // --------------------
  Future<void> _onBack() async {
    await Nav.goBack(
      context: context,
      invoker: 'SelectDistrictScreen',
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _cityName = CityModel.getTranslatedCityNameFromCity(
      context: context,
      city: widget.city,
    );

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      onSearchSubmit: _onSearchDistrict,
      onSearchChanged: _onSearchDistrict,
      pageTitleVerse: const Verse(
        text: 'phid_select_a_district',
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: _onBack,
      searchHintVerse: Verse(
        text: '${xPhrase( context, 'phid_search_districts_of')} $_cityName',
        translate: false,
      ),
      loading: _loading,
      layoutWidget: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return DistrictsScreenSearchView(
                loading: _loading,
                foundDistricts: _foundDistricts,
                onDistrictTap: _onDistrictTap,
              );

            }

            /// NOT SEARCHING
            else {

              return
                ValueListenableBuilder(
                  valueListenable: _cityDistricts,
                  builder: (_, List<DistrictModel> districts, Widget child){

                    return DistrictsScreenBrowseView(
                      onDistrictChanged: _onDistrictTap,
                      districts: districts,
                    );

                  },
                );

            }

          },
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
