// import 'package:bldrs/ambassadors/database/db_author.dart';
// import 'package:bldrs/ambassadors/database/db_bzz.dart';
// import 'package:bldrs/ambassadors/database/db_call.dart';
// import 'package:bldrs/ambassadors/database/db_connection.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_email.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_facebook.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_instagram.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_linkedin.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_phone.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_pinterest.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_tiktok.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_twitter.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_website.dart';
// import 'package:bldrs/ambassadors/database/db_flyer.dart';
// import 'package:bldrs/ambassadors/database/db_follow.dart';
// import 'package:bldrs/ambassadors/database/db_horus.dart';
// import 'package:bldrs/ambassadors/database/db_save.dart';
// import 'package:bldrs/ambassadors/database/db_share.dart';
// import 'package:bldrs/ambassadors/database/db_user.dart';
// import 'package:bldrs/models/bz_model.dart';
// import 'package:bldrs/models/enums/enum_flyer_type.dart';
// import 'package:bldrs/models/flyer_model.dart';
// import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_author.dart';
// import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_bz.dart';
// import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_flyer.dart';
// import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_slide.dart';
// import 'package:bldrs/models/old_models_to_delete_when_done/combined_models/co_user.dart';
// import 'package:bldrs/models/stenographs/call_model.dart';
// import 'package:bldrs/models/stenographs/joint_model.dart';
// import 'package:bldrs/models/stenographs/follow_model.dart';
// import 'package:bldrs/models/stenographs/horus_model.dart';
// import 'package:bldrs/models/stenographs/save_model.dart';
// import 'package:bldrs/models/stenographs/share_model.dart';
// import 'package:bldrs/models/sub_models/author_model.dart';
// import 'package:bldrs/models/sub_models/contact_model.dart';
// import 'package:bldrs/models/sub_models/slide_model.dart';
// import 'package:bldrs/models/user_model.dart';
// import 'package:bldrs/xxx_LABORATORY/testers/test_subjects.dart';
//
// bool emptyDB = false; /// wrongEntry switch for testing is here [wrongEntry]
//
// List<AuthorModel>     xAuthors          = emptyDB? [] : dbAuthors;
// List<BzModel>         xBzz              = emptyDB? [] : dbBzz;
// List<CallModel>       xCalls            = emptyDB? [] : dbCalls;
// List<ConnectionModel> xConnections      = emptyDB? [] : dbConnections;
// List<FlyerModel>      xFlyers           = emptyDB? [] : dbFlyers;
// List<FollowModel>     xFollows          = emptyDB? [] : dbFollows;
// List<HorusModel>      xHorusee          = emptyDB? [] : dbHorusee;
// List<SaveModel>       xSaves            = emptyDB? [] : dbSaves;
// List<ShareModel>      xShares           = emptyDB? [] : dbShares;
// List<SlideModel>      xSlides           = emptyDB? [] : [];
// List<UserModel>       xUsers            = emptyDB? [] : dbUsers;
// List<ContactModel>    xEmails           = emptyDB? [] : dbEmails;
// List<ContactModel>    xFacebooks        = emptyDB? [] : dbFacebooks;
// List<ContactModel>    xInstagrams       = emptyDB? [] : dbInstagrams;
// List<ContactModel>    xLinkedins        = emptyDB? [] : dbLinkedins;
// List<ContactModel>    xPhones           = emptyDB? [] : dbPhones;
// List<ContactModel>    xPinterests       = emptyDB? [] : dbPinterests;
// List<ContactModel>    xTiktoks          = emptyDB? [] : dbTiktoks;
// List<ContactModel>    xTwitters         = emptyDB? [] : dbTwitters;
// List<ContactModel>    xWebsites         = emptyDB? [] : dbWebsites;
//
// // ----------------------------------------------------------------------------
// // --- USER FETCHERS
//
// UserModel getUserByUserID(String userID){
//   UserModel userData = xUsers.singleWhere((user) => user.userID == userID, orElse: ()=> null);
//   return userData;
// }
// // ----------------------------------------------------------------------------
// List<ContactModel> getContactsFromContactsByOwnerID(List<ContactModel> list, String ownerID){
//   List<ContactModel> outputList = new List();
//   list.forEach((co) {
//     if (co.ownerID  == ownerID){outputList.add(co);}
//   });
//   return outputList; // can never be null only empty list
// }
// // ----------------------------------------------------------------------------
// List<ContactModel> getContactsByOwnerID(String ownerID){
//   List<ContactModel> ownerContacts = new List();
//
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xEmails, ownerID));
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xFacebooks, ownerID));
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xInstagrams, ownerID));
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xLinkedins, ownerID));
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xPhones, ownerID));
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xPinterests, ownerID));
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xTiktoks, ownerID));
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xTwitters, ownerID));
//   ownerContacts.addAll(getContactsFromContactsByOwnerID(xWebsites, ownerID));
//
//   return ownerContacts.isEmpty ? null : ownerContacts;
// }
// // ----------------------------------------------------------------------------
// // List<ContactModel> getContactModelByContactTypeWithID(int index, String userID){
// //   List<ContactModel> contactList = getContactModelListByID(userID);
// //   if (contactList == null){contactList = [];}
// //   return index >= contactList?.length || index < 0 ? null :
// //   contactList[index];
// // }
// // ----------------------------------------------------------------------------
// CoUser getCoUserByUserID(String userID){
//
//   UserModel user = getUserByUserID(userID);
//   List<ContactModel> userContacts = getContactsByOwnerID(userID);
//
//   return CoUser(
//       user: user,
//       userContacts: userContacts,
//   );
// }
// // ----------------------------------------------------------------------------
// // ----------------------------------------------------------------------------
// // --- AUTHOR FETCHERS
//
// // UserModel getAuthorByUserID(){} should go to provider
// // UserModel getUserByAuthorID(){} should go to provider
// // ----------------------------------------------------------------------------
// AuthorModel getAuthorByAuthorID(String authorID){
//   AuthorModel author = xAuthors.singleWhere((au) => au.authorID == authorID, orElse: ()=> null);
//   return author;
// }
// // ----------------------------------------------------------------------------
// List<ConnectionModel> getConnectionsByAuthorID(String authorID){
//   List<ConnectionModel> connections = new List();
//   xConnections.forEach((co) {
//     if (co.requesterID == authorID || co.responderID == authorID){
//       connections.add(co);
//     }
//   });
//   return connections;
// }
// // ----------------------------------------------------------------------------
// CoAuthor getCoAuthorByAuthorID(String authorID){
//
//   AuthorModel author = getAuthorByAuthorID(authorID);
//   CoUser coUser = getCoUserByUserID(author?.userID);
//   List<ConnectionModel> connections = getConnectionsByAuthorID(authorID);
//   List<String> authorFlyersID = getFlyersIDsByAuthorID(authorID);
//
//   return CoAuthor(
//       author: author,
//       coUser: coUser,
//       connections: connections,
//       authorFlyersIDs: authorFlyersID,
//   );
// }
// // ----------------------------------------------------------------------------
// List<CoAuthor> getAllCoAuthors(){
//   List<CoAuthor> allCoAuthors = new List();
//   xAuthors.forEach((au) {
//     allCoAuthors.add(getCoAuthorByAuthorID(au.userID));
//   });
//   return allCoAuthors;
// }
// // ----------------------------------------------------------------------------
// // ----------------------------------------------------------------------------
// // --- BZ FETCHERS
//
// BzModel getBzByBzID(String bzID){
//   BzModel bz = xBzz.singleWhere((bz) => bz.bzId == bzID, orElse: ()=>null);
//   return bz;
// }
//
// BzModel getBzByAuthorID(String authorID){
//   String bzID = getAuthorByAuthorID(authorID)?.bzId;
//   BzModel bzModel = getBzByBzID(bzID);
//   return bzModel;
// }
//
// List<BzModel> getAllBzz(){
//   List<BzModel> allBz = new List();
//   xBzz.forEach((b) {
//     allBz.add(getBzByBzID(b.bzId));
//   });
//   return allBz;
// }
//
// LocationModel getLocationByBzID(String bzID){
//   LocationModel location = xBzzLocations.singleWhere((lo) => lo.ownerID == bzID, orElse: ()=> null);
//   return location;
// }
//
// List<FollowModel> getFollowsByBzID(String bzID){
//   List<FollowModel> follows = new List();
//   xFollows.forEach((fo) {
//     if (fo.bzID == bzID){follows.add(fo);}
//   });
//   return follows;
// }
//
// List<CoAuthor> getCoAuthorsByBzID(String bzID){
//   List<CoAuthor> coAuthors = new List();
//   xAuthors.forEach((au) {
//     if(au.bzId == bzID){coAuthors.add(getCoAuthorByAuthorID(au.authorID));}
//   });
//   return coAuthors;
// }
//
// Function getContactsByBzId = getContactsByOwnerID;
//
// CoBz getCoBzByAuthorID(String authorID){
//   String bzID = getBzByAuthorID(authorID)?.bzId;
//   CoBz coBz = getCoBzByBzID(bzID);
//   return coBz;
// }
//
// CoBz getCoBzByBzID(String bzID){
//
//   BzModel bz = getBzByBzID(bzID);
//   List<ContactModel> bzContacts = getContactsByBzId(bzID);
//   LocationModel bzLocation = getLocationByBzID(bzID);
//   int followsCount = getFollowsByBzID(bzID)?.length;
//   List<CoAuthor> coAuthors = getCoAuthorsByBzID(bzID);
//   List<String> bzCallsIDs = getCallsIDsByBzID(bzID);
//   int bzSlidesCount = getSlidesIDsByBzID(bzID)?.length;
//   int bzTotalViews = getAllHoruseeUsersIDsByBzID(bzID)?.length;
//   int bzTotalShares = getAllSharesUsersIDsByBzID(bzID)?.length;
//   int bzTotalSaves = getAllSavesUsersIDsByBzID(bzID)?.length;
//   int bzTotalConnections = getAllConnectionsByBzID(bzID)?.length;
//   // int
//
//   return CoBz(
//     bz: bz,
//     bzContacts: bzContacts,
//     bzLocation: bzLocation,
//     followsCount: followsCount,
//     coAuthors: coAuthors,
//     callsCount: bzCallsIDs.length,
//     bzTotalViews: bzTotalViews,
//     bzTotalSlides: bzSlidesCount,
//     bzTotalShares: bzTotalShares,
//     bzTotalSaves: bzTotalSaves,
//     bzConnects: bzTotalConnections,
//     // followIsOn:
//   );
// }
//
// List<CoBz> getAllCoBz(){
//   List<CoBz> allCoBz = new List();
//   xBzz.forEach((b) {
//     allCoBz.add(getCoBzByBzID(b.bzId));
//   });
//   return allCoBz.isEmpty? null : allCoBz;
// }
//
// // ----------------------------------------------------------------------------
// // --- SLIDE FETCHERS
//
// SlideModel getSlideBySlideID(String slideID){
//   SlideModel slide = xSlides.singleWhere((sl) => sl.slideID == slideID, orElse: ()=> null);
//   return slide;
// }
//
//
//
//
//
// List<CallModel> getCallsBySlideID(String slideID){
//   List<CallModel> calls = new List();
//   xCalls.forEach((ca) {
//     if (ca.slideID == slideID){calls.add(ca);}
//   });
//   return calls; // should never be null but only []
// }
//
// List<ShareModel> getSharesBySlideID(String slideID){
//   List<ShareModel> shares = new List();
//   xShares.forEach((sh) {
//     if (sh.slideID == slideID){shares.add(sh);}
//   });
//   return shares; // should never be null but only []
// }
//
// List<HorusModel> getHoruseeBySlideID(String slideID){
//   List<HorusModel> horusee = new List();
//   xHorusee.forEach((ho) {
//     if (ho.slideID == slideID){horusee.add(ho);}
//   });
//   return horusee; // should always be empty list not null
// }
//
// List<SaveModel> getSavesBySlideID(String slideID){
//   List<SaveModel> saves = new List();
//   xSaves.forEach((sa) {
//     if (sa.slideID == slideID && sa.saveState == SaveState.Saved){saves.add(sa);}
//   });
//   return saves;
// }
//
//
// CoSlide getCoSlideBySlideID(String slideID){
//
//   SlideModel slide = getSlideBySlideID(slideID);
//   int callsCount = getCallsBySlideID(slideID)?.length;
//   int sharesCount = getSharesBySlideID(slideID)?.length;
//   int horuseeCount = getHoruseeBySlideID(slideID)?.length;
//   int savesCount = getSavesBySlideID(slideID)?.length;
//
//   return CoSlide(
//       slide: slide,
//       callsCount: callsCount,
//       sharesCount: sharesCount,
//       horuseeCount: horuseeCount,
//       savesCount: savesCount,
//   );
// }
//
// // ----------------------------------------------------------------------------
// // --- FLYER FETCHERS
//
// FlyerModel getFlyerByFlyerID(String flyerID){
//   FlyerModel flyer = xFlyers.singleWhere((fl) => fl.flyerID == flyerID, orElse: ()=> null);
//   return flyer;
// }
//
// LocationModel getFlyerLocationByFlyerID(String flyerID){
//   LocationModel flyerLocation = xFlyersLocations.singleWhere((lo) => lo.ownerID == flyerID,
//   orElse: () => null);
//   return flyerLocation;
// }
//
// List<String> getSlidesIDsByFlyerID(String flyerID){
//   List<String> slidesIDs = new List();
//   xSlides.forEach((sl) {
//     if (sl.flyerID == flyerID){slidesIDs.add(sl.slideID);}
//   });
//   return slidesIDs; // can't be null
// }
//
// List<CoSlide> getCoSlidesByFlyerID(String flyerID){
//   List<CoSlide> coSlides = new List();
//   List<String> slidesIDs = getSlidesIDsByFlyerID(flyerID);
//   for (String slideID in slidesIDs){
//     xSlides.forEach((sl) {
//       if(sl.slideID == slideID){coSlides.add(getCoSlideBySlideID(slideID));}
//     });
//   }
//   return coSlides;
// }
//
// String getAuthorIDByFlyerID(String flyerID){
//   String authorID = xFlyers.singleWhere((fl) => fl.flyerID == flyerID, orElse: ()=> null)?.authorID;
//   return authorID;
// }
//
// CoBz getCoBzByFlyerID(String flyerID){
//   String authorID = getAuthorIDByFlyerID(flyerID);
//   CoBz coBz = getCoBzByAuthorID(authorID);
//   return coBz;
// }
//
// bool getAnkhByFlyerIDWithUserID(String flyerID, String userID){
//   bool ankhIsOn;
//   List<String> slidesIDs = getSlidesIDsByFlyerID(flyerID);
//
//   for (String sID in slidesIDs){
//     if (ankhIsOn==true) break;
//     for (SaveModel sv in xSaves){
//       if (sv.userID == userID && sv.saveState == SaveState.Saved){ankhIsOn = true;}
//       else
//       if (sv.userID == userID && sv.saveState == SaveState.UnSaved){ankhIsOn = false;}
//     }
//   }
//
//   return ankhIsOn;
// }
//
// CoFlyer getCoFlyerByFlyerID(String flyerID){
//
//   FlyerModel flyer = getFlyerByFlyerID(flyerID);
//   LocationModel flyerLocation = getFlyerLocationByFlyerID(flyerID);
//   List<CoSlide> coSlides = getCoSlidesByFlyerID(flyerID);
//   CoBz coBz = getCoBzByFlyerID(flyerID);
//
//   return CoFlyer(
//       flyer: flyer,
//       flyerLocation: flyerLocation,
//       coSlides: coSlides,
//       coBz: coBz,
//   );
// }
//
// // ----------------------------------------------------------------------------
// // --- COLLECTION FETCHERS
//
// List<String> getFlyersIDsByAuthorID(String authorID){
//   List<String> flyersIDs = new List();
//   xFlyers.forEach((fl) {
//     if(fl.authorID == authorID){flyersIDs.add(fl.flyerID);}
//   });
//   return flyersIDs; // can not be null
// }
//
// List<CoFlyer> getCoFlyersByAuthorID(String authorID){
//   List<CoFlyer> coFlyers = new List();
//   List<String> flyersIDs = getFlyersIDsByAuthorID(authorID);
//   for(String fID in flyersIDs){
//     xFlyers.forEach((fl) {
//       if(fl.flyerID == fID){coFlyers.add(getCoFlyerByFlyerID(fID));}
//     });
//   }
//   return coFlyers.isEmpty ? null : coFlyers;
// }
//
// List<String> getFlyersIDsByFlyerType(FlyerType flyerType){
//   List<String> flyersIDs = new List();
//   xFlyers.forEach((fl) {
//     if(fl.flyerType == flyerType){flyersIDs.add(fl.flyerID);}
//   });
//   return flyersIDs;
// }
//
// List<CoFlyer> getCoFlyersByFlyerType(FlyerType flyerType){
//   List<CoFlyer> coFlyers = new List();
//   List<String> flyersIDs = getFlyersIDsByFlyerType(flyerType);
//   for(String flyerID in flyersIDs){
//     xFlyers.forEach((fl) {
//       if(fl.flyerID == flyerID){coFlyers.add(getCoFlyerByFlyerID(flyerID));}
//     });
//   }
//   return coFlyers;//.isEmpty ? null : coFlyers;
// }
//
// List<CoFlyer> getAllCoFlyers(){
//   List<CoFlyer> allCoFlyers = new List();
//   xFlyers.forEach((fl) {
//     allCoFlyers.add(getCoFlyerByFlyerID(fl.flyerID));
//   });
//   return allCoFlyers;
// }
//
// // ----------------------------------------------------------------------------
// // --- SAVES FETCHERS
//
//
// List<String> getSavedSlidesIDsByUserID(String userID){
//   List<String> savedSlidesIDs = new List();
//   xSaves.forEach((sv) {
//     if (sv.userID == userID && sv.saveState == SaveState.Saved){savedSlidesIDs.add(sv.slideID);}
//   });
//   return savedSlidesIDs;
// }
//
// String getFlyerIDBySlideID(String slideID){
//   String flyerID = xSlides.singleWhere((sl) => sl.slideID == slideID, orElse: ()=> null)?.flyerID;
//   return flyerID;
// }
//
// CoFlyer getCoFlyerBySlideID(String slideID){
//   String flyerID = getFlyerIDBySlideID(slideID);
//   CoFlyer coFlyer = getCoFlyerByFlyerID(flyerID);
//   return coFlyer;
// }
//
// List<CoFlyer> getSavedCoFlyersByUserID(String userID){
//   List<CoFlyer> savedCoFlyers = new List();
//   List<String> savedSlidesIDs = getSavedSlidesIDsByUserID(userID);
//
//   savedSlidesIDs.forEach((sID) {
//     savedCoFlyers.add(getCoFlyerBySlideID(sID));
//   });
//
//   return savedCoFlyers;
// }
//
// // EXTRAS
//
// List<UserModel> getAllUsers(){
//   List<UserModel> allUsers = xUsers;
//   return allUsers;
// }
//
// String getBzIDByAuthorID(String authorID){
//   String bzID = xAuthors.singleWhere((au) => au.authorID == authorID, orElse: ()=> null)?.bzId;
//   return bzID;
// }
//
// String getBzIDByFlyerID(String flyerID){
//   String authorID = getAuthorIDByFlyerID(flyerID);
//   String bzID = getBzIDByAuthorID(authorID);
//   return bzID;
// }
//
// bool getFollowIsOnByUserIDWithFlyerID(String userID, String flyerID){
//   String bzID = getBzIDByFlyerID(flyerID);
//   FollowModel follow = xFollows.singleWhere(
//           (fo) =>
//           fo.userID == userID &&
//               fo.bzID == bzID &&
//               fo.followState == FollowState.accepted,
//       orElse: ()=> null);
//   return follow == null ? false : true;
// }
//
// List<String> getFollowedBzzIDsByUserID(String userID){
//   List<String> followedBzzIDs= new List();
//   for (FollowModel fo in xFollows){
//     if (fo.userID == userID){followedBzzIDs.add(fo.bzID);}
//   }
//   return followedBzzIDs;
// }
//
// List<String> getAuthorsIDsByBzID(String bzID){
//   List<String> authorsIDs = new List();
//   xAuthors.forEach((au) {
//     if (au.bzId == bzID){authorsIDs.add(au.authorID);}
//   });
//   return authorsIDs;
// }
//
// List<String> getFlyersIDsByBzID(String bzID){
//   List<String> flyersIDs = new List();
//   List<String> authorsIDs = getAuthorsIDsByBzID(bzID);
//   authorsIDs.forEach((aID) {
//     flyersIDs.addAll(getFlyersIDsByAuthorID(aID));
//   });
//   return flyersIDs;
// }
//
// List<String> getSlidesIDsByBzID(String bzID){
//   List<String> bzSlidesIDs = new List();
//   List<String> bzFlyersIDs = getFlyersIDsByBzID(bzID);
//   for (String id in bzFlyersIDs){bzSlidesIDs.addAll(getSlidesIDsByFlyerID(id));}
//   return bzSlidesIDs;
// }
//
// List<String> getCallsIDsByBzID(String bzID){
//   List<String> bzCallsIDs = new List();
//   List<String> bzSlidesIDs = getSlidesIDsByBzID(bzID);
//   for (String id in bzSlidesIDs){
//     xCalls.forEach((ca) {
//       if (ca.slideID == id){bzCallsIDs.add(ca.callID);}
//     });
//   }
//   return bzCallsIDs;
// }
//
// List<String> getAllHoruseeUsersIDsByBzID(String bzID){
//   List<String> allHoruseeUserIDs = new List();
//   List<String> bzSlidesIDs = getSlidesIDsByBzID(bzID);
//
//   for (String sID in bzSlidesIDs){
//     xHorusee.forEach((ho) {
//       if(ho.slideID == sID){allHoruseeUserIDs.add(ho.userID);}
//     });
//   }
// return allHoruseeUserIDs;
// }
//
// List<String> getAllSharesUsersIDsByBzID(String bzID){
//   List<String> allSharesUsersIDs = new List();
//   List<String> bzSlidesIDs = getSlidesIDsByBzID(bzID);
//
//   for (String sID in bzSlidesIDs){
//     xShares.forEach((sh) {
//       if (sh.slideID == sID){allSharesUsersIDs.add(sh.userID);}
//     });
//   }
//
//   return allSharesUsersIDs;
// }
//
// List<String> getAllSavesUsersIDsByBzID(String bzID){
//   List<String> savesUsersIDs = new List();
//   List<String> bzSlidesIDs = getSlidesIDsByBzID(bzID);
//   for (String sID in bzSlidesIDs){
//     xSaves.forEach((sa) {
//       if(sa.slideID == sID){savesUsersIDs.add(sa.userID);}
//     });
//   }
//   return savesUsersIDs;
// }
//
// List<ConnectionModel> getAllConnectionsByBzID(String bzID){
//   List<ConnectionModel> bzConnections = new List();
//   List<String> bzAuthorsIDs = getAuthorsIDsByBzID(bzID);
//   for (String aID in bzAuthorsIDs){
//     bzConnections.addAll(getConnectionsByAuthorID(aID));
//   }
//   return bzConnections;
// }