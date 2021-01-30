import 'dart:typed_data';
import 'package:bldrs/view_brains/controllers/locations_brain.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/bldrs_appbar.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;


class GoogleMapScreen2 extends StatefulWidget {
  @override
  _GoogleMapScreen2State createState() => _GoogleMapScreen2State();
}

class _GoogleMapScreen2State extends State<GoogleMapScreen2> {
BitmapDescriptor customMarker;
int markerWidth = 50;

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}

 missingFunction()async{
  final Uint8List markerIcon = await getBytesFromAsset(Iconz.DumPyramidPin, markerWidth);
  customMarker = BitmapDescriptor.fromBytes(markerIcon);
}

  @override
  void initState(){
      super.initState();
      missingFunction();
  }

  @override
  Widget build(BuildContext context) {
   var theMarkers = countryCitiesMarkers(Flagz.egy, customMarker);


    double screenWidth = superScreenWidth(context);
    double screenHeight = superScreenHeight(context);

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
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[

                  GoogleMap(
                    mapType: MapType.hybrid,
                    zoomGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: cityLocationByCityID('1818253931'), // Mecca 1682169241 - Cairo 1818253931
                        zoom: 10
                    ),
                    onMapCreated: (GoogleMapController googleMapController){setState(() {
                      print('map has been created');
                    });},

                    markers: theMarkers,
                  ),

                  ABStrip(
                    rowWidgets: [

                      Container(),

                      DreamBox(
                        height: 35,
                        icon: Iconz.ArrowDown,
                    ),

                      DreamBox(
                        height: 35,
                        icon: Iconz.ArrowUp,
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
