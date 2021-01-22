import 'dart:async';
import 'dart:typed_data';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pro_flyer/flyer_parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
// ----------------------------------------------------------------------
// Google Cloud Platform
// Bldrs
// Google Map for Android - IOS
// AuthorPic key 1
// AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI
// ----------------------------------------------------------------------
class GoogleMapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  GoogleMapScreen({
    this.initialLocation = const PlaceLocation(latitude: 37.43296265331129, longitude: -122.08832357078792),
    this.isSelecting = false,
  });

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  LatLng _pickedLocation;
  BitmapDescriptor customMarker;
  int markerWidth = 125;
  Position currentUserPosition;
  Position initialPosition;
  bool confirmButtonIsActive;
  // ----------------------------------------------------------------------
  @override
  void initState(){
    super.initState();
    missingFunction();
    getUserLocation();
    confirmButtonIsActive = true;
  }
  // ----------------------------------------------------------------------
  void getUserLocation () async {
    currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best,);
    setState(() {
      initialPosition = currentUserPosition;
    });
  }
  // // ----------------------------------------------------------------------
  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
      confirmButtonIsActive = true;
    });
    print('The fucking position is $position');
  }
  // ----------------------------------------------------------------------
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
  // ----------------------------------------------------------------------
  missingFunction()async{
    final Uint8List markerIcon = await getBytesFromAsset(Iconz.FlyerPinPNG, markerWidth);
    customMarker = BitmapDescriptor.fromBytes(markerIcon);
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    var theMarkers = _pickedLocation == null ? null :
    {
      Marker(
        markerId: MarkerId('m1'),
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

    LatLng userCurrentLocation = LatLng(initialPosition.latitude, initialPosition.longitude);

    return MainLayout(
      layoutWidget:
      Stack(
        alignment: Alignment.center,
        children: <Widget>[

          FlyerZone(
            flyerSizeFactor: 0.85,
            tappingFlyerZone: (){},
            stackWidgets: <Widget>[

              GoogleMap(
                mapType: MapType.hybrid,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                liteModeEnabled: false,
                buildingsEnabled: false,
                compassEnabled: true,
                trafficEnabled: false,
                mapToolbarEnabled: false,
                initialCameraPosition:
                CameraPosition(
                  target: userCurrentLocation,
                  zoom: 10,
                  // bearing: ,
                  // tilt: ,
                ),
                onMapCreated: (GoogleMapController googleMapController){setState(() {print('map has been created');});},
                markers: theMarkers,
                onTap: widget.isSelecting ? _selectLocation : null,
              ),

            ],
          ),

          if (widget.isSelecting)
            Positioned(
              top: 80,
              left: 10,
              child: DreamBox(
                height: 60,
                verse: 'Tap The Map\nto pin flyer on the map !',
                verseWeight: VerseWeight.regular,
                verseItalic: true,
                verseMaxLines: 2,
                color: Colorz.BlackLingerie,
                bubble: false,
                icon: Iconz.FingerTap,
                iconSizeFactor: 0.7,
              ),
            ),

          if (widget.isSelecting)
          Positioned(
            bottom: 5,
            child: DreamBox(
              height: 50,
              width: 220,
              color: confirmButtonIsActive == true ? Colorz.Yellow : Colorz.BloodRed,
              verse: confirmButtonIsActive == true ? 'Confirm flyer Location' : 'Pin the Map first !',
              verseMaxLines: 2,
              verseScaleFactor: 0.7,
              verseWeight: VerseWeight.black,
              verseColor: confirmButtonIsActive == true ? Colorz.BlackBlack : Colorz.White,
              boxFunction: _pickedLocation == null ?
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

