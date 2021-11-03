import 'dart:async';
import 'dart:convert';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/db/fire/methods/firestore.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

abstract class ZoneOps{
// -----------------------------------------------------------------------------
  static Future<CountryModel> readCountryOps({@required BuildContext context, @required String countryID}) async {

    final Map<String, dynamic> _map = await Fire.readSubDoc(
      context: context,
      collName: FireColl.zones,
      docName: 'countries',
      subCollName: 'countries',
      subDocName: countryID,
    );

    final CountryModel _countryModel = CountryModel.decipherCountryMap(map: _map, fromJSON: false);

    return _countryModel;
  }
// -----------------------------------------------------------------------------
  static Future<CityModel> readCityOps({@required BuildContext context, @required String cityID}) async {

    final Map<String, dynamic> _map = await Fire.readSubDoc(
      context: context,
      collName: FireColl.zones,
      docName: 'cities',
      subCollName: 'cities',
      subDocName: cityID,
    );

    final CityModel _cityModel = CityModel.decipherCityMap(map: _map, fromJSON: false);

    return _cityModel;
  }
// -----------------------------------------------------------------------------
  static Future<List<CityModel>> readCountryCitiesOps({@required BuildContext context, @required String countryID}) async {

    final CountryModel _country = await readCountryOps(context: context, countryID: countryID);

    List<CityModel> _cities = <CityModel>[];

    if (_country != null){

      final List<String> _citiesIDs = _country.citiesIDs;

      if (Mapper.canLoopList(_citiesIDs)){

        for (String id in _citiesIDs){

          final CityModel _city = await readCityOps(context: context, cityID: id);

          if (_city!= null){
            _cities.add(_city);
          }

        }

      }

    }

    return _cities;
  }
// -----------------------------------------------------------------------------
  static Future<List<Continent>> readContinentsOps({@required BuildContext context}) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.zones,
      docName: FireDoc.zones_continents,
    );

    final List<Continent> _allContinents = Continent.decipherContinents(_map);

    return _allContinents;
  }
// -----------------------------------------------------------------------------
//   Future<void> updateCountryDoc() async {}
// -----------------------------------------------------------------------------
  static Future<Position> getGeoLocatorCurrentPosition() async {
    bool _serviceEnabled;
    LocationPermission permission;

    /// Test if location services are enabled.
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    /// When we reach here, permissions are granted and we can
    /// continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
      // forceAndroidLocationManager: true,
      // timeLimit: Duration(seconds: Standards.maxLocationFetchSeconds)
    );
  }
// -----------------------------------------------------------------------------
  static Future<List<Placemark>> getAddressFromPosition({@required GeoPoint geoPoint}) async {

    List<Placemark> _placeMarks = <Placemark>[];

    print('getAddressFromPosition :starting getAddressFromPosition');

    if (geoPoint != null){
      _placeMarks = await placemarkFromCoordinates(geoPoint.latitude, geoPoint.longitude);
      print('getAddressFromPosition :found placemarks aho $_placeMarks');
    }

    else {
      print('getAddressFromPosition : could not get this position placeMarks');
    }


    return _placeMarks;
  }
// -----------------------------------------------------------------------------
  /// this is limited and needs paid subscription
  static Future<ZoneModel> _getZoneByIP_ipApi({@required BuildContext context}) async {

    String _countryID;
    String _cityID;

    const String _url = 'http://ip-api.com/json';
    final Uri _uri = Uri.parse(_url);

    await tryAndCatch(
        context: context,
        methodName: 'get Country by IP',
        functions: () async {

          http.Response _response = await http.get(_uri);

          if (_response.statusCode == 200){

            final Map<String, dynamic> _countryData = json.decode(_response.body);

            if (_countryData != null){

              final String _countryISO = _countryData['countryCode'];
              final String _cityName = _countryData['city'];

              if (_countryISO != null && _countryISO != ''){

                final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

                _countryID = CountryIso.getCountryIDByIso(_countryISO);

                if (_countryID != null){
                  CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _countryID);
                  CityModel _city;
                  if (_cityName != null){
                    _city = await _zoneProvider.fetchCityByName(context: context, countryID: _countryID, cityName: _cityName, lingoCode: 'en');
                    _cityID = CityModel.createCityID(countryID: _country.id, cityEnName: Name.getNameByLingoFromNames(names: _city.names, lingoCode: 'en'));
                  }


                }

              }

            }

            print('response body is : ${_response.body}');
          }

          else {
            print('response is : ${_response.body}');
          }

        }
    );

    return ZoneModel(countryID: _countryID, cityID: _cityID, districtID: null);
  }
