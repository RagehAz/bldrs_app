import 'dart:async';

import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/a_models/d_zone/city_model.dart';
import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/flag_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/search_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip_with_headline.dart';
import 'package:bldrs/c_protocols/zone_protocols/fire/zone_fire_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/backend_lab/location_test/google_map_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationsTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LocationsTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _LocationsTestScreenState createState() => _LocationsTestScreenState();
/// --------------------------------------------------------------------------
}

class _LocationsTestScreenState extends State<LocationsTestScreen> {
// -----------------------------------------------------------------------------
  /// List<int> _list = <int>[1,2,3,4,5,6,7,8];
  /// int _loops = 0;
  /// Color _color = Colorz.BloodTest;
  /// SuperFlyer _flyer;
  /// bool _thing;
// -----------------------------------------------------------------------------
  ScrollController _scrollController;
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
    _scrollController = ScrollController();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _scrollController.dispose();
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   unawaited(_triggerLoading(setTo: false));
      // });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  GeoPoint _point;
  Future<void> _getCurrentUserLocation() async {

    unawaited(_triggerLoading(setTo: true));

    await tryAndCatch(
        invoker: 'get location thing',
        functions: () async {
          blog('getting location aho');

          final Position _position = await ZoneFireOps.getGeoLocatorCurrentPosition();

          blog('got position = $_position');

          final GeoPoint _geoPoint = GeoPoint(_position?.latitude, _position?.longitude);

          blog('made geo point aho $_geoPoint');

          setState(() {
            _point = _geoPoint;
          });

          blog('getting place marks');

          await _getCountryData(geoPoint: _geoPoint);
        },
        onError: (String e) {
          blog('ERROR IS : $e');
        });

    unawaited(_triggerLoading(setTo: false));
  }
// -------------------------------------------------
  Future<void> _getPositionFromMap() async {

    unawaited(_triggerLoading(setTo: true));

    final GeoPoint _pickedPoint = await Nav.goToNewScreen(
        context: context,
        screen: const GoogleMapScreen(
          isSelecting: true,
        )
    );

    if (_pickedPoint != null) {
      setState(() {
        _point = _pickedPoint;
      });

      await _getCountryData(geoPoint: _point);
    }

    unawaited(_triggerLoading(setTo: false));
  }
// -----------------------------------------------------------------------------
  String _countryID;
  CountryModel _countryModel;
  CityModel _cityModel;
  Future<void> _getCountryData({
    @required GeoPoint geoPoint
  }) async {

    final ZoneModel _zoneModel = await ZoneProtocols.fetchZoneModelByGeoPoint(
        context: context,
        geoPoint: geoPoint
    );

    if (_zoneModel != null) {

      final CountryModel _country = await ZoneProtocols.fetchCountry(
          countryID: _zoneModel.countryID
      );

      final CityModel _city = await ZoneProtocols.fetchCity(
          cityID: _zoneModel.cityID
      );

      setState(() {
        _countryID = _zoneModel.countryID;
        _countryModel = _country;
        _cityModel = _city;
      });
    }
  }
// -----------------------------------------------------------------------------
  final GlobalKey globalKey = GlobalKey();
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    // final double _screenWidth = Scale.superScreenWidth(context);
    // final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      // loading: _loading,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: Center(
        child: OldMaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            children: <Widget>[

              const Stratosphere(),

              Container(
                color: Colorz.white10,
                child: SearchBar(
                  globalKey: globalKey,
                    appBarType: AppBarType.basic,
                  // onSearchChanged: (String val) async {blog(val);},
                    onSearchSubmit: (String val) async {

                      final CityModel _result = await ZoneProtocols.fetchCityByName(
                          context: context,
                          cityName: val,
                          langCode: 'en'
                      );

                      if (_result != null) {

                        final CountryModel _country = await ZoneProtocols.fetchCountry(
                            countryID: _result.countryID
                        );

                        setState(() {
                          _countryModel = _country;
                          _countryID = _result.countryID;
                          _cityModel = _result;
                        });

                        _result.blogCity();
                      }

                      else {
                        await TopDialog.showTopDialog(
                            context: context,
                            firstVerse: Verse.plain('No city found'),
                        );
                      }

                    },
                    searchIconIsOn: false),
              ),

              FlagBox(
                  size: 50,
                  countryID: _countryID,
              ),

              WideButton(
                verse: Verse.plain('Get Current Location'),
                icon: _countryID == null ?
                Iconz.share
                    :
                Flag.getFlagIcon(_countryID),
                onTap: () async {
                  blog('LET THE GAMES BEGIN');

                  await _getCurrentUserLocation();
                },
              ),

              WideButton(
                verse: Verse.plain('Get Position from Map'),
                icon: _countryID == null ?
                Iconz.share
                    :
                Flag.getFlagIcon(_countryID),
                onTap: () async {
                  blog('LET THE GAMES BEGIN');
                  await _getPositionFromMap();
                },
              ),

              DataStripWithHeadline(
                dataKey: 'geo point',
                dataValue: 'LAT : ${_point?.latitude} : LNG : ${_point?.longitude}',
              ),

              DataStripWithHeadline(
                dataKey: 'ID',
                dataValue: _countryID,
              ),

              DataStripWithHeadline(
                dataKey: 'Country Name (EN)',
                dataValue: xPhrase( context, _countryModel?.id),
              ),

              DataStripWithHeadline(
                dataKey: 'Country Name (AR)',
                dataValue: xPhrase( context, _countryModel?.id),
              ),

              DataStripWithHeadline(
                  dataKey: 'City ID',
                  dataValue: _cityModel?.cityID,
              ),

              DataStripWithHeadline(
                dataKey: 'City Name (EN)',
                dataValue: xPhrase( context, _cityModel?.cityID),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
