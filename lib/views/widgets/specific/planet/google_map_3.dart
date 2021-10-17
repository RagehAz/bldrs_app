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
// // import 'package:flutter/services.dart';
// // import 'dart:ui' as ui;
//
// class GoogleMapScreen3 extends StatefulWidget {
//   @override
//   _GoogleMapScreen3State createState() => _GoogleMapScreen3State();
// }
//
// class _GoogleMapScreen3State extends State<GoogleMapScreen3> {
// BitmapDescriptor _customMarker;
// int _markerWidth = 100;
//
//   //   Future<Uint8List> _getBytesFromCanvas(int width, int height, urlAsset) async {
//   //   final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
//   //   final Canvas _canvas = Canvas(_pictureRecorder);
//   //
//   //   final ByteData _dataI = await rootBundle.load(urlAsset);
//   //   var _imaged = await loadImage(new Uint8List.view(_dataI.buffer));
//   //
//   //   _canvas.drawImageRect(
//   //     _imaged,
//   //     Rect.fromLTRB(0.0, 0.0, _imaged.width.toDouble(), _imaged.height.toDouble()),
//   //     Rect.fromLTRB(0.0, 0.0, width.toDouble(), height.toDouble()),
//   //     new Paint(),
//   //   );
//   //
//   //   final _img = await _pictureRecorder.endRecording().toImage(width, height);
//   //   final _data = await _img.toByteData(format: ui.ImageByteFormat.png);
//   //   return _data.buffer.asUint8List();
//   // }
//
//
// _missingFunction()async{
//     // int markerScale = 30;
//     final Uint8List _markerIcon = await getBytesFromCanvas(_markerWidth, _markerWidth, Iconz.DumAuthorPic);
//     _customMarker = BitmapDescriptor.fromBytes(_markerIcon);
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
