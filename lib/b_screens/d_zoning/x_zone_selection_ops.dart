import 'dart:async';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_screens/d_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_screens/d_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter/material.dart';

/*
  ------------------------------------------------------------------
  ZoneDepth is COUNTRY
  -> goToCountriesScreen
       | => goBack * 1 (pass null)
       | -> onCountryTap -> goBack * 1 => (pass zoneWithCountryID)
  ------------------------------------------------------------------
  ZoneDepth is CITY
  -> goToCountriesScreen
       | => goBack * 1 (pass null)
       | -> onCountryTap -> goToCitiesScreen
                               | => goBack * 1 (pass null)
                               | => onCityTap -> goBack * 2 => (pass zoneWithCountryIDAndCityID)
  ------------------------------------------------------------------
 */

enum ZoneDepth {
  country,
  city,
}

/// => TAMAM
class ZoneSelection {
  // -----------------------------------------------------------------------------

  const ZoneSelection();

  // -----------------------------------------------------------------------------

  /// ZONE SELECTION MAIN CONTROLLER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> goBringAZone({
    required ZoneDepth depth,
    // required bool settingCurrentZone,
    required ViewingEvent zoneViewingEvent,
    required ZoneModel? viewerZone,
    required List<String> selectedCountries,
    bool ignoreCensusAndStaging = false,
  }) async {

    final ZoneModel? _output = await goToCountriesScreen(
      zoneViewingEvent: zoneViewingEvent,
      depth: depth,
      viewerZone: viewerZone,
      selectedCountries: selectedCountries,
      ignoreCensusAndStaging: ignoreCensusAndStaging,
    );

    // if (settingCurrentZone == true && _output != null){
    //   await setCurrentZoneAndNavHome(
    //     zone: _output,
    //   );
    // }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> goToCountriesScreen({
    required ViewingEvent zoneViewingEvent,
    required ZoneDepth depth,
    required ZoneModel? viewerZone,
    required List<String> selectedCountries,
    bool ignoreCensusAndStaging = false,
  }) async {

    final ZoneModel? _zone = await BldrsNav.goToNewScreen(
      // pageTransitionType: PageTransitionType.bottomToTop,
      duration: const Duration(milliseconds: 350),
      screen: CountriesScreen(
        zoneViewingEvent: zoneViewingEvent,
        depth: depth,
        viewerZone: viewerZone,
        selectedCountries: selectedCountries,
        ignoreCensusAndStaging: ignoreCensusAndStaging,
      ),
    );

    if (_zone?.countryID != null){
      final ZoneModel? _output = await ZoneProtocols.completeZoneModel(
        incompleteZoneModel: _zone,
        invoker: 'goToCountriesScreen',
      );
      return _output;
    }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSelectCountry({
    required BuildContext context,
    required String? countryID,
    required ZoneDepth depth,
    required ViewingEvent zoneViewingEvent,
    required ZoneModel? viewerZone,
    required ZoneModel? selectedZone,
  }) async {

    await Keyboard.closeKeyboard();
    ZoneModel? _zoneWithCountry;

    if (countryID != null){
      /// COMPLETE ZONE
      _zoneWithCountry = await ZoneProtocols.completeZoneModel(
        invoker: 'onSelectCountry',
        incompleteZoneModel: ZoneModel(
          countryID: countryID,
        ),
      );
    }

    /// Go back (1 step) + pass zone with countryID
    if (
        depth == ZoneDepth.country ||
        countryID == null ||
        countryID == Flag.planetID ||
        countryID == 'usa'
    ){

      await Nav.goBack(
        context: context,
        invoker: 'onSelectCountry',
        passedData: _zoneWithCountry,
      );

    }

    /// Go to Cities Screen
    else {

      final ZoneModel? _zoneWithCity = await BldrsNav.goToNewScreen(
          screen: CitiesScreen(
            zoneViewingEvent: zoneViewingEvent,
            countryID: countryID,
            depth: depth,
            viewerZone: viewerZone,
            selectedZone: selectedZone,
          )
      );

      _zoneWithCity?.blogZone(invoker: 'just selected that shit');

      /// SECOND CITY SELECTION BACK
      if (_zoneWithCity?.cityID != null){

        await Nav.goBack(
          context: context,
          invoker: 'onSelectCountry.AFTER CITY SELECTION',
          passedData: _zoneWithCity,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSelectCity({
    required BuildContext context,
    required String? countryID,
    required String? cityID,
    required ZoneDepth depth,
    required ViewingEvent zoneViewingEvent,
  }) async {

    ZoneModel? _zoneWithCity;
    await Keyboard.closeKeyboard();

    if (countryID != null && cityID != null){
      _zoneWithCity = await ZoneProtocols.completeZoneModel(
        invoker: 'onSelectCity',
        incompleteZoneModel: ZoneModel(
          countryID: countryID,
          cityID: cityID,
        ),
      );
    }

    /// FIRST CITY SELECTION BACK
    await Nav.goBack(
        context: context,
        invoker: 'onSelectCountry',
        passedData: _zoneWithCity,
      );

  }
  // --------------------
  // /// TESTED : WORKS PERFECT
  // static Future<void> setCurrentZoneAndNavHome({
  //   required ZoneModel zone,
  // }) async {
  //
  //     WaitDialog.showUnawaitedWaitDialog(
  //       verse: const Verse(
  //         id: 'phid_loading',
  //         translate: true,
  //       ),
  //     );
  //
  //     await ZoneProvider.proSetCurrentZone(
  //       zone: zone,
  //     );
  //
  //     await WaitDialog.closeWaitDialog();
  //
  //     UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);
  //
  //     await Nav.pushHomeAndRemoveAllBelow(
  //       context: getMainContext(),
  //       invoker: 'SelectCountryScreen._onCountryTap',
  //       homeRoute: ScreenName.home,
  //     );
  //
  // }
  // -----------------------------------------------------------------------------
}
