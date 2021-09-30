import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class TinyBz with ChangeNotifier{
  final String bzID;
  final dynamic bzLogo;
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
      'bzZone' : bzZone.toMap(),
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
        bzZone: bzModel.bzZone,
        bzTotalFollowers: bzModel.bzTotalFollowers,
        bzTotalFlyers: bzModel.nanoFlyers.length,
      );
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cipherTinyBzzModels(List<TinyBz> tinyBzz){
    final List<dynamic> _tinyBzzMaps = <dynamic>[];
    tinyBzz.forEach((b) {
      _tinyBzzMaps.add(b.toMap());
    });
    return _tinyBzzMaps;
  }
// -----------------------------------------------------------------------------
  static TinyBz decipherTinyBzMap(dynamic map){
    TinyBz _tinyBz;

    if(map != null){
      _tinyBz = TinyBz(
        bzID: map['bzID'],
        bzLogo: map['bzLogo'],
        bzName: map['bzName'],
        bzType: BzModel.decipherBzType(map['bzType']),
        bzZone: Zone.decipherZoneMap(map['bzZone']),
        bzTotalFollowers: map['bzTotalFollowers'],
        bzTotalFlyers: map['bzTotalFlyers'],
      );
    }
    return _tinyBz;
  }
// -----------------------------------------------------------------------------
  static List<TinyBz> decipherTinyBzzMaps(List<dynamic> maps){
    final List<TinyBz> _tinyBzz = <TinyBz>[];
    maps.forEach((map){
      _tinyBzz.add(decipherTinyBzMap(map));
    });
    return _tinyBzz;
  }
// -----------------------------------------------------------------------------
  static List<String> getBzzIDsFromTinyBzz(List<TinyBz> _tinyBzz){
    final List<String> _ids = <String>[];

    if (_tinyBzz != null){
      _tinyBzz.forEach((tinyBz) {
        _ids.add(tinyBz.bzID);
      });
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
  static List<TinyBz> getTinyBzzFromBzzModels(List<BzModel> bzzModels){
    final List<TinyBz> _tinyBzz = <TinyBz>[];

    bzzModels.forEach((bz) {
      _tinyBzz.add(getTinyBzFromBzModel(bz));
    });

    return _tinyBzz;
  }
// -----------------------------------------------------------------------------
  static TinyBz dummyTinyBz(String bzID){

    final String _bzID = bzID ?? 'ytLfMwdqK565ByP1p56G';

    return
        TinyBz(
            bzID: _bzID,
            bzLogo: Iconz.DumBusinessLogo, //'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bzLogos%2Far1.jpg?alt=media&token=f68673f8-409a-426a-9a80-f1026715c469'
            bzName: 'Business Name',
            bzType: BzType.Designer,
            bzZone: Zone(countryID: 'egy', cityID: 'cairo', districtID: 'heliopolis'),
            bzTotalFollowers: 1000,
            bzTotalFlyers: 10,
        );
  }
// -----------------------------------------------------------------------------
  static List<TinyBz> dummyTinyBzz(){
    return
        <TinyBz>[
          dummyTinyBz('bz1'),
          dummyTinyBz('bz2'),
          dummyTinyBz('bz3'),
        ];
  }
// -----------------------------------------------------------------------------
  static TinyBz getTinyBzFromSuperFlyer(SuperFlyer superFlyer){
    return
        TinyBz(
            bzID: superFlyer.bz.bzID,
            bzLogo:  superFlyer.bz.bzLogo,
            bzName: superFlyer.bz.bzName,
            bzType: superFlyer.bz.bzType,
            bzZone:  superFlyer.bz.bzZone,
            bzTotalFollowers: superFlyer.bz.bzTotalFollowers,
            bzTotalFlyers: superFlyer.bz.bzTotalFlyers,
        );
  }
// -----------------------------------------------------------------------------
  static TinyBz getTinyBzModelFromSnapshot(DocumentSnapshot doc){
    final Object _map = doc.data();
    final TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_map);
    return _tinyBz;
  }
// -----------------------------------------------------------------------------
  static bool tinyBzzContainThisTinyBz({List<TinyBz> tinyBzz, TinyBz tinyBz}){
    bool _contains = false;

    final bool _canLoop = tinyBzz != null && tinyBzz.length > 0 && tinyBz != null;

    if (_canLoop == true){

      for (TinyBz bz in tinyBzz){

        if (bz.bzID == tinyBz.bzID){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------
}
