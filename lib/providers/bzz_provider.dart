import 'package:bldrs/ambassadors/database/db_bzz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:flutter/material.dart';

class BzzProvider with ChangeNotifier {
  List<BzModel> _allBzzList = dbBzz;
// ---------------------------------------------------------------------------
  List<BzModel> get allBzz {
    return [..._allBzzList];
  }
// ---------------------------------------------------------------------------
  BzModel getBzByBzID(String bzID){
    BzModel bz = _allBzzList?.singleWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
    return bz;
  }
// ---------------------------------------------------------------------------
  List<BzModel> getAllFollowedBzFromDB(List<String> followedBzzIDs){
    List<BzModel> followedBzzList = [];
    followedBzzIDs.forEach((id) {
      followedBzzList.add(getBzByBzID(id));
    });
    return followedBzzList;
  }
// ---------------------------------------------------------------------------

}