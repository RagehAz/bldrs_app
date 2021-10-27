import 'dart:async';
import 'dart:convert';

import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

abstract class Atlas{
// -----------------------------------------------------------------------------
  static dynamic cipherGeoPoint({@required GeoPoint point, @required bool toJSON}){
    dynamic _output;

    if(point != null){

      if (toJSON == true){
        final String lat = '${point.latitude}';
        final String lng = '${point.longitude}';
        _output = '${lat}_${lng}';
      }

      else {
        _output = point;
      }

    }

    return _output;

  }
// -----------------------------------------------------------------------------
  static GeoPoint decipherGeoPoint({@required dynamic point, @required bool fromJSON}){
    GeoPoint _output;

    if (point != null){

      if (fromJSON == true){

        final String _latString = TextMod.trimTextAfterLastSpecialCharacter(point, '_');
        final double _lat = Numeric.stringToDouble(_latString);
        final String _lngString = TextMod.trimTextBeforeFirstSpecialCharacter(point, '_');
        final double _lng = Numeric.stringToDouble(_lngString);

        _output = GeoPoint(_lat, _lng);

      }

      else {

        _output = point;

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static GeoPoint dummyPosition(){
    return
        GeoPoint(29.979174, 31.134264);
  }
// -----------------------------------------------------------------------------
  static Future<Position> getCurrentPosition() async {
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
  static Future<List<Placemark>> getAddressFromPosition({@required GeoPoint geopoint}) async {

    List<Placemark> _placemarks = [];

    print('getAddressFromPosition :starting getAddressFromPosition');

    if (geopoint != null){
      _placemarks = await placemarkFromCoordinates(geopoint.latitude, geopoint.longitude);
     print('getAddressFromPosition :found placemarks aho $_placemarks');
    }

    else {
      print('getAddressFromPosition : could not get this position placeMarks');
    }


    return _placemarks;
  }
// -----------------------------------------------------------------------------

}


// ----------------------------------------------------------------------
const GOOGLE_API_KEY = 'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI';
// ----------------------------------------------------------------------
int zoom = 15;
String size = '600x1044';
String mapType = 'satellite'; //roadmap // satellite // hybrid // terrain
String color1 = 'red%7C';
String label = 'B%7C';
// ----------------------------------------------------------------------
class LocationHelper{

  static String generateLocationPreviewImage(double latitude, double longitude){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=$zoom&size=$size&maptype=$mapType&markers=color:${color1}label:$label$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddressFromGoogleMaps({@required double lat, @required double lng}) async {
    final _url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    Uri _uri = Uri.parse(_url);
    final response = await http.get(_uri);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

  static String getStaticMapImage(BuildContext context, double latitude, double longitude){

    int     zoomValue       = 15;
    int     widthValue      = (Scale.superScreenWidth(context) * 0.73).toInt();
    int     heightValue     = (widthValue * 1.74).toInt();
    double  scaleValue      = 1;
    String  mapTypeValue    = 'hybrid';
    String  iconPath        = 'https://i.ibb.co/f2mv77f/gi-flyer-pin-png.png|$latitude,$longitude';

    // String  center          = 'center=$latitude,$longitude';
    String  zoom            = 'zoom=$zoomValue';
    String  size            = '&size=${widthValue}x$heightValue';
    String  scale           = scaleValue == 1 ? '' : '&scale=$scaleValue';
    String  mapType         = '&maptype=$mapTypeValue';
    String  markers         = '&markers=icon:$iconPath';
    String  key             = '&key=$GOOGLE_API_KEY';
    String  parameters      = '$zoom$size$scale$mapType$markers$key';

    // https://staticmapmaker.com/google/
    // this website is awesome to test if the url custom marker link works or not
    // and used this https://imgbb.com/ to create the URL for the flyer_pin custom marker

    // this documentation explains all shits
    // https://developers.google.com/maps/documentation/maps-static/start

    //when we have several markers on the screen and want the map to assign
    // dynamically the perfect zoom for them

    // Implicit Positioning of the Map
    // Normally, you need to specify center and zoom URL parameters to define
    // the location and zoom level of your generated map. However, if you supply
    // markers, path, or visible parameters, you can instead let the Maps Static
    // API determine the correct center and zoom level implicitly, based on
    // evaluation of the position of these elements.
    // If supplying two or more elements, the Maps Static API will determine a
    // proper center and zoom level, providing generous margins for the elements
    // contained. The example below displays a map containing San Francisco,
    // Oakland, and San Jose, CA:
    // https://maps.googleapis.com/maps/api/staticmap?size=512x512&maptype=roadmap\
    // &markers=size:mid%7Ccolor:red%7CSan+Francisco,CA%7COakland,CA%7CSan+Jose,CA&key=YOUR_API_KEY

    return 'https://maps.googleapis.com/maps/api/staticmap?$parameters';
  }

}
// ----------------------------------------------------------------------
// Completer<GoogleMapController> _controller = Completer();
// Position loadedPosition;
// Position currentUserPosition;
// BitmapDescriptor customMarker;
// LatLng aMarkerLatLng;
// var aMarker;
// // ----------------------------------------------------------------------
// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
// ----------------------------------------------------------------------
