import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/data_strip.dart';
import 'package:bldrs/xxx_LABORATORY/google_maps/googl_map_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LocationsTestScreen extends StatefulWidget {

  @override
  _LocationsTestScreenState createState() => _LocationsTestScreenState();
}

class _LocationsTestScreenState extends State<LocationsTestScreen> {
  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;

  ScrollController _ScrollController;

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
  void initState() {
    _ScrollController = new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here

        _triggerLoading(
          function: (){
            /// set new values here
          }
        );
      });


    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  GeoPoint _point;
  Future<void> _getCurrentUserLocation() async {

    _triggerLoading();

    await tryAndCatch(
        context: context,
        methodName: 'get location thing',
        functions: () async {

          print('getting location aho');

          final Position _position = await Atlas.getGeoLocatorCurrentPosition();

          print('got position = ${_position}');

          final GeoPoint _geoPoint = GeoPoint(_position?.latitude, _position?.longitude);

          print('made geo point aho $_geoPoint');

          setState(() {
            _point = _geoPoint;
          });

          print('getting place marks');

          await _getCountryData(geoPoint: _geoPoint);

        },

        onError: (e){
          print('ERROR IS : ${e.toString()}');
      }
      );

    _triggerLoading();

  }
// -------------------------------------------------
  Future<void> _getPositionFromMap() async {

    _triggerLoading();

    final GeoPoint _pickedPoint = await Nav.goToNewScreen(
        context,
        GoogleMapScreen(
          isSelecting: true,
        )
    );

    if (_pickedPoint != null){

      setState(() {
        _point = _pickedPoint;
      });

      await _getCountryData(geoPoint: _point);
    }

    _triggerLoading();

  }
// -----------------------------------------------------------------------------
  String _flag;
  String _countryID;
  CountryModel _countryModel;
  Future<void> _getCountryData({@required GeoPoint geoPoint}) async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    final CountryModel _model = await _zoneProvider.getCountryModelByGeoPoint(context: context, geoPoint: geoPoint);

    if (_model != null){

      final String _countryFlag = Flag.getFlagIconByCountryID(_model.id);

      setState(() {
        _flag = _countryFlag;
        _countryID = _model.id;
        _countryModel = _model;
      });

      }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    // final double _screenWidth = Scale.superScreenWidth(context);
    // final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },

      appBarRowWidgets: const <Widget>[],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _ScrollController,
            children: <Widget>[

              const Stratosphere(),

              WideButton(
                verse: 'Get Current Location',
                icon: _flag ?? Iconz.Share,
                onTap: () async {

                  print('LET THE GAMES BEGIN');

                  await _getCurrentUserLocation();

                },
              ),
              WideButton(
                verse: 'Get Position from Map',
                icon: _flag ?? Iconz.Share,
                onTap: () async {

                  print('LET THE GAMES BEGIN');

                  await _getPositionFromMap();

                },
              ),


              DataStrip(dataKey: 'geo point',dataValue: 'LAT : ${_point?.latitude} : LNG : ${_point?.longitude}',),
              DataStrip(dataKey: 'ID',dataValue: _countryID,),
              DataStrip(dataKey: 'Country Name (EN)',dataValue: Name.getNameByLingoFromNames(names: _countryModel?.names, lingoCode: 'en'),),
              DataStrip(dataKey: 'Country Name (AR)',dataValue: Name.getNameByLingoFromNames(names: _countryModel?.names, lingoCode: 'ar'),),


            ],
          ),
        ),
      ),
    );
  }


}