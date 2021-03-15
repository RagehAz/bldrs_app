import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
// ----------------------------------------------------------------------
String getStaticMapImage(BuildContext context, double latitude, double longitude){

  int     zoomValue       = 15;
  int     widthValue      = (superScreenWidth(context) * 0.73).toInt();
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
// ----------------------------------------------------------------------
// Completer<GoogleMapController> _controller = Completer();
// Position loadedPosition;
// Position currentUserPosition;
// BitmapDescriptor customMarker;
// LatLng aMarkerLatLng;
// var aMarker;
// ----------------------------------------------------------------------
// missingFunction()async{
//   // int markerScale = 30;
//   final Uint8List markerIcon = await getBytesFromCanvas(100,100, 'Za7ma');
//   customMarker = BitmapDescriptor.fromBytes(markerIcon);
// }
// ----------------------------------------------------------------------
// getUserLocation () async {
//   currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//   missingFunction();
//   setState(() {
//     loadedPosition = currentUserPosition;
//     aMarkerLatLng = LatLng(loadedPosition.latitude, loadedPosition.longitude);
//     aMarker = someMarker(customMarker, aMarkerLatLng.latitude , aMarkerLatLng.longitude);
//   });
// }
// ----------------------------------------------------------------------
// static final CameraPosition _kLake = CameraPosition(
//     bearing: 192.8334901395799,
//     target: LatLng(37.43296265331129, -122.08832357078792),
//     tilt: 59.440717697143555,
//     zoom: 19.151926040649414);
// // ----------------------------------------------------------------------
// Future<void> _goToTheLake() async {
//   final GoogleMapController controller = await _controller.future;
//   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
// ----------------------------------------------------------------------
