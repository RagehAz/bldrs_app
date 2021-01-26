import 'package:bldrs/ambassadors/database/db_flyer.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:flutter/cupertino.dart';

class FlyersProvider with ChangeNotifier {
  List<FlyerModel> _loadedFlyers = dbFlyers.isEmpty? [] : dbFlyers;
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
  List<FlyerModel> getAllSavedFlyersFromDB (List<String> savedFlyersIDsList){
    List<FlyerModel> savedFlyersList = [];
    savedFlyersIDsList.forEach((id) {
      savedFlyersList.add(getFlyerByFlyerID(id));
    });
    return savedFlyersList;
  }
// ---------------------------------------------------------------------------
  List<String> getFlyersIDsByFlyerType(FlyerType flyerType){
    List<String> flyersIDs = new List();
    _loadedFlyers.forEach((fl) {
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
  String getFlyerIDFromFlyerModel(FlyerModel flyer){
    return flyer.flyerID;
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
// ---------------------------------------------------------------------------
//   List<FlyerModel> getFlyersByBzID(String bzID){
//     List<FlyerModel> flyers = new List();
//     List<AuthorModel> authors = getAuthorsByBzID;
//     BzModel bz = getBzByBzID(bzID);
//
//     for(String aID in authorsIDs){coFlyers.addAll(hatCoFlyersByAuthorID(aID));}
//
//     return FlyerModel;
//   }

  // CoAuthor hatCoAuthorFromCoAuthorsByAuthorID(List<CoAuthor> coAuthors, String authorID){
  //   CoAuthor authorData = coAuthors?.singleWhere((coA) => coA.author.authorID == authorID, orElse: ()=> null);
  //   return authorData;
  // }

  String hatContactFromContactsByContactType(List<ContactModel> contacts, ContactType contactType){
    String contact = contacts?.singleWhere((co) => co.contactType == contactType, orElse: ()=> null)?.contact;
    return contact;
  }

  // List<CoSlide> hatCoSlidesByFlyerID(String flyerID){
  //   List<CoSlide> flyerCoSlides = new List();
  //   _loadedCoFlyers.forEach((coF) {
  //     if(coF.flyer.flyerID == flyerID){flyerCoSlides.addAll(coF.coSlides,);}
  //   });
  //   return flyerCoSlides;
  // }
  //
  // String hatBzIDByFlyerID(String flyerID){
  //   String bzID = getBzIDByFlyerID(flyerID);
  //   return bzID;
  // }
  //
  // bool hatFollowIsOnByFlyerID(String flyerID){
  //   String flyerBzID = hatBzIDByFlyerID(flyerID);
  //   String bzFollow = _followedBzzIDs.singleWhere((bzID) => bzID == flyerBzID, orElse: ()=> null);
  //   bool followIsOn = bzFollow == null ? false : true;
  //   return followIsOn;
  // }
  //
  //
  // List<CoFlyer> get hatAllSavedCoFlyers {
  //   return _loadedCoFlyers.where((coFlyer)=> coFlyer.ankhIsOn).toList();
  // }




// void addFlyerInBeginning(ProcessedFlyerData newFlyer){
  //   _downloadedFlyers.insert(0, newFlyer);
  //   notifyListeners();
  // }
  // void addFlyerInEnd(ProcessedFlyerData newFlyer){
  //   _downloadedFlyers.add(newFlyer);
  //   notifyListeners();
  // }


}