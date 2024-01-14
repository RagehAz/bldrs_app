// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
// import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
// import 'package:bldrs/z_components/loading/loading.dart';
// import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
// 
// import 'package:basics/helpers/space/scale.dart';
// import 'package:basics/helpers/files/filers.dart';
// 
// import 'package:fire/super_fire.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// // -----------------------------------------------------------------------------
// /// Google Cloud Platform
// /// Bldrs
// /// Google Map for Android - IOS
// /// AuthorPic key 1
// // -----------------------------------------------------------------------------
// class FlyerMapScreen extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const FlyerMapScreen({
//     required this.flyerBoxWidth,
//     this.geoPoint, // = const PlaceLocation(latitude: 37.43296265331129, longitude: -122.08832357078792),
//     this.isSelecting = false,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final GeoPoint geoPoint;
//   final bool isSelecting;
//   final double flyerBoxWidth;
//   /// --------------------------------------------------------------------------
//   @override
//   _FlyerMapScreenState createState() => _FlyerMapScreenState();
//   /// --------------------------------------------------------------------------
// }
//
// class _FlyerMapScreenState extends State<FlyerMapScreen> {
//   // -----------------------------------------------------------------------------
//   LatLng _pickedLocation;
//   BitmapDescriptor customMarker;
//   int markerWidth = 125;
//   bool confirmButtonIsActive;
//   LocationData currentLocation;
//   Location location;
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//   CameraPosition _initialCameraPosition;
//   bool isLoading = false;
//   GoogleMapController mapController;
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//     location = Location();
//     getUserLocation();
//     confirmButtonIsActive = true;
//   }
//   // --------------------
//   @override
//   void dispose() {
//     mapController.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   Future<void> getUserLocation() async {
//     setState(() {
//       isLoading = true;
//     });
//     await initialize();
//     blog('trying to get user location aho');
//     currentLocation = await location.getLocation();
//     blog(
//         'get location function finished aho and processing remaining functions');
//     if (currentLocation == null) {
//       blog("Counldn't get current User Location");
//       return;
//     }
//     _initialCameraPosition = CameraPosition(
//         target: LatLng(currentLocation.latitude, currentLocation.longitude),
//         zoom: 10);
//
//     blog('_initialCameraPosition is $_initialCameraPosition');
//
//     setState(() {
//       isLoading = false;
//     });
//
//     blog('CurrentLocation: $currentLocation');
//     await missingFunction();
//   }
//   // --------------------
//   Future<void> initialize() async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//     blog('location permission is $_permissionGranted');
//   }
//   // --------------------
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//   // --------------------
//   void _selectLocation(LatLng position) {
//     setState(() {
//       _pickedLocation = position;
//       confirmButtonIsActive = true;
//     });
//     blog('The fucking position is $position');
//   }
//   // --------------------
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     final ByteData data = await Floaters.getByteDataFromPath(path);
//     final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//     final ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
//         .buffer
//         .asUint8List();
//   }
//   // --------------------
//   Future<void> missingFunction() async {
//     blog('missing function starts');
//     final Uint8List markerIcon =
//     await getBytesFromAsset(Iconz.flyerPinPNG, markerWidth);
//     customMarker = BitmapDescriptor.fromBytes(markerIcon);
//     blog('missing function ends ${customMarker.toString()}');
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final Set<Marker> theMarkers =
//     _pickedLocation == null ? null
//         :
//     <Marker>{
//       Marker(
//         markerId: const MarkerId('m1'),
//         position: _pickedLocation,
//         icon: customMarker,
//         // infoWindow: InfoWindow(
//         //   title: 'title',
//         //   snippet: 'snippet',
//         //   onTap: (){blog('pin taps aho');},
//         //   // anchor: const Offset(0,0),
//         // ),
//       )
//     };
//     // --------------------
//     final double _screenWidth = Scale.screenWidth(context);
//     // LatLng userCurrentLocation = LatLng(_initialPosition?.latitude ?? 0, _initialPosition?.longitude ?? 0);
//     final double _screenHeight = Scale.screenHeight(context);
//     // --------------------
//     return MainLayout(
//       skyType: SkyType.grey,
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           SizedBox(
//             width: _screenWidth,
//             height: _screenHeight,
//             child: isLoading
//                 ? Loading(
//               loading: isLoading,
//             )
//                 : GoogleMap(
//               mapType: MapType.hybrid,
//               myLocationEnabled: true,
//               buildingsEnabled: false,
//               mapToolbarEnabled: false,
//               initialCameraPosition: _initialCameraPosition,
//               onMapCreated: _onMapCreated,
//               //(GoogleMapController googleMapController){setState(() {blog('map has been created');});},
//               markers: theMarkers,
//               onTap: widget.isSelecting ? _selectLocation : null,
//             ),
//           ),
//
//           // FlyerZone(
//           //   flyerSizeFactor: 0.85,
//           //   tappingFlyerZone: (){},
//           //   stackWidgets: <Widget>[
//           //
//           //     // Container(
//           //     //   width: 400,
//           //     //   height: 400,
//           //     //   child: GoogleMap(
//           //     //     mapType: MapType.hybrid,
//           //     //     zoomGesturesEnabled: true,
//           //     //     myLocationButtonEnabled: true,
//           //     //     myLocationEnabled: true,
//           //     //     liteModeEnabled: false,
//           //     //     buildingsEnabled: false,
//           //     //     compassEnabled: true,
//           //     //     trafficEnabled: false,
//           //     //     mapToolbarEnabled: false,
//           //     //     initialCameraPosition:
//           //     //     CameraPosition(
//           //     //       target: userCurrentLocation,
//           //     //       zoom: 10,
//           //     //       // bearing: ,
//           //     //       // tilt: ,
//           //     //     ),
//           //     //     onMapCreated: (GoogleMapController googleMapController){setState(() {blog('map has been created');});},
//           //     //     markers: theMarkers,
//           //     //     onTap: widget.isSelecting ? _selectLocation : null,
//           //     //   ),
//           //     // ),
//           //
//           //
//           //
//           //   ],
//           // ),
//
//           if (widget.isSelecting)
//             const Positioned(
//               top: 10,
//               left: 10,
//               child: DreamBox(
//                 height: 60,
//                 verse: Verse(
//                   text: '#!#Tap The Map\nto pin flyer on the map !',
//                   translate: false,
//                 ),
//                 verseWeight: VerseWeight.regular,
//                 verseItalic: true,
//                 verseMaxLines: 2,
//                 color: Colorz.black200,
//                 bubble: false,
//                 icon: Iconz.fingerTap,
//                 iconSizeFactor: 0.7,
//               ),
//             ),
//
//           if (widget.isSelecting)
//             Positioned(
//               bottom: 5,
//               child: DreamBox(
//                 height: 60,
//                 width: 220,
//                 color: confirmButtonIsActive == true
//                     ? Colorz.yellow255
//                     : Colorz.red255,
//                 verse: Verse(
//                   text: confirmButtonIsActive == true ? 'Confirm flyer Location' : 'phid_pin_the_map_first',
//                   translate: true,
//                 ),
//                 verseMaxLines: 2,
//                 verseScaleFactor: 0.7,
//                 verseWeight: VerseWeight.black,
//                 verseColor: confirmButtonIsActive == true
//                     ? Colorz.black230
//                     : Colorz.white255,
//                 onTap: _pickedLocation == null
//                     ? () {
//                   setState(() {
//                     confirmButtonIsActive = false;
//                   });
//                 }
//                     : () {
//                   Navigator.of(context).pop(_pickedLocation);
//                   blog('a77a ba2a');
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//     // --------------------
//   }
// // -----------------------------------------------------------------------------
// }
