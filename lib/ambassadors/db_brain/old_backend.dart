// import 'package:bldrs/ambassadors/database/db_author.dart';
// import 'package:bldrs/ambassadors/database/db_bz.dart';
// import 'package:bldrs/ambassadors/database/db_call.dart';
// import 'package:bldrs/ambassadors/database/db_connection.dart';
// import 'package:bldrs/ambassadors/database/db_contacts/db_phone.dart';
// import 'package:bldrs/ambassadors/database/db_flyer.dart';
// import 'package:bldrs/ambassadors/database/db_follow.dart';
// import 'package:bldrs/ambassadors/database/db_horus.dart';
// import 'package:bldrs/ambassadors/database/db_save.dart';
// import 'package:bldrs/ambassadors/database/db_share.dart';
// import 'package:bldrs/ambassadors/database/db_slide.dart';
// import 'package:bldrs/ambassadors/database/db_user.dart';
// import 'package:bldrs/mos/enum_bz_type.dart';
// import 'package:bldrs/mos/enum_flyer_type.dart';
// import 'package:bldrs/mos/author_model.dart';
// import 'package:bldrs/mos/bz_model.dart';
// import 'package:bldrs/mos/call_model.dart';
// import 'package:bldrs/mos/connection_model.dart';
// import 'package:bldrs/mos/contact_model.dart';
// import 'package:bldrs/mos/flyer_model.dart';
// import 'package:bldrs/mos/follow_model.dart';
// import 'package:bldrs/mos/horus_model.dart';
// import 'package:bldrs/mos/save_model.dart';
// import 'package:bldrs/mos/share_model.dart';
// import 'package:bldrs/mos/slide_model.dart';
// import 'package:bldrs/mos/user_model.dart';
// import 'package:bldrs/mos/user_contact_model.dart';
// import 'package:bldrs/providers/processed_models/processed_flyer.dart';
//
// List<MoFlyer> xFlyersList = dbFlyers;
// List<MoBz> xBzList = dbBzz;
// List<MoSlide> xSlidesList = dbSlides;
// List<MoAuthor> xAuthorsList = dbAuthors;
// List<MoUser> xUsersList = dbUsers;
// List<MoContact> xUsersContactsList = dbPhones; // for now
// List<MoHorus> xViewsList = dbHorusee;
// List<MoSave> xSavesList = dbSaves;
// List<MoShare> xSharesList = dbShares;
// List<MoFollow> xFollowsList = dbFollows;
// List<MoCall> xCallsList = dbCalls;
// List<MoConnection> xConnectionsList = dbConnections;
//
// /// Class searchResult = listOfClassObjects.singleWhere((x) => x.theSearchMatchWeAreLookingForInSearchList == inputToSearchFor);
//
//
// // --- returns ProcessedFlyerData
// flyerIDProcessor (String flyerID){
//
//   // FLYER -------------------------------------------------------
//   // 0--- select flyer by ID
//   String vFlyerID = flyerID; // vflyer is view Flyer and to be defined manually for now
//
//   // 1--- get vFlyerData searching by flyerID in *flyers list*
//   MoFlyer vFlyerData = xFlyersList.singleWhere((x) => x.flyerID == vFlyerID);
//
//   // AUTHOR -------------------------------------------------------
//   // 2--- get vAuthorID from flyerData
//   String vAuthorID = vFlyerData.authorID;
//
//   // 3--- get vAuthorData searching by authorID in *authors list*
//   MoAuthor vAuthorData = xAuthorsList.singleWhere((x) => x.authorID == vAuthorID);
//
//   // USER -------------------------------------------------------
//   // 4--- get vUserID from authorData
//   String vUserId = vAuthorData.userID;
//
//   // 5--- get vUserData searching by vUserID in *users List*
//   MoUser vUserData = xUsersList.singleWhere((id) => id.userID == vUserId);
//
//   // BZ -------------------------------------------------------
//   // 6--- get vBzID from vAuthorID
//   String vBzID = vAuthorData.bzId;
//
//   // 7--- get vBzData searching by vBzID in *Bz List*
//   MoBz vBzData = xBzList.singleWhere((id) => id.bzId == vBzID);
//
//   // FLYER SLIDES -------------------------------------------------------
//   // 8--- create new empty list to hold the slides
//   List<MoSlide> vSlideData = new List();
//
//   // 9--- search all slides in *Slides List* for vFlyerID and add matching slides in the empty list vSlideData
//   xSlidesList.forEach((slide) {
//     if(slide.flyerID == vFlyerID){vSlideData.add(slide);}
//   });
//
//   // SLIDES PICTURES -------------------------------------------------------
//   // 10--- create new empty list to hold slide pictures
//   List<String> vSlidesPictures = [];
//
//   // 11--- add all found pictures in vSlideData into the new list of pictures
//   vSlideData.forEach((slide) {
//     vSlidesPictures.add(slide.picture);
//   });
//
//   // SLIDES HEADLINES -------------------------------------------------------
//   // 12--- create new empty list to hold slide headlines
//   List<String> vSlidesHeadlines = [];
//
//   // 13--- add all found headlines in vSlideData into the new list of headlines
//   vSlideData.forEach((slide) {
//     vSlidesHeadlines.add(slide.headline);
//   });
//
//   // SLIDES IDS -------------------------------------------------------
//   // 14--- create new empty list slideIDs to use for searching views
//   List<String> vSlidesIDs = [];
//
//   // 15--- loop in vSlideData to get all slides IDs to add them into the list vSlidesIDs
//   for (MoSlide n in vSlideData){
//     vSlidesIDs.add(n.slideID);
//   }
//
//
//   // SLIDES VIEWS -------------------------------------------------------
//   // 16--- create an empty list of all slides Views
//   List<MoHorus> vAllSlidesViewsData = [];
//
//   // 17--- for every SlideID in vSlidesIDs, will search db for matching IDs
//   // and add them one by one to the empty combined list vAllSlidesViewsData
//   for (String x in vSlidesIDs){
//     xViewsList.forEach((view) {
//       if(view.slideID == x){vAllSlidesViewsData.add(view);}
//     });
//   }
//
//   // 18--- create an empty Map to store <slideID : viewsCount>
//   var viewsMap = Map();
//
//   // 19--- initialize value of zero for each pair in the map to define
//   // the length of the map
//   vSlideData.forEach((z) {
//     viewsMap[z.slideID] = 0;
//   });
//
//   // 20--- loop in every object in the combined vAllSlidesViewsData to
//   // override a value of 1 count for every unique slide ID
//   // and add a value of 1 for each duplicate slide ID
//   // Note : vAllSlidesViewsData does not contain the slides that were not viewed and were not stored in db
//   vAllSlidesViewsData.forEach((z) {
//     if(!viewsMap.containsKey(z.slideID)){
//       viewsMap[z.slideID] = 1;
//     }
//     else {
//       viewsMap[z.slideID] += 1;
//     }
//   });
//
//   // 21--- create empty list as final views list
//   List<int> vSlidesViewsList = [];
//
//   // 22--- separate the values counted in the map into a separate list of views
//   viewsMap.forEach((key, value)=> vSlidesViewsList.add(value));
//
//   // SLIDES Saves -------------------------------------------------------
//   // 23--- the exact process of finding slidesViews starting function number 16
//   List<MoSave> vAllSlidesSavesData = [];
//
//   // 24--- for every SlideID in vSlidesIDs, will search db for matching IDs
//   // and add them one by one to the empty combined list vAllSlidesSavesData
//   for (String x in vSlidesIDs){
//     xSavesList.forEach((save) {
//       if(save.slideID == x){vAllSlidesSavesData.add(save);}
//
//     });
//   }
//   // print('slide saves list for ${vSlidesIDs[0]} is $vAllSlidesSavesData');
//
//   // 25--- create an empty Map to store <slideID : savesCount>
//   var savesMap = Map();
//
//   // 26--- initialize value of zero for each pair in the map to define
//   // the length of the map
//   vSlideData.forEach((z) {
//     savesMap[z.slideID] = 0;
//   });
//
//   // 27--- loop in every object in the combined vAllSlidesSavesData to
//   // override a value of 1 count for every unique slide ID
//   // and add a value of 1 for each duplicate slide ID
//   // Note : vAllSlidesSavesData does not contain the slides that were not saved and were not stored in db
//   vAllSlidesSavesData.forEach((z) {
//     if(!savesMap.containsKey(z.slideID)){
//       savesMap[z.slideID] = 1;
//     }
//     else {
//       savesMap[z.slideID] += 1;
//     }
//   });
//
//   // 28--- create empty list as final views list
//   List<int> vSlidesSavesList = [];
//
//   // 29--- separate the values counted in the map into a separate list of views
//   savesMap.forEach((key, value)=> vSlidesSavesList.add(value));
//
//   // SLIDES Shares -------------------------------------------------------
//   // 30--- the exact process of finding slidesViews starting function number 16 and 23
//   List<MoShare> vAllSlidesSharesData = [];
//
//   // 31--- for every SlideID in vSlidesIDs, will search db for matching IDs
//   // and add them one by one to the empty combined list vAllSlidesSharesData
//   for (String x in vSlidesIDs){
//     xSharesList.forEach((share) {
//       if(share.slideID == x){vAllSlidesSharesData.add(share);}
//     });
//   }
//
//   // 32--- create an empty Map to store <slideID : sharesCount>
//   var sharesMap = Map();
//
//   // 33--- initialize value of zero for each pair in the map to define
//   // the length of the map
//   vSlideData.forEach((z) {
//     sharesMap[z.slideID] = 0;
//   });
//
//   // 34--- loop in every object in the combined vAllSlidesSharesData to
//   // override a value of 1 count for every unique slide ID
//   // and add a value of 1 for each duplicate slide ID
//   // Note : vAllSlidesSharesData does not contain the slides that were not saved and were not stored in db
//   vAllSlidesSharesData.forEach((z) {
//     if(!sharesMap.containsKey(z.slideID)){
//       sharesMap[z.slideID] = 1;
//     }
//     else {
//       sharesMap[z.slideID] += 1;
//     }
//   });
//
//   // 35--- create empty list as final views list
//   List<int> vSlidesSharesList = [];
//
//   // 36--- separate the values counted in the map into a separate list of views
//   sharesMap.forEach((key, value)=> vSlidesSharesList.add(value));
//
//   // AnkhIsOn -------------------------------------------------------
//   // 37--- define who ise the user
//   String currentUser = 'u21';
//
//   // 38--- initialize false values for each slide
//   // List<bool> flyerAnkhs = [];
//
//   bool vFlyerUserAnkh = false;
//
//   if (vFlyerUserAnkh == false){
//
//     vSlideData.forEach((x) {
//       xSavesList.forEach((save) {
//         if (save.userID == currentUser && save.slideID == x.slideID) {vFlyerUserAnkh = true;}
//       });
//     });
//
//   } else {}
//
//   // BZ FOLLOWERS -------------------------------------------------------
//   // 39---
//   int vFollowersCount = 0;
//   xFollowsList.forEach((follow) {
//     if ( follow.bzID == vBzID ) {vFollowersCount++;}
//   });
//
//
//   // CALLS -------------------------------------------------------
//   // 40 --- GET ALL AuthorsIDs for this BzID
//   List<String> vAllAuthorsIDsOfThisBz = [];
//   xAuthorsList.forEach((author) {
//     if(author.bzId == vBzID){vAllAuthorsIDsOfThisBz.add(author.authorID);}
//   });
//
//   // 41 --- GET All FlyersIDs by All AuthorsIDs
//   List<String> vAllFlyersIDSByAllAuthors = [];
//   for (String x in vAllAuthorsIDsOfThisBz){
//     xFlyersList.forEach((flyer) {
//       if(flyer.authorID == x){vAllFlyersIDSByAllAuthors.add(flyer.flyerID);}
//     });
//   }
//
//   int vBzFlyersCount = vAllFlyersIDSByAllAuthors.length;
//
//   // 42 --- GET ALL SlidesIDs in All FlyerIDs
//   List<String> vAllSlidesIDsInAllFlyersByAllAuthorsInThisBz =[];
//
//   for (String x in vAllFlyersIDSByAllAuthors){
//     xSlidesList.forEach((slide) {
//       if(slide.flyerID == x){vAllSlidesIDsInAllFlyersByAllAuthorsInThisBz.add(slide.slideID);}
//     });
//   }
//
//   int vBzSlidesCount = vAllSlidesIDsInAllFlyersByAllAuthorsInThisBz.length;
//
//   // 43 -- GET ALL BZ CALLS & COUNT
//   List<MoCall> vBzCallsData = [];
//   for (String slide in vAllSlidesIDsInAllFlyersByAllAuthorsInThisBz){
//     xCallsList.forEach((call) {
//       if(call.slideID == slide){vBzCallsData.add(call);}
//     });
//   }
//
//   int vBzCallsCount = vBzCallsData.length;
//
//   // 44 -- GET ALL BZ VIEWS & COUNT
//   List<MoHorus> vBzViews = [];
//   for (String z in vAllSlidesIDsInAllFlyersByAllAuthorsInThisBz) {
//     xViewsList.forEach((view) {
//       if(view.slideID == z){vBzViews.add(view);}
//     });
//   }
//   int vBzViewsCount = vBzViews.length;
//
//
//   // 45 -- GET ALL BZ SHARES & COUNT
//   List<MoShare> vBzShares = [];
//   for (String s in vAllSlidesIDsInAllFlyersByAllAuthorsInThisBz) {
//     xSharesList.forEach((share) {
//       if(share.slideID == s){vBzShares.add(share);}
//     });
//   }
//
//   int vBzSharesCount = vBzShares.length;
//
//   // 45 -- GET ALL BZ SAVES & COUNT
//   List<MoSave> vBzSaves = [];
//   for (String v in vAllSlidesIDsInAllFlyersByAllAuthorsInThisBz) {
//     xSavesList.forEach((save) {
//       if(save.slideID == v){vBzSaves.add(save);}
//     });
//   }
//
//   int vBzSavesCount = vBzSaves.length;
//
//
//   // CONNECTS -------------------------------------------------------
//   // 46 --- GET THIS BZ CONNECTIONS
//   List<MoConnection> vBzConnections = [];
//
//   xConnectionsList.forEach((connection) {
//     if((connection.responderID == vBzID || connection.requesterID == vBzID)&&(connection.connectionState == ConnectionState.Approved))
//     {vBzConnections.add(connection);}
//   });
//
//   int vBzConnectionsCount = vBzConnections.length;
//
//   //  XXXXXXXXXXXXXXXX----- PRINTER -----XXXXXXXXXXXXXXXX
//   //  XXXXXXXXXXXXXXXX----- PRINTER -----XXXXXXXXXXXXXXXX
//   // print(vFlyerUserAnkh);
//   //  XXXXXXXXXXXXXXXX----- PRINTER -----XXXXXXXXXXXXXXXX
//   //  XXXXXXXXXXXXXXXX----- PRINTER -----XXXXXXXXXXXXXXXX
//
//   return ProcessedFlyerData(
//     flyerID: flyerID,
//     authorID: vFlyerData.authorID,
//     flyerShowsAuthor: vFlyerData.flyerShowsAuthor,
//     flyerType: vFlyerData.flyerType,
//     keyWords: vFlyerData.keyWords,
//     // publishTime: ,
//     // x_dummy_database.location: ,
//     // -------------------------------------- FROM CLASS BzData
//     bzId: vBzData.bzId,
//     bzType: vBzData.bzType,
//     bzName: vBzData.bzName,
//     bzLogo: vBzData.bzLogo,
//     bzCounty: vBzData.bzCountry,
//     bzCity: vBzData.bzCity,
//     bzFieldsList: vBzData.bzFieldsList,
//     bzBirth: vBzData.bzBirth,
//     bldrBirth: vBzData.bldrBirth,
//     bzAbout: vBzData.bzAbout,
//     bzPhone1: vBzData.bzPhone1,
//     bzWhatsAppIsOn: vBzData.bzWhatsAppIsOn,
//     bzPhone2: vBzData.bzPhone2,
//     bzFacebook: vBzData.bzFacebook,
//     bzInstagram: vBzData.bzInstagram,
//     bzLinkedIn: vBzData.bzLinkedIn,
//     bzTwitter: vBzData.bzTwitter,
//     bzEmail: vBzData.bzEmail,
//     bzWebSite: vBzData.bzWebSite,
//     // BzLocation:
//     bzShowsTeam: vBzData.bzShowsTeam,
//     bzTeamIDs: vAllAuthorsIDsOfThisBz,
//     // -------------------------------------- FROM CLASS UserData
//     authorName: vUserData.name,
//     authorPic: vUserData.pic,
//     authorTitle: vUserData.title,
//     authorCity: vUserData.userCity,
//     authorCountry: vUserData.userCountry,
//     authorWhatsAppIsOn: vUserData.userWhatsAppIsOn,
//     // -------------------------------------- COMBINED FROM SEVERAL ITEMS OF CLASS SlideData
//     slidesIDsList: vSlidesIDs,
//     slidesPictures: vSlidesPictures,
//     slidesHeadlines: vSlidesHeadlines,
//     // slidesDescriptions: ,
//     // slidesBonds: ,
//     // slidesSources: ,
//     // -------------------------------------- TO BE FIGURED OUT
//     followersCount: vFollowersCount,
//     // followingOn,
//     galleryCount: vBzFlyersCount,
//     slidesSharesCounts: vSlidesSharesList,
//     slidesViewsCounts: vSlidesViewsList,
//     slidesSavesCounts: vSlidesSavesList,
//     bzCallsCount: vBzCallsCount,
//     bzSlidesCount:vBzSlidesCount,
//     bzViewsCount: vBzViewsCount,
//     bzSharesCount: vBzSharesCount,
//     bzSavesCount: vBzSavesCount,
//     bzConnectionsCount: vBzConnectionsCount,
//     flyerAnkhIsOn: vFlyerUserAnkh,
//   );
// }
//
// // --- returns ProcessedFlyerData
// allFlyersExtractor (){
//
//   List<String> flyerIDs =[];
//
//   xFlyersList.forEach((flyer){
//     flyerIDs.add(flyer.flyerID);
//   });
//
//   for (MoFlyer f in xFlyersList)
//   {return List<ProcessedFlyerData>.generate(
//       xFlyersList.length,
//           (index) => flyerIDProcessor(flyerIDs[index]));
//   }
//
// }
//
// // --- returns ProcessedFlyerData
// flyerTypeClassifier (FlyerType flyerType){
//   // this method should take the flyerType as input
//   // and put the matching flyer ID's into a list of IDs
//   // then should return a list of processedFlyers
//
//   // 1--- create new List of IDs
//   List<String> flyerIDs = [];
//
//   // 2--- search db for any id when flyertype is the searched flyertype and add them to the list
//   xFlyersList.forEach((flyer) {
//     if(flyer.flyerType == flyerType){flyerIDs.add(flyer.flyerID);}
//   });
//
//   // 3--- return list of processedFlyers
//   return List<ProcessedFlyerData>.generate(
//       flyerIDs.length,
//           (indexOfFlyerIDsList) =>
//           flyerIDProcessor(flyerIDs[indexOfFlyerIDsList])
//   );
// }
//
// // --- returns ProcessedFlyerData
// savedFlyersExtractor (String userID){
//   // by UserID as input, get the FlyerSaveData for that user and put them in a list
//   // then return a list of processed flyers
//   List<String> savedSlidesIDs = [];
//
//   xSavesList.forEach((save) {
//     if(save.userID == userID){savedSlidesIDs.add(save.slideID);}
//   });
//
//   // get a list of flyerIDs by searching by slideIDs
//   List<String> savedFlyerIDs = [];
//
//   for (String x in savedSlidesIDs){
//     xSlidesList.forEach((slide) {
//       if((slide.slideID == x)&&(!savedFlyerIDs.contains(slide.flyerID))){savedFlyerIDs.add(slide.flyerID);}
//     });
//   }
//
//   return List<ProcessedFlyerData>.generate(
//       savedFlyerIDs.length,
//           (indexOfFlyerIDsList) =>
//           flyerIDProcessor(savedFlyerIDs[indexOfFlyerIDsList])
//   );
//
// }
//
// // --- returns ProcessedFlyerData
// authorFlyersExtractor (String authorID){
//   // should take author ID as input
//   // get list of flyer IDs
//   List<String> authorFlyersIDsList = [];
//   xFlyersList.forEach((flyer) {
//     if(flyer.authorID == authorID){authorFlyersIDsList.add(flyer.flyerID);}
//   });
//
//   // return a list of processedFlyers
//   return List<ProcessedFlyerData>.generate(
//       authorFlyersIDsList.length,
//           (indexOfAuthorFlyersIDsList) =>
//           flyerIDProcessor(authorFlyersIDsList[indexOfAuthorFlyersIDsList])
//   );
//
// }
//
// // --- returns ProcessedFlyerData
// bzFlyersExtractor (String bzID) {
//   // take bzID as input
//   // get a List of AuthorsIDs;
//   List<String> authorsIDs = [];
//   xAuthorsList.forEach((author) {
//     if (author.bzId == bzID) {
//       authorsIDs.add(author.authorID);
//     }
//   });
//
//   // extract and return flyers of each author
//   List<String> flyersIDs = [];
//   for (String id in authorsIDs) {
//     xFlyersList.forEach((flyer) {
//       if (flyer.authorID == id) {
//         flyersIDs.add(flyer.flyerID);
//       }
//     });
//   }
//
//   // return a list of processedFlyers
//   return List<ProcessedFlyerData>.generate(
//       flyersIDs.length,
//           (indexOfFlyerID) =>
//           flyerIDProcessor(flyersIDs[indexOfFlyerID])
//   );
// }
//
// // --- returns ProcessedAuthorData
// // authorDataExtractor (String authorID){
// //   // by author ID, get all data of the author and return a ProcessedAuthorData
// //   String aUserID = xAuthorsList.singleWhere((x) => x.authorID == authorID).userID;
// //
// //   MoUser aUserData = xUsersList.singleWhere((u) => u.userID == aUserID);
// //
// //   List<String> authorFlyersIDs = [];
// //
// //   xFlyersList.forEach((flyer) {
// //     if (flyer.authorID == authorID){authorFlyersIDs.add(flyer.flyerID);}
// //   });
// //
// //   int authorFlyersCount = authorFlyersIDs.length;
// //
// //   return ProcessedAuthorData(
// //     authorName: aUserData.name,
// //     authorPic: aUserData.pic,
// //     authorTitle: aUserData.title,
// //     authorFlyersIDs: authorFlyersIDs,
// //     authorPhone: aUserData.userPhone,
// //     authorWhatsAppIsOn: aUserData.userWhatsAppIsOn,
// //     authorEmail: aUserData.userEmail,
// //     authorFacebook: aUserData.userFacebook,
// //     authorInstagram: aUserData.userInstagram,
// //     authorLinkedIn: aUserData.userLinkedIn,
// //     authorTwitter: aUserData.userTwitter,
// //     authorFlyersCount: authorFlyersCount,
// //     authorID: authorID,
// //   );
// // }
//
// followedBzListExtractor(){
//   // should take user ID as input,, // fetch db
// }
//
// getAllBzLogosOfThisType(BzType bzType){
//   // should loop the database
//   // if bz has matching bzType
//   // return BzLogo in a list of logos
//   List<String> bzLogoz = [];
//
//   xBzList.forEach((bz) {
//     if (bz.bzType == bzType){bzLogoz.add(bz.bzLogo);}
//   });
//
//   return bzLogoz;
// }
//
//
