import 'dart:async';
import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GoogleMapScreen({
    Key key,
    this.geoPoint,
    this.isSelecting = false,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GeoPoint geoPoint;
  final bool isSelecting;
  /// --------------------------------------------------------------------------
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
  /// --------------------------------------------------------------------------
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // -----------------------------------------------------------------------------
  GeoPoint _geoPoint;
  // --------------------
  CountryModel _countryModel;
  // --------------------
  GoogleMapController _googleMapController;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _geoPoint = const GeoPoint(
        30.0778, 31.2852); //widget.geoPoint ?? Atlas.dummyPosition();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {

        // final BitmapDescriptor _marker = await Imagers.getCustomMapMarkerFromSVG(context: context, assetName: Iconz.FlyerPin);
        // _mapMarker = _marker;

        unawaited(_triggerLoading(setTo: false));
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _googleMapController.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /*
  String _previewImage;
  void _showPreview(double lat, double lng){
    blog('show Preview, Lat: $lat, lng: $lng');
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(lat, lng);
    setState(() {
      _previewImage = staticMapImageUrl;
    });
  }
   */
  // --------------------
  void _selectLocation({
    @required LatLng latLng
  }) {
    final GeoPoint _point = GeoPoint(latLng.latitude, latLng.longitude);

    blog('LatLng : lat : ${latLng.latitude} : lng : ${latLng.longitude}');
    blog('GeoPoint : lat : ${_point.latitude} : lng : ${_point.longitude}');

    setState(() {
      _geoPoint = _point;
    });

    blog('_selectLocation :  $latLng');
  }
  // --------------------
  /*
  BitmapDescriptor _mapMarker;
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
          visible: true,
          zIndex: 0.0,
          flat: true,
        ),
      };
    }

    return _markers;
  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    // Set<Marker> theMarkers = _getMarkers();
    // double mapBoxWidth = screenWidth * 0.8;
    // double mapBoxHeight = mapBoxWidth;
    // final double _boxCorners = Ratioz.rrFlyerBottomCorners *  _screenWidth;

    const double _pinWidth = 30;

    return MainLayout(
      pageTitleVerse: const Verse(
        text: 'phid_select_on_map',
        translate: true,
      ),
      appBarType: AppBarType.basic,
      // loading: _loading,
      appBarRowWidgets: const <Widget>[],
      onBack: () async {
        await Nav.goBack(
          context: context,
            invoker: 'GoogleMapScreen.onBack',
            passedData: _geoPoint,
        );
        // await null;
      },
      skyType: SkyType.black,
      layoutWidget: Stack(
        children: <Widget>[

          /// MAP
          GoogleMap(
            key: const PageStorageKey<String>('google_map'),

            /// UI
            mapType: MapType.hybrid,

            /// GOOGLE MAP BUTTONS
            compassEnabled: false,
            myLocationButtonEnabled: false,
            buildingsEnabled: false,

            /// IN-EFFECTIVE
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _geoPoint == null
                  ? null
                  : LatLng(_geoPoint?.latitude, _geoPoint?.longitude),
              zoom: 5,
              // bearing: ,
              // tilt: ,
            ),

            /// METHODS
            onCameraIdle: () {
              blog('Camera is idle');
            },
            onCameraMove: (CameraPosition cameraPosition) async {
              blog('cameraPosition : $cameraPosition');
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
            onCameraMoveStarted: () {
              blog('Camera move started');
            },
            onLongPress: (LatLng latLng) {
              blog(
                  'long tap is tapped on : LAT : ${latLng.latitude} : LNG : ${latLng.longitude}');
            },
            onMapCreated: (GoogleMapController googleMapController) {
              googleMapController = _googleMapController;
            },
            onTap: (LatLng latLng) {
              if (widget.isSelecting == true) {
                _selectLocation(latLng: latLng);
              } else {
                blog(
                    'on tap is tapped on : LAT : ${latLng.latitude} : LNG : ${latLng.longitude}');
              }
            },
          ),

          /// LOCATION PIN
          Container(
            width: _screenWidth,
            height: _screenHeight,
            alignment: Alignment.center,
            child: SizedBox(
              width: _pinWidth,
              height: _pinWidth * 2,
              child: Column(
                children: const <Widget>[
                  /// pin square on top
                  DreamBox(
                    width: _pinWidth,
                    height: _pinWidth,
                    icon: Iconz.locationPin,
                    iconColor: Colorz.red230,
                    bubble: false,
                  ),

                  /// fake balancing bottom square
                  SizedBox(
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
              icon: _countryModel == null ? Iconz.locationPin : Flag.getFlagIcon(_countryModel.id),
              // iconColor: Colorz.red230,
              iconSizeFactor: 0.7,
              verse: const Verse(text: 'phid_confirm', translate: true),
              verseCentered: false,
              secondLine: Verse.plain('lat ${Numeric.roundFractions(_geoPoint.latitude, 2)}, Lng ${Numeric.roundFractions(_geoPoint.longitude, 2)}'),
              color: Colorz.black230,
              onTap: () async {
                await Nav.goBack(
                    context: context,
                    invoker: 'GoogleMapScreen.Confirm',
                    passedData: _geoPoint
                );
                // await null;
              },
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
