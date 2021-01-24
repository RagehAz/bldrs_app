import 'package:bldrs/ambassadors/db_brain/db_controller.dart';
import 'package:bldrs/models/enums/enum_contact_type.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_author.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_flyer.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_slide.dart';
import 'package:bldrs/models/old_models_to_delete_when_done/contact_model.dart';
import 'package:flutter/cupertino.dart';

class CoFlyersProvider with ChangeNotifier {
  List<CoFlyer>  _loadedCoFlyers      = getAllCoFlyers().isEmpty?                [] : getAllCoFlyers();
  List<CoAuthor> _loadedCoAuthors     = getAllCoAuthors().isEmpty?               [] : getAllCoAuthors();
  List<CoFlyer>  _loadedSavedCoFlyers = getSavedCoFlyersByUserID('u21').isEmpty? [] : getSavedCoFlyersByUserID('u21');
  List<String>   _followedBzzIDs      = getFollowedBzzIDsByUserID('u21').isEmpty?[] : getFollowedBzzIDsByUserID('u21');

  List<CoFlyer> get hatAllCoFlyers {
    return [..._loadedCoFlyers];
  }

  List<CoFlyer> get hatAllSavedCoFlyersFromDB {
    return [..._loadedSavedCoFlyers];
  }



  CoFlyer hatCoFlyerByFlyerID (String flyerID){
    CoFlyer coFlyer = _loadedCoFlyers?.singleWhere((x) => x.flyer.flyerID == flyerID, orElse: ()=>null);
    return coFlyer;
  }

  List<String> hatFlyersIDsByFlyerType(FlyerType flyerType){
    List<String> flyersIDs = new List();
    _loadedCoFlyers.forEach((fl) {
      if(fl.flyer.flyerType == flyerType){flyersIDs.add(fl.flyer.flyerID);}
    });
    return flyersIDs;
  }

  List<CoFlyer> hatCoFlyersByFlyerType(FlyerType flyerType){
    List<CoFlyer> coFlyers = new List();
    List<String> flyersIDs = hatFlyersIDsByFlyerType(flyerType);
    flyersIDs.forEach((fID) {
      coFlyers.add(hatCoFlyerByFlyerID(fID));
    });
    return coFlyers;
  }

  List<CoSlide> hatSavedCoSlidesByFlyerID(String flyerID){
    List<CoSlide> savedCoSlides = (_loadedSavedCoFlyers.singleWhere((coF) => coF.flyer.flyerID == flyerID, orElse: ()=> null))?.coSlides;
    return savedCoSlides;
  }

  List<String> hatSavedFlyersIDs(){
    List<String> savedFlyersIDs = new List();
    _loadedSavedCoFlyers.forEach((coF) {savedFlyersIDs.add(coF.flyer.flyerID); });
    return savedFlyersIDs;
  }


  bool hatAnkhByFlyerID(String flyerID){
    bool ankhIsOn;
    List<CoSlide> savedCoSlides = hatSavedCoSlidesByFlyerID(flyerID);
    if (savedCoSlides == null){ankhIsOn = false;}else{ankhIsOn = true;}
    return ankhIsOn;
  }

  List<CoFlyer> hatSavedCoFlyersFromCoFlyers (List<CoFlyer> inputList, String userID){
    List<CoFlyer> savedCoFlyers = new List();
    List<CoFlyer> _inputList = inputList.isEmpty || inputList == null ? [] : inputList;
    List<String> savedFlyersIDs = hatSavedFlyersIDs();

    for (String fID in savedFlyersIDs){
      _inputList.forEach((coF) {
        if (coF.flyer.flyerID == fID){savedCoFlyers.add(coF);}
      });
    }

    return savedCoFlyers;
  }


  List<CoFlyer> hatCoFlyersByAuthorID(String authorID){
    List<CoFlyer> authorFlyers = new List();
    for (CoFlyer fl in _loadedCoFlyers){
      if (fl.flyer.authorID == authorID){
        authorFlyers.add(fl);
      }
    }
    return authorFlyers;
  }

  List<String> hatAuthorsIDsByBzID(String bzID){
    List<String> authorsIDs = new List();
    _loadedCoAuthors.forEach((au) {
      if(au.author.bzId == bzID){
        authorsIDs.add(au.author.authorID);
      }
    });
    return authorsIDs;
  }

  List<CoFlyer> hatCoFlyersByBzID(String bzID){
    List<CoFlyer> coFlyers = new List();
    List<String> authorsIDs = hatAuthorsIDsByBzID(bzID);

    for(String aID in authorsIDs){coFlyers.addAll(hatCoFlyersByAuthorID(aID));}

    return coFlyers;
  }

  // CoAuthor hatCoAuthorFromCoAuthorsByAuthorID(List<CoAuthor> coAuthors, String authorID){
  //   CoAuthor authorData = coAuthors?.singleWhere((coA) => coA.author.authorID == authorID, orElse: ()=> null);
  //   return authorData;
  // }

  String hatContactFromContactsByContactType(List<ContactModel> contacts, ContactType contactType){
    String contact = contacts?.singleWhere((co) => co.contactType == contactType, orElse: ()=> null)?.contact;
    return contact;
  }

  List<CoSlide> hatCoSlidesByFlyerID(String flyerID){
    List<CoSlide> flyerCoSlides = new List();
    _loadedCoFlyers.forEach((coF) {
      if(coF.flyer.flyerID == flyerID){flyerCoSlides.addAll(coF.coSlides,);}
    });
    return flyerCoSlides;
  }

  String hatBzIDByFlyerID(String flyerID){
    String bzID = getBzIDByFlyerID(flyerID);
    return bzID;
  }

  bool hatFollowIsOnByFlyerID(String flyerID){
    String flyerBzID = hatBzIDByFlyerID(flyerID);
    String bzFollow = _followedBzzIDs.singleWhere((bzID) => bzID == flyerBzID, orElse: ()=> null);
    bool followIsOn = bzFollow == null ? false : true;
    return followIsOn;
  }


  List<CoFlyer> get hatAllSavedCoFlyers {
    return _loadedCoFlyers.where((coFlyer)=> coFlyer.ankhIsOn).toList();
  }




// void addFlyerInBeginning(ProcessedFlyerData newFlyer){
  //   _downloadedFlyers.insert(0, newFlyer);
  //   notifyListeners();
  // }
  // void addFlyerInEnd(ProcessedFlyerData newFlyer){
  //   _downloadedFlyers.add(newFlyer);
  //   notifyListeners();
  // }


}