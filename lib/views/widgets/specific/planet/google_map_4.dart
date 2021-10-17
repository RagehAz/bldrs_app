// import 'dart:typed_data';
// import 'package:bldrs/view_brains/controllers/atlas.dart';
// import 'package:bldrs/view_brains/drafters/borderers.dart';
// import 'package:bldrs/view_brains/drafters/scalers.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/view_brains/theme/flag_model.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
// import 'package:bldrs/view_brains/theme/ratioz.dart';
// import 'package:bldrs/views/widgets/appbar/ab_strip.dart';
// import 'package:bldrs/views/widgets/buttons/dream_box.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:ui' as ui;
//
// class GoogleMapScreen4 extends StatefulWidget {
//   @override
//   _GoogleMapScreen4State createState() => _GoogleMapScreen4State();
// }
//
// class _GoogleMapScreen4State extends State<GoogleMapScreen4> {
// BitmapDescriptor _customMarker;
// int _markerWidth = 50;
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
//     final Uint8List markerIcon = await _getBytesFromCanvas(_markerWidth,_markerWidth, 'marker 50');
//     _customMarker = BitmapDescriptor.fromBytes(markerIcon);
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
//               // decoration: BoxDecoration(
//               //   borderRadius: superBorderRadius(context, boxCorners, boxCorners, 0, boxCorners),
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
