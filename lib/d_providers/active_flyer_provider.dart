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

    setActiveFlyerBzCountryAndCity(
      bzCountry: _bzCountry,
      bzCity: _bzCity,
      notify: notify,
    );

  }
// -------------------------------------
  void setActiveFlyerBzCountryAndCity({
    @required CountryModel bzCountry,
    @required CityModel bzCity,
    @required bool notify,
  }){
    _activeFlyerBzCountry = bzCountry;
    _activeFlyerBzCity = bzCity;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

  /// FOLLOW IS ON

// -------------------------------------
  bool _followIsOn = false;
// -------------------------------------
  bool get followIsOn => _followIsOn;
// -------------------------------------
  void setFollowIsOn({@required bool setFollowIsOnTo, @required bool notify}){
    _followIsOn = setFollowIsOnTo;
    _notify(notify);
  }
// -------------------------------------
  Future<void> getSetFollowIsOn({
    @required BuildContext context,
    @required String bzID,
    @required bool notify
  }) async {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final bool _isOn = _bzzProvider.checkFollow(
      context: context,
      bzID: bzID,
    );

    setFollowIsOn(
        setFollowIsOnTo: _isOn,
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
  void setCurrentSlideIndex({
    @required int setIndexTo,
    @required bool notify
  }){
    _currentSlideIndex = setIndexTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

  /// PROGRESS BAR OPACITY

// -------------------------------------
  int _progressBarOpacity = 0;
// -------------------------------------
  int get progressBarOpacity => _progressBarOpacity;
// -------------------------------------
  void setProgressBarOpacity({
    @required int setOpacityTo,
    bool notify = true
  }){
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
  void setHeaderIsExpanded({
    @required bool setHeaderIsExpandedTo,
    @required bool notify,
  }){
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
  void setHeaderPageOpacity({@required int setOpacityTo, @required bool notify}){
    _headerPageOpacity = setOpacityTo;
    _notify(notify);
  }
// -----------------------------------------------------------------------------

}
