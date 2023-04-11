// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
// import 'package:fire/fire.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest/rest.dart';
/// => GEOLOCATOR_DOES_NOT_WORK
// import 'package:geolocator/geolocator.dart';
// import 'package:bldrs/c_protocols/zone_protocols/positioning_protocols/geo_location/location_ops.dart';
// import 'package:fire/fire.dart';
/// => TAMAM
class ZoneIPOps {
  // -----------------------------------------------------------------------------

  const ZoneIPOps();

  // -----------------------------------------------------------------------------

  /// GET ZONE BY USER IP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> getZoneByIP({
    @required BuildContext context
  }) async {

    /// trial 1
    ZoneModel _zone = await _getZoneByIP_ipApi(context: context);

    // blog('superGetZone : trial 1 : _getZoneByIP_ipApi '
    //     ': zone is : '
    //     'countryID : ${_zone.countryID} : '
    //     'cityID : ${_zone.cityID}');

    if (_zone == null || (_zone?.countryID == null && _zone?.cityID == null)) {
      _zone = await _getZoneByIP_ipRegistry(context: context);
      // blog('superGetZone : trial 2 : _getZoneByIP_ipRegistry : '
      //     'zone is : '
      //     'countryID : ${_zone.countryID} : '
      //     'cityID : ${_zone.cityID}'
      // );
    }

    if (_zone == null || (_zone?.countryID == null && _zone?.cityID == null)) {
      _zone = await _getZoneByGeoLocator(context: context);
      // blog('superGetZone : trial 3 : _getZoneByGeoLocator : '
      //     'zone is : '
      //     'countryID : ${_zone.countryID} : '
      //     'cityID : ${_zone.cityID}'
      // );

    }

    return _zone;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> _getZoneByIP_ipApi({
    @required BuildContext context
  }) async  {

    /// NOTE : this is limited and needs paid subscription

    String _countryID;
    String _cityID;

    const String _url = 'http://ip-api.com/json';

    await tryAndCatch(
        invoker: 'get Country by IP',
        functions: () async {

          final Response _response = await Rest.get(
            rawLink: _url,
            invoker: '_getZoneByIP_ipApi',
          );

          /// RECEIVED DATA
          if (_response?.statusCode == 200) {

            final Map<String, dynamic> _countryData = json.decode(_response.body);

            if (_countryData != null) {
              final String _countryISO = _countryData['countryCode'];
              final String _cityName = _countryData['city'];

              if (_countryISO != null && _countryISO != '') {

                _countryID = Flag.getCountryIDByISO2(_countryISO);

                if (_countryID != null) {

                  final CountryModel _country = await ZoneProtocols.fetchCountry(
                      countryID: _countryID
                  );

                  CityModel _city;
                  if (_cityName != null) {

                    _city = await ZoneProtocols.fetchCityByName(
                      context: context,
                      countryID: _countryID,
                      cityName: _cityName,
                      langCode: 'en',
                    );

                    _cityID = CityModel.createCityID(
                        countryID: _country?.id,
                        cityEnName: _cityName
                    );

                    _city?.blogCity();

                  }
                }
              }
            }

            blog('_getZoneByIP_ipApi : found data : response body is : ${_response?.body}');
          }

          /// NO DATA RECEIVED
          else {
            blog('_getZoneByIP_ipApi : no data : response is : $_response');
          }

        }
    );

    return ZoneModel(
      countryID: _countryID,
      cityID: _cityID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> _getZoneByIP_ipRegistry({
    @required BuildContext context
  }) async {

    /// NOTE : this needs subscription after first 100'000 requests
    /// Note that on Android it requires the android.permission.INTERNET permission.
    String _countryID;
    String _cityID;

    const String _url = 'https://api.ipregistry.co?key=${BldrsKeys.ipRegistryAPIKey}';

    await tryAndCatch(
        invoker: 'get Country by IP',
        functions: () async {

          final Response _response = await Rest.get(
            rawLink: _url,
            invoker: '_getZoneByIP_ipRegistry',
          );

          /// RECEIVED DATA
          if (_response.statusCode == 200) {

            final Map<String, dynamic> _countryData = json.decode(_response.body);

            // Mapper.blogMap(_countryData);

            if (_countryData != null) {

              final String _countryISO =
              _countryData['location']['country']['code'];

              blog('country iso is : $_countryISO');

              const String _cityName = null;

              if (_countryISO != null && _countryISO != '') {

                _countryID = Flag.getCountryIDByISO2(_countryISO);

                if (_countryID != null) {

                  // final CountryModel _country = await _zoneProvider.fetchCountryByID(
                  //     context: context,
                  //     countryID: _countryID,
                  // );

                  final CityModel _city = await ZoneProtocols.fetchCityByName(
                    context: context,
                    countryID: _countryID,
                    cityName: _cityName,
                    langCode: 'en',
                  );

                  if (_city != null) {

                    /// TASK : FIX THIS
                    // _cityID = CityModel.createCityID(
                    //     countryID: _country.id,
                    //     cityEnName: Phrase.getPhraseByLangFromPhrases(
                    //         phrases: _city.phrases, langCode: 'en')?.value,
                    // );

                  }
                }
              }
            }

            blog('response body is : ${_response.body}');
          }

          /// NO DATA RECEIVED
          else {
            blog('nothing found : ${_response.body}');
          }

        }
    );

    return ZoneModel(
      countryID: _countryID,
      cityID: _cityID,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel> _getZoneByGeoLocator({
    @required BuildContext context
  }) async {
    ZoneModel _zoneModel;

    /// GEOLOCATOR_DOES_NOT_WORK
    // final Position _position = await LocationOps.getCurrentPosition(context);
    //
    // if (_position != null) {
    //
    //   final GeoPoint _geoPoint = GeoPoint(_position?.latitude, _position?.longitude);
    //
    //   _zoneModel = await ZoneProtocols.fetchZoneModelByGeoPoint(
    //       context: context,
    //       geoPoint: _geoPoint
    //   );
    //
    // }

    return _zoneModel;
  }
  // -----------------------------------------------------------------------------
}
