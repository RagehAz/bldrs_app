import 'package:bldrs/models/planet/zone_model.dart';
import 'package:flutter/foundation.dart';
import '../bz_model.dart';
// -----------------------------------------------------------------------------
class TinyBz with ChangeNotifier{
  final String bzID;
  final String bzLogo;
  final String bzName;
  final BzType bzType;
  final Zone bzZone;
  final int bzTotalFollowers;
  final int bzTotalFlyers;

  TinyBz({
    @required this.bzID,
    @required this.bzLogo,
    @required this.bzName,
    @required this.bzType,
    @required this.bzZone,
    @required this.bzTotalFollowers,
    @required this.bzTotalFlyers,
  });
// -----------------------------------------------------------------------------
  Map<String,dynamic> toMap(){
    return {
      'bzID' : bzID,
      'bzLogo' : bzLogo,
      'bzName' : bzName,
      'bzType' : BzModel.cipherBzType(bzType),
      'bzZone' : bzZone.cipherToString(),
      'bzTotalFollowers' : bzTotalFollowers,
      'bzTotalFlyers' : bzTotalFlyers,
    };
  }

  TinyBz clone(){
    return TinyBz(
        bzID: bzID,
        bzLogo: bzLogo,
        bzName: bzName,
        bzType: bzType,
        bzZone: bzZone.clone(),
        bzTotalFollowers: bzTotalFollowers,
        bzTotalFlyers: bzTotalFlyers,
    );
  }
// -----------------------------------------------------------------------------
  static bool tinyBzzAreTheSame(TinyBz finalBz, TinyBz originalBz){
    bool _tinyBzzAreTheSame = true;

    if (finalBz.bzLogo != originalBz.bzLogo) {_tinyBzzAreTheSame = false;}
    else if (finalBz.bzName != originalBz.bzName) {_tinyBzzAreTheSame = false;}
    else if (finalBz.bzType != originalBz.bzType) {_tinyBzzAreTheSame = false;}
    else if (Zone.zonesAreTheSame(finalBz.bzZone, originalBz.bzZone)) {_tinyBzzAreTheSame = false;}
    else if (finalBz.bzTotalFollowers != originalBz.bzTotalFollowers) {_tinyBzzAreTheSame = false;}
    else if (finalBz.bzTotalFlyers != originalBz.bzTotalFlyers) {_tinyBzzAreTheSame = false;}
    else {_tinyBzzAreTheSame = true;}

    return _tinyBzzAreTheSame;
  }
// -----------------------------------------------------------------------------
  static TinyBz getTinyBzFromBzModel(BzModel bzModel){
    return
      TinyBz(
        bzID: bzModel.bzID,
        bzLogo: bzModel.bzLogo,
        bzName: bzModel.bzName,
        bzType: bzModel.bzType,
        bzZone: Zone.getZoneFromBzModel(bzModel),
        bzTotalFollowers: bzModel.bzTotalFollowers,
        bzTotalFlyers: bzModel.bzFlyers.length,
      );
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherTinyBzzModels(List<TinyBz> tinyBzz){
    List<dynamic> _tinyBzzMaps = new List();
    tinyBzz.forEach((b) {
      _tinyBzzMaps.add(b.toMap());
    });
    return _tinyBzzMaps;
  }
// -----------------------------------------------------------------------------
  static TinyBz decipherTinyBzMap(dynamic map){
    return TinyBz(
      bzID: map['bzID'],
      bzLogo: map['bzLogo'],
      bzName: map['bzName'],
      bzType: BzModel.decipherBzType(map['bzType']),
      bzZone: Zone.decipherZoneString(map['bzZone']),
      bzTotalFollowers: map['bzTotalFollowers'],
      bzTotalFlyers: map['bzTotalFlyers'],
    );
  }
// -----------------------------------------------------------------------------
  static List<TinyBz> decipherTinyBzzMaps(List<dynamic> maps){
    List<TinyBz> _tinyBzz = new List();
    maps.forEach((map){
      _tinyBzz.add(decipherTinyBzMap(map));
    });
    return _tinyBzz;
  }
// -----------------------------------------------------------------------------
  static List<String> getBzzIDsFromTinyBzz(List<TinyBz> _tinyBzz){
    List<String> _ids = new List();

    if (_tinyBzz != null){
      _tinyBzz.forEach((tinyBz) {
        _ids.add(tinyBz.bzID);
      });
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
}
