import 'package:bldrs/ambassadors/database/db_bzz.dart';
import 'package:bldrs/ambassadors/database/db_flyer.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String realtimeDatabaseLink = 'https://bldrsnet.firebaseio.com/';
const String realtimeDatabaseFlyersPath = '${realtimeDatabaseLink}flyers.json';
const String realtimeDatabaseBzzPath = '${realtimeDatabaseLink}bzz.json';

class FlyersProvider with ChangeNotifier {
  List<FlyerModel> _loadedFlyers = geebAllFlyers();
  List<BzModel> _loadedBzz = geebAllBzz();
// ---------------------------------------------------------------------------
  List<FlyerModel> get getAllFlyers {
    return [..._loadedFlyers];
  }
// ---------------------------------------------------------------------------
  FlyerModel getFlyerByFlyerID (String flyerID){
    FlyerModel flyer = _loadedFlyers?.singleWhere((x) => x.flyerID == flyerID, orElse: ()=>null);
    return flyer;
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> get getSavedFlyers {
    return _loadedFlyers.where((fl) => fl.ankhIsOn).toList();
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyersIDs(List<dynamic> flyersIDs){
    List<FlyerModel> flyers = new List();
    flyersIDs?.forEach((id) {flyers.add(getFlyerByFlyerID(id));});
    return flyers;
  }
// ---------------------------------------------------------------------------
  List<String> getFlyersIDsByFlyerType(FlyerType flyerType){
    List<String> flyersIDs = new List();
    _loadedFlyers?.forEach((fl) {
      if(fl.flyerType == flyerType){flyersIDs.add(fl.flyerID);}
    });
    return flyersIDs;
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyerType(FlyerType flyerType){
    List<FlyerModel> flyers = new List();
    List<String> flyersIDs = getFlyersIDsByFlyerType(flyerType);
    flyersIDs.forEach((fID) {
      flyers.add(getFlyerByFlyerID(fID));
    });
    return flyers;
  }
// ---------------------------------------------------------------------------
  bool getAnkhByFlyerID(String flyerID, String useID){
    bool ankhIsOn = false;
    FlyerModel flyer = getFlyerByFlyerID(flyerID);
    if (flyer.ankhIsOn == true){ankhIsOn = true;}else{ankhIsOn = false;}
    return ankhIsOn;
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> getSavedFlyersFromFlyersList (List<FlyerModel> inputList, String userID){
    List<FlyerModel> savedFlyers = new List();
    List<FlyerModel> _inputList = inputList.isEmpty || inputList == null ? [] : inputList;
    _inputList.forEach((flyer) {
      if (getAnkhByFlyerID(flyer.flyerID, userID) == true){savedFlyers.add(flyer);}
    });
    return savedFlyers;
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> getFlyersByAuthorID(String authorID){
    List<FlyerModel> authorFlyers = new List();
    for (FlyerModel fl in _loadedFlyers){
      if (fl.authorID == authorID){
        authorFlyers.add(fl);
      }
    }
    return authorFlyers;
  }
// ############################################################################
  List<FlyerModel> getFlyersByBzModel(BzModel bz){
    List<String> bzFlyersIDs = new List();
    bz?.authors?.forEach((au) {bzFlyersIDs.addAll(au.publishedFlyersIDs);});
    List<FlyerModel> flyers = new List();
    bzFlyersIDs.forEach((id) {flyers.add(getFlyerByFlyerID(id));});
    return flyers;
  }
// ---------------------------------------------------------------------------
  BzModel getBzByBzID(String bzID){
    BzModel bz = _loadedBzz?.singleWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
    return bz;
  }
// ---------------------------------------------------------------------------
List<BzModel> getBzzOfFlyersList(List<FlyerModel> flyersList){
    List<BzModel> bzz = new List();
    flyersList.forEach((fl) {
      bzz.add(getBzByBzID(fl.bzID));
    });
    return bzz;
}
// ---------------------------------------------------------------------------
List<BzModel> getBzzByBzzIDs(List<String> bzzIDs){
List<BzModel> bzz = new List();
bzzIDs.forEach((bzID) {bzz.add(getBzByBzID(bzID));});
return bzz;
}
// ---------------------------------------------------------------------------
List<BzModel> get getFollowedBzz{
    return _loadedBzz.where((bz) => bz.followIsOn).toList();
}
// ############################################################################
void addFlyer(FlyerModel flyer){
    const url = realtimeDatabaseFlyersPath;
    http.post(url,
      body: json.encode({
        'flyerID' : flyer.flyerID,
        // -------------------------
        'flyerType' : flyer.flyerType,
        'flyerState' : flyer.flyerState,
        'keyWords' : flyer.keyWords,
        'flyerShowsAuthor' : flyer.flyerShowsAuthor,
        'flyerURL' : flyer.flyerURL,
        // -------------------------
        'authorID' : flyer.authorID,
        'bzID' : flyer.bzID,
        // -------------------------
        'publishTime' : flyer.publishTime,
        'flyerPosition' : flyer.flyerPosition,
        // -------------------------
        'ankhIsOn' : flyer.ankhIsOn,
        // -------------------------
        'slides' : flyer.slides,
      }),
    );

    final FlyerModel newFlyer = FlyerModel(
    flyerID : flyer.flyerID,
    // -------------------------
    flyerType : flyer.flyerType,
    flyerState : flyer.flyerState,
    keyWords : flyer.keyWords,
    flyerShowsAuthor : flyer.flyerShowsAuthor,
    flyerURL : flyer.flyerURL,
    // -------------------------
    authorID : flyer.authorID,
    bzID : flyer.bzID,
    // -------------------------
    publishTime : flyer.publishTime,
    flyerPosition : flyer.flyerPosition,
    // -------------------------
    ankhIsOn : flyer.ankhIsOn, // will change in later max lessons to be user based
      // -------------------------
    slides : flyer.slides,
    );
    _loadedFlyers.add(newFlyer);
    notifyListeners();
}
// ---------------------------------------------------------------------------
void addBz(BzModel bz){
  const url = realtimeDatabaseBzzPath;
  http.post(url,
    body: json.encode({
      'bzID': bz.bzID,
      // -------------------------
      'bzType': bz.bzType,
      'bzForm': bz.bzForm,
      'bldrBirth': bz.bldrBirth,
      'accountType': bz.accountType,
      'bzURL': bz.bzURL,
      // -------------------------
      'bzName': bz.bzName,
      'bzLogo': bz.bzLogo,
      'bzScope': bz.bzScope,
      'bzCountry': bz.bzCountry,
      'bzProvince': bz.bzProvince,
      'bzArea' : bz.bzArea,
      'bzAbout': bz.bzAbout,
      'bzPosition': bz.bzPosition,
      'bzContacts': bz.bzContacts,
      'authors': bz.authors,
      'bzShowsTeam': bz.bzShowsTeam,
      // -------------------------
      'bzIsVerified': bz.bzIsVerified,
      'bzAccountIsDeactivated': bz.bzAccountIsDeactivated,
      'bzAccountIsBanned': bz.bzAccountIsBanned,
      // -------------------------
      'bzTotalFollowers': bz.bzTotalFollowers,
      'bzTotalSaves': bz.bzTotalSaves,
      'bzTotalShares': bz.bzTotalShares,
      'bzTotalSlides': bz.bzTotalSlides,
      'bzTotalViews': bz.bzTotalViews,
      'bzTotalCalls': bz.bzTotalCalls,
      'bzTotalConnects': bz.bzTotalConnects,
      // -------------------------
      'jointsBzzIDs': bz.jointsBzzIDs,
      // -------------------------
      'followIsOn': bz.followIsOn, // will change in later max lessons to be user based
    }),
  );

  final BzModel newBz = BzModel(
    bzID: bz.bzID,
    // -------------------------
    bzType: bz.bzType,
    bzForm: bz.bzForm,
    bldrBirth: bz.bldrBirth,
    accountType: bz.accountType,
    bzURL: bz.bzURL,
    // -------------------------
    bzName: bz.bzName,
    bzLogo: bz.bzLogo,
    bzScope: bz.bzScope,
    bzCountry: bz.bzCountry,
    bzProvince: bz.bzProvince,
    bzArea: bz.bzArea,
    bzAbout: bz.bzAbout,
    bzPosition: bz.bzPosition,
    bzContacts: bz.bzContacts,
    authors: bz.authors,
    bzShowsTeam: bz.bzShowsTeam,
    // -------------------------
    bzIsVerified: bz.bzIsVerified,
    bzAccountIsDeactivated: bz.bzAccountIsDeactivated,
    bzAccountIsBanned: bz.bzAccountIsBanned,
    // -------------------------
    bzTotalFollowers: bz.bzTotalFollowers,
    bzTotalSaves: bz.bzTotalSaves,
    bzTotalShares: bz.bzTotalShares,
    bzTotalSlides: bz.bzTotalSlides,
    bzTotalViews: bz.bzTotalViews,
    bzTotalCalls: bz.bzTotalCalls,
    bzTotalConnects: bz.bzTotalConnects,
    // -------------------------
    jointsBzzIDs: bz.jointsBzzIDs,
    // -------------------------
    followIsOn: bz.followIsOn,
    );
    _loadedBzz.add(newBz);
    notifyListeners();
}
}