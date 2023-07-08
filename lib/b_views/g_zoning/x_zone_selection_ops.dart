import 'dart:async';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:flutter/material.dart';
import 'package:basics/layouts/nav/nav.dart';
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
    required String? viewerCountryID,
  }) async {

    final ZoneModel? _output = await _goToCountriesScreen(
      zoneViewingEvent: zoneViewingEvent,
      depth: depth,
      viewerCountryID: viewerCountryID,
    );

    if (settingCurrentZone == true && _output != null){
      await setCurrentZoneAndNavHome(
        zone: _output,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> _goToCountriesScreen({
    required ViewingEvent zoneViewingEvent,
    required ZoneDepth depth,
    required String? viewerCountryID,
  }) async {

    final ZoneModel? _zone = await Nav.goToNewScreen(
      context: getMainContext(),
      screen: CountriesScreen(
        zoneViewingEvent: zoneViewingEvent,
        depth: depth,
        viewerCountryID: viewerCountryID,
      ),
    );

    if (_zone?.countryID != null){
      final ZoneModel? _output = await ZoneProtocols.completeZoneModel(
        incompleteZoneModel: _zone,
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
    required String? viewerCountryID,
  }) async {

    Keyboard.closeKeyboard();

    /// COMPLETE ZONE
    final ZoneModel? _zoneWithCountry = await ZoneProtocols.completeZoneModel(
      incompleteZoneModel: ZoneModel(
        countryID: countryID,
      ),
    );

    /// Go back (1 step) + pass zone with countryID
    if (depth == ZoneDepth.country){

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
            viewerCountryID: viewerCountryID,
          )
      );

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
    required String? cityID,
    required ZoneDepth depth,
    required ViewingEvent zoneViewingEvent,
  }) async {

    Keyboard.closeKeyboard();

    /// COMPLETE ZONE
    final ZoneModel? _zoneWithCity = await ZoneProtocols.completeZoneModel(
      incompleteZoneModel: ZoneModel(
        countryID: CityModel.getCountryIDFromCityID(cityID),
        cityID: cityID,
      ),
    );

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
    required ZoneModel? zone,
  }) async {

      pushWaitDialog(
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
        homeRoute: Routing.home,
      );


  }
  // -----------------------------------------------------------------------------
  static Future<void> setCurrentZoneProtocol({
    required ZoneModel? zone,
  }) async {

    // blog('RUNNING setCurrentZone');

    final BuildContext context = getMainContext();

    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
      /// SET ZONE
      zoneProvider.setCurrentZone(
        zone: zone,
        setCountryOnly: false,
        notify: false,
      );
      /// SET CURRENCY
      zoneProvider.getSetCurrentCurrency(
        zone: zone,
        notify: true,
      );

      // /// SET CHAINS
      // final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      // await _chainsProvider.reInitializeZoneChains();

  }
  // -----------------------------------------------------------------------------
}
