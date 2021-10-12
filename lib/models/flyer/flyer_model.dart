import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/sub/spec_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class FlyerModel with ChangeNotifier{
  final String flyerID;
  // -------------------------
  final FlyerType flyerType;
  final FlyerState flyerState;
  final List<String> keywordsIDs;
  final bool flyerShowsAuthor;
  final Zone flyerZone;
  // -------------------------
  final TinyUser tinyAuthor;
  final TinyBz tinyBz;
  // -------------------------
  final DateTime createdAt;
  final GeoPoint flyerPosition;
  // -------------------------
  bool ankhIsOn;
  // -------------------------
  final List<SlideModel> slides; // TASK : only 10 max slides per flyer
  // -------------------------
  final bool flyerIsBanned;
  final DateTime deletionTime;
  final List<Spec> specs;
  final String info;
  final List<PublishTime> times;
  final bool priceTagIsOn;

  FlyerModel({
    this.flyerID,
    // -------------------------
    this.flyerType,
    this.flyerState = FlyerState.Draft,
    this.keywordsIDs,
    this.flyerShowsAuthor = false,
    this.flyerZone,
    // -------------------------
    this.tinyAuthor,
    this.tinyBz,
    // -------------------------
    this.createdAt,
    this.flyerPosition,
    // -------------------------
    this.ankhIsOn,
    // -------------------------
    this.slides,
    // -------------------------
    this.flyerIsBanned,
    this.deletionTime, /// TASK : delete this
    this.specs,
    @required this.info,
    this.times,
    @required this.priceTagIsOn,
  });
// -----------------------------------------------------------------------------
  void toggleAnkh(){
    ankhIsOn = !ankhIsOn;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){
    return {
      'flyerID' : flyerID,
      // -------------------------
      'flyerType' : FlyerTypeClass.cipherFlyerType(flyerType),
      'flyerState' : cipherFlyerState(flyerState),
      'keywordsIDs' : keywordsIDs,
      'flyerShowsAuthor' : flyerShowsAuthor,
      'flyerZone' : flyerZone.toMap(),
      // -------------------------
      'tinyAuthor' : tinyAuthor.toMap(),
      'tinyBz' : tinyBz.toMap(),
      // -------------------------
      'createdAt' : Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'flyerPosition' : Atlas.cipherGeoPoint(point: flyerPosition, toJSON: toJSON),
      // -------------------------
      'ankhIsOn' : ankhIsOn,
      // -------------------------
      'slides' : SlideModel.cipherSlidesModels(slides),
      // -------------------------
      'flyerIsBanned' : flyerIsBanned,
      'deletionTime' : Timers.cipherTime(time: deletionTime, toJSON: toJSON),
      'specs' : Spec.cipherSpecs(specs),
      'info' : info,
      'priceTagIsOn' : priceTagIsOn,
    };
  }
// -----------------------------------------------------------------------------
  static FlyerModel decipherFlyer({@required dynamic map, @required bool fromJSON}){
    FlyerModel _flyerModel;
    if (map != null){
      _flyerModel = FlyerModel(
        flyerID: map['flyerID'],
        // -------------------------
        flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
        flyerState: FlyerModel.decipherFlyerState(map['flyerState']),
        keywordsIDs: Mapper.getStringsFromDynamics(dynamics: map['keywordsIDs']),
        flyerShowsAuthor: map['flyerShowsAuthor'],
        flyerZone: Zone.decipherZoneMap(map['flyerZone']),
        // -------------------------
        tinyAuthor: TinyUser.decipherTinyUserMap(map['tinyAuthor']),
        tinyBz: TinyBz.decipherTinyBzMap(map['tinyBz']),
        // -------------------------
        createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        flyerPosition: Atlas.decipherGeoPoint(point: map['flyerPosition'], fromJSON: fromJSON),
        // -------------------------
        slides: SlideModel.decipherSlidesMaps(map['slides']),
        // -------------------------
        flyerIsBanned: map['flyerIsBanned'],
        deletionTime: Timers.decipherTime(time: map['deletionTime'], fromJSON: fromJSON),
        specs: Spec.decipherSpecs(map['specs']),
        info: map['info'],
        priceTagIsOn: map['priceTagIsOn'],
      );

    }
    return _flyerModel;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, Object>> cipherFlyers({@required List<FlyerModel> flyers, @required bool toJSON}){
    final List<Map<String, Object>> _maps = <Map<String, Object>>[];

    for (FlyerModel flyer in flyers){

      final Map<String, Object> _flyerMap = flyer.toMap(toJSON: toJSON);

      _maps.add(_flyerMap);

    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static List<FlyerModel> decipherFlyers({@required List<dynamic> maps, @required bool fromJSON}){
    final List<FlyerModel> _flyersList = <FlyerModel>[];

    if (maps != null && maps.isNotEmpty){

      maps?.forEach((map) {
        _flyersList.add(decipherFlyer(
          map: map,
          fromJSON: fromJSON,
        ));
      });


    }

    return _flyersList;
  }
// -----------------------------------------------------------------------------
  FlyerModel clone(){
    return new FlyerModel(
      flyerID: flyerID,
      flyerType: flyerType,
      flyerState: flyerState,
      keywordsIDs: Mapper.cloneListOfStrings(keywordsIDs),
      flyerShowsAuthor: flyerShowsAuthor,
      flyerZone: flyerZone,
      tinyAuthor: tinyAuthor.clone(),
      tinyBz: tinyBz.clone(),
      createdAt: createdAt,
      flyerPosition: flyerPosition,
      slides: SlideModel.cloneSlides(slides),
      flyerIsBanned: flyerIsBanned,
      deletionTime: deletionTime,
      ankhIsOn: ankhIsOn,
      specs: Spec.cloneSpecs(specs),
      info: info,
      priceTagIsOn: priceTagIsOn,
      // times:
    );
  }
// -----------------------------------------------------------------------------
  static FlyerModel replaceSlides(FlyerModel flyer, List<SlideModel> updatedSlides){
    return
        FlyerModel(
          flyerID: flyer.flyerID,
          flyerType: flyer.flyerType,
          flyerState: flyer.flyerState,
          keywordsIDs: flyer.keywordsIDs,
          flyerShowsAuthor: flyer.flyerShowsAuthor,
          flyerZone: flyer.flyerZone,
          tinyAuthor: flyer.tinyAuthor,
          tinyBz: flyer.tinyBz,
          createdAt: flyer.createdAt,
          flyerPosition: flyer.flyerPosition,
          slides: updatedSlides,
          flyerIsBanned: flyer.flyerIsBanned,
          deletionTime: flyer.deletionTime,
          ankhIsOn: flyer.ankhIsOn,
          specs: flyer.specs,
          info: flyer.info,
          priceTagIsOn: flyer.priceTagIsOn,
          // times:
    );
  }
// -----------------------------------------------------------------------------
  static FlyerState decipherFlyerState (int x){
    switch (x){
      case 1:   return  FlyerState.Published;     break;
      case 2:   return  FlyerState.Draft;         break;
      case 3:   return  FlyerState.Deleted;       break;
      case 4:   return  FlyerState.Unpublished;   break;
      case 5:   return  FlyerState.Banned;        break;
      case 6:   return  FlyerState.Verified;      break;
      case 7:   return  FlyerState.Suspended;     break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherFlyerState (FlyerState x){
    switch (x){
      case FlyerState.Published     :     return  1;  break;
      case FlyerState.Draft         :     return  2;  break;
      case FlyerState.Deleted       :     return  3;  break;
      case FlyerState.Unpublished   :     return  4;  break;
      case FlyerState.Banned        :     return  5;  break;
      case FlyerState.Verified      :     return  6;  break;
      case FlyerState.Suspended     :     return  7;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfFlyerIDsFromFlyers(List<FlyerModel> flyers){
    final List<String> _flyerIDs = <String>[];

    flyers.forEach((flyer) {
      _flyerIDs.add(flyer.flyerID);
    });

    return _flyerIDs;
  }
// -----------------------------------------------------------------------------
  static FlyerModel replaceFlyerSlidesWithNewSlides(FlyerModel inputFlyerModel, List<SlideModel> updatedSlides){
    return FlyerModel(
      flyerID: inputFlyerModel.flyerID,
      flyerType: inputFlyerModel.flyerType,
      flyerZone: inputFlyerModel.flyerZone,
      tinyAuthor: inputFlyerModel.tinyAuthor,
      tinyBz: inputFlyerModel.tinyBz,
      createdAt: inputFlyerModel.createdAt,
      slides: updatedSlides,
      flyerShowsAuthor: inputFlyerModel.flyerShowsAuthor,
      flyerState: inputFlyerModel.flyerState,
      keywordsIDs: inputFlyerModel.keywordsIDs,
      flyerPosition: inputFlyerModel.flyerPosition,
      ankhIsOn: inputFlyerModel.ankhIsOn,
      flyerIsBanned: inputFlyerModel.flyerIsBanned,
      deletionTime: inputFlyerModel.deletionTime,
      specs: inputFlyerModel.specs,
      info: inputFlyerModel.info,
        priceTagIsOn: inputFlyerModel.priceTagIsOn,
    );
  }
// -----------------------------------------------------------------------------
  static const List<FlyerState> flyerStatesList = const <FlyerState>[
    FlyerState.Published,
    FlyerState.Draft,
    FlyerState.Deleted,
    FlyerState.Unpublished,
    FlyerState.Banned,
    FlyerState.Verified,
    FlyerState.Suspended,
  ];
// -----------------------------------------------------------------------------
  /// TASK : why ?
  static int getNumberOfFlyersFromBzzModels(List<BzModel> bzzModels){
    int _totalFlyers = 0;
    bzzModels.forEach((bzModel) {
      _totalFlyers = _totalFlyers + (bzModel.flyersIDs.length);
    });
    return _totalFlyers;
  }
// -----------------------------------------------------------------------------
  static int getTotalSaves(FlyerModel flyer){
    int _totalSaves = 0;

    if (flyer != null && flyer?.slides != null && flyer?.slides?.length !=0){

      flyer.slides.forEach((slide) {
        _totalSaves = _totalSaves + slide.savesCount;
      });

    }
    return _totalSaves;
  }
// -----------------------------------------------------------------------------
  static int getTotalShares(FlyerModel flyer){
    int _totalShares = 0;

    if (flyer != null && flyer?.slides != null && flyer?.slides?.length !=0){

      flyer.slides.forEach((slide) {
        _totalShares = _totalShares + slide.sharesCount;
      });

    }
    return _totalShares;
  }
// -----------------------------------------------------------------------------
  static int getTotalViews(FlyerModel flyer){
    int _totalViews = 0;

    if (flyer != null && flyer?.slides != null && flyer?.slides?.length !=0){

      flyer.slides.forEach((slide) {
        _totalViews = _totalViews + slide.viewsCount;
      });

    }
    return _totalViews;
  }
// -----------------------------------------------------------------------------
  static bool canFlyerShowAuthor({BzModel bzModel}){
    bool _canShow = true;

    if(bzModel.bzShowsTeam == true){
      _canShow = true;
    }
    else {
      _canShow = false;
    }
    return _canShow;
  }
// -----------------------------------------------------------------------------
  static List<TextEditingController> createHeadlinesControllersForExistingFlyer(FlyerModel flyerModel){
  final List<TextEditingController> _controllers = <TextEditingController>[];

  flyerModel.slides.forEach((slide) {
    TextEditingController _controller = new TextEditingController(text: slide.headline);
    _controllers.add(_controller);
  });

  return _controllers;
}
// -----------------------------------------------------------------------------
  static List<TextEditingController> createDescriptionsControllersForExistingFlyer(FlyerModel flyerModel){
    final List<TextEditingController> _controllers = <TextEditingController>[];

    flyerModel.slides.forEach((slide) {
      TextEditingController _controller = new TextEditingController(text: slide.description);
      _controllers.add(_controller);
    });

    return _controllers;
  }
// -----------------------------------------------------------------------------
  static FlyerModel getFlyerModelFromSnapshot(DocumentSnapshot doc){
    final Object _map = doc.data();
    final FlyerModel _flyerModel = FlyerModel.decipherFlyer(
      map: _map,
      fromJSON: false,
    );
    return _flyerModel;
  }

// -----------------------------------------------------------------------------
  static FlyerModel getFlyerModelFromSuperFlyer(SuperFlyer superFlyer){
    FlyerModel _flyer;

    if (superFlyer != null){
      _flyer = FlyerModel(
        flyerID: superFlyer.flyerID,
        flyerType: superFlyer.flyerType,
        flyerState: superFlyer.flyerState,
        keywordsIDs: Keyword.getKeywordsIDsFromKeywords(superFlyer.keywords),
        flyerShowsAuthor: superFlyer.flyerShowsAuthor,
        flyerZone: superFlyer.flyerZone,
        tinyAuthor: superFlyer.flyerTinyAuthor,
        tinyBz: TinyBz.getTinyBzFromSuperFlyer(superFlyer),
        createdAt: PublishTime.getPublishTimeFromTimes(times: superFlyer.flyerTimes, state: FlyerState.Published),
        flyerPosition: superFlyer.position,
        slides: SlideModel.getSlidesFromMutableSlides(superFlyer.mSlides),
        flyerIsBanned: PublishTime.flyerIsBanned(superFlyer.flyerTimes),
        deletionTime: PublishTime.getPublishTimeFromTimes(times: superFlyer.flyerTimes, state: FlyerState.Deleted),
        ankhIsOn: superFlyer.rec.ankhIsOn,
        specs: superFlyer.specs,
        info: superFlyer?.infoController?.text,
        priceTagIsOn : superFlyer?.priceTagIsOn,
        // times:
      );
    }

    return _flyer;
  }
// -----------------------------------------------------------------------------
  void printFlyer(){
    print('FLYER-PRINT --------------------------------------------------START');
    print('FLYER-PRINT : flyerID : ${flyerID}');
    print('FLYER-PRINT : flyerType : ${flyerType}');
    print('FLYER-PRINT : flyerState : ${flyerState}');
    print('FLYER-PRINT : keywordsIDs : ${keywordsIDs}');
    print('FLYER-PRINT : flyerShowsAuthor : ${flyerShowsAuthor}');
    print('FLYER-PRINT : flyerZone : ${flyerZone}');
    print('FLYER-PRINT : tinyAuthor : ${tinyAuthor}');
    print('FLYER-PRINT : tinyBz : ${tinyBz}');
    print('FLYER-PRINT : createdAt : ${createdAt}');
    print('FLYER-PRINT : flyerPosition : ${flyerPosition}');
    print('FLYER-PRINT : ankhIsOn : ${ankhIsOn}');
    print('FLYER-PRINT : slides : ${slides}');
    print('FLYER-PRINT : flyerIsBanned : ${flyerIsBanned}');
    print('FLYER-PRINT : deletionTime : ${deletionTime}');
    print('FLYER-PRINT : specs : ${specs}');
    print('FLYER-PRINT : info : ${info}');
    print('FLYER-PRINT : times : ${times}');
    print('FLYER-PRINT : priceTagIsOn : ${priceTagIsOn}');
    print('FLYER-PRINT --------------------------------------------------END');
  }
// -----------------------------------------------------------------------------
  static bool flyersContainThisID({String flyerID, List<FlyerModel> flyers}){
    bool _hasTheID = false;

      if (flyerID != null && flyers != null && flyers.length != 0){

        for (FlyerModel flyer in flyers){

          if (flyer.flyerID == flyerID){
            _hasTheID = true;
            break;
          }

        }

    }

      return _hasTheID;
  }
// -----------------------------------------------------------------------------

}
// -----------------------------------------------------------------------------
enum FlyerState{
  Published,
  Draft,
  Deleted,
  Unpublished,
  Banned,
  Verified,
  Suspended,
}
// -----------------------------------------------------------------------------
