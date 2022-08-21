import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/ccc_select_district_screen_all_districts_view.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/ccc_select_district_screen_search_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols_old.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class SelectDistrictScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SelectDistrictScreen({
    @required this.country,
    @required this.city,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final CityModel city;
  /// --------------------------------------------------------------------------
  @override
  State<SelectDistrictScreen> createState() => _SelectDistrictScreenState();
/// --------------------------------------------------------------------------
}

class _SelectDistrictScreenState extends State<SelectDistrictScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<DistrictModel>> _cityDistricts = ValueNotifier<List<DistrictModel>>(<DistrictModel>[]);
  final ValueNotifier<List<DistrictModel>> _foundDistricts = ValueNotifier<List<DistrictModel>>(null);
  ValueNotifier<ZoneModel> _currentZone;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SelectDistrictScreen',);
    }
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _isSearching.dispose();
    _cityDistricts.dispose();
    _foundDistricts.dispose();
    _cityDistricts.dispose();
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

    Nav.goBack(
        context: context,
        invoker: 'SelectDistrictScreen',
        passedData: _zoneWithDistrict,
    );

  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchDistrict(String inputText) async {

    TextChecker.triggerIsSearchingNotifier(
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
// -----------------------------------------------------------------------------
  void _onBack(){
    Nav.goBack(
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
      sectionButtonIsOn: false,
      onSearchSubmit: _onSearchDistrict,
      onSearchChanged: _onSearchDistrict,
      pageTitle: xPhrase(context, 'phid_select_a_district'),
      pyramidsAreOn: true,
      onBack: _onBack,
      searchHint: '${xPhrase(context, 'phid_search_districts_of')} $_cityName',
      loading: _loading,
      layoutWidget: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return SearchedDistrictsButtons(
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

                    return SelectDistrictScreenAllDistrictsView(
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
}
