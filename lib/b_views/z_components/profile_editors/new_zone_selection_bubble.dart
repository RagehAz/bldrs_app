import 'dart:async';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_new_zoning/a_new_select_country_screen.dart';
import 'package:bldrs/b_views/x_screens/h_new_zoning/b_new_select_city_screen.dart';
import 'package:bldrs/b_views/x_screens/h_new_zoning/c_new_select_district_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewZoneSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewZoneSelectionBubble({
    @required this.currentZone,
    @required this.onZoneChanged,
    this.title = 'Preferred Location',
    this.notes,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel currentZone;
  final ValueChanged<ZoneModel> onZoneChanged;
  final String title;
  final List<String> notes;
  /// --------------------------------------------------------------------------
  @override
  _NewZoneSelectionBubbleState createState() => _NewZoneSelectionBubbleState();
/// --------------------------------------------------------------------------
}

class _NewZoneSelectionBubbleState extends State<NewZoneSelectionBubble> {
// -----------------------------------------------------------------------------
//   final ValueNotifier<CountryModel> _selectedCountry = ValueNotifier(null); /// tamam disposed
//   final ValueNotifier<CityModel> _selectedCity = ValueNotifier(null);/// tamam disposed
//   final ValueNotifier<DistrictModel> _selectedDistrict = ValueNotifier(null);/// tamam disposed
// ------------------------------------------
  ValueNotifier<ZoneModel> _selectedZone;
  ZoneProvider _zoneProvider;
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
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final ZoneModel _initialZone = widget.currentZone ?? _zoneProvider.currentZone;
    _selectedZone = ValueNotifier<ZoneModel>(_initialZone);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
        await _initializeBubbleZone();
// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    _loading.dispose();
    _selectedZone.dispose();
    // _selectedCountry.dispose();
    // _selectedCity.dispose();
    // _selectedDistrict.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _initializeBubbleZone() async {

    _selectedZone.value = await ZoneProvider.proFetchCompleteZoneModel(
      context: context,
      incompleteZoneModel: _selectedZone.value,
    );

    // _selectedCountry.value = _selectedZone?.countryModel ?? await _zoneProvider.fetchCountryByID(
    //   context: context,
    //   countryID: _selectedZone.countryID,
    // );
    //
    // _selectedCity.value = _selectedZone?.cityModel ?? await _zoneProvider.fetchCityByID(
    //   context: context,
    //   cityID: _selectedZone.cityID,
    // );
    //
    // _selectedDistrict.value = DistrictModel.getDistrictFromDistricts(
    //   districts: _selectedCity.value?.districts,
    //   districtID: _selectedZone.districtID,
    // );

  }
// -----------------------------------------------------------------------------
  Future<void> _onCountryButtonTap({
    @required BuildContext context
  }) async {

    Keyboarders.closeKeyboard(context);

    final ZoneModel _zone = await Nav.goToNewScreen(
        context: context,
        screen: const NewSelectCountryScreen(),
    );

    if (_zone == null){

    }
    else {

      _zone.blogZone(methodName: 'received zone');
      _selectedZone.value =  await ZoneProvider.proFetchCompleteZoneModel(
        context: context,
        incompleteZoneModel: _zone,
      );

      widget.onZoneChanged(_selectedZone.value);

      // await _onCityButtonTap(context: context);

    }

  }
// ----------------------------------------
  /*
  Future<void> _onSelectCountry(String countryID) async {

    // _loading.value = true;
    // _selectedCity.value = null;
    // _selectedDistrict.value = null;

    _selectedZone.value =  await ZoneProvider.proFetchCompleteZoneModel(
      context: context,
      incompleteZoneModel: ZoneModel(
        countryID: countryID,
      ),
    );

    widget.onZoneChanged(_selectedZone.value);
    Nav.goBack(context);

    _selectedCountry.value = await _zoneProvider.fetchCountryByID(
      context: context,
      countryID: countryID,
    );

    // _selectedCountryCities.value = await _zoneProvider.fetchCitiesByIDs(
    //   context: context,
    //   citiesIDs: _selectedCountry.value?.citiesIDs,
    // );

    // _isLoadingCities.value = false;

    await _onShowCitiesTap(context: context);
  }
   */
