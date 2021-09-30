import 'dart:ui';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class NanoFlyer with ChangeNotifier{
  final String flyerID;
  final FlyerType flyerType;
  final String authorID;
  final String slidePic;
  final Zone flyerZone;
  final Color midColor;

  NanoFlyer({
    @required this.flyerID,
    @required this.flyerType,
    @required this.authorID,
    @required this.slidePic,
    @required this.flyerZone,
    @required this.midColor,
  });
// -----------------------------------------------------------------------------
  Map<String,dynamic> toMap (){
    return {
      'flyerID' : flyerID,
      'flyerType' : FlyerTypeClass.cipherFlyerType(flyerType),
      'authorID' : authorID,
      'slidePic' : slidePic,
      'flyerZone' : flyerZone.toMap(),
      'midColor' : Colorizer.cipherColor(midColor),
    };
  }
// -----------------------------------------------------------------------------
  static bool nanoFlyersAreTheSame(FlyerModel finalFlyer, FlyerModel originalFlyer){
    bool nanoFlyerAreTheSame = true;

    if (finalFlyer.flyerType != originalFlyer.flyerType) {nanoFlyerAreTheSame = false;}
    else if (finalFlyer.slides[0].pic != originalFlyer.slides[0].pic) {nanoFlyerAreTheSame = false;}
    else if (Colorizer.colorsAreTheSame(finalFlyer.slides[0].midColor, originalFlyer.slides[0].midColor) == false){nanoFlyerAreTheSame = false;}

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
      slidePic: flyerModel == null ? null : flyerModel?.slides[0]?.pic,
      flyerZone: flyerModel?.flyerZone,
      midColor: flyerModel == null ? null : flyerModel?.slides[0]?.midColor,
    );
  }
// -----------------------------------------------------------------------------
  static List<NanoFlyer> replaceNanoFlyerInAList({List<NanoFlyer> originalNanoFlyers, NanoFlyer finalNanoFlyer}){
    final List<NanoFlyer> _finalNanoFlyers = originalNanoFlyers;

    final int _nanoFlyerIndex = _finalNanoFlyers.indexWhere((nano) => nano.flyerID == finalNanoFlyer.flyerID);
    _finalNanoFlyers.removeAt(_nanoFlyerIndex);
    _finalNanoFlyers.insert(_nanoFlyerIndex, finalNanoFlyer);

    return _finalNanoFlyers;
  }
// -----------------------------------------------------------------------------
  static List<NanoFlyer> decipherNanoFlyersMaps(List<dynamic> nanoFlyersMaps){
    final List<NanoFlyer> _nanoFlyers = <NanoFlyer>[];

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
      midColor: Colorizer.decipherColor(map['midColor']),
    );
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherNanoFlyers (List<NanoFlyer> nanoFlyers){
    final List<dynamic> _nanoFlyersMaps = <dynamic>[];

    nanoFlyers.forEach((f) {
      _nanoFlyersMaps.add(f.toMap());
    });

    return _nanoFlyersMaps;
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfFlyerIDsFromNanoFlyers(List<NanoFlyer> nanoFlyers){
    final List<String> _flyerIDs = <String>[];

    nanoFlyers.forEach((nano) {
      _flyerIDs.add(nano.flyerID);
    });

    return _flyerIDs;
  }
// -----------------------------------------------------------------------------
  static List<NanoFlyer> removeNanoFlyerFromNanoFlyers(List<NanoFlyer> nanoFlyers, String flyerID){
    final int _flyerIndex = nanoFlyers.indexWhere((nano) => nano.flyerID == flyerID, );

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
  static NanoFlyer getNanoFlyerFromTinyFlyer(TinyFlyer tinyFlyer){
    NanoFlyer _nano;

    if(tinyFlyer != null){
      _nano = NanoFlyer(
      flyerID : tinyFlyer.flyerID,
      flyerType : tinyFlyer.flyerType,
      authorID : tinyFlyer.authorID,
      slidePic : tinyFlyer.slidePic,
      flyerZone : tinyFlyer.flyerZone,
      midColor : tinyFlyer.midColor,
      );

    }

    return _nano;
  }
// -----------------------------------------------------------------------------
}

