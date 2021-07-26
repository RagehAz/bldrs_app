import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/publish_time_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/sub_models/spec_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class FlyerModel with ChangeNotifier{
  final String flyerID;
  // -------------------------
  final FlyerType flyerType;
  final FlyerState flyerState;
  final List<dynamic> keywords;
  final bool flyerShowsAuthor;
  final String flyerURL;
  final Zone flyerZone;
  // -------------------------
  final TinyUser tinyAuthor;
  final TinyBz tinyBz;
  // -------------------------
  final DateTime publishTime;
  final GeoPoint flyerPosition;
  // -------------------------
  bool ankhIsOn;
  // -------------------------
  final List<SlideModel> slides;
  // -------------------------
  final bool flyerIsBanned;
  final DateTime deletionTime;
  final List<Spec> specs;
  final String info;
  final List<PublishTime> times;

  FlyerModel({
    this.flyerID,
    // -------------------------
    this.flyerType,
    this.flyerState = FlyerState.Draft,
    this.keywords,
    this.flyerShowsAuthor = false,
    this.flyerURL,
    this.flyerZone,
    // -------------------------
    this.tinyAuthor,
    this.tinyBz,
    // -------------------------
    this.publishTime, /// TASK : delete this
    this.flyerPosition,
    // -------------------------
    this.ankhIsOn,
    // -------------------------
    this.slides,
    // -------------------------
    this.flyerIsBanned,
    this.deletionTime, /// TASK : delete this
    this.specs,
    this.info,
    this.times,
  });
// -----------------------------------------------------------------------------
  void toggleAnkh(){
    ankhIsOn = !ankhIsOn;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'flyerID' : flyerID,
      // -------------------------
      'flyerType' : FlyerTypeClass.cipherFlyerType(flyerType),
      'flyerState' : cipherFlyerState(flyerState),
      'keyWords' : keywords,
      'flyerShowsAuthor' : flyerShowsAuthor,
      'flyerURL' : flyerURL,
      'flyerZone' : flyerZone.toMap(),
      // -------------------------
      'tinyAuthor' : tinyAuthor.toMap(),
      'tinyBz' : tinyBz.toMap(),
      // -------------------------
      'publishTime' : cipherDateTimeToString(publishTime),
      'flyerPosition' : flyerPosition,
      // -------------------------
      'ankhIsOn' : ankhIsOn,
      // -------------------------
      'slides' : SlideModel.cipherSlidesModels(slides),
      // -------------------------
      'flyerIsBanned' : flyerIsBanned,
      'deletionTime' : cipherDateTimeToString(deletionTime),
      'specs' : Spec.cipherSpecs(specs),
      'info' : info,
    };
  }
// -----------------------------------------------------------------------------
  FlyerModel clone(){
    return new FlyerModel(
      flyerID: flyerID,
      flyerType: flyerType,
      flyerState: flyerState,
      keywords: Mapper.cloneListOfStrings(keywords),
      flyerShowsAuthor: flyerShowsAuthor,
      flyerURL: flyerURL,
      flyerZone: flyerZone,
      tinyAuthor: tinyAuthor.clone(),
      tinyBz: tinyBz.clone(),
      publishTime: publishTime,
      flyerPosition: flyerPosition,
      slides: SlideModel.cloneSlides(slides),
      flyerIsBanned: flyerIsBanned,
      deletionTime: deletionTime,
      ankhIsOn: ankhIsOn,
      specs: Spec.cloneSpecs(specs),
    );
  }
