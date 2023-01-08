import 'dart:async';

import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/b_views/g_zoning/c_districts_screen/a_districts_screen.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class ZoneSelectionBubble extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoneSelectionBubble({
    @required this.currentZone,
    @required this.onZoneChanged,
    @required this.zoneViewingEvent,
    @required this.depth,
    this.titleVerse,
    this.bulletPoints,
    this.translateBullets = true,
    this.validator,
    this.autoValidate = true,
    // this.selectCountryAndCityOnly = true,
    // this.selectCountryIDOnly = false,
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
  final ZoneDepth depth;
  // final bool selectCountryAndCityOnly;
  // final bool selectCountryIDOnly;
  final bool isRequired;
  final ViewingEvent zoneViewingEvent;
  /// --------------------------------------------------------------------------
  @override
  _ZoneSelectionBubbleState createState() => _ZoneSelectionBubbleState();
  /// --------------------------------------------------------------------------
}

class _ZoneSelectionBubbleState extends State<ZoneSelectionBubble> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ZoneModel> _selectedZone = ValueNotifier<ZoneModel>(null);
  bool _cityHasDistricts = false;
  // -----------------------------------------------------------------------------
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
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ZoneModel _initialZone = widget.currentZone ?? ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
    );

    setNotifier(
        notifier: _selectedZone,
        mounted: mounted,
        value: _initialZone,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // --------------------
        final ZoneModel _zone = await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _selectedZone.value,
        );
        // --------------------
        setNotifier(
            notifier: _selectedZone,
            mounted: mounted,
            value: _zone,
        );
        // --------------------
        await _checkCityHasDistricts();
        // --------------------
        await _triggerLoading(setTo: false);
        // --------------------
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

    final bool _zonesIdsAreIdentical = ZoneModel.checkZonesIDsAreIdentical(
      zone1: oldWidget.currentZone,
      zone2: widget.currentZone,
    );

    if (_zonesIdsAreIdentical == false){

      // widget.currentZone.blogZone(invoker: 'didUpdateWidget');

      setNotifier(
          notifier: _selectedZone,
          mounted: mounted,
          value: widget.currentZone,
      );

    }

    super.didUpdateWidget(oldWidget);
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCountryButtonTap({
    @required BuildContext context
  }) async {

    Keyboard.closeKeyboard(context);

    final ZoneModel _zone = await Nav.goToNewScreen(
      context: context,
      screen: CountriesScreen(
        zoneViewingEvent: widget.zoneViewingEvent,
        depth: widget.depth,
        // selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
        // selectCountryIDOnly: widget.selectCountryIDOnly,
      ),
    );

    if (_zone == null){

    }
    else {

      _zone.blogZone(invoker: 'received zone');

      final ZoneModel _completedZone = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: _zone,
      );

      setNotifier(
          notifier: _selectedZone,
          mounted: mounted,
          value: _completedZone,
      );

      widget.onZoneChanged(_selectedZone.value);

      // await _onCityButtonTap(context: context);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCityButtonTap({
    @required BuildContext context
  }) async {

    Keyboard.closeKeyboard(context);

    if (_selectedZone.value.countryModel != null){

      final ZoneModel _zone = await Nav.goToNewScreen(
          context: context,
          screen: CitiesScreen(
            zoneViewingEvent: widget.zoneViewingEvent,
            depth: widget.depth,
            countryID: _selectedZone.value.countryID,
            // country: _selectedZone.value.countryModel,
            // selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
          )
      );

      /// WHEN NO CITY GOT SELECTED
      if (_zone == null){

      }

      /// WHEN SELECTED A CITY
      else {

        final ZoneModel _completedZone = await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _zone,
        );

        setNotifier(
            notifier: _selectedZone,
            mounted: mounted,
            value: _completedZone,
        );

        await _checkCityHasDistricts();

        widget.onZoneChanged(_selectedZone.value);

        // if (Mapper.checkCanLoopList(_selectedZone.value?.cityModel?.districts) == true){
        //   await _onDistrictButtonTap(context: context);
        // }

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDistrictButtonTap({
    @required BuildContext context,
  }) async {

    Keyboard.closeKeyboard(context);

    if (_selectedZone.value.countryModel != null && _selectedZone.value.cityModel != null){

      final ZoneModel _zone = await Nav.goToNewScreen(
        context: context,
        screen: DistrictsScreen(
          zoneViewingEvent: widget.zoneViewingEvent,
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

        final ZoneModel _completedZone = await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _zone,
        );

        setNotifier(
            notifier: _selectedZone,
            mounted: mounted,
            value: _completedZone,
        );

        widget.onZoneChanged(_selectedZone.value);

      }

    }

  }
  // --------------------
  /// TASK : TEST ME
  Future<void> _checkCityHasDistricts() async {

    final List<DistrictModel> _cityDistricts = await ZoneProtocols.fetchDistrictsOfCity(
      cityID: _selectedZone.value?.cityID,
    );

    /// CITY HAS DISTRICTS
    if (Mapper.checkCanLoopList(_cityDistricts) == true){
      if (mounted && _cityHasDistricts != true){
        setState(() {
          _cityHasDistricts = true;
        });
      }
    }

    /// CITY HAS NO DISTRICTS
    else {
      if (mounted && _cityHasDistricts != false){
        setState(() {
          _cityHasDistricts = false;
        });
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
                  bubbleHeaderVM: BubbleHeaderVM(
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
                        text: zone?.countryName,
                        translate: false,
                      ),
                      icon: zone?.icon ?? Iconz.circleDot,
                      onTap: () => _onCountryButtonTap(context: context),
                      loading: loading,
                    ),

                    /// City BUTTON
                    if (widget.depth == ZoneDepth.city || widget.depth == ZoneDepth.district)
                    ZoneSelectionButton(
                      title: const Verse(
                        text: 'phid_city',
                        translate: true,
                      ),
                      verse: Verse(
                        text: zone?.cityName,
                        translate: false,
                      ),
                      onTap: () => _onCityButtonTap(context: context),
                      loading: loading,
                    ),

                    /// DISTRICT BUTTON
                    if (widget.depth == ZoneDepth.district && _cityHasDistricts == true)
                      ZoneSelectionButton(
                        title: const Verse(
                          text: 'phid_district',
                          translate: true,
                        ),
                        verse: Verse(
                          text: zone?.districtName,
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
                      focusNode: null,
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

    // _loading.value  = true;
    // _selectedCity.value  = null;
    // _selectedDistrict.value  = null;

    _selectedZone.value  =  await ZoneProvider.proFetchCompleteZoneModel(
      context: context,
      incompleteZoneModel: ZoneModel(
        countryID: countryID,
      ),
    );

    widget.onZoneChanged(_selectedZone.value);
    Nav.goBack(context);

    _selectedCountry.value  = await _zoneProvider.fetchCountryByID(
      context: context,
      countryID: countryID,
    );

    // _selectedCountryCities.value  = await _zoneProvider.fetchCitiesByIDs(
    //   context: context,
    //   citiesIDs: _selectedCountry.value?.citiesIDs,
    // );

    // _isLoadingCities.value  = false;

    await _onShowCitiesTap(context: context);
  }
   */
// ----------------------------------------
/*
  Future<void> _onSelectCity(String cityID) async {

    // _isLoadingDistricts.value  = true;

    // _selectedDistrict.value  = null;

    // _selectedZone = ZoneModel(
    //   countryID: _selectedZone.countryID,
    //   cityID: cityID,
    //   // districtID: null,
    // );

    // widget.onZoneChanged(_selectedZone);
    // Nav.goBack(context);

    // _selectedCity.value  = await _zoneProvider.fetchCityByID(
    //     context: context,
    //     cityID: cityID
    // );

    // _isLoadingDistricts.value  = false;

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

    // _selectedDistrict.value  = _district;

    // _selectedZone = _selectedZone.copyWith(
    //   districtID: districtID,
    // );

    // widget.onZoneChanged(_selectedZone);
    //
    // Nav.goBack(context);

  }
   */
// ----------------------------------------
