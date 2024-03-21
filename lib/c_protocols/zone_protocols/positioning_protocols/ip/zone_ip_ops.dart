// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:http/http.dart';
import 'package:basics/helpers/rest/rest.dart';
/// => GEOLOCATOR_DOES_NOT_WORK
// import 'package:geolocator/geolocator.dart';
// import 'package:bldrs/c_protocols/zone_protocols/positioning_protocols/geo_location/location_ops.dart';
// import 'package:fire/super_fire.dart';
/// => TAMAM
class ZoneIPOps {
  // -----------------------------------------------------------------------------

  const ZoneIPOps();

  // -----------------------------------------------------------------------------

  /// GET ZONE BY USER IP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> getZoneByIP() async {

    blog('start : getZoneByIP');

    /// trial 1
    ZoneModel? _zone = await _getZoneByIP_ipApi();
    // blog('superGetZone : trial 1 : _getZoneByIP_ipApi '
    //     ': zone is : '
    //     'countryID : ${_zone?.countryID} : '
    //     'cityID : ${_zone?.cityID}');

      _zone ??= await _getZoneByIP_ipRegistry();
      // blog('superGetZone : trial 2 : _getZoneByIP_ipRegistry : '
      //     'zone is : '
      //     'countryID : ${_zone?.countryID} : '
      //     'cityID : ${_zone?.cityID}'
      // );

      _zone ??= await _getZoneByGeoLocator();
      // blog('superGetZone : trial 3 : _getZoneByGeoLocator : '
      //     'zone is : '
      //     'countryID : ${_zone?.countryID} : '
      //     'cityID : ${_zone?.cityID}'
      // );


    return _zone;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> _getZoneByIP_ipApi() async  {

    /// NOTE : this is limited and needs paid subscription

    ZoneModel? _output;

    await tryAndCatch(
        invoker: 'get Country by IP',
        functions: () async {

          final Response? _response = await Rest.get(
            rawLink: 'http://ip-api.com/json',
            invoker: '_getZoneByIP_ipApi',
            timeoutSeconds: 5,
          );

          /// RECEIVED DATA
          if (Rest.checkResponseBodyIsGood(_response) == true) {

            final Map<String, dynamic>? _countryData = json.decode(_response!.body);

            if (_countryData != null) {

              final String? _countryISO = _countryData['countryCode']; // US
              final String? _stateISO2 = _countryData['region']; // IL
              final String? _cityName = _countryData['city']; // Chicago

              _output = await _getZoneFromData(
                countryCode: _countryISO,
                stateCode: _stateISO2,
                cityCode: _cityName,
                invoker: '_getZoneByIP_ipApi',
              );

            }

            // blog('_getZoneByIP_ipApi : found data : response body is : ${_response.body}');
          }

          /// NO DATA RECEIVED
          else {
            blog('_getZoneByIP_ipApi : no data : response is : $_response');
          }

        }
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> _getZoneByIP_ipRegistry() async {

    /// NOTE : this needs subscription after first 100'000 requests
    /// Note that on Android it requires the android.permission.INTERNET permission.
    ZoneModel? _output;

    await tryAndCatch(
        invoker: 'get Country by IP',
        functions: () async {

          final Response? _response = await Rest.get(
            rawLink: 'https://api.ipregistry.co?key=${BldrsKeys.ipRegistryAPIKey}',
            invoker: '_getZoneByIP_ipRegistry',
            timeoutSeconds: 5,
          );

          /// RECEIVED DATA
          if (Rest.checkResponseBodyIsGood(_response) == true) {

            final Map<String, dynamic>? _countryData = json.decode(_response!.body);

            if (_countryData != null) {

              final String? _countryISO = _countryData['location']['country']['code']; // "US"
              final String? _stateCode = TextMod.replaceAllCharacters(
                      characterToReplace: '-',
                      replacement: '_',
                      input: _countryData['location']['region']['code']?.toLowerCase(), // "US-GA"
              );
              final String? _cityName = _countryData['location']['city']; // "Atlanta"

              _output = await _getZoneFromData(
                countryCode: _countryISO?.toLowerCase(),
                stateCode: _stateCode,
                cityCode: _cityName,
                invoker: '_getZoneByIP_ipRegistry',
              );

            }

          }

          /// NO DATA RECEIVED
          else {
            blog('nothing found : ${_response?.body}');
          }

        }
    );

    return _output;

  }
  // --------------------
  /// GEOLOCATOR_DOES_NOT_WORK
  static Future<ZoneModel?> _getZoneByGeoLocator() async {
    ZoneModel? _zoneModel;

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

  /// HANDLE USA

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ZoneModel?> _getZoneFromData({
    required String? countryCode,
    required String? stateCode,
    required String? cityCode,
    required String invoker,
  }) async {
    String? _countryID;
    String? _cityID;

    /// GET COUNTRY - STATE ID
    if (TextCheck.isEmpty(countryCode) == false){

      final bool _isAmerican = countryCode!.toLowerCase() == 'us'
                                ||
                               countryCode.toLowerCase() == 'usa';

      /// AMERICA
      if (_isAmerican == true){

        final String? _stateIso2 = stateCode?.toLowerCase();

        if (_stateIso2 != null && _stateIso2.length == 2){
          _countryID = 'us_$_stateIso2';
        }

        else if (_stateIso2?.length == 5){
          _countryID = _stateIso2;
        }

      }

      /// WORLD
      else {
        _countryID = Flag.getCountryIDByISO2(countryCode);
      }

    }

    /// GET CITY ID
    if (_countryID != null){

      CityModel? _city = await ZoneProtocols.fetchCityByName(
        countryID: _countryID,
        cityName: cityCode?.toLowerCase(),
        langCode: 'en',
      );

      _city ??= await ZoneProtocols.fetchCity(
        cityID: CityModel.createCityID(
            countryID: _countryID,
            cityEnName: cityCode?.toLowerCase(),
        ),
      );

      _cityID = _city?.cityID;

    }

    /// RETURN NULL
    if (_countryID == null){
      return null;
    }

    /// RETURN ZONE
    else {
      return ZoneProtocols.completeZoneModel(
        invoker: '_getZoneFromData : invoker : $invoker',
        incompleteZoneModel: ZoneModel(
          countryID: _countryID,
          cityID: _cityID,
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------
}
