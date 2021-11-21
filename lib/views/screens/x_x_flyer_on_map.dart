import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// -----------------------------------------------------------------------------
// Google Cloud Platform
// Bldrs
// Google Map for Android - IOS
// AuthorPic key 1
// AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI
// -----------------------------------------------------------------------------
class GoogleMapScreen extends StatefulWidget {
  final GeoPoint geoPoint;
  final bool isSelecting;
  final double flyerBoxWidth;

  const GoogleMapScreen({
    this.geoPoint, // = const PlaceLocation(latitude: 37.43296265331129, longitude: -122.08832357078792),
    this.isSelecting = false,
    @required this.flyerBoxWidth,
  });

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng _pickedLocation;
  BitmapDescriptor customMarker;
  int markerWidth = 125;
  bool confirmButtonIsActive;

  LocationData currentLocation;
  Location location;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  CameraPosition _initialCameraPosition;
  bool isLoading = false;
  GoogleMapController mapController;
// -----------------------------------------------------------------------------
  @override
  void initState(){
    super.initState();
    location = new Location();
    getUserLocation();
    confirmButtonIsActive = true;
  }
// -----------------------------------------------------------------------------
  Future<void> getUserLocation () async {
    setState(() {
      isLoading = true;
    });
    await initialize();
    print('trying to get user location aho');
    currentLocation = await location.getLocation();
    print('getlocation function finished aho and processing remaining functions');
    if (currentLocation == null) {
      print('Counldn\'t get current User Location');
      return;
    }
    _initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 10
    );

    print('_initialCameraPosition is $_initialCameraPosition');

    setState(() {
      isLoading = false;
    });

    print("CurrentLocation: $currentLocation");
    await missingFunction();
  }
// -----------------------------------------------------------------------------
  Future<void> initialize() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    print('location permission is $_permissionGranted');
  }
// -----------------------------------------------------------------------------
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
// -----------------------------------------------------------------------------
  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
      confirmButtonIsActive = true;
    });
    print('The fucking position is $position');
  }
// -----------------------------------------------------------------------------
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
// -----------------------------------------------------------------------------
  Future<void> missingFunction()async{
    print('missing function starts');
    final Uint8List markerIcon = await getBytesFromAsset(Iconz.FlyerPinPNG, markerWidth);
    customMarker = BitmapDescriptor.fromBytes(markerIcon);
    print('missing function ends ${customMarker.toString()}');
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    var theMarkers = _pickedLocation == null ? null :
    {
      Marker(
        markerId: const MarkerId('m1'),
        position: _pickedLocation,
        icon: customMarker,
        // infoWindow: InfoWindow(
        //   title: 'title',
        //   snippet: 'snippet',
        //   onTap: (){print('pin taps aho');},
        //   // anchor: const Offset(0,0),
        // ),

      )
    };

    // LatLng userCurrentLocation = LatLng(_initialPosition?.latitude ?? 0, _initialPosition?.longitude ?? 0);

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    return MainLayout(
      skyType: SkyType.Black,
      pyramids: Iconz.DvBlankSVG,
      // tappingRageh: getUserLocation,
      layoutWidget:
      Stack(
        alignment: Alignment.center,
        children: <Widget>[

          Container(
            width: _screenWidth,
            height: _screenHeight,
            child: isLoading ?
            Loading(loading: isLoading,) :
            GoogleMap(
              mapType: MapType.hybrid,
              indoorViewEnabled: false,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              liteModeEnabled: false,
              buildingsEnabled: false,
              compassEnabled: true,
              trafficEnabled: false,
              mapToolbarEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: _onMapCreated,
              //(GoogleMapController googleMapController){setState(() {print('map has been created');});},
              markers: theMarkers,
              onTap: widget.isSelecting ? _selectLocation : null,

            ),
          ),

          // FlyerZone(
          //   flyerSizeFactor: 0.85,
          //   tappingFlyerZone: (){},
          //   stackWidgets: <Widget>[
          //
          //     // Container(
          //     //   width: 400,
          //     //   height: 400,
          //     //   child: GoogleMap(
          //     //     mapType: MapType.hybrid,
          //     //     zoomGesturesEnabled: true,
          //     //     myLocationButtonEnabled: true,
          //     //     myLocationEnabled: true,
          //     //     liteModeEnabled: false,
          //     //     buildingsEnabled: false,
          //     //     compassEnabled: true,
          //     //     trafficEnabled: false,
          //     //     mapToolbarEnabled: false,
          //     //     initialCameraPosition:
          //     //     CameraPosition(
          //     //       target: userCurrentLocation,
          //     //       zoom: 10,
          //     //       // bearing: ,
          //     //       // tilt: ,
          //     //     ),
          //     //     onMapCreated: (GoogleMapController googleMapController){setState(() {print('map has been created');});},
          //     //     markers: theMarkers,
          //     //     onTap: widget.isSelecting ? _selectLocation : null,
          //     //   ),
          //     // ),
          //
          //
          //
          //   ],
          // ),

          if (widget.isSelecting)
            const Positioned(
              top: 10,
              left: 10,
              child: DreamBox(
                height: 60,
                verse: 'Tap The Map\nto pin flyer on the map !',
                verseWeight: VerseWeight.regular,
                verseItalic: true,
                verseMaxLines: 2,
                color: Colorz.black200,
                bubble: false,
                icon: Iconz.FingerTap,
                iconSizeFactor: 0.7,
              ),
            ),

          if (widget.isSelecting)
          Positioned(
            bottom: 5,
            child: DreamBox(
              height: 60,
              width: 220,
              color: confirmButtonIsActive == true ? Colorz.yellow255 : Colorz.red255,
              verse: confirmButtonIsActive == true ? 'Confirm flyer Location' : 'Pin the Map first !',
              verseMaxLines: 2,
              verseScaleFactor: 0.7,
              verseWeight: VerseWeight.black,
              verseColor: confirmButtonIsActive == true ? Colorz.black230 : Colorz.white255,
              onTap: _pickedLocation == null ?
                  (){
                setState(() {
                  confirmButtonIsActive = false;
                });
              }
                  :
                  (){
                Navigator.of(context).pop(_pickedLocation);
                print('a77a ba2a');
              },
            ),
          ),

        ],
      ),


    );
  }
}

