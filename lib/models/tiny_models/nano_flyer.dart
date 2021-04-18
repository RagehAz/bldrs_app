import 'package:flutter/foundation.dart';
import '../flyer_model.dart';
// -----------------------------------------------------------------------------
class NanoFlyer with ChangeNotifier{
  final String flyerID;
  final FlyerType flyerType;
  final String authorID;
  final String slidePic;

  NanoFlyer({
    @required this.flyerID,
    @required this.flyerType,
    @required this.authorID,
    @required this.slidePic,
  });
// -----------------------------------------------------------------------------
  Map<String,dynamic> toMap (){
    return {
      'flyerID' : flyerID,
      'flyerType' : FlyerModel.cipherFlyerType(flyerType),
      'authorID' : authorID,
      'slidePic' : slidePic,
    };
  }
// -----------------------------------------------------------------------------
  static bool nanoFlyersAreTheSame(FlyerModel finalFlyer, FlyerModel originalFlyer){
    bool nanoFlyerAreTheSame = true;

    if (finalFlyer.flyerType != originalFlyer.flyerType) {nanoFlyerAreTheSame = false;}
    else if (finalFlyer.slides[0].picture != originalFlyer.slides[0].picture) {nanoFlyerAreTheSame = false;}
    else {nanoFlyerAreTheSame = true;}

    return nanoFlyerAreTheSame;
  }
// -----------------------------------------------------------------------------
  static NanoFlyer getNanoFlyerFromFlyerModel(FlyerModel flyerModel){
    return NanoFlyer(
      flyerID: flyerModel?.flyerID,
      flyerType: flyerModel?.flyerType,
      authorID: flyerModel?.tinyAuthor?.userID,
      slidePic: flyerModel == null ? null : flyerModel?.slides[0]?.picture,
    );
  }
// -----------------------------------------------------------------------------
  static List<NanoFlyer> replaceNanoFlyerInAList({List<NanoFlyer> originalNanoFlyers, NanoFlyer finalNanoFlyer}){
    List<NanoFlyer> _finalNanoFlyers = originalNanoFlyers;

    int _nanoFlyerIndex = _finalNanoFlyers.indexWhere((nano) => nano.flyerID == finalNanoFlyer.flyerID);
    _finalNanoFlyers.removeAt(_nanoFlyerIndex);
    _finalNanoFlyers.insert(_nanoFlyerIndex, finalNanoFlyer);

    return _finalNanoFlyers;
  }
// -----------------------------------------------------------------------------
  static List<NanoFlyer> decipherNanoFlyersMaps(List<dynamic> nanoFlyersMaps){
    List<NanoFlyer> _nanoFlyers = new List();
    nanoFlyersMaps.forEach((map) {
      _nanoFlyers.add(decipherNanoFlyerMap(map));
    });
    return _nanoFlyers;
  }
// -----------------------------------------------------------------------------
  static NanoFlyer decipherNanoFlyerMap(dynamic map){
    return NanoFlyer(
      flyerID: map['flyerID'],
      flyerType: FlyerModel.decipherFlyerType(map['flyerType']),
      authorID: map['authorID'],
      slidePic: map['slidePic'],
    );
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherNanoFlyers (List<NanoFlyer> nanoFlyers){
    List<dynamic> _nanoFlyersMaps = new List();

    nanoFlyers.forEach((f) {
      _nanoFlyersMaps.add(f.toMap());
    });

    return _nanoFlyersMaps;
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfFlyerIDsFromNanoFlyers(List<NanoFlyer> nanoFlyers){
    List<String> _flyerIDs = new List();

    nanoFlyers.forEach((nano) {
      _flyerIDs.add(nano.flyerID);
    });

    return _flyerIDs;
  }
// -----------------------------------------------------------------------------
  static List<NanoFlyer> removeNanoFlyerFromNanoFlyers(List<NanoFlyer> nanoFlyers, String flyerID){
    int _flyerIndex = nanoFlyers.indexWhere((nano) => nano.flyerID == flyerID,);

    if (_flyerIndex != null){
      nanoFlyers.removeAt(_flyerIndex);
      return nanoFlyers;
    } else {
      return null;
    }

  }
// -----------------------------------------------------------------------------
}

