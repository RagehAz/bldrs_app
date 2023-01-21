import 'dart:async';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/c_protocols/zone_protocols/positioning_protocols/geo_location/location_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:numeric/numeric.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:bldrs/f_helpers/router/navigators.dart';
// import 'package:bldrs/x_dashboard/zones_manager/location_test/google_map_screen.dart';

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
  final GlobalKey globalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  // --------------------
  GeoPoint _point;
  // --------------------
  String _countryID;
  // CountryModel _countryModel;
  CityModel _cityModel;
  // --------------------
  /// List<int> _list = <int>[1,2,3,4,5,6,7,8];
  /// int _loops = 0;
  /// Color _color = Colorz.BloodTest;
  /// SuperFlyer _flyer;
  /// bool _thing;
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
  }
  // --------------------
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
  // --------------------
  @override
  void dispose() {
    _scrollController.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _getCurrentUserLocation() async {

    unawaited(_triggerLoading(setTo: true));

    await tryAndCatch(
        invoker: 'get location thing',
        functions: () async {
          blog('getting location aho');

          final Position _position = await LocationOps.getCurrentPosition();

          if (_position != null){

            blog('got position = $_position');

            final GeoPoint _geoPoint = GeoPoint(_position?.latitude, _position?.longitude);

            blog('made geo point aho $_geoPoint');

            setState(() {
              _point = _geoPoint;
            });

            blog('getting place marks');

            await _getCountryData(geoPoint: _geoPoint);

          }

        },
        onError: (String e) {
          blog('ERROR IS : $e');
        });

    unawaited(_triggerLoading(setTo: false));
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _getPositionFromMap() async {

    unawaited(_triggerLoading(setTo: true));

    // final GeoPoint _pickedPoint = await Nav.goToNewScreen(
    //     context: context,
    //     screen: const GoogleMapScreen(
    //       isSelecting: true,
    //     )
    // );
    //
    // if (_pickedPoint != null) {
    //   setState(() {
    //     _point = _pickedPoint;
    //   });
    //
    //   await _getCountryData(geoPoint: _point);
    // }

    unawaited(_triggerLoading(setTo: false));
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _getCountryData({
    @required GeoPoint geoPoint
  }) async {

    final ZoneModel _zoneModel = await ZoneProtocols.fetchZoneModelByGeoPoint(
        context: context,
        geoPoint: geoPoint
    );

    if (_zoneModel != null) {

      // final CountryModel _country = await ZoneProtocols.fetchCountry(
      //     countryID: _zoneModel.countryID
      // );

      final CityModel _city = await ZoneProtocols.fetchCity(
        cityID: _zoneModel.cityID,
      );

      setState(() {
        _countryID = _zoneModel.countryID;
        // _countryModel = _country;
        _cityModel = _city;
      });
    }
  }
  // --------------------
  ///
  Future<void> _onSearch(String text) async {

    //
    // final CityModel _result = await ZoneProtocols.fetchCityByName(
    //     context: context,
    //     cityName: val,
    //     langCode: 'en',
    //   countryID: _countryID
    // );
    //
    // if (_result != null) {
    //
    //   final String _cityCountryID = _result.getCountryID();
    //
    //   final CountryModel _country = await ZoneProtocols.fetchCountry(
    //       countryID: _cityCountryID,
    //   );
    //
    //   setState(() {
    //     _countryModel = _country;
    //     _countryID = _cityCountryID;
    //     _cityModel = _result;
    //   });
    //
    //   _result.blogCity();
    // }
    //
    // else {
    //   await TopDialog.showTopDialog(
    //       context: context,
    //       firstVerse: Verse.plain('No city found'),
    //   );
    // }

  }
  // --------------------
  ///
  Future<void> _onSearchCancelled() async {

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchZoneByIP() async {

    final ZoneModel _zone = await ZoneProtocols.getZoneByIP(
        context: context,
    );

    blog('done');
    _zone?.blogZone();

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.search,
      pyramidsAreOn: true,
      // loading: _loading,
      onSearchSubmit: _onSearch,
      onSearchChanged: _onSearch,
      onSearchCancelled: _onSearchCancelled,
      searchHintVerse: Verse.plain('Search Planet Earth'),
      searchController: _searchController,

      appBarRowWidgets: <Widget>[

        const Expander(),

        /// SELECTED COUNTRY
        FlagBox(
          size: 40,
          countryID: _countryID,
        ),

        const SizedBox(width: 5),

      ],
      child: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
            controller: _scrollController,
            children: <Widget>[

              /// GET CURRENT LOCATION
              WideButton(
                verse: Verse.plain('Get Current Location'),
                icon: _countryID == null ?
                Iconz.share
                    :
                Flag.getCountryIcon(_countryID),
                onTap: () async {
                  blog('LET THE GAMES BEGIN');

                  await _getCurrentUserLocation();
                },
              ),

              /// GET POSITION FROM MAP
              WideButton(
                verse: Verse.plain('Get Position from Map'),
                icon: _countryID == null ?
                Iconz.share
                    :
                Flag.getCountryIcon(_countryID),
                onTap: () async {
                  blog('LET THE GAMES BEGIN');
                  await _getPositionFromMap();
                },
              ),

              /// SEARCH ZONE BY IP
              WideButton(
                verse: Verse.plain('Search zone by IP'),
                icon: Iconz.redAlert,
                onTap: _onSearchZoneByIP,
              ),

              /// GEO POINT
              DataStrip(
                height: 30,
                withHeadline: true,
                dataKey: 'GeoPoint',
                dataValue: 'LAT : ${Numeric.roundFractions(_point?.latitude, 2)} : LNG : ${Numeric.roundFractions(_point?.longitude, 2)}',
              ),

              /// COUNTRY ID
              DataStrip(
                height: 30,
                withHeadline: true,
                dataKey: 'countryID',
                dataValue: _countryID,
              ),

              /// COUNTRY NAME EN
              DataStrip(
                height: 30,
                withHeadline: true,
                dataKey: 'Country Name (EN)',
                dataValue: ZoneProtocols.translateCountry(
                  context: context,
                  countryID: _countryID,
                  langCode: 'en',
                )?.text,
              ),

              /// COUNTRY NAME AR
              DataStrip(
                height: 30,
                withHeadline: true,
                dataKey: 'Country Name (AR)',
                dataValue: ZoneProtocols.translateCountry(
                  context: context,
                  countryID: _countryID,
                  langCode: 'ar',
                )?.text,
              ),

              /// CITY ID
              DataStrip(
                height: 30,
                withHeadline: true,
                  dataKey: 'City ID',
                  dataValue: _cityModel?.cityID,
              ),

              /// CITY NAME EN
              DataStrip(
                height: 30,
                withHeadline: true,
                dataKey: 'City Name (EN)',
                dataValue: ZoneProtocols.translateCity(
                  context: context,
                  cityModel: _cityModel,
                  langCode: 'en',
                )?.text,
              ),

            ],
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
