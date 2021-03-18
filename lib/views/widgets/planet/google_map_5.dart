// import 'dart:async';
// import 'dart:typed_data';
// import 'package:bldrs/view_brains/controllers/google_maps_drafters.dart';
// import 'package:bldrs/view_brains/drafters/borderers.dart';
// import 'package:bldrs/view_brains/drafters/scalers.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/view_brains/theme/flagz.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
// import 'package:bldrs/view_brains/theme/ratioz.dart';
// import 'package:bldrs/views/widgets/appbar/ab_strip.dart';
// import 'package:bldrs/views/widgets/buttons/dream_box.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:ui' as ui;
//
// class GoogleMapScreen5 extends StatefulWidget {
//
//   @override
//   _GoogleMapScreen5State createState() => _GoogleMapScreen5State();
// }
//
//
// class _GoogleMapScreen5State extends State<GoogleMapScreen5> {
//   Completer<GoogleMapController> _controller = Completer();
//   Position _currentUserPosition;
//   Position _loadedPosition;
//   BitmapDescriptor _customMarker;
//   int _markerWidth = 100;
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//     Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
//
//
//  _getUserLocation () async {
//   _currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//   setState(() {
//     _loadedPosition = _currentUserPosition;
//   });
// }
//
// // --- this makes blue rounded rectangle with text inside
// Future<Uint8List> _getBytesFromCanvas(int width, int height, String verse) async {
//   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//   final Canvas canvas = Canvas(pictureRecorder);
//   final Paint paint = Paint()..color = Colors.blue;
//   final Radius radius = Radius.circular(20.0);
//   canvas.drawRRect(
//       RRect.fromRectAndCorners(
//         Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
//         topLeft: radius,
//         topRight: radius,
//         bottomLeft: radius,
//         bottomRight: radius,
//       ),
//       paint);
//   TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
//   painter.text = TextSpan(
//     text: verse,
//     style: TextStyle(fontSize: 25.0, color: Colorz.White),
//   );
//   painter.layout();
//   painter.paint(canvas, Offset((width * 0.5) - painter.width * 0.5, (height * 0.5) - painter.height * 0.5));
//   final img = await pictureRecorder.endRecording().toImage(width, height);
//   final data = await img.toByteData(format: ui.ImageByteFormat.png);
//   return data.buffer.asUint8List();
// }
//
//  _missingFunction()async{
//     // int markerScale = 30;
//     final Uint8List markerIcon = await _getBytesFromCanvas(_markerWidth,_markerWidth, 'Bldrs.net');
//     _customMarker = BitmapDescriptor.fromBytes(markerIcon);
// }
//
//   @override
//   void initState() {
//       _getUserLocation();
//       _missingFunction();
//       super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//   bool _searchingCities = false;
//
//   // var _cityMarkers = countryCitiesMarkers(Flagz.egy, _customMarker);
//
//   LatLng _aMarkerLatLng = LatLng(_loadedPosition.latitude, _loadedPosition.longitude);
//   var _aMarker = someMarker(_customMarker, _aMarkerLatLng.latitude , _aMarkerLatLng.longitude);
//
//   double _screenWidth = superScreenWidth(context);
//   double _screenHeight = superScreenHeight(context);
//   // double _mapBoxWidth = _screenWidth * 0.8;
//   // double _mapBoxHeight = _mapBoxWidth;
//   double _boxCorners = Ratioz.rrFlyerBottomCorners *  _screenWidth;
//
//     return SafeArea(
//
//       child: Scaffold(
//         backgroundColor: Colorz.SkyDarkBlue,
//         body: Center(
//           child: ClipRRect(
//             borderRadius: superBorderRadius(context, _boxCorners, _boxCorners, _boxCorners, _boxCorners),
//             child: Container(
//               width: _screenWidth,
//               height: _screenHeight,
//               // decoration: BoxDecoration(
//               //   borderRadius: superBorderRadius(context, _boxCorners, _boxCorners, 0, _boxCorners),
//               // ),
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: <Widget>[
//
//                   GoogleMap(
//                     mapType: MapType.hybrid,
//                     zoomGesturesEnabled: true,
//                     myLocationButtonEnabled: true,
//                     myLocationEnabled: true,
//                     initialCameraPosition: CameraPosition(
//                         target: _searchingCities == true ? cityLocationByCityID('1818253931') : _aMarkerLatLng, // Mecca 1682169241 - Cairo 1818253931
//                         zoom: 18
//                     ),
//                     onMapCreated: (GoogleMapController googleMapController){
//
//                       // _controller.complete(googleMapController);
//
//                       setState(() {
//                         print('map has been created');
//                       });
//                       },
//
//                     markers: _searchingCities == true ? _cityMarkers : _aMarker,
//                   ),
//
//                   ABStrip(
//                     rowWidgets: [
//
//                       Container(),
//
//                       DreamBox(
//                         height: 50,
//                         width: 120,
//                         icon: Iconz.LocationPin,
//                         iconColor: Colorz.Yellow,
//                         verse: 'My Fucking Location',
//                         verseMaxLines: 2,
//                         verseScaleFactor: 0.5,
//                         iconSizeFactor: 0.8,
//                         boxFunction: ()async{
//                           print('.....');
//                           // LocationPermission permission = await Geolocator.requestPermission();
//                           // LocationPermission permission = await Geolocator.checkPermission();
//                           Position position = await _getUserLocation();
//                           // --- LAST KNOWN LOCATION
//                           // Position position = await Geolocator.getLastKnownPosition();
//                           print('YOUR FUCKING LOCATION IS : Latitude (${position.latitude}) ,Longitude (${position.longitude})');
//                           setState(() {
//                             _aMarkerLatLng = LatLng(position.latitude, position.longitude);
//                           });
//                         },
//                     ),
//
//                       DreamBox(
//                         height: 50,
//                         width: 50,
//                         icon: Iconz.LocationPin,
//                         iconColor: Colorz.BloodRed,
//                         iconSizeFactor: 0.8,
//                         boxFunction: ()async{
//                           print('.....');
//                           // LocationPermission permission = await Geolocator.requestPermission();
//                           // LocationPermission permission = await Geolocator.checkPermission();
//                           // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//                           // print('YOUR FUCKING LOCATION IS : Latitude (${position.latitude}) ,Longitude (${position.longitude})');
//                           setState(() {
//                             _aMarkerLatLng = cityLocationByCityID('1682169241');
//                             print('the new position is Latitude (${_aMarkerLatLng.latitude}) ,Longitude (${_aMarkerLatLng.longitude})');
//                           _goToTheLake();
//                           });
//                         },
//                     ),
//
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
