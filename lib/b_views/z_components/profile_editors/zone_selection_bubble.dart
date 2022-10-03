import 'dart:async';

import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/b_views/g_zoning/c_districts_screen/a_districts_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class ZoneSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoneSelectionBubble({
    @required this.currentZone,
    @required this.onZoneChanged,
    this.titleVerse,
    this.bulletPoints,
    this.translateBullets = true,
    this.validator,
    this.autoValidate = true,
    this.selectCountryAndCityOnly = true,
    this.selectCountryIDOnly = false,
    this.isRequired = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel currentZone;
  final ValueChanged<ZoneModel> onZoneChanged;
  final Verse titleVerse;
  final List<Verse> bulletPoints;
  final bool translateBullets;
  final String Function() validator;
  final bool autoValidate;
  final bool selectCountryAndCityOnly;
  final bool selectCountryIDOnly;
  final bool isRequired;
  /// --------------------------------------------------------------------------
  @override
  _ZoneSelectionBubbleState createState() => _ZoneSelectionBubbleState();
  /// --------------------------------------------------------------------------
}

class _ZoneSelectionBubbleState extends State<ZoneSelectionBubble> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ZoneModel> _selectedZone = ValueNotifier<ZoneModel>(null);
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
      blogLoading(loading: _loading.value, callerName: 'ZoneSelectionBubble',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ZoneModel _initialZone = widget.currentZone ?? ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
    );

    _selectedZone.value = _initialZone;

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // ----------------------------------
        _selectedZone.value = await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _selectedZone.value,
        );
        // ----------------------------------
        await _triggerLoading(setTo: false);
        // ----------------------------------
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose(){
    _loading.dispose();
    _selectedZone.dispose();
    super.dispose();
  }
  // --------------------
  @override
  void didUpdateWidget(covariant ZoneSelectionBubble oldWidget) {

    if (
    ZoneModel.checkZonesIDsAreIdentical(
      zone1: oldWidget.currentZone,
      zone2: widget.currentZone,
    ) == false
    ){
      // widget.currentZone.blogZone(methodName: 'didUpdateWidget');
      _selectedZone.value = widget.currentZone;
    }

    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------
  Future<void> _onCountryButtonTap({
    @required BuildContext context
  }) async {

    Keyboard.closeKeyboard(context);

    final ZoneModel _zone = await Nav.goToNewScreen(
      context: context,
      screen: CountriesScreen(
        selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
        selectCountryIDOnly: widget.selectCountryIDOnly,
      ),
    );

    if (_zone == null){

    }
    else {

      _zone.blogZone(methodName: 'received zone');
      _selectedZone.value =  await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: _zone,
      );

      widget.onZoneChanged(_selectedZone.value);

      // await _onCityButtonTap(context: context);

    }

  }
  // --------------------
  Future<void> _onCityButtonTap({
    @required BuildContext context
  }) async {

    Keyboard.closeKeyboard(context);

    if (_selectedZone.value.countryModel != null){

      final ZoneModel _zone = await Nav.goToNewScreen(
          context: context,
          screen: CitiesScreen(
            country: _selectedZone.value.countryModel,
            selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
          )
      );

      /// WHEN NO CITY GOT SELECTED
      if (_zone == null){

      }

      /// WHEN SELECTED A CITY
      else {
        _selectedZone.value = await ZoneProtocols.completeZoneModel(
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
  // --------------------
  Future<void> _onDistrictButtonTap({
    @required BuildContext context,
  }) async {

    Keyboard.closeKeyboard(context);

    if (_selectedZone.value.countryModel != null && _selectedZone.value.cityModel != null){

      final ZoneModel _zone = await Nav.goToNewScreen(
        context: context,
        screen: DistrictsScreen(
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

        _selectedZone.value = await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _zone,
        );

        widget.onZoneChanged(_selectedZone.value);

      }

    }

  }
  // -----------------------------------------------------------------------------
  String _validator(){
    if (widget.validator == null){
      return null;
    }
    else {
      return widget.validator();
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget child){

          return ValueListenableBuilder(
            valueListenable: _selectedZone,
            builder: (_, ZoneModel zone, Widget bulletPoints){

              return Bubble(
                  bubbleColor: Formers.validatorBubbleColor(
                    validator: _validator,
                  ),
                  headerViewModel: BubbleHeaderVM(
                    headlineVerse: widget.titleVerse ?? const Verse(
                      text: 'phid_location',
                      translate: true,
                    ),
                    redDot: widget.isRequired,
                  ),
                  columnChildren: <Widget>[

                    if (Mapper.checkCanLoopList(widget.bulletPoints))
                      bulletPoints,

                    /// COUNTRY BUTTON
                    ZoneSelectionButton(
                      title: const Verse(
                        text: 'phid_country',
                        translate: true,
                      ),
                      verse: Verse(
                        text: zone.countryName,
                        translate: false,
                      ),
                      icon: zone?.flag,
                      onTap: () => _onCountryButtonTap(context: context),
                      loading: loading,
                    ),

                    /// City BUTTON
                    if (
                    widget.selectCountryAndCityOnly == true
                    ||
                    widget.selectCountryIDOnly == false
                    )
                    ZoneSelectionButton(
                      title: const Verse(
                        text: 'phid_city',
                        translate: true,
                      ),
                      verse: Verse(
                        text: zone.cityName,
                        translate: false,
                      ),
                      onTap: () => _onCityButtonTap(context: context),
                      loading: loading,
                    ),

                    /// DISTRICT BUTTON
                    if (
                    widget.selectCountryAndCityOnly == false
                    &&
                    widget.selectCountryIDOnly == false
                    &&
                    Mapper.checkCanLoopList(zone?.cityModel?.districts) == true
                    )
                      ZoneSelectionButton(
                        title: const Verse(
                          text: 'phid_district',
                          translate: true,
                        ),
                        verse: Verse(
                          text: zone.districtName,
                          translate: false,
                        ),
                        onTap: () => _onDistrictButtonTap(context: context),
                        loading: loading,
                      ),

                    if (widget.validator != null)
                    SuperValidator(
                      width: Bubble.clearWidth(context) - 20,
                      validator: _validator,
                      autoValidate: widget.autoValidate,
                    ),

                  ]
              );

            },
            child: BulletPoints(
              bulletPoints: widget.bulletPoints,
            ),
          );

        });

  }
  // -----------------------------------------------------------------------------
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
// ----------------------------------------
