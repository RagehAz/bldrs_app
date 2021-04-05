import 'package:flutter/foundation.dart';
import '../bz_model.dart';
import '../flyer_model.dart';
import 'nano_flyer.dart';
import 'tiny_bz.dart';
// -----------------------------------------------------------------------------
class TinyFlyer with ChangeNotifier{
  final String flyerID;
  final FlyerType flyerType;
  final TinyBz tinyBz;
  final String authorID;
  final int slideIndex;
  final String slidePic;

  TinyFlyer({
    @required this.flyerID,
    @required this.flyerType,
    this.tinyBz,
    @required this.authorID,
    @required this.slideIndex,
    @required this.slidePic,
  });
// -----------------------------------------------------------------------------
  Map<String,dynamic> toMap (){
    return {
      'flyerID' : flyerID,
      'flyerType' : FlyerModel.cipherFlyerType(flyerType),
      'tinyBz' : tinyBz.toMap(),
      'authorID' : authorID,
      'slideIndex' : slideIndex,
      'slidePic' : slidePic,
    };
  }
// -----------------------------------------------------------------------------
  static bool tinyFlyersAreTheSame(FlyerModel finalFlyer, FlyerModel originalFlyer){
    bool tinyFlyersAreTheSame = true;

    if (finalFlyer.flyerType != originalFlyer.flyerType) {tinyFlyersAreTheSame = false;}
    else if (TinyBz.tinyBzzAreTheSame(finalFlyer.tinyBz, originalFlyer.tinyBz) == false) {tinyFlyersAreTheSame = false;}
    else if (finalFlyer.slides[0].picture != originalFlyer.slides[0].picture) {tinyFlyersAreTheSame = false;}
    else {tinyFlyersAreTheSame = true;}

    return tinyFlyersAreTheSame;
  }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> decipherTinyFlyersMaps(List<dynamic> tinyFlyersMaps){
    List<TinyFlyer> _tinyFlyers = new List();
    tinyFlyersMaps.forEach((map) {
      _tinyFlyers.add(decipherTinyFlyerMap(map));
    });
    return _tinyFlyers;
  }
// -----------------------------------------------------------------------------
  static TinyFlyer decipherTinyFlyerMap(dynamic map){
    return TinyFlyer(
      flyerID: map['flyerID'],
      flyerType: FlyerModel.decipherFlyerType(map['flyerType']),
      tinyBz: TinyBz.decipherTinyBzMap(map['tinyBz']),
      authorID: map['authorID'],
      slideIndex: map['slideIndex'],
      slidePic: map['slidePic'],
    );
  }
// -----------------------------------------------------------------------------
  static TinyFlyer getTinyFlyerFromFlyerModel(FlyerModel flyerModel){
    return TinyFlyer(
      flyerID: flyerModel?.flyerID,
      flyerType: flyerModel?.flyerType,
      authorID: flyerModel?.tinyAuthor?.userID,
      slideIndex: 0,
      slidePic: flyerModel == null ? null : flyerModel?.slides[0]?.picture,
      tinyBz: flyerModel?.tinyBz,
    );
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherTinyFlyers (List<TinyFlyer> tinyFlyers){
    List<dynamic> _tinyFlyersMaps = new List();

    tinyFlyers.forEach((f) {
      _tinyFlyersMaps.add(f.toMap());
    });

    return _tinyFlyersMaps;
  }
// -----------------------------------------------------------------------------
  static List<TinyFlyer> getTinyFlyersFromBzModel(BzModel bzModel){
    List<TinyFlyer> _tinyFlyers = new List();

    List<NanoFlyer> _nanoFlyers = bzModel.bzFlyers;

    for (var nano in _nanoFlyers){
      _tinyFlyers.add(
          TinyFlyer(
              flyerID: nano.flyerID,
              flyerType: nano.flyerType,
              authorID: nano.authorID,
              slideIndex: 0,
              slidePic: nano.slidePic,
              tinyBz: TinyBz.getTinyBzFromBzModel(bzModel)
          )
      );
    }

    return _tinyFlyers;
  }
// -----------------------------------------------------------------------------
}


