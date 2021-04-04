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

  Map<String,dynamic> toMap(){
    return {
      'bzID' : bzID,
      'bzLogo' : bzLogo,
      'bzName' : bzName,
      'bzType' : cipherBzType(bzType),
      'bzZone' : bzZone.cipherToString(),
      'bzTotalFollowers' : bzTotalFollowers,
      'bzTotalFlyers' : bzTotalFlyers,
    };
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
      bzType: decipherBzType(map['bzType']),
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
}