// -----------------------------------------------------------------------------
  Future<void> _onCityButtonTap({
    @required BuildContext context
  }) async {

    Keyboarders.closeKeyboard(context);

    if (_selectedZone.value.countryModel != null){

      final ZoneModel _zone = await Nav.goToNewScreen(
          context: context,
          screen: NewSelectCityScreen(
            country: _selectedZone.value.countryModel,
          )
      );

      /// WHEN NO CITY GOT SELECTED
      if (_zone == null){

      }

      /// WHEN SELECTED A CITY
      else {
        _selectedZone.value = await ZoneProvider.proFetchCompleteZoneModel(
          context: context,
          incompleteZoneModel: _zone,
        );

        widget.onZoneChanged(_selectedZone.value);

        // if (Mapper.checkCanLoopList(_selectedZone.value?.cityModel?.districts) == true){
        //   await _onDistrictButtonTap(context: context);
        // }

      }

    }

  }
// ----------------------------------------
  /*
  Future<void> _onSelectCity(String cityID) async {

    // _isLoadingDistricts.value = true;

    // _selectedDistrict.value = null;

    // _selectedZone = ZoneModel(
    //   countryID: _selectedZone.countryID,
    //   cityID: cityID,
    //   // districtID: null,
    // );

    // widget.onZoneChanged(_selectedZone);
    // Nav.goBack(context);

    // _selectedCity.value = await _zoneProvider.fetchCityByID(
    //     context: context,
    //     cityID: cityID
    // );

    // _isLoadingDistricts.value = false;

    // if (Mapper.checkCanLoopList(_selectedCity.value?.districts) == true){
    //   await _onShowDistricts(context: context);
    // }

  }
   */
// -----------------------------------------------------------------------------
  Future<void> _onDistrictButtonTap({
    @required BuildContext context,
  }) async {

    Keyboarders.closeKeyboard(context);

    if (_selectedZone.value.countryModel != null && _selectedZone.value.cityModel != null){

      final ZoneModel _zone = await Nav.goToNewScreen(
        context: context,
        screen: NewSelectDistrictScreen(
          country: _selectedZone.value.countryModel,
          city: _selectedZone.value.cityModel,
        ),
      );

      /// WHEN NO DISTRICT SELECTED
      if (_zone == null){

      }

      /// WHEN SELECTED A DISTRICT
      else {

        blog('got back with district : ${_zone.districtID}');

        _selectedZone.value = await ZoneProvider.proFetchCompleteZoneModel(
          context: context,
          incompleteZoneModel: _zone,
        );

        widget.onZoneChanged(_selectedZone.value);

      }

    }

  }
// ----------------------------------------
  /*
  void _onSelectDistrict(String districtID) {

    // final DistrictModel _district = DistrictModel.getDistrictFromDistricts(
    //     districts: _selectedCity.value.districts,
    //     districtID: districtID
    // );

    // _selectedDistrict.value = _district;

    // _selectedZone = _selectedZone.copyWith(
    //   districtID: districtID,
    // );

    // widget.onZoneChanged(_selectedZone);
    //
    // Nav.goBack(context);

  }
   */
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget child){

      return ValueListenableBuilder(
        valueListenable: _selectedZone,
        builder: (_, ZoneModel zone, Widget bulletPoints){

          final String _countryFlag = Flag.getFlagIconByCountryID(zone?.countryID);

          return Bubble(
              title: widget.title,
              redDot: true,
              columnChildren: <Widget>[

                if (Mapper.checkCanLoopList(widget.notes))
                  bulletPoints,

                /// COUNTRY BUTTON
                ZoneSelectionButton(
                  title: superPhrase(context, 'phid_country'),
                  icon: _countryFlag,
                  verse: zone.countryName,
                  onTap: () => _onCountryButtonTap(context: context),
                  loading: loading,
                ),

                /// City BUTTON
                ZoneSelectionButton(
                  title: 'City',
                  verse: zone.cityName,
                  onTap: () => _onCityButtonTap(context: context),
                  loading: loading,
                ),

                /// DISTRICT BUTTON
                if (Mapper.checkCanLoopList(zone?.cityModel?.districts) == true)
                  ZoneSelectionButton(
                    title: 'District',
                    verse: zone.districtName,
                    onTap: () => _onDistrictButtonTap(context: context),
                    loading: loading,
                  ),

              ]
          );

        },
        child: BubbleBulletPoints(
          bulletPoints: widget.notes,
        ),
      );

    });

  }
}