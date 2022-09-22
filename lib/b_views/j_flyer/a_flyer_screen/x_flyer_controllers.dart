import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/a_static_flyer.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/e_db/real/ops/flyer_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// FLYER DATA COMPLETION

// --------------------
Future<BzModel> getFlyerBzModel({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  final BzModel _bzModel = await BzProtocols.fetchBz(
      context: context,
      bzID: flyerModel?.bzID
  );

  return _bzModel;
}
// --------------------
Future<CountryModel> getFlyerBzCountry({
  @required BuildContext context,
  @required String countryID,
}) async {

  final CountryModel _country = await ZoneProtocols.fetchCountry(
      context: context,
      countryID: countryID
  );

  return _country;
}
// --------------------
Future<CityModel> getFlyerBzCity({
  @required BuildContext context,
  @required String cityID,
}) async {

  final CityModel _city = await ZoneProtocols.fetchCity(
      context: context,
      cityID: cityID
  );

  return _city;
}
// --------------------
ZoneModel getZoneModel({
  @required BuildContext context,
  @required String countryID,
  @required CityModel cityModel,
  @required String districtID,
}){

  final String _countryName = CountryModel.translateCountryName(
    context: context,
    countryID: countryID,
  );

  final String _cityName = CityModel.getTranslatedCityNameFromCity(
    context: context,
    city: cityModel,
  );

  final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
    context: context,
    city: cityModel,
    districtID: districtID,
  );

  return ZoneModel(
    countryID: countryID,
    cityID: cityModel.cityID,
    districtID: districtID,
    countryName: _countryName,
    cityName: _cityName,
    districtName: _districtName,
  );

}
// -----------------------------------------------------------------------------

/// SLIDES INDEXING

// --------------------
int getNumberOfSlides({
  @required FlyerModel flyerModel,
  @required BzModel bzModel,
  @required String heroTag,
}){
  int _numberOfSlides;

  final bool _canShowGallery = canShowGalleryPage(
    bzModel: bzModel,
    heroTag: heroTag,
  );

  if (_canShowGallery == true){
    _numberOfSlides = flyerModel.slides.length + 1;
  }

  else {
    _numberOfSlides = flyerModel.slides.length;
  }

  return _numberOfSlides;
}
// --------------------
int getPossibleStartingIndex({
  @required FlyerModel flyerModel,
  @required BzModel bzModel,
  @required String heroTag,
  @required int startFromIndex,
}){

  int _output = 0;

  final int _numberOfSlides = getNumberOfSlides(
    flyerModel: flyerModel,
    bzModel: bzModel,
    heroTag: heroTag,
  );


  final int _lastIndex = _numberOfSlides - 1;

  if (startFromIndex > _lastIndex){
    _output = 0;
  }

  else {
    _output = startFromIndex;
  }


  return _output;
}
// -----------------------------------------------------------------------------

/// HERO

