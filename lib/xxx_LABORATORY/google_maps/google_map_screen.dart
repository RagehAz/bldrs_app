import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
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
  CountryModel _countryModel;
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
    _geoPoint = const GeoPoint(30.0778, 31.2852);//widget.geoPoint ?? Atlas.dummyPosition();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        // final BitmapDescriptor _marker = await Imagers.getCustomMapMarkerFromSVG(context: context, assetName: Iconz.FlyerPin);

        _triggerLoading(
            function: (){
              // _mapMarker = _marker;
            }
        );
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
//   String _previewImage;
//   void _showPreview(double lat, double lng){
//     print('show Preview, Lat: $lat, lng: $lng');
//     final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(lat, lng);
//     setState(() {
//       _previewImage = staticMapImageUrl;
//     });
//   }
// -----------------------------------------------------------------------------
  void _selectLocation({@required LatLng latLng}){

    final GeoPoint _point = GeoPoint(latLng.latitude, latLng.longitude);

    print('LatLng : lat : ${latLng.latitude} : lng : ${latLng.longitude}');
    print('GeoPoint : lat : ${_point.latitude} : lng : ${_point.longitude}');

    setState(() {
      _geoPoint = _point;
    });

    print('_selectLocation :  $latLng');
  }
// -----------------------------------------------------------------------------
//   BitmapDescriptor _mapMarker;
//   Set<Marker> _getMarkers(){
//
//     Set<Marker> _markers = {};
//
//     if (_mapMarker != null && _geoPoint != null){
//       _markers = {
//         Marker(
//           markerId: MarkerId('m1'),
//           position: LatLng(_geoPoint?.longitude, _geoPoint?.longitude),
//           icon: _mapMarker ?? null,
//           anchor: Offset(0.5,1),
//           draggable: false,
//           visible: true,
//           zIndex: 0.0,
//           flat: true,
//         ),
//       };
//     }
//
//     return _markers;
//   }
// -----------------------------------------------------------------------------
  GoogleMapController _googleMapController;
  @override
  Widget build(BuildContext context) {

    // Set<Marker> theMarkers = _getMarkers();

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    // double mapBoxWidth = screenWidth * 0.8;
    // double mapBoxHeight = mapBoxWidth;
    // final double _boxCorners = Ratioz.rrFlyerBottomCorners *  _screenWidth;

    const double _pinWidth = 30;

    return MainLayout(
      pageTitle: 'Select on Map',
      appBarType: AppBarType.Basic,
      loading: _loading,
      pyramids: Iconz.DvBlankSVG,
      appBarRowWidgets: const [],
      onBack: () async {

        await Nav.goBack(context, argument: _geoPoint);

      },
      sectionButtonIsOn: false,
      skyType: SkyType.Black,
      layoutWidget: Stack(
        children: <Widget>[

          /// MAP
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
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},

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
              zoom: 5,
              // bearing: ,
              // tilt: ,
            ),

            /// METHODS
            onCameraIdle: (){
              print('Camera is idle');
            },
            onCameraMove: (CameraPosition cameraPosition) async {
              print('cameraPosition : ${cameraPosition}');
              final double _lat = cameraPosition.target.latitude;
              final double _lng = cameraPosition.target.longitude;

              setState(() {
              _geoPoint = GeoPoint(_lat, _lng);
              });

              // final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
              // final CountryModel _country = await _zoneProvider.getCountryModelByGeoPoint(context: context, geoPoint: _geoPoint);
              //
              // if (_country != null && CountryModel.countriesAreTheSame(_country, _countryModel) == false){
              //   setState(() {
              //     _geoPoint = GeoPoint(_lat, _lng);
              //   });
              // }
            },
            onCameraMoveStarted: (){
              print('Camera move started');
            },
            onLongPress: (LatLng latLng){
              print('long tap is tapped on : LAT : ${latLng.latitude} : LNG : ${latLng.longitude}');
            },
            onMapCreated: (GoogleMapController googleMapController){
              googleMapController = _googleMapController;
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
            // markers: theMarkers,
            polygons: const <Polygon>{},
            polylines: const <Polyline>{},
            circles: const <Circle>{},
            tileOverlays: const <TileOverlay>{},
          ),

          /// LOCATION PIN
          Container(
            width: _screenWidth,
            height: _screenHeight,
            alignment: Alignment.center,
            child: Container(
              width: _pinWidth,
              height: _pinWidth * 2,
              child: Column(
                children: <Widget>[

                  /// pin square on top
                  const DreamBox(
                    width: _pinWidth,
                    height: _pinWidth,
                    icon: Iconz.LocationPin,
                    iconColor: Colorz.red230,
                    bubble: false,
                  ),

                  /// fake balancing bottom square
                  Container(
                    width: _pinWidth,
                    height: _pinWidth,
                  ),

                ],
              ),
            ),
          ),

          /// CONFIRM BUTTON
          Container(
            width: _screenWidth,
            height: _screenHeight,
            alignment: Alignment.bottomLeft,
            child: DreamBox(
              width: _screenWidth * 0.6,
              height: 50,
              margins: Ratioz.appBarMargin,
              icon: _countryModel == null ? Iconz.LocationPin : Flag.getFlagIconByCountryID(_countryModel.id),
              // iconColor: Colorz.red230,
              iconSizeFactor: 0.7,
              verse: 'Confirm Location',
              verseCentered: false,
              secondLine: 'lat ${Numeric.roundFractions(_geoPoint.latitude, 2)}, Lng ${Numeric.roundFractions(_geoPoint.longitude, 2)}',
              color: Colorz.black230,
              onTap: () async {

                await Nav.goBack(context, argument: _geoPoint);

              },
            ),
          ),


        ],
      ),
    );
  }
}
