import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/pathing.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:fire/super_fire.dart';

// -----------------------------------------------------------------------------

/// FLYER DATA COMPLETION

// --------------------
/// DEPRECATED
/*
Future<BzModel> getFlyerBzModel({
  required BuildContext context,
  required FlyerModel flyerModel,
}) async {

  final BzModel? _bzModel = await BzProtocols.fetchBz(
      context: context,
      bzID: flyerModel?.bzID
  );

  return _bzModel;
}
 */
// --------------------
/// DEPRECATED
/*
Future<CountryModel> getFlyerBzCountry({
  required String countryID,
}) async {

  final CountryModel _country = await ZoneProtocols.fetchCountry(
      countryID: countryID
  );

  return _country;
}
 */
// --------------------
/// DEPRECATED
/*
Future<CityModel> getFlyerBzCity({
  required String cityID,
}) async {
  final CityModel _city = await ZoneProtocols.fetchCity(cityID: cityID,);
  return _city;
}
 */
// -----------------------------------------------------------------------------

/// SLIDES INDEXING

// --------------------
/// TESTED : WORKS PERFECT
int getNumberOfSlides({
  required FlyerModel? flyerModel,
  required BzModel? bzModel,
  // required String heroPath,
  required bool showGallerySlide,
}){
  int _numberOfSlides;

  final bool _canShowGallery = canShowGalleryPage(
    bzModel: bzModel,
    // heroPath: heroPath,
    canShowGallerySlide: showGallerySlide,
  );

  if (_canShowGallery == true){
    _numberOfSlides = (flyerModel?.slides?.length??0) + 1;
  }

  else {
    _numberOfSlides = flyerModel?.slides?.length ?? 0;
  }

  // blog('getNumberOfSlides : $_numberOfSlides');
  return _numberOfSlides;
}
// --------------------
/// TESTED : WORKS PERFECT
int getPossibleStartingIndex({
  required FlyerModel? flyerModel,
  required BzModel? bzModel,
  required String heroTag,
  required int startFromIndex,
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


  // blog('getPossibleStartingIndex : $_output');
  return _output;
}

bool isAtGallerySlide({
  required FlyerModel? flyerModel,
  required BzModel? bzModel,
  required bool showGallerySlide,
  required ProgressBarModel? progressBarModel,
}){
  bool _output = false;

  if (progressBarModel != null){

    final bool _canShowGallery = canShowGalleryPage(
      bzModel: bzModel,
      // heroPath: heroPath,
      canShowGallerySlide: showGallerySlide,
    );

    if (_canShowGallery == true) {
      final int _numberOfSlides = getNumberOfSlides(
        bzModel: bzModel,
        flyerModel: flyerModel,
        showGallerySlide: showGallerySlide,
      );

      if (progressBarModel.index + 1 == _numberOfSlides) {
        _output = true;
      }
    }

  }

  return _output;
}
// -----------------------------------------------------------------------------

/// HERO

// --------------------
/// TESTED : WORKS PERFECT
String? createFlyerHeroTag({
  required String flyerID,
  required String heroPath,
}){
  // ------
  // assert(flyerID != null, 'createFlyerHeroTag : flyerID can not be null');
  // assert(heroPath != null, 'createFlyerHeroTag : heroPath can not be null');
  // ------
  /// NOTES
  /// - flyer either is at screen level or inside flyer's gallery slide
  /// heroTag = 'screenName/firstFlyerID/galleryFlyerID';
  // ------

  final List<String> _nodes = Pathing.splitPathNodes(heroPath);

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
/// TESTED : WORKS PERFECT
bool checkFlyerHeroTagHasGalleryFlyerID(String heroTag){
  bool _has = false;

  if (TextCheck.isEmpty(heroTag) == false){

    final List<String> _nodes = Pathing.splitPathNodes(heroTag);
    _has = _nodes.length == 2;

  }

  return _has;
}
// --------------------
/// DEPRECATED
/*
/// DEPRECATED
Widget flyerFlightShuttle({
  required BuildContext flightContext,
  required Animation<double> animation, // 0 to 1
  required HeroFlightDirection flightDirection,
  required BuildContext fromHeroContext,
  required BuildContext toHeroContext,
  required FlyerModel flyerModel,
  required BzModel bzModel,
  required double flyerBoxWidth,
  required String heroTag,
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
/// DEPRECATED
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
/// TESTED : WORKS PERFECT
bool canShowGalleryPage({
  required BzModel? bzModel,
  // required String heroPath,
  required bool canShowGallerySlide,
}){
  bool _canShowGallery = false;
  // assert(bzModel != null, 'canShowGalleryPage : BzModel can not be null');

  if (canShowGallerySlide == true){
    // if (bzModel != null){

      if (Lister.checkCanLoop(bzModel?.publication.published) == true){

        final bool _bzHasMoreThanOneFlyer = (bzModel?.publication.published.length ?? 0) > 1;

        // final bool isGalleryFlyer = checkFlyerHeroTagHasGalleryFlyerID(heroPath);

        if (_bzHasMoreThanOneFlyer == true){

          _canShowGallery = true;

        }

      }

    // }
  }

  // blog('canShowGallerySlide : $_canShowGallery : bzModel != null : ${bzModel != null}');

  return _canShowGallery;
}
// --------------------
/// TESTED : WORKS PERFECT
List<String> getNextFlyersIDs({
  required List<String> allFlyersIDsWithoutParentFlyerID,
  required List<String> loadedFlyersIDs,
  required String heroTag,
  required FlyerModel flyerModel,
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
/// TESTED : WORKS PERFECT
Future<List<FlyerModel>> fetchMoreFlyers({
  required List<FlyerModel> loadedFlyers,
  required FlyerModel flyerModel,
  required String heroTag,
  required BzModel bzModel,
}) async {

  final List<String> _loadedFlyersIDs = FlyerModel.getFlyersIDsFromFlyers(loadedFlyers);

  final List<String> _nextFlyersIDs = getNextFlyersIDs(
    flyerModel: flyerModel,
    heroTag: heroTag,
    allFlyersIDsWithoutParentFlyerID: Stringer.removeStringsFromStrings(
        removeFrom: bzModel.publication.published,
        removeThis: flyerModel.id == null ? [] : [flyerModel.id!],
    ),
    loadedFlyersIDs: _loadedFlyersIDs,
    // numberOfFlyers: 4
  );

  final List<FlyerModel> _moreFlyers = await FlyerProtocols.fetchFlyers(
    flyersIDs: _nextFlyersIDs,
  );

  return _moreFlyers;
}
// -----------------------------------------------------------------------------

/// SIZING

// --------------------
/// TESTED : WORKS PERFECT
double flyerWidthSizeFactor({
  required double tween,
  /// min flyer width factor * screen width = minimum flyer width
  required double minWidthFactor,
  /// max flyer width factor * screen width = max flyer width
  double maxWidthFactor = 1,
}) {
  /// EW3AAA
  final double _flyerWidthSizeFactor =
      minWidthFactor + (tween * (maxWidthFactor - minWidthFactor));
  return _flyerWidthSizeFactor;
}
// -----------------------------------------------------------------------------

/// VIEW SLIDE

// --------------------
/// TASK : TEST ME
Future<void> recordFlyerView({
  required FlyerModel? flyerModel,
  required int index,
}) async {

  /// ANONYMOUS VIEWS ARE COUNTED
  if (Authing.userHasID() == true) {

    await RecorderProtocols.onViewSlide(
      flyerID: flyerModel?.id,
      bzID: flyerModel?.bzID,
      index: index,
    );

  }

}
// -----------------------------------------------------------------------------
