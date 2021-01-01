import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI';

int zoom = 15;
String size = '600x1044';
String mapType = 'satellite'; //roadmap // satellite // hybrid // terrain
String color1 = 'red%7C';
String label = 'B%7C';

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


String getStaticMapImage(BuildContext context, double latitude, double longitude){

  int     zoomValue       = 15;
  int     widthValue      = (superScreenWidth(context) * 0.73).toInt();
  int     heightValue     = (widthValue * 1.74).toInt();
  double  scaleValue      = 2;
  String  mapTypeValue    = 'hybrid';
  String  iconPath        = 'https://i.ibb.co/f2mv77f/gi-flyer-pin-png.png|$latitude,$longitude';

  String  center          = 'center=$latitude,$longitude';
  String  zoom            = 'zoom=$zoomValue';
  String  size            = '&size=${widthValue}x$heightValue';
  String  scale           = scaleValue == 1 ? '' : '&scale=$scaleValue';
  String  mapType         = '&maptype=$mapTypeValue';
  String  markers         = '&markers=icon:$iconPath';
  String  key             = '&key=$GOOGLE_API_KEY';
  String  parameters      = '$zoom$size$scale$mapType$markers$key';

  print('https://maps.googleapis.com/maps/api/staticmap?$parameters');
  return 'https://maps.googleapis.com/maps/api/staticmap?$parameters';
}

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