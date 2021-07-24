// import 'dart:typed_data';
// import 'package:bldrs/view_brains/controllers/google_maps_drafters.dart';
// import 'package:bldrs/view_brains/drafters/borderers.dart';
// import 'package:bldrs/view_brains/drafters/scalers.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/view_brains/theme/flagz.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
// import 'package:bldrs/view_brains/theme/ratioz.dart';
// import 'package:bldrs/views/widgets/appbar/ab_strip.dart';
// import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:ui' as ui;
//
// class GoogleMapScreen2 extends StatefulWidget {
//   @override
//   _GoogleMapScreen2State createState() => _GoogleMapScreen2State();
// }
//
// class _GoogleMapScreen2State extends State<GoogleMapScreen2> {
// BitmapDescriptor _customMarker;
// int _markerWidth = 50;
//
// Future<Uint8List> _getBytesFromAsset(String path, int width) async {
//   ByteData _data = await rootBundle.load(path);
//   ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: width);
//   ui.FrameInfo _fi = await _codec.getNextFrame();
//   return (await _fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
// }
//
//  _missingFunction()async{
//   final Uint8List _markerIcon = await _getBytesFromAsset(Iconz.DumPyramidPin, _markerWidth);
//   _customMarker = BitmapDescriptor.fromBytes(_markerIcon);
// }
//
//   @override
//   void initState(){
//       super.initState();
//       _missingFunction();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//    // var _theMarkers = countryCitiesMarkers(Flagz.egy, _customMarker);
//
//
//     double _screenWidth = superScreenWidth(context);
//     double _screenHeight = superScreenHeight(context);
//
//     // double _mapBoxWidth = _screenWidth * 0.8;
//     // double _mapBoxHeight = _mapBoxWidth;
//     double _boxCorners = Ratioz.rrFlyerBottomCorners *  _screenWidth;
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
//                         target: cityLocationByCityID('1818253931'), // Mecca 1682169241 - Cairo 1818253931
//                         zoom: 10
//                     ),
//                     onMapCreated: (GoogleMapController googleMapController){setState(() {
//                       print('map has been created');
//                     });},
//
//                     markers: _theMarkers,
//                   ),
//
//                   ABStrip(
//                     rowWidgets: [
//
//                       Container(),
//
//                       DreamBox(
//                         height: 35,
//                         icon: Iconz.ArrowDown,
//                     ),
//
//                       DreamBox(
//                         height: 35,
//                         icon: Iconz.ArrowUp,
//                       ),
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
