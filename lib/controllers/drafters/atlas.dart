import 'dart:async';
import 'dart:collection';

import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Atlas{
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
}

// -----------------------------------------------------------------------------
// Widget aDot (){
//   return
//     Container(
//       width: 2,
//       height: 2,
//       decoration: BoxDecoration(
//           color: Color.fromARGB(1000, 255, 192, 0),
//           shape: BoxShape.circle
//       ),
//     );
// }
// -----------------------------------------------------------------------------
// List<Widget> worldDots(double width){
//   final dots = <Widget>[];
//   for(var i = 0; i < cityDataBase.length; i++ ){
//       dots.add(
//           Positioned(
//             bottom: cityDataBase[i].latitude + (0.5 * width),
//             left: cityDataBase[i].longitude + (0.5 * width),
//             child: aDot(),
//           )
//       );
//   }
//   return dots;
// }
// -----------------------------------------------------------------------------
// List<Province> countryCities(String countryFlag){
//   final String countryISO3 = (countryDataBase.singleWhere((c) => c.flag == countryFlag)).iso3;
//
//   final List<City> foundCities = [];
//
//   for(var i = 0; i < cityDataBase.length; i++ ){
//     if(cityDataBase[i].iso3 == countryISO3){foundCities.add(cityDataBase[i]);}
//   }
//
//   return foundCities;
// }
// -----------------------------------------------------------------------------
// List<Widget> countryDots(double boxWidth, String countryFlag){
//
//   final List<City> foundCities = countryCities(countryFlag);
//
//   final List<double> latitudes = [];
//   final List<double> longitudes = [];
//
//   for (var i = 0; i < foundCities.length; i++){
//     latitudes.add(foundCities[i].latitude);
//     longitudes.add(foundCities[i].longitude);
//   }
//
//   final double minX = longitudes.reduce(min);
//   final double maxX = longitudes.reduce(max);
//   final double minY = latitudes.reduce(min);
//   final double maxY = latitudes.reduce(max);
//
//   final double dx = maxX - minX;
//   final double dY = maxY - minY;
//
//   final dots = <Widget>[];
//
//   for (var i = 0; i < foundCities.length; i++){
//     final double dotLongitude = foundCities[i].longitude;
//     final double dotLatitude = foundCities[i].latitude;
//
//       dots.add(
//           Positioned(
//             bottom: boxWidth * ((dotLatitude-minY)/(dY)),
//             left:  boxWidth * ((dotLongitude-minX)/(dx)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 aDot(),
//                 // CityLabel(cityName: foundCities[i].cityName),
//                 // -----------
//                 // Text(foundCities[i].cityNameASCII,
//                 // style: TextStyle(
//                 //   color: Colorz.White,
//                 //   fontFamily: 'BldrsBodyFont',
//                 //   fontSize: 2,
//                 // ),
//                 // )
//                 // -----------
//                 // DreamBox(
//                 //   height: 5,
//                 //   width: 5,
//                 //   icon: Iconz.DvRageh,
//                 //   bubble: false,
//                 // ),
//               ],
//             ),
//           )
//       );
//   }
//
//   return dots;
// }
// -----------------------------------------------------------------------------
class CityLabel extends StatelessWidget {
  final String cityName;

  CityLabel({
    @required this.cityName,
});
  @override
  Widget build(BuildContext context) {
    return SuperVerse(
      verse: cityName,
      weight: VerseWeight.thin,
      size: 0,
      scaleFactor: 0.2,
      labelColor: Colorz.White10,
      centered: false,
      onTap: (){print(cityName);},
      maxLines: 1,
      shadow: false,
    );
  }
}
// -----------------------------------------------------------------------------
// LatLng cityLocationByCityID(String cityID){
//   final double latitude = (cityDataBase.singleWhere((city) => city.id == cityID)).latitude;
//   final double longitude = (cityDataBase.singleWhere((city) => city.id == cityID)).longitude;
//   return LatLng(latitude, longitude);
// }
// -----------------------------------------------------------------------------
Future<BitmapDescriptor> getTheFuckingMarker()async{

  final BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration
            .empty,
          // (size: Size(50,50),),
        Iconz.DumBzPNG
    );

   return customMarker;
  }
// -----------------------------------------------------------------------------
// HashSet<Marker> countryCitiesMarkers (String countryFlag, BitmapDescriptor customMarker){
//   final List<City> foundCities = countryCities(countryFlag);
//   var citiesMarkers = HashSet<Marker>();
//
//   foundCities.forEach((city) {
//     citiesMarkers.add(
//       Marker(
//         markerId: MarkerId('${city.id}'),
//         position: LatLng(city.latitude, city.longitude),
//         icon: customMarker,
//         infoWindow: InfoWindow(
//           title: '${city.name}',
//           snippet: 'City ID : ${city.id}',
//           onTap: (){print('${city.name} : ${city.iso3}');},
//           // anchor: const Offset(0,0),
//         ),
//       ),
//     );
//   });
//
//   return citiesMarkers;
// }
// -----------------------------------------------------------------------------
HashSet<Marker> someMarker (BitmapDescriptor customMarker, double latitude, double longitude){
  final HashSet<Marker> someMarker = HashSet<Marker>();

   someMarker.add(
      Marker(
        markerId: MarkerId('${latitude}_$longitude'),
        position: LatLng(latitude, longitude),
        icon: customMarker,
        infoWindow: InfoWindow(
          title: 'Latitude ($latitude) ,Longitude ($longitude})',
          // snippet: 'Latitude ($latitude) ,Longitude ($longitude}',
          onTap: (){print('MARKER LOCATION IS : Latitude ($latitude) ,Longitude ($longitude}');},
          // anchor: const Offset(0,0),
        ),
      ),
   );

   return someMarker;
   }
// -----------------------------------------------------------------------------
// Future<Position> getUserLocation() async {
//   dynamic currentLocation = LocationData;
//   var error;
//   var location = new Location();
//   try{
//     currentLocation = await.location.getLocation();
//   }
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//   return position;
// }
// -----------------------------------------------------------------------------
