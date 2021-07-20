import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:flutter/foundation.dart';
import '../flyer_model.dart';
// -----------------------------------------------------------------------------
class NanoFlyer with ChangeNotifier{
  final String flyerID;
  final FlyerType flyerType;
  final String authorID;
  final String slidePic;
  final Zone flyerZone;

  NanoFlyer({
    @required this.flyerID,
    @required this.flyerType,
    @required this.authorID,
    @required this.slidePic,
    @required this.flyerZone,
  });
// -----------------------------------------------------------------------------
  Map<String,dynamic> toMap (){
    return {
      'flyerID' : flyerID,
      'flyerType' : FlyerTypeClass.cipherFlyerType(flyerType),
      'authorID' : authorID,
      'slidePic' : slidePic,
      'flyerZone' : flyerZone.toMap(),
    };
  }
// -----------------------------------------------------------------------------
  static bool nanoFlyersAreTheSame(FlyerModel finalFlyer, FlyerModel originalFlyer){
    bool nanoFlyerAreTheSame = true;

    if (finalFlyer.flyerType != originalFlyer.flyerType) {nanoFlyerAreTheSame = false;}
    else if (finalFlyer.slides[0].picture != originalFlyer.slides[0].picture) {nanoFlyerAreTheSame = false;}

    else if (finalFlyer.flyerZone.countryID != originalFlyer.flyerZone.countryID) {nanoFlyerAreTheSame = false;}
    else if (finalFlyer.flyerZone.cityID != originalFlyer.flyerZone.cityID) {nanoFlyerAreTheSame = false;}
    else if (finalFlyer.flyerZone.districtID != originalFlyer.flyerZone.districtID) {nanoFlyerAreTheSame = false;}

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
      flyerZone: flyerModel?.flyerZone,
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
      flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
      authorID: map['authorID'],
      slidePic: map['slidePic'],
      flyerZone: Zone.decipherZoneMap(map['flyerZone']),
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
    int _flyerIndex = nanoFlyers.indexWhere((nano) => nano.flyerID == flyerID, );

    print('removeNanoFlyerFromNanoFlyers : _flyerIndex : $_flyerIndex');

    if (_flyerIndex == -1){
      print('flyer does not exist in nano flyers list');

      return null;
    } else if (_flyerIndex == null) {

      print('flyer does not exist in nano flyers list');
      return null;

    } else {
      nanoFlyers.removeAt(_flyerIndex);
      return nanoFlyers;
    }

  }
// -----------------------------------------------------------------------------
}