// --------------------
String createHeroTag({
  @required String heroTag,
  @required String flyerID
}){
  String _heroTag;

  if (heroTag == null){
    _heroTag = '${flyerID}_';
  }

  else {
    _heroTag = '$heroTag${flyerID}_';
  }

  return _heroTag;
}
// --------------------
List<String> splitHeroTagIntoFlyersIDs({
  @required String heroTag,
}){
  final List<String> _flyersIDs = heroTag?.split('_');

  List<String> _output = <String>[];

  if (Mapper.checkCanLoopList(_flyersIDs)){
    _output = [..._flyersIDs];
  }

  return _output;
}
// --------------------
Widget flyerFlightShuttle({
  @required BuildContext flightContext,
  @required Animation<double> animation, // 0 to 1
  @required HeroFlightDirection flightDirection,
  @required BuildContext fromHeroContext,
  @required BuildContext toHeroContext,
  @required FlyerModel flyerModel,
  @required BzModel bzModel,
  @required double minWidthFactor,
  @required ValueNotifier<ProgressBarModel> progressBarModel,
  @required Function onSaveFlyer,
  @required ValueNotifier<bool> flyerIsSaved,
}) {

  /*
      final Hero toHero = toHeroContext.widget;
      final double _flyerBoxWidth = FlyerBox.width(fromHeroContext, 1);
      final double _flyerZoneHeight = FlyerBox.height(fromHeroContext, _flyerBoxWidth);
      final double _headerHeight = FlyerBox.headerBoxHeight(
          bzPageIsOn: false,
          flyerBoxWidth: _flyerBoxWidth
      );
      final double _footerHeight = FlyerFooter.boxHeight(
          context: fromHeroContext,
          flyerBoxWidth: _flyerBoxWidth
      );
      final double _flyerSmallWidth = FlyerBox.width(fromHeroContext, 0.4);
      final double _flyerSmallHeight = FlyerBox.height(fromHeroContext, _flyerSmallWidth);
      final double _flyerBigWidth = Scale.superScreenWidth(fromHeroContext);
      final double _flyerBigHeight = FlyerBox.height(fromHeroContext, _flyerBigWidth);
   */

  /// 'push' if expanding --- 'pop' if contracting
  final String _flightDirectionName = flightDirection.name;

  final Curve _curve = _flightDirectionName == 'push' ? Curves.fastOutSlowIn : Curves.fastOutSlowIn.flipped;

  final Tween<double> _tween = _flightDirectionName == 'push' ?
  Tween<double>(begin: 0, end: 1)
      :
  Tween<double>(begin: 1, end: 0);

  return TweenAnimationBuilder(
      key: const ValueKey<String>('FlyerHero_TweenAnimationBuilder'),
      tween: _tween,
      duration: Ratioz.duration150ms,
      curve: _curve,
      builder: (ctx, double value, Widget child){

        final double _flyerWidthFactor = flyerWidthSizeFactor(
          tween: value,
          minWidthFactor: minWidthFactor,
          // maxWidthFactor: 1, REDUNDANT
        );

        final double _flyerBoxWidth = FlyerBox.width(flightContext, _flyerWidthFactor);

        final FlightDirection _flightDirection = getFlightDirection(flightDirection.name);

        return Scaffold(
          backgroundColor: Colorz.nothing,
          body: StaticFlyer(
            flyerModel: flyerModel,
            bzModel: bzModel,
            flyerBoxWidth: _flyerBoxWidth,
            flightTweenValue: value,
            flightDirection: _flightDirection,
            heroTag: 'heroTagInFlight',
          ),
          // body: FlyerTree(
          //   flyerBoxWidth: _flyerBoxWidth,
          //   flyerModel: flyerModel,
          //   bzModel: bzModel,
          //   flyerZone: null,
          //   loading: true,
          //   flightDirection: _flightDirection,
          //   progressBarModel: progressBarModel,
          //   onSaveFlyer: onSaveFlyer,
          //   flyerIsSaved: flyerIsSaved,
          // ),
        );

      }
  );
}
// --------------------
FlightDirection getFlightDirection(String direction){

  switch(direction){
    case 'push': return FlightDirection.push; break;
    case 'pop' : return FlightDirection.pop; break;
    default: return FlightDirection.non;
  }

}


// -----------------------------------------------------------------------------

/// GALLERY

