// import 'package:bldrs/view_brains/controllers/locations_brain.dart';
// import 'package:bldrs/view_brains/drafters/borderers.dart';
// import 'package:bldrs/view_brains/drafters/scalers.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/view_brains/theme/flagz.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
// import 'package:bldrs/view_brains/theme/ratioz.dart';
// import 'package:bldrs/views/widgets/appbar/ab_strip.dart';
// import 'package:bldrs/views/widgets/buttons/dream_box.dart';
// import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
// import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
//
// // Google Cloud Platform
// // Bldrs
// // Google Map for Android - IOS
// // AuthorPic key 1
// // AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI
//
// // -------------------------------------------
// class GoogleMapScreen extends StatefulWidget {
//   final PlaceLocation initialLocation;
//   final bool isSelecting;
//
//   GoogleMapScreen({
//     this.initialLocation = const PlaceLocation(latitude: 37.43296265331129, longitude: -122.08832357078792),
//     this.isSelecting = false,
//   });
//
//   @override
//   _GoogleMapScreenState createState() => _GoogleMapScreenState();
// }
//
// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   String _previewImage;
//   BitmapDescriptor _customMarker;
//   LatLng _pickedLocation;
//
//   Future getCustomMarker()async{
//     _customMarker = await BitmapDescriptor.
//     fromAssetImage(ImageConfiguration.empty, Iconz.DumPinPNG)
//     ;
//   }
//
//   void _showPreview(double lat, double lng){
//     print('show Preview, Lat: $lat, lng: $lng');
//     final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(lat, lng);
//     setState(() {
//       _previewImage = staticMapImageUrl;
//     });
//   }
//
//   // -- max get location method
//   Future<void> _getCurrentUserLocation() async {
//     try {
//       final locData = await Location().getLocation();
//       _showPreview(locData.latitude, locData.longitude);
//       // widget.onSelectPlace(locData.latitude, locData.longitude);
//     } catch (error){
//       return;
//     }
//   }
//
//   // --- to go to a new screen with default position,, why the fuck ?
//   Future<void>_selectOnMap() async {
//     final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
//         MaterialPageRoute(
//             builder: (ctx) => GoogleMapScreen(
//               isSelecting: true,
//             )
//         )
//     );
//     if (selectedLocation == null){ return; }
//     _showPreview(selectedLocation.latitude, selectedLocation.longitude);
//     print("${selectedLocation.latitude},${selectedLocation.longitude}");
//   }
//
//   void _selectLocation(LatLng position){
//     setState(() {
//       _pickedLocation = position;
//     });
//     print('The fucking position is $position');
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     getCustomMarker();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     var theMarkers =
//     // _pickedLocation == null ? countryCitiesMarkers(Flagz.sau, _customMarker) :
//     {
//       Marker(
//         markerId: MarkerId('m1'),
//         position: _pickedLocation,
//       )
//     };
//
//     double _screenWidth = superScreenWidth(context);
//     double _screenHeight = superScreenHeight(context);
//     // double mapBoxWidth = screenWidth * 0.8;
//     // double mapBoxHeight = mapBoxWidth;
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
//                     initialCameraPosition:
//                     CameraPosition(
//                       target: cityLocationByCityID('1818253931'), // Mecca 1682169241 - Cairo 1818253931zoom: 10
//                       zoom: 16,
//                       // bearing: ,
//                       // tilt: ,
//                     ),
//                     onMapCreated: (GoogleMapController googleMapController){setState(() {print('map has been created');});},
//                     markers: theMarkers,
//                     onTap: widget.isSelecting ?
//                     _selectLocation
//                         :
//                     null,
//                   ),
//
//                   ABStrip(
//                     scrollable: true,
//                     rowWidgets: [
//
//
//
//                       DreamBox(
//                         height: 40,
//                         width: 120,
//                         icon: Iconz.BxPropertiesOff,
//                         verse: 'Cuurent Location',
//                         verseMaxLines: 2,
//                         verseScaleFactor: 0.5,
//                         boxFunction: _getCurrentUserLocation,
//                       ),
//
//                       Container(
//                         width: 5,
//                         height: 50,
//                       ),
//
//                       DreamBox(
//                         height: 40,
//                         width: 120,
//                         icon: Iconz.LocationPin,
//                         iconSizeFactor: 0.7,
//                         verse: 'Select On Map',
//                         verseMaxLines: 2,
//                         verseScaleFactor: 0.7,
//                         boxFunction: _selectOnMap,
//                       ),
//
//                       Container(
//                         width: 5,
//                         height: 50,
//                       ),
//
//                       _previewImage == null ?
//                       DreamBox(
//                         height: 40,
//                         width: 100,
//                         verse: 'no Image chosen',
//                         verseScaleFactor: 0.5,
//                         verseMaxLines: 2,
//                       )
//                           :
//                       Image.network(_previewImage,
//                         width: 40,
//                         height: 40,
//                         fit: BoxFit.cover,
//                       ),
//
//                       if (widget.isSelecting)
//                         DreamBox(
//                           height: 40,
//                           icon: Iconz.Check,
//                           boxFunction: _pickedLocation == null ? null : (){
//                             Navigator.of(context).pop(_pickedLocation);
//                           },
//                         ),
//
//                     ],
//                   ),
//
//                   _previewImage == null ? Container() :
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     child: Container(
//                       width: _screenWidth,
//                       height: 300,
//                       child: Image.network(_previewImage,
//                         // width: 40,
//                         // height: 40,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   )
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
