import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sub_models/slide_model.dart';
import 'tiny_models/tiny_flyer.dart';
import 'tiny_models/tiny_user.dart';
// -----------------------------------------------------------------------------
class FlyerModel with ChangeNotifier{
  final String flyerID;
  // -------------------------
  final FlyerType flyerType;
  final FlyerState flyerState;
  final List<dynamic> keyWords;
  final bool flyerShowsAuthor;
  final String flyerURL;
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
      'flyerType' : cipherFlyerType(flyerType),
      'flyerState' : cipherFlyerState(flyerState),
      'keyWords' : keyWords,
      'flyerShowsAuthor' : flyerShowsAuthor,
      'flyerURL' : flyerURL,
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
    return FlyerModel(
      flyerID: flyerID,
      flyerType: flyerType,
      flyerState: flyerState,
      keyWords: Mapper.cloneListOfStrings(keyWords),
      flyerShowsAuthor: flyerShowsAuthor,
      flyerURL: flyerURL,
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
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherFlyerState (FlyerState x){
    switch (x){
      case FlyerState.Published     :    return  1;  break;
      case FlyerState.Draft         :    return  2;  break;
      case FlyerState.Deleted       :    return  3;  break;
      default : return null;
    }
  }
  // -----------------------------------------------------------------------------
  static FlyerType decipherFlyerType (int x){
    switch (x){
      case 1:   return  FlyerType.Property;     break;
      case 2:   return  FlyerType.Design;       break;
      case 3:   return  FlyerType.Product;      break;
      case 4:   return  FlyerType.Project;      break;
      case 5:   return  FlyerType.Craft;        break;
      case 6:   return  FlyerType.Equipment;    break;
      case 7:   return  FlyerType.General;      break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherFlyerType (FlyerType x){
    switch (x){
      case FlyerType.Property    :    return  1;  break;
      case FlyerType.Design      :    return  2;  break;
      case FlyerType.Product     :    return  3;  break;
      case FlyerType.Project     :    return  4;  break;
      case FlyerType.Craft       :    return  5;  break;
      case FlyerType.Equipment   :    return  6;  break;
      case FlyerType.General     :    return  7;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static FlyerType concludeFlyerType(BzType bzType){
    switch (bzType){
      case BzType.Developer    :   return FlyerType.Property;   break;
      case BzType.Broker       :   return FlyerType.Property;   break;
      case BzType.Designer     :   return FlyerType.Design;     break;
      case BzType.Contractor   :   return FlyerType.Project;    break;
      case BzType.Artisan      :   return FlyerType.Craft;      break;
      case BzType.Manufacturer :   return null;    break; // product or equipment for author to choose while creating flyer
      case BzType.Supplier     :   return null;    break; // product or equipment for author to choose while creating flyer
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
      flyerType: decipherFlyerType(map['flyerType']),
      flyerState: FlyerModel.decipherFlyerState(map['flyerState']),
      keyWords: map['keyWords'],
      flyerShowsAuthor: map['flyerShowsAuthor'],
      flyerURL: map['flyerURL'],
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
  static List<String> getListOfFlyerIDsFromTinyFlyers(List<TinyFlyer> tinyFlyers){
    List<String> _flyerIDs = new List();

    tinyFlyers.forEach((flyer) {
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
  static List<FlyerType> flyerTypesList = <FlyerType>[
    FlyerType.Property,
    FlyerType.Design,
    FlyerType.Product,
    FlyerType.Project,
    FlyerType.Craft,
    FlyerType.Equipment,
    // FlyerType.General,
  ];
// -----------------------------------------------------------------------------
  static List<FlyerState> flyerStatesList = <FlyerState>[
    FlyerState.Published,
    FlyerState.Draft,
    FlyerState.Deleted,
  ];
// -----------------------------------------------------------------------------

}
// -----------------------------------------------------------------------------
enum FlyerState{
  Published,
  Draft,
  Deleted,
}
// -----------------------------------------------------------------------------
enum FlyerType {
  Property, // pp
  Design, // ds
  Product, // pd
  Project, // pj
  Craft, // cr
  Equipment, // eq
  General,
}
// -----------------------------------------------------------------------------