// -----------------------------------------------------------------------------
  static FlyerModel replaceSlides(FlyerModel flyer, List<SlideModel> updatedSlides){
    return
        FlyerModel(
          flyerID: flyer.flyerID,
          flyerType: flyer.flyerType,
          flyerState: flyer.flyerState,
          keywords: flyer.keywords,
          flyerShowsAuthor: flyer.flyerShowsAuthor,
          flyerURL: flyer.flyerURL,
          flyerZone: flyer.flyerZone,
          tinyAuthor: flyer.tinyAuthor,
          tinyBz: flyer.tinyBz,
          publishTime: flyer.publishTime,
          flyerPosition: flyer.flyerPosition,
          slides: updatedSlides,
          flyerIsBanned: flyer.flyerIsBanned,
          deletionTime: flyer.deletionTime,
          ankhIsOn: flyer.ankhIsOn,
          specs: flyer.specs,
          info: flyer.info,
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
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherFlyerState (FlyerState x){
    switch (x){
      case FlyerState.Published     :    return  1;  break;
      case FlyerState.Draft         :    return  2;  break;
      case FlyerState.Deleted       :    return  3;  break;
      case FlyerState.Unpublished   :    return  4;  break;
      case FlyerState.Banned        :    return  5;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static List<FlyerModel> decipherFlyersMaps(List<dynamic> maps){
    List<FlyerModel> _flyersList = new List();

    maps?.forEach((map) {
      _flyersList.add(decipherFlyerMap(map));
    });

    return _flyersList;
  }
// -----------------------------------------------------------------------------
  static FlyerModel decipherFlyerMap(dynamic map){
    FlyerModel _flyerModel;
    if (map != null){
      _flyerModel = FlyerModel(
        flyerID: map['flyerID'],
        // -------------------------
        flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
        flyerState: FlyerModel.decipherFlyerState(map['flyerState']),
        keywords: map['keyWords'],
        flyerShowsAuthor: map['flyerShowsAuthor'],
        flyerURL: map['flyerURL'],
        flyerZone: Zone.decipherZoneMap(map['flyerZone']),
        // -------------------------
        tinyAuthor: TinyUser.decipherTinyUserMap(map['tinyAuthor']),
        tinyBz: TinyBz.decipherTinyBzMap(map['tinyBz']),
        // -------------------------
        publishTime: decipherDateTimeString(map['publishTime']),
        flyerPosition: map['flyerPosition'],
        // -------------------------
        slides: SlideModel.decipherSlidesMaps(map['slides']),
        // -------------------------
        flyerIsBanned: map['flyerIsBanned'],
        deletionTime: decipherDateTimeString(map['deletionTime']),
        specs: Spec.decipherSpecs(map['specs']),
        info: map['info'],
      );

    }

    return _flyerModel;
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfFlyerIDsFromFlyers(List<FlyerModel> flyers){
    List<String> _flyerIDs = new List();

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
      flyerURL: inputFlyerModel.flyerURL,
      flyerZone: inputFlyerModel.flyerZone,
      tinyAuthor: inputFlyerModel.tinyAuthor,
      tinyBz: inputFlyerModel.tinyBz,
      publishTime: inputFlyerModel.publishTime,
      slides: updatedSlides,
      flyerShowsAuthor: inputFlyerModel.flyerShowsAuthor,
      flyerState: inputFlyerModel.flyerState,
      keywords: inputFlyerModel.keywords,
      flyerPosition: inputFlyerModel.flyerPosition,
      ankhIsOn: inputFlyerModel.ankhIsOn,
      flyerIsBanned: inputFlyerModel.flyerIsBanned,
      deletionTime: inputFlyerModel.deletionTime,
      specs: inputFlyerModel.specs,
      info: inputFlyerModel.info,
    );
  }
// -----------------------------------------------------------------------------
  static List<FlyerState> flyerStatesList = <FlyerState>[
    FlyerState.Published,
    FlyerState.Draft,
    FlyerState.Deleted,
    FlyerState.Unpublished,
    FlyerState.Banned,
  ];
// -----------------------------------------------------------------------------
  /// TASK : why ?
  static int getNumberOfFlyersFromBzzModels(List<BzModel> bzzModels){
    int _totalFlyers = 0;
    bzzModels.forEach((bzModel) {
      _totalFlyers = _totalFlyers + (bzModel.nanoFlyers.length);
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
  List<TextEditingController> _controllers = new List();

  flyerModel.slides.forEach((slide) {
    TextEditingController _controller = new TextEditingController(text: slide.headline);
    _controllers.add(_controller);
  });

  return _controllers;
}
// -----------------------------------------------------------------------------
  static List<TextEditingController> createDescriptionsControllersForExistingFlyer(FlyerModel flyerModel){
    List<TextEditingController> _controllers = new List();

    flyerModel.slides.forEach((slide) {
      TextEditingController _controller = new TextEditingController(text: slide.description);
      _controllers.add(_controller);
    });

    return _controllers;
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
}
// -----------------------------------------------------------------------------