// --------------------
/// TESTED : WORKS PERFECT
bool canShowGalleryPage({
  @required BzModel bzModel,
  @required String heroTag,
}){
  bool _canShowGallery = false;
  assert(bzModel != null, 'canShowGalleryPage : BzModel can not be null');

  if (bzModel != null){

    if (Mapper.checkCanLoopList(bzModel.flyersIDs)){

      /// only CAN SHOW : WHEN BZ FLYERS ARE MORE THAN THE SHOWN FLYER
      final bool _bzHasMoreThanOneFlyer = bzModel.flyersIDs.length > 1;

      /// & only CAN SHOW : WHEN HERO TAG CONTAINS MORE THAN 1 FLYER ID
      final List<String> _heroFlyersIDs = splitHeroTagIntoFlyersIDs(heroTag: heroTag);
      final bool _heroTagHasMoreThanOneFlyerID = _heroFlyersIDs.isNotEmpty;

      /// & only CAN SHOW : WHEN HERO TAG HAS LESS THAN 3 FLYERS IDS
      final bool _heroTagHasLessThanThreeFlyersIDs = _heroFlyersIDs.length < 2;

      /// so :-
      if (_bzHasMoreThanOneFlyer == true){

        if (_heroTagHasMoreThanOneFlyerID == true){

          if (_heroTagHasLessThanThreeFlyersIDs == true){

            _canShowGallery = true;

          }

        }

      }

    }

  }

  return _canShowGallery;
}
// --------------------
/// GETS ONLY THE NEXT UNLOADED NUMBER OF FLYERS IDS
List<String> getNextFlyersIDs({
  @required List<String> allFlyersIDs,
  @required List<String> loadedFlyersIDs,
  @required String heroTag,
  @required FlyerModel flyerModel,
  int numberOfFlyers = 4,
}){
  final List<String> _nextFlyersIDs = <String>[];

  /// 1 - check each id in all Ids
  /// 2 - if id is already inserted in [loadedFlyersIDs], skip
  /// 3 - if not
  ///   A - if next flyers IDs reach max count [numberOfFlyers] => break
  ///   B - if not : insert that id

  for (int i = 0; i < allFlyersIDs.length; i++){

    /// A - WHILE TARGET [numberOfFlyers] NOT YET REACHED
    if (_nextFlyersIDs.length <= numberOfFlyers){

      final String _flyerID = allFlyersIDs[i];

      final bool _alreadyLoaded = Stringer.checkStringsContainString(
        strings: loadedFlyersIDs,
        string: _flyerID,
      );

      final List<String> _parentFlyersIDs = splitHeroTagIntoFlyersIDs(heroTag: heroTag);

      final bool _alreadyAParentFlyer = Stringer.checkStringsContainString(
          strings: _parentFlyersIDs,
          string: _flyerID
      );

      final bool _flyerIsAlreadyActive = _flyerID == flyerModel.id;

      /// B - WHEN ID IS NOT YET LOADED NOR A PARENT
      if (
      _alreadyLoaded == false
          &&
          _flyerIsAlreadyActive == false
          &&
          _alreadyAParentFlyer == false
      ){
        /// do nothing and go next
        _nextFlyersIDs.add(_flyerID);
      }

      /// B - WHEN ID IS ALREADY LOADED
      // else {
      /// do nothing
      // }

    }

    /// A - WHEN TARGET [numberOfFlyers] IS REACHED
    else {
      break;
    }

  }

  return _nextFlyersIDs;
}
// --------------------
Future<List<FlyerModel>> fetchMoreFlyers({
  @required BuildContext context,
  @required List<FlyerModel> loadedFlyers,
  @required FlyerModel flyerModel,
  @required String heroTag,
  @required BzModel bzModel,
}) async {

  final List<String> _loadedFlyersIDs = FlyerModel.getFlyersIDsFromFlyers(loadedFlyers);

  final List<String> _nextFlyersIDs = getNextFlyersIDs(
    flyerModel: flyerModel,
    heroTag: heroTag,
    allFlyersIDs: bzModel.flyersIDs,
    loadedFlyersIDs: _loadedFlyersIDs,
    // numberOfFlyers: 4
  );

  final List<FlyerModel> _moreFlyers = await FlyerProtocols.fetchFlyers(
    context:  context,
    flyersIDs: _nextFlyersIDs,
  );

  return _moreFlyers;
}
// -----------------------------------------------------------------------------

/// SIZING

// --------------------
double flyerWidthSizeFactor({
  @required double tween,
  /// min flyer width factor * screen width = minimum flyer width
  @required double minWidthFactor,
  /// max flyer width factor * screen width = max flyer width
  double maxWidthFactor = 1,
}) {
  /// EW3AAA
  final double _flyerWidthSizeFactor =
      minWidthFactor + (tween * (maxWidthFactor - minWidthFactor));
  return _flyerWidthSizeFactor;
}
// --------------------
Future<void> recordFlyerView({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required int index,
}) async {

  if (AuthModel.userIsSignedIn() == true){
    await FlyerRecordRealOps.viewFlyer(
      context: context,
      flyerModel: flyerModel,
      index: index,
    );

  }

}
// -----------------------------------------------------------------------------
