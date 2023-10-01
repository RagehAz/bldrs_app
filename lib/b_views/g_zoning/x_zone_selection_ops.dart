import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    required bool settingCurrentZone,
    required ViewingEvent zoneViewingEvent,
    required ZoneModel? viewerZone,
    required ZoneModel? selectedZone,
  }) async {

    blog('aa7aaa 1');

    final ZoneModel? _output = await goToCountriesScreen(
      zoneViewingEvent: zoneViewingEvent,
      depth: depth,
      viewerZone: viewerZone,
      selectedZone: selectedZone,
    );

    blog('aa7aaa 2 : $_output');

    if (settingCurrentZone == true && _output != null){
      await setCurrentZoneAndNavHome(
        zone: _output,
      );
    }

    blog('aa7aaa 3');

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> goToCountriesScreen({
    required ViewingEvent zoneViewingEvent,
    required ZoneDepth depth,
    required ZoneModel? viewerZone,
    required ZoneModel? selectedZone,
  }) async {

    final ZoneModel? _zone = await Nav.goToNewScreen(
      context: getMainContext(),
      // pageTransitionType: PageTransitionType.bottomToTop,
      duration: const Duration(milliseconds: 350),
      screen: CountriesScreen(
        zoneViewingEvent: zoneViewingEvent,
        depth: depth,
        viewerZone: viewerZone,
        selectedZone: selectedZone,
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

      final ZoneModel? _zoneWithCity = await Nav.goToNewScreen(
          context: context,
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
  /// TESTED : WORKS PERFECT
  static Future<void> setCurrentZoneAndNavHome({
    required ZoneModel zone,
  }) async {

      WaitDialog.showUnawaitedWaitDialog(
        verse: const Verse(
          id: 'phid_loading',
          translate: true,
        ),
      );

      await setCurrentZoneProtocol(
        zone: zone,
      );

      await WaitDialog.closeWaitDialog();

      await Nav.pushHomeAndRemoveAllBelow(
        context: getMainContext(),
        invoker: 'SelectCountryScreen._onCountryTap',
        homeRoute: RouteName.home,
      );


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> setCurrentZoneProtocol({
    required ZoneModel? zone,
  }) async {

    if (zone != null){

      final BuildContext context = getMainContext();
      final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
        /// SET ZONE + CURRENCY
        await zoneProvider.setCurrentZone(
          zone: zone,
          setCountryOnly: false,
          notify: true,
          invoker: 'ZoneSelection.setCurrentZoneProtocol',
        );

        // /// SET CHAINS
        // final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
        // await _chainsProvider.changeHomeWallFlyerType(
        //   notify: true,
        //   flyerType: null,
        //   phid: null,
        // );
        // await _chainsProvider.reInitializeZoneChains();

    }

  }
  // -----------------------------------------------------------------------------
}
