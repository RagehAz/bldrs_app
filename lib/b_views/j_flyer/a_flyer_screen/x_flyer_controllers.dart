import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/d_zone/city_model.dart';
import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/district_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// FLYER DATA COMPLETION

// --------------------
/// TASK : TEST ME
Future<BzModel> getFlyerBzModel({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  final BzModel _bzModel = await BzProtocols.fetch(
      context: context,
      bzID: flyerModel?.bzID
  );

  return _bzModel;
}
// --------------------
/// TASK : TEST ME
Future<CountryModel> getFlyerBzCountry({
  @required String countryID,
}) async {

  final CountryModel _country = await ZoneProtocols.fetchCountry(
      countryID: countryID
  );

  return _country;
}
// --------------------
/// TASK : TEST ME
Future<CityModel> getFlyerBzCity({
  @required String cityID,
}) async {

  final CityModel _city = await ZoneProtocols.fetchCity(
      cityID: cityID
  );

  return _city;
}
// --------------------
/// TASK : TEST ME
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
/// TASK : TEST ME
int getNumberOfSlides({
  @required FlyerModel flyerModel,
  @required BzModel bzModel,
  @required String heroPath,
}){
  int _numberOfSlides;

  final bool _canShowGallery = canShowGalleryPage(
    bzModel: bzModel,
    heroPath: heroPath,
  );

  if (_canShowGallery == true){
    _numberOfSlides = flyerModel.slides.length + 1;
  }

  else {
    _numberOfSlides = flyerModel.slides.length;
  }

  blog('getNumberOfSlides : $_numberOfSlides');
  return _numberOfSlides;
}
// --------------------
/// TASK : TEST ME
int getPossibleStartingIndex({
  @required FlyerModel flyerModel,
  @required BzModel bzModel,
  @required String heroTag,
  @required int startFromIndex,
}){

  const int _output = 0;

  // final int _numberOfSlides = getNumberOfSlides(
  //   flyerModel: flyerModel,
  //   bzModel: bzModel,
  //   heroTag: heroTag,
  // );
  //
  //
  // final int _lastIndex = _numberOfSlides - 1;
  //
  // if (startFromIndex > _lastIndex){
  //   _output = 0;
  // }
  //
  // else {
  //   _output = startFromIndex;
  // }


  blog('getPossibleStartingIndex : $_output');
  return _output;
}
// -----------------------------------------------------------------------------

/// HERO

// --------------------
/// TASK : TEST ME
String createFlyerHeroTag({
  @required String flyerID,
  @required String heroPath,
}){
  // ------
  assert(flyerID != null, 'createFlyerHeroTag : flyerID can not be null');
  assert(heroPath != null, 'createFlyerHeroTag : heroPath can not be null');
  // ------
  /// NOTES
  /// - flyer either is at screen level or inside flyer's gallery slide
  /// heroTag = 'screenName/firstFlyerID/galleryFlyerID';
  // ------

  final List<String> _nodes = ChainPathConverter.splitPathNodes(heroPath);

  if (_nodes.length == 1){
    return '$heroPath$flyerID/';
  }

  else if (_nodes.length == 2){
    return '$heroPath$flyerID/';
  }
  else if (_nodes.length == 3){
    return null;
  }
  else {
    return null;
  }


}
// --------------------
/// TASK : TEST ME
bool checkFlyerHeroTagHasGalleryFlyerID(String heroTag){
  bool _has = false;

  if (TextCheck.isEmpty(heroTag) == false){

    final List<String> _nodes = ChainPathConverter.splitPathNodes(heroTag);
    _has = _nodes.length == 3;

  }

  return _has;
}
// --------------------
/*
/// DEPRECATED
Widget flyerFlightShuttle({
  @required BuildContext flightContext,
  @required Animation<double> animation, // 0 to 1
  @required HeroFlightDirection flightDirection,
  @required BuildContext fromHeroContext,
  @required BuildContext toHeroContext,
  @required FlyerModel flyerModel,
  @required BzModel bzModel,
  @required double flyerBoxWidth,
  @required String heroTag,
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

        // final double _flyerWidthFactor = flyerWidthSizeFactor(
        //   tween: value,
        //   minWidthFactor: minWidthFactor,
        //   // maxWidthFactor: 1, REDUNDANT
        // );

        // final double _flyerBoxWidth = FlyerDim.flyerWidthByFactor(flightContext, _flyerWidthFactor);

        final FlightDirection _flightDirection = getFlightDirection(flightDirection.name);

        return Scaffold(
          backgroundColor: Colorz.nothing,
          body: SmallFlyer(
            flyerModel: flyerModel,
            bzModel: bzModel,
            flyerBoxWidth: flyerBoxWidth,
            flightTweenValue: value,
            flightDirection: _flightDirection,
            heroTag: heroTag,
          ),
        );

      }
  );
}
 */
// --------------------
/*
/// DEPRECATED
FlightDirection getFlightDirection(String direction){

  switch(direction){
    case 'push': return FlightDirection.push; break;
    case 'pop' : return FlightDirection.pop; break;
    default: return FlightDirection.non;
  }

}
 */
// -----------------------------------------------------------------------------

/// GALLERY

// --------------------
/// TASK : TEST ME
bool canShowGalleryPage({
  @required BzModel bzModel,
  @required String heroPath,
}){
  bool _canShowGallery = false;
  assert(bzModel != null, 'canShowGalleryPage : BzModel can not be null');

  if (bzModel != null){

    if (Mapper.checkCanLoopList(bzModel.flyersIDs)){

      final bool _bzHasMoreThanOneFlyer = bzModel.flyersIDs.length > 1;

      final bool isGalleryFlyer = checkFlyerHeroTagHasGalleryFlyerID(heroPath);

      if (_bzHasMoreThanOneFlyer == true && isGalleryFlyer == false){

        _canShowGallery = true;

      }

    }

  }

  return _canShowGallery;
}
// --------------------
/// TASK : TEST ME
List<String> getNextFlyersIDs({
  @required List<String> allFlyersIDsWithoutParentFlyerID,
  @required List<String> loadedFlyersIDs,
  @required String heroTag,
  @required FlyerModel flyerModel,
  int numberOfFlyers = 4,
}){

  /// NOTES : GETS ONLY THE NEXT UNLOADED NUMBER OF FLYERS IDS

  final List<String> _nextFlyersIDs = <String>[];

  /// 1 - check each id in all Ids
  /// 2 - if id is already inserted in [loadedFlyersIDs], skip
  /// 3 - if not
  ///   A - if next flyers IDs reach max count [numberOfFlyers] => break
  ///   B - if not : insert that id

  for (int i = 0; i < allFlyersIDsWithoutParentFlyerID.length; i++){

    /// A - WHILE TARGET [numberOfFlyers] NOT YET REACHED
    if (_nextFlyersIDs.length <= numberOfFlyers){

      final String _flyerID = allFlyersIDsWithoutParentFlyerID[i];

      final bool _alreadyLoaded = Stringer.checkStringsContainString(
        strings: loadedFlyersIDs,
        string: _flyerID,
      );

      // final List<String> _parentFlyersIDs = splitHeroTagIntoFlyersIDs(heroPath: heroTag);

      // final bool _alreadyAParentFlyer = Stringer.checkStringsContainString(
      //     strings: _parentFlyersIDs,
      //     string: _flyerID
      // );

      final bool _flyerIsAlreadyActive = _flyerID == flyerModel.id;

      /// B - WHEN ID IS NOT YET LOADED NOR A PARENT
      if (
      _alreadyLoaded == false
          &&
          _flyerIsAlreadyActive == false
          // &&
          // _alreadyAParentFlyer == false
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
/// TASK : TEST ME
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
    allFlyersIDsWithoutParentFlyerID: Stringer.removeStringsFromStrings(
        removeFrom: bzModel.flyersIDs,
        removeThis: [flyerModel.id],
    ),
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
/// TASK : TEST ME
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
/// TASK : TEST ME
Future<void> recordFlyerView({
  @required FlyerModel flyerModel,
  @required int index,
}) async {

    await FlyerRecordRealOps.viewFlyer(
      flyerModel: flyerModel,
      index: index,
    );

}
// -----------------------------------------------------------------------------
