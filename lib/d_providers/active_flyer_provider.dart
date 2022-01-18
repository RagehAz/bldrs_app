import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// THIS CONTROLLERS ACTIVE FLYER STATES
// final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
class ActiveFlyerProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// NOTIFIER
  void _notify(bool notify){
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// ACTIVE FLYER BZ MODEL

// -------------------------------------
  BzModel _activeFlyerBzModel;
// -------------------------------------
  BzModel get activeFlyerBzModel => _activeFlyerBzModel;
// -------------------------------------
  Future<void> getSetActiveFlyerBzModel({
    @required BuildContext context,
    @required String bzID,
    bool notify,
  }) async {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final BzModel _bzModel = await _bzzProvider.fetchBzModel(context: context, bzID: bzID);

    _activeFlyerBzModel = _bzModel;
    _notify(notify);

  }
// -----------------------------------------------------------------------------

  /// ACTIVE FLYER BZ COUNTRY AND CITY

// -------------------------------------
  CountryModel _activeFlyerBzCountry;
  CityModel _activeFlyerBzCity;
// -------------------------------------
  CountryModel get activeFlyerBzCountry => _activeFlyerBzCountry;
  CityModel get activeFlyerBzCity => _activeFlyerBzCity;
// -------------------------------------
  Future<void> getSetActiveFlyerBzCountryAndCity({
    @required BuildContext context,
    @required String countryID,
    @required String cityID,
    bool notify,
  }) async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(
        context: context,
        countryID: countryID
    );
    final CityModel _bzCity = await _zoneProvider.fetchCityByID(
        context: context,
        cityID: cityID,
    );

    _activeFlyerBzCountry = _bzCountry;
    _activeFlyerBzCity = _bzCity;
    _notify(notify);

  }
// -----------------------------------------------------------------------------

  /// FOLLOW IS ON

// -------------------------------------
  bool _followIsOn = false;
// -------------------------------------
  bool get followIsOn => _followIsOn;
// -------------------------------------
  void setFollowIsOn({@required bool setFollowIsOnTo, bool notify}){

    _notify(notify);
  }

  Future<void> getSetFollowIsOn({bool notify}) async {


    setFollowIsOn(
        setFollowIsOnTo: _followIsOn,
        notify: notify,
    );

  }
// -----------------------------------------------------------------------------

  /// CURRENT SLIDE INDEX

// -------------------------------------
  int _currentSlideIndex = 0;
// -------------------------------------
  int get currentSlideIndex => _currentSlideIndex;
// -------------------------------------
  void setCurrentSlideIndex({@required int setIndexTo, bool notify = true}){
    _currentSlideIndex = setIndexTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

/// PROGRESS BAR OPACITY

// -------------------------------------
  int _progressBarOpacity = 1;
// -------------------------------------
  int get progressBarOpacity => _progressBarOpacity;
// -------------------------------------
  void setProgressBarOpacity({@required int setOpacityTo, bool notify = true}){
    _progressBarOpacity = setOpacityTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

/// HEADER IS EXPANDED

// -------------------------------------
  bool _headerIsExpanded = false;
// -------------------------------------
  bool get headerIsExpanded => _headerIsExpanded;
// -------------------------------------
  void setHeaderIsExpanded({@required bool setHeaderIsExpandedTo, bool notify = true}){
    _headerIsExpanded = setHeaderIsExpandedTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

/// HEADER PAGE OPACITY

// -------------------------------------
  int _headerPageOpacity = 0;
// -------------------------------------
  int get headerPageOpacity => _headerPageOpacity;
// -------------------------------------
  void setHeaderPageOpacity({@required int setOpacityTo, bool notify = true}){
    _headerPageOpacity = setOpacityTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

}
