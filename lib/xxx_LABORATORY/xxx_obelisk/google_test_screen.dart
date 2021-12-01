import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/db/fire/ops/zone_ops.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/appbar/search_bar.dart';
import 'package:bldrs/views/widgets/general/buttons/flagbox_button.dart';
import 'package:bldrs/views/widgets/general/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/data_strip.dart';
import 'package:bldrs/xxx_LABORATORY/google_maps/google_map_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LocationsTestScreen extends StatefulWidget {
  const LocationsTestScreen({Key key}) : super(key: key);

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

          final Position _position = await ZoneOps.getGeoLocatorCurrentPosition();

          print('got position = ${_position}');

          final GeoPoint _geoPoint = GeoPoint(_position?.latitude, _position?.longitude);

          print('made geo point aho $_geoPoint');

          setState(() {
            _point = _geoPoint;
          });

          print('getting place marks');

          await _getCountryData(geoPoint: _geoPoint);

        },

        onError: (String e){
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
        const GoogleMapScreen(
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
  String _countryID;
  CountryModel _countryModel;
  CityModel _cityModel;
  Future<void> _getCountryData({@required GeoPoint geoPoint}) async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    final ZoneModel _zoneModel = await _zoneProvider.getZoneModelByGeoPoint(context: context, geoPoint: geoPoint);

    if (_zoneModel != null){

      final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _zoneModel.countryID);
      final CityModel _city = await _zoneProvider.fetchCityByID(context: context, cityID: _zoneModel.cityID);


      setState(() {
        _countryID = _zoneModel.countryID;
        _countryModel = _country;
        _cityModel = _city;
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
      appBarRowWidgets: const <Widget>[],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _ScrollController,
            children: <Widget>[

              const Stratosphere(),

              Container(
                color: Colorz.white10,
                child: SearchBar(
                    // onSearchChanged: (String val) async {print(val);},
                    onSearchSubmit: (String val) async {

                      final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

                      final CityModel _result = await _zoneProvider.fetchCityByName(context: context, cityName: val, lingoCode: 'en');

                        if (_result != null){

                          final CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _result.countryID);

                          setState(() {
                            _countryModel = _country;
                            _countryID = _result.countryID;
                            _cityModel = _result;
                          });

                          _result.printCity();

                        }

                      else {

                        await TopDialog.showTopDialog(context: context, verse: 'No city found');

                      }

                    },
                    historyButtonIsOn: false
                ),
              ),

              FlagBox(
                  size: 50,
                  flag: Flag.getFlagIconByCountryID(_countryID)
              ),

              WideButton(
                verse: 'Get Current Location',
                icon: _countryID == null ? Iconz.Share : Flag.getFlagIconByCountryID(_countryID),
                onTap: () async {

                  print('LET THE GAMES BEGIN');

                  await _getCurrentUserLocation();

                },
              ),
              WideButton(
                verse: 'Get Position from Map',
                icon: _countryID == null ? Iconz.Share : Flag.getFlagIconByCountryID(_countryID),
                onTap: () async {

                  print('LET THE GAMES BEGIN');

                  await _getPositionFromMap();

                },
              ),


              DataStrip(dataKey: 'geo point',dataValue: 'LAT : ${_point?.latitude} : LNG : ${_point?.longitude}',),
              DataStrip(dataKey: 'ID',dataValue: _countryID,),
              DataStrip(dataKey: 'Country Name (EN)',dataValue: Name.getNameByLingoFromNames(names: _countryModel?.names, lingoCode: 'en'),),
              DataStrip(dataKey: 'Country Name (AR)',dataValue: Name.getNameByLingoFromNames(names: _countryModel?.names, lingoCode: 'ar'),),

              DataStrip(dataKey: 'City ID',dataValue: _cityModel?.cityID),
              DataStrip(dataKey: 'City Name (EN)',dataValue: Name.getNameByLingoFromNames(names: _cityModel?.names, lingoCode: 'en'),),



            ],
          ),
        ),
      ),
    );
  }


}