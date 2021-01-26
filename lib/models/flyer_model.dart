import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'sub_models/slide_model.dart';
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
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
  final String bzID;
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
    @required this.bzID,
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

}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum FlyerState{
  Published,
  Draft,
  Deleted,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<FlyerState> flyerStatesList = [
  FlyerState.Published,
  FlyerState.Draft,
  FlyerState.Deleted,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
FlyerState decipherFlyerState (int x){
  switch (x){
    case 1:   return  FlyerState.Published;     break;
    case 2:   return  FlyerState.Draft;         break;
    case 3:   return  FlyerState.Deleted;       break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherFlyerState (FlyerState x){
  switch (x){
    case FlyerState.Published     :    return  1;  break;
    case FlyerState.Draft         :    return  2;  break;
    case FlyerState.Deleted       :    return  3;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum FlyerType {
  Property, // pp
  Design, // ds
  Product, // pd
  Project, // pj
  Craft, // cr
  Equipment, // eq
  General,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<FlyerType> flyerTypesList = [
  FlyerType.Property,
  FlyerType.Design,
  FlyerType.Product,
  FlyerType.Project,
  FlyerType.Craft,
  FlyerType.Equipment,
  FlyerType.General,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
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
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
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
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class FlyerLink{
  final String flyerLink;
  final String description;

  FlyerLink({
    @required this.flyerLink,
    @required this.description,
  });

  Map<String, Object> toMap(){
    return {
    'flyerLink' : flyerLink,
    'description' : description,
    };
  }

}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
