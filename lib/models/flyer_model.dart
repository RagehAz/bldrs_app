import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sub_models/slide_model.dart';
// -----------------------------------------------------------------------------
class FlyerModel with ChangeNotifier{
  final String flyerID;
  // -------------------------
  final FlyerType flyerType;
  final FlyerState flyerState;
  final List<String> keyWords;
  final bool flyerShowsAuthor;
  final String flyerURL;
  // -------------------------
  final String authorID;
  final TinyBz tinyBz;
  // -------------------------
  final DateTime publishTime;
  final GeoPoint flyerPosition;
  // -------------------------
  bool ankhIsOn;
  // -------------------------
  final List<SlideModel> slides;
  // -------------------------

  FlyerModel({
    @required this.flyerID,
    // -------------------------
    @required this.flyerType,
    this.flyerState = FlyerState.Draft,
    this.keyWords,
    this.flyerShowsAuthor = false,
    @required this.flyerURL,
    // -------------------------
    @required this.authorID,
    @required this.tinyBz,
    // -------------------------
    @required this.publishTime,
    this.flyerPosition,
    // -------------------------
    this.ankhIsOn,
    // -------------------------
    @required this.slides,
  });

  void toggleAnkh(){
    ankhIsOn = !ankhIsOn;
    notifyListeners();
  }

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
      'authorID' : authorID,
      'tinyBz' : tinyBz.toMap(),
      // -------------------------
      'publishTime' : cipherDateTimeToString(publishTime),
      'flyerPosition' : flyerPosition,
      // -------------------------
      'ankhIsOn' : ankhIsOn,
      // -------------------------
      'slides' : cipherSlidesModels(slides),
    };
  }

}
// -----------------------------------------------------------------------------
class TinyFlyer with ChangeNotifier{
  final String flyerID;
  final String bzID;
  final String bzLogo;
  final String authorID;
  final int slideIndex;
  final String slidePic;

  TinyFlyer({
    @required this.flyerID,
    this.bzID,
    this.bzLogo,
    @required this.authorID,
    @required this.slideIndex,
    @required this.slidePic,
});

  Map<String,dynamic> toMap (){
    return {
    'flyerID' : flyerID,
    'bzID' : bzID,
    'bzLogo' : bzLogo,
    'authorID' : authorID,
    'slideIndex' : slideIndex,
    'slidePic' : slidePic,
    };
  }

}
// -----------------------------------------------------------------------------
List<dynamic> cipherTinyFlyers (List<TinyFlyer> tinyFlyers){
  List<dynamic> _tinyFlyersMaps = new List();

  tinyFlyers.forEach((f) {
    _tinyFlyersMaps.add(f.toMap());
  });

  return _tinyFlyersMaps;
}
// -----------------------------------------------------------------------------
List<TinyFlyer> decipherTinyFlyers (List<dynamic> tinyFlyersMaps){
  List<TinyFlyer> _tinyFlyers = new List();
  tinyFlyersMaps.forEach((map) {
    _tinyFlyers.add(decipherTinyFlyerMap(map));
  });
  return _tinyFlyers;
}
// -----------------------------------------------------------------------------
TinyFlyer decipherTinyFlyerMap(Map<String, dynamic> map){
  return TinyFlyer(
      flyerID: map['flyerID'],
      bzID: map['bzID:'],
      bzLogo: map['bzLogo'],
      authorID: map['authorID'],
      slideIndex: map['slideIndex'],
      slidePic: map['slidePic'],
  );
}
// -----------------------------------------------------------------------------
enum FlyerState{
  Published,
  Draft,
  Deleted,
}
// -----------------------------------------------------------------------------
List<FlyerState> flyerStatesList = <FlyerState>[
  FlyerState.Published,
  FlyerState.Draft,
  FlyerState.Deleted,
];
// -----------------------------------------------------------------------------
FlyerState decipherFlyerState (int x){
  switch (x){
    case 1:   return  FlyerState.Published;     break;
    case 2:   return  FlyerState.Draft;         break;
    case 3:   return  FlyerState.Deleted;       break;
    default : return   null;
  }
}
// -----------------------------------------------------------------------------
int cipherFlyerState (FlyerState x){
  switch (x){
    case FlyerState.Published     :    return  1;  break;
    case FlyerState.Draft         :    return  2;  break;
    case FlyerState.Deleted       :    return  3;  break;
    default : return null;
  }
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
List<FlyerType> flyerTypesList = <FlyerType>[
  FlyerType.Property,
  FlyerType.Design,
  FlyerType.Product,
  FlyerType.Project,
  FlyerType.Craft,
  FlyerType.Equipment,
  FlyerType.General,
];
// -----------------------------------------------------------------------------
FlyerType decipherFlyerType (int x){
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
int cipherFlyerType (FlyerType x){
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
FlyerType concludeFlyerType(BzType bzType){
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
List<FlyerModel> decipherFlyersMapsFromFireStore(List<dynamic> maps){
  List<FlyerModel> _flyersList = new List();

  maps?.forEach((map) {
    _flyersList.add(decipherFlyerMap(map));
  });

  return _flyersList;
}
// -----------------------------------------------------------------------------
FlyerModel decipherFlyerMap(dynamic map){
  return FlyerModel(
    flyerID: map['flyerID'],
    // -------------------------
    flyerType: decipherFlyerType(map['flyerType']),
    flyerState: decipherFlyerState(map['flyerState']),
    keyWords: map['keyWords'],
    flyerShowsAuthor: map['flyerShowsAuthor'],
    flyerURL: map['flyerURL'],
    // -------------------------
    authorID: map['authorID'],
    tinyBz: decipherTinyBzMap(map['tinyBz']),
    // -------------------------
    publishTime: decipherDateTimeString(map['publishTime']),
    flyerPosition: map['flyerPosition'],
    // -------------------------
    slides: decipherSlidesMaps(map['slides']),
  );
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<String> getListOfFlyerIDsFromTinyFlyers(List<TinyFlyer> tinyFlyers){
  List<String> _flyerIDs = new List();

  tinyFlyers.forEach((flyer) {
    _flyerIDs.add(flyer.flyerID);
  });

  return _flyerIDs;
}