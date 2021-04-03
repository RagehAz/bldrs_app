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

  Map<String,dynamic> toMap (){
    return {
      'flyerID' : flyerID,
      'flyerType' : cipherFlyerType(flyerType),
      'authorID' : authorID,
      'slidePic' : slidePic,
    };
  }
}
// -----------------------------------------------------------------------------
List<NanoFlyer> decipherNanoFlyersMaps(List<dynamic> nanoFlyersMaps){
  List<NanoFlyer> _nanoFlyers = new List();
  nanoFlyersMaps.forEach((map) {
    _nanoFlyers.add(decipherNanoFlyerMap(map));
  });
  return _nanoFlyers;
}
// -----------------------------------------------------------------------------
NanoFlyer decipherNanoFlyerMap(dynamic map){
  return NanoFlyer(
    flyerID: map['flyerID'],
    flyerType: decipherFlyerType(map['flyerType']),
    authorID: map['authorID'],
    slidePic: map['slidePic'],
  );
}
// -----------------------------------------------------------------------------
NanoFlyer getNanoFlyerFromFlyerModel(FlyerModel flyerModel){
  return NanoFlyer(
    flyerID: flyerModel?.flyerID,
    flyerType: flyerModel?.flyerType,
    authorID: flyerModel?.tinyAuthor?.userID,
    slidePic: flyerModel == null ? null : flyerModel?.slides[0]?.picture,
  );
}
// -----------------------------------------------------------------------------
List<dynamic> cipherNanoFlyers (List<NanoFlyer> nanoFlyers){
  List<dynamic> _nanoFlyersMaps = new List();

  nanoFlyers.forEach((f) {
    _nanoFlyersMaps.add(f.toMap());
  });

  return _nanoFlyersMaps;
}
// -----------------------------------------------------------------------------
List<String> getListOfFlyerIDsFromNanoFlyers(List<NanoFlyer> nanoFlyers){
  List<String> _flyerIDs = new List();

  nanoFlyers.forEach((nano) {
    _flyerIDs.add(nano.flyerID);
  });

  return _flyerIDs;
}
// -----------------------------------------------------------------------------

