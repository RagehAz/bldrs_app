import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


// Google Cloud Platform
// Bldrs
// Google Map for Android - IOS
// AuthorPic key 1
// AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI

// -------------------------------------------
class GoogleMapScreen extends StatefulWidget {
  final GeoPoint geoPoint;
  final bool isSelecting;

  GoogleMapScreen({
    this.geoPoint,
    this.isSelecting = false,
  });

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GeoPoint _geoPoint;
  String _previewImage;
  BitmapDescriptor _mapMarker;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState(){
    super.initState();
    _geoPoint = widget.geoPoint ?? Atlas.dummyPosition();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        final BitmapDescriptor _marker = await Imagers.getCustomMapMarkerFromSVG(context: context, assetName: Iconz.Dollar);

        _triggerLoading(
            function: (){
              _mapMarker = _marker;
            }
        );
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  void _showPreview(double lat, double lng){
    print('show Preview, Lat: $lat, lng: $lng');
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(lat, lng);
    setState(() {
      _previewImage = staticMapImageUrl;
    });
  }
// -----------------------------------------------------------------------------
  void _selectLocation({@required LatLng latLng}){

    final GeoPoint _point = GeoPoint(latLng.latitude, latLng.longitude);

    setState(() {
      _geoPoint = _point;
    });

    print('_selectLocation :  $latLng');
  }
// -----------------------------------------------------------------------------
  Set<Marker> _getMarkers(){

    Set<Marker> _markers = {};

    if (_mapMarker != null && _geoPoint != null){
      _markers = {
        Marker(
          markerId: MarkerId('m1'),
          position: LatLng(_geoPoint?.longitude, _geoPoint?.longitude),
          icon: _mapMarker ?? null,
          anchor: Offset(0.5,1),
          draggable: false,
        ),
      };
    }

    return _markers;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    Set<Marker> theMarkers = _getMarkers();

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    // double mapBoxWidth = screenWidth * 0.8;
    // double mapBoxHeight = mapBoxWidth;
    final double _boxCorners = Ratioz.rrFlyerBottomCorners *  _screenWidth;

    return MainLayout(
      pageTitle: 'Select on Map',
      appBarType: AppBarType.Basic,
      loading: _loading,
      pyramids: Iconz.DvBlankSVG,
      appBarRowWidgets: [],
      onBack: () async {

        await Nav.goBack(context, argument: _geoPoint);

      },
      sectionButtonIsOn: false,
      sky: Sky.Black,
      layoutWidget: Stack(
        children: <Widget>[

          GoogleMap(
            key: const PageStorageKey<String>('google_map'),

            /// UI
            mapType: MapType.hybrid,
            padding: const EdgeInsets.all(0),

            /// GOOGLE MAP BUTTONS
            compassEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,

            /// GESTURES
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{},

            /// FEATURES
            liteModeEnabled: false, // freezes map, add google map button in the corner to use google map app instead
            indoorViewEnabled: false,
            buildingsEnabled: false,
            trafficEnabled: false,

            /// IN-EFFECTIVE
            myLocationEnabled: true,
            mapToolbarEnabled: true, // in-effective,

            /// CAMERA
            cameraTargetBounds: CameraTargetBounds.unbounded,
            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            initialCameraPosition:
            CameraPosition(
              target: _geoPoint == null ? null : LatLng(_geoPoint?.latitude, _geoPoint?.longitude),
              zoom: 4,
              // bearing: ,
              // tilt: ,
            ),

            /// METHODS
            onCameraIdle: (){
              print('Camera is idle');
            },
            onCameraMove: (CameraPosition cameraPosition){
              print('cameraPosition : ${cameraPosition}');
            },
            onCameraMoveStarted: (){
              print('Camera move started');
            },
            onLongPress: (LatLng latLng){
              print('long tap is tapped on : LAT : ${latLng.latitude} : LNG : ${latLng.longitude}');
            },
            onMapCreated: (GoogleMapController googleMapController){
              setState(() {
                print('map has been created');
              });
              },
            onTap: (LatLng latLng){
              if (widget.isSelecting == true){
                 _selectLocation(latLng: latLng);
              }
              else {
                print('on tap is tapped on : LAT : ${latLng.latitude} : LNG : ${latLng.longitude}');
              }
            },

            /// SHAPES
            markers: theMarkers,
            polygons: <Polygon>{},
            polylines: <Polyline>{},
            circles: <Circle>{},
            tileOverlays: <TileOverlay>{},
          ),


          // _previewImage == null ? Container() :
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: Container(
          //     width: _screenWidth,
          //     height: 300,
          //     child: Image.network(_previewImage,
          //       // width: 40,
          //       // height: 40,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // )


        ],
      ),
    );
  }
}
