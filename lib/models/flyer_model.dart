import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// TASK : WE NEED TO ADD FLYER ZONE IN MODEL, AND DATABASE AND FLYER EDITOR

class FlyerModel with ChangeNotifier{
  final String flyerID;
  // -------------------------
  final FlyerType flyerType;
  final FlyerState flyerState;
  final List<dynamic> keyWords;
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

  FlyerModel({
    this.flyerID,
    // -------------------------
    this.flyerType,
    this.flyerState = FlyerState.Draft,
    this.keyWords,
    this.flyerShowsAuthor = false,
    this.flyerURL,
    @required this.flyerZone,
    // -------------------------
    this.tinyAuthor,
    this.tinyBz,
    // -------------------------
    this.publishTime,
    this.flyerPosition,
    // -------------------------
    this.ankhIsOn,
    // -------------------------
    this.slides,
    // -------------------------
    @required this.flyerIsBanned,
    @required this.deletionTime,
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
      'keyWords' : keyWords,
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
    };
  }
// -----------------------------------------------------------------------------
  FlyerModel clone(){
    return new FlyerModel(
      flyerID: flyerID,
      flyerType: flyerType,
      flyerState: flyerState,
      keyWords: Mapper.cloneListOfStrings(keyWords),
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
    );
  }
// -----------------------------------------------------------------------------
  static FlyerModel replaceSlides(FlyerModel flyer, List<SlideModel> updatedSlides){
    return
        FlyerModel(
          flyerID: flyer.flyerID,
          flyerType: flyer.flyerType,
          flyerState: flyer.flyerState,
          keyWords: flyer.keyWords,
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
    );
  }
// -----------------------------------------------------------------------------
  static FlyerState decipherFlyerState (int x){
    switch (x){
      case 1:   return  FlyerState.Published;     break;
      case 2:   return  FlyerState.Draft;         break;
      case 3:   return  FlyerState.Deleted;       break;
      case 4:   return  FlyerState.Unpublished;   break;
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
    return FlyerModel(
      flyerID: map['flyerID'],
      // -------------------------
      flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
      flyerState: FlyerModel.decipherFlyerState(map['flyerState']),
      keyWords: map['keyWords'],
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
    );
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
      keyWords: inputFlyerModel.keyWords,
      flyerPosition: inputFlyerModel.flyerPosition,
      ankhIsOn: inputFlyerModel.ankhIsOn,
      flyerIsBanned: inputFlyerModel.flyerIsBanned,
      deletionTime: inputFlyerModel.deletionTime,
    );
  }
// -----------------------------------------------------------------------------
  static List<FlyerState> flyerStatesList = <FlyerState>[
    FlyerState.Published,
    FlyerState.Draft,
    FlyerState.Deleted,
  ];
// -----------------------------------------------------------------------------
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
}
// -----------------------------------------------------------------------------
enum FlyerState{
  Published,
  Draft,
  Deleted,
  Unpublished,
}
// -----------------------------------------------------------------------------
