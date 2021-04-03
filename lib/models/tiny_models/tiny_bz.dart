import 'package:flutter/foundation.dart';
import '../bz_model.dart';
// -----------------------------------------------------------------------------
class TinyBz with ChangeNotifier{
  final String bzID;
  final String bzLogo;
  final String bzName;
  final BzType bzType;

  TinyBz({
    @required this.bzID,
    @required this.bzLogo,
    @required this.bzName,
    @required this.bzType,
  });

  Map<String,dynamic> toMap(){
    return {
      'bzID' : bzID,
      'bzLogo' : bzLogo,
      'bzName' : bzName,
      'bzType' : cipherBzType(bzType),
    };
  }

}
// -----------------------------------------------------------------------------
TinyBz getTinyBzFromBzModel(BzModel bzModel){
  return
    TinyBz(
      bzID: bzModel.bzID,
      bzLogo: bzModel.bzLogo,
      bzName: bzModel.bzName,
      bzType: bzModel.bzType,
    );
}
// -----------------------------------------------------------------------------
List<dynamic> cipherTinyBzzModels(List<TinyBz> tinyBzz){
  List<dynamic> _tinyBzzMaps = new List();
  tinyBzz.forEach((b) {
    _tinyBzzMaps.add(b.toMap());
  });
  return _tinyBzzMaps;
}
// -----------------------------------------------------------------------------
TinyBz decipherTinyBzMap(dynamic map){
  return TinyBz(
    bzID: map['bzID'],
    bzLogo: map['bzLogo'],
    bzName: map['bzName'],
    bzType: decipherBzType(map['bzType']),
  );
}
// -----------------------------------------------------------------------------
List<TinyBz> decipherTinyBzzMaps(List<dynamic> maps){
  List<TinyBz> _tinyBzz = new List();
  maps.forEach((map){
    _tinyBzz.add(decipherTinyBzMap(map));
  });
  return _tinyBzz;
}
// -----------------------------------------------------------------------------
