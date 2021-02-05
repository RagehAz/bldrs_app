import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bldrs/ambassadors/database/db_planet/db_countries.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
// ----------------------------------------------------------------------------
//   List<City> cityDataBase = dbCities;
  List<Country> countryDataBase = dbCountries;
// ----------------------------------------------------------------------------
Widget aDot (){
  return
Container(
  width: 2,
  height: 2,
  decoration: BoxDecoration(
    color: Color.fromARGB(1000, 255, 192, 0),
    shape: BoxShape.circle
  ),
);
}
// ----------------------------------------------------------------------------
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
// ----------------------------------------------------------------------------
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
// ----------------------------------------------------------------------------
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
// ----------------------------------------------------------------------------
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
      labelColor: Colorz.WhiteAir,
      centered: false,
      labelTap: (){print(cityName);},
      maxLines: 1,
      shadow: false,
    );
  }
}
// ----------------------------------------------------------------------------
// LatLng cityLocationByCityID(String cityID){
//   final double latitude = (cityDataBase.singleWhere((city) => city.id == cityID)).latitude;
//   final double longitude = (cityDataBase.singleWhere((city) => city.id == cityID)).longitude;
//   return LatLng(latitude, longitude);
// }
// ----------------------------------------------------------------------------
Future<BitmapDescriptor> getTheFuckingMarker()async{
  BitmapDescriptor customMarker;
   customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration
            .empty,
          // (size: Size(50,50),),
        Iconz.DumBzPNG
    );
   return customMarker;
  }
// ----------------------------------------------------------------------------
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
// ----------------------------------------------------------------------------
HashSet<Marker> someMarker (BitmapDescriptor customMarker, double latitude, double longitude){
  var someMarker = HashSet<Marker>();
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
// ----------------------------------------------------------------------------
Future<Uint8List> getBytesFromAsset(String iconPath, int width) async {
  ByteData data = await rootBundle.load(iconPath);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}
// ----------------------------------------------------------------------------
Future < Uint8List > getBytesFromCanvas(int width, int height, urlAsset) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.transparent;
    final Radius radius = Radius.circular(20.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
            topLeft: radius,
            topRight: radius,
            bottomLeft: radius,
            bottomRight: radius,
        ),
        paint);

    final ByteData datai = await rootBundle.load(urlAsset);

    var imaged = await loadImage(new Uint8List.view(datai.buffer));

    canvas.drawImage(imaged, new Offset(0, 0), new Paint());

    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
}
// ----------------------------------------------------------------------------
Future < ui.Image > loadImage(List < int > img) async {
    final Completer < ui.Image > completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {

        return completer.complete(img);
    });
    return completer.future;
}
// ----------------------------------------------------------------------------
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
// ----------------------------------------------------------------------------
