import 'dart:typed_data';
import 'package:bldrs/ambassadors/db_brain/locations_brain.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class GoogleMapScreen3 extends StatefulWidget {
  @override
  _GoogleMapScreen3State createState() => _GoogleMapScreen3State();
}

class _GoogleMapScreen3State extends State<GoogleMapScreen3> {
BitmapDescriptor customMarker;
int markerWidth = 50;

    Future<Uint8List> getBytesFromCanvas(int width, int height, urlAsset) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final ByteData datai = await rootBundle.load(urlAsset);
    var imaged = await loadImage(new Uint8List.view(datai.buffer));

    canvas.drawImageRect(
      imaged,
      Rect.fromLTRB(0.0, 0.0, imaged.width.toDouble(), imaged.height.toDouble()),
      Rect.fromLTRB(0.0, 0.0, width.toDouble(), height.toDouble()),
      new Paint(),
    );

    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }


 missingFunction()async{
    // int markerScale = 30;
    final Uint8List markerIcon = await getBytesFromCanvas(100,100, Iconz.DumAuthorPic);
    customMarker = BitmapDescriptor.fromBytes(markerIcon);
}

  @override
  void initState(){
      super.initState();
      missingFunction();
  }

  @override
  Widget build(BuildContext context) {
   var theMarkers = countryCitiesMarkers(Flagz.Egypt, customMarker);

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
                        target: cityLocationByCityID(1818253931), // Mecca 1682169241 - Cairo 1818253931
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