// -----------------------------------------------------------------------------
  /// this needs subscription after first 100'000 requests
  static Future<ZoneModel> _getZoneByIP_ipRegistry({@required BuildContext context}) async {

    /// Note that on Android it requires the android.permission.INTERNET permission.
    String _countryID;
    String _cityID;

    const String _url = 'https://api.ipregistry.co?key=${Standards.ipRegistryAPIKey}';
    final Uri _uri = Uri.parse(_url);

    await tryAndCatch(
        context: context,
        methodName: 'get Country by IP',
        functions: () async {

          http.Response _response = await http.get(_uri);

          if (_response.statusCode == 200){

            final Map<String, dynamic> _countryData = json.decode(_response.body);

            Mapper.printMap(_countryData);

            if (_countryData != null){

              final String _countryISO = _countryData['location']['country']['code'];

              print('country iso is : ${_countryISO}');

              const String _cityName = null;

              if (_countryISO != null && _countryISO != ''){

                final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

                _countryID = CountryIso.getCountryIDByIso(_countryISO);

                if (_countryID != null){
                  CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _countryID);
                  CityModel _city = await _zoneProvider.fetchCityByName(context: context, countryID: _countryID, cityName: _cityName, lingoCode: 'en');

                  if (_city != null){
                    _cityID = CityModel.createCityID(countryID: _country.id, cityEnName: Name.getNameByLingoFromNames(names: _city.names, lingoCode: 'en'));
                  }

                }

              }

            }

            print('response body is : ${_response.body}');
          }

          else {
            print('nothing found : ${_response.body}');
          }

        }
    );

    return ZoneModel(countryID: _countryID, cityID: _cityID, districtID: null);
  }
// -----------------------------------------------------------------------------
  static Future<ZoneModel> _getZoneByGeoLocator({@required BuildContext context}) async {

    ZoneModel _zoneModel;

    final Position _position = await getGeoLocatorCurrentPosition();

    if (_position != null){

      final GeoPoint _geoPoint = GeoPoint(_position?.latitude, _position?.longitude);
      final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
      _zoneModel = await _zoneProvider.getZoneModelByGeoPoint(context: context, geoPoint: _geoPoint);

    }

    return _zoneModel;
  }
// -----------------------------------------------------------------------------
  static Future<ZoneModel> superGetZone(BuildContext context) async {

    /// trial 1
    ZoneModel _zone = await _getZoneByIP_ipApi(context: context);

    print('superGetZone : trial 1 : _getZoneByIP_ipApi : zone is : countryID : ${_zone.countryID} : cityID : ${_zone.cityID}');

    if (_zone == null){
      _zone = await _getZoneByIP_ipRegistry(context: context);
      print('superGetZone : trial 2 : _getZoneByIP_ipRegistry : zone is : countryID : ${_zone.countryID} : cityID : ${_zone.cityID}');
    }


    if (_zone == null){
      _zone = await _getZoneByGeoLocator(context: context);
      print('superGetZone : trial 3 : _getZoneByGeoLocator : zone is : countryID : ${_zone.countryID} : cityID : ${_zone.cityID}');
    }

    return _zone;
  }
// -----------------------------------------------------------------------------
}
