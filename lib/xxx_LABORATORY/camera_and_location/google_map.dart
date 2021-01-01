import 'package:bldrs/view_brains/controllers/locations_brain.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pro_flyer/flyer_parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/test_provider.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x17_create_new_flyer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  String _previewImage;
  BitmapDescriptor customMarker;
  LatLng _pickedLocation;
  // ----------------------------------------------------------------------
  @override
  void initState(){
    super.initState();
    getCustomMarker();
  }
  // ----------------------------------------------------------------------
  Future getCustomMarker()async{
    customMarker = await BitmapDescriptor.
    fromAssetImage(ImageConfiguration.empty, Iconz.DumPinPNG)
    ;
  }
  // ----------------------------------------------------------------------
  // void _showPreview(double lat, double lng){
  //   print('show Preview, Lat: $lat, lng: $lng');
  //   final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(lat, lng);
  //   setState(() {
  //     _previewImage = staticMapImageUrl;
  //   });
  // }
  // ----------------------------------------------------------------------
  // // -- max get location method
  // Future<void> _getCurrentUserLocation() async {
  //   try {
  //     final locData = await Location().getLocation();
  //     _showPreview(locData.latitude, locData.longitude);
  //     // widget.onSelectPlace(locData.latitude, locData.longitude);
  //   } catch (error){
  //     return;
  //   }
  // }
  // // ----------------------------------------------------------------------
  // // --- to go to a new screen with default position,, why the fuck ?
  // Future<void>_selectOnMap() async {
  //   final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
  //       MaterialPageRoute(
  //           builder: (ctx) => GoogleMapScreen(
  //             isSelecting: true,
  //           )
  //       )
  //   );
  //   if (selectedLocation == null){ return; }
  //   _showPreview(selectedLocation.latitude, selectedLocation.longitude);
  //   print("${selectedLocation.latitude},${selectedLocation.longitude}");
  // }
  // ----------------------------------------------------------------------
  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
    print('The fucking position is $position');
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    var theMarkers = _pickedLocation == null ? countryCitiesMarkers(Flagz.Saudi_Arabia, customMarker) :
    {
      Marker(
        markerId: MarkerId('m1'),
        position: _pickedLocation,
      )
    };

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double mapBoxWidth = screenWidth * 0.8;
    // double mapBoxHeight = mapBoxWidth;
    double boxCorners = Ratioz.rrFlyerBottomCorners *  screenWidth;

    return MainLayout(
      appBarType: AppBarType.Scrollable,
      appBarRowWidgets: <Widget>[
        zorar(getCustomMarker, 'getCustomMarker'),
        // zorar(() => _showPreview(20,20), '_showPreview(20,20)'),
        // zorar(_getCurrentUserLocation, '_getCurrentUserLocation'),
        // zorar( _selectOnMap, '_selectOnMap'),
        zorar(() => _selectLocation(cityLocationByCityID(1682169241)), '_selectLocation(cityLocationByCityID(1682169241))'),

      ],
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
                initialCameraPosition:
                CameraPosition(
                  target: cityLocationByCityID(1818253931), // Mecca 1682169241 - Cairo 1818253931zoom: 10
                  zoom: 16,
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
            bottom: 5,
            child: DreamBox(
              height: 50,
              width: 220,
              color: Colorz.Yellow,
              verse: 'Confirm flyer Location',
              verseMaxLines: 2,
              verseScaleFactor: 0.7,
              verseWeight: VerseWeight.black,
              verseColor: Colorz.BlackBlack,
              boxFunction: _pickedLocation == null ? (){print('_pickedLocation : $_pickedLocation');} : (){
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

