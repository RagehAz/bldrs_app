import 'dart:async';
import 'dart:typed_data';
import 'package:bldrs/view_brains/controllers/locations_brain.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class GoogleMapScreen5 extends StatefulWidget {

  @override
  _GoogleMapScreen5State createState() => _GoogleMapScreen5State();
}


class _GoogleMapScreen5State extends State<GoogleMapScreen5> {
  Completer<GoogleMapController> _controller = Completer();
Position currentUserPosition;
  Position loadedPosition;
  BitmapDescriptor customMarker;
  int markerWidth = 50;


  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

    Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


 getUserLocation () async {
  currentUserPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  setState(() {
    loadedPosition = currentUserPosition;
  });
}

// --- this makes blue rounded rectangle with text inside
Future<Uint8List> getBytesFromCanvas(int width, int height, String verse) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color = Colors.blue;
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
  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = TextSpan(
    text: verse,
    style: TextStyle(fontSize: 25.0, color: Colorz.White),
  );
  painter.layout();
  painter.paint(canvas, Offset((width * 0.5) - painter.width * 0.5, (height * 0.5) - painter.height * 0.5));
  final img = await pictureRecorder.endRecording().toImage(width, height);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data.buffer.asUint8List();
}

 missingFunction()async{
    // int markerScale = 30;
    final Uint8List markerIcon = await getBytesFromCanvas(100,100, 'Za7ma');
    customMarker = BitmapDescriptor.fromBytes(markerIcon);
}

  @override
  void initState() {
      getUserLocation();
      missingFunction();
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
  bool searchingCities = false;

  var cityMarkers = countryCitiesMarkers(Flagz.Egypt, customMarker);

  LatLng aMarkerLatLng = LatLng(loadedPosition.latitude, loadedPosition.longitude);
  var aMarker = someMarker(customMarker, aMarkerLatLng.latitude , aMarkerLatLng.longitude);

  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  // double mapBoxWidth = screenWidth * 0.8;
  // double mapBoxHeight = mapBoxWidth;
  double boxCorners = Ratioz.rrFlyerBottomCorners *  screenWidth;

    return SafeArea(

      child: Scaffold(
        backgroundColor: Colorz.SkyDarkBlue,
        body: Center(
          child: ClipRRect(
            borderRadius: superBorderRadius(context, boxCorners, boxCorners, boxCorners, boxCorners),
            child: Container(
              width: screenWidth,
              height: screenHeight,
              // decoration: BoxDecoration(
              //   borderRadius: superBorderRadius(context, boxCorners, boxCorners, 0, boxCorners),
              // ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[

                  GoogleMap(
                    mapType: MapType.hybrid,
                    zoomGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: searchingCities == true ? cityLocationByCityID(1818253931) : aMarkerLatLng, // Mecca 1682169241 - Cairo 1818253931
                        zoom: 18
                    ),
                    onMapCreated: (GoogleMapController googleMapController){

                      // _controller.complete(googleMapController);

                      setState(() {
                        print('map has been created');
                      });
                      },

                    markers: searchingCities == true ? cityMarkers : aMarker,
                  ),

                  ABStrip(
                    rowWidgets: [

                      Container(),

                      DreamBox(
                        height: 50,
                        width: 120,
                        icon: Iconz.LocationPin,
                        iconColor: Colorz.Yellow,
                        verse: 'My Fucking Location',
                        verseMaxLines: 2,
                        verseScaleFactor: 0.5,
                        iconSizeFactor: 0.8,
                        boxFunction: ()async{
                          print('.....');
                          // LocationPermission permission = await Geolocator.requestPermission();
                          // LocationPermission permission = await Geolocator.checkPermission();
                          Position position = await getUserLocation();
                          // --- LAST KNOWN LOCATION
                          // Position position = await Geolocator.getLastKnownPosition();
                          print('YOUR FUCKING LOCATION IS : Latitude (${position.latitude}) ,Longitude (${position.longitude})');
                          setState(() {
                            aMarkerLatLng = LatLng(position.latitude, position.longitude);
                          });
                        },
                    ),

                      DreamBox(
                        height: 50,
                        width: 50,
                        icon: Iconz.LocationPin,
                        iconColor: Colorz.BloodRed,
                        iconSizeFactor: 0.8,
                        boxFunction: ()async{
                          print('.....');
                          // LocationPermission permission = await Geolocator.requestPermission();
                          // LocationPermission permission = await Geolocator.checkPermission();
                          // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
                          // print('YOUR FUCKING LOCATION IS : Latitude (${position.latitude}) ,Longitude (${position.longitude})');
                          setState(() {
                            aMarkerLatLng = cityLocationByCityID(1682169241);
                            print('the new position is Latitude (${aMarkerLatLng.latitude}) ,Longitude (${aMarkerLatLng.longitude})');
                          _goToTheLake();
                          });
                        },
                    ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
