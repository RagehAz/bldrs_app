import 'package:bldrs/models/enums/enum_flyer_state.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FlyerDocument{
  final String flyerID;
  /// authorID is the userID of the flyer creator, and so while building widgets
  /// flyer requires : userPic, userName & userTitle only while viewing flyer in MiniHeader
  /// if we save them here, will be duplicated data for each flyer made
  /// but if we fetch them in the same dbserver call while fetching flyer, db should fetch these
  /// info from the UsersCollection documents. and bring them with all flyer data
  /// and that will increase loading time
  final String authorID;
  /// bzID is the ID of author's Bz, and while viewing flyer in MiniHeader
  /// flyer requires : bzLogo, bzName, bzLocale, bzTotalFollowersCount, bzTotalFlyersCount, bzPhones
  /// so while fetching flyer data from flyerCollection, db should fetch bzData as well with the flyer
  /// in the one fetchaya
  final String bzID; // keda hayfetsh bz w howa byfetch flyer
  final bool flyerShowsAuthor;
  final FlyerType flyerType; // should we split each type in a separate firebase collection ?
  final List<String> keyWords;
  final FlyerState flyerState;
  final DateTime publishTime;
  final GeoPoint flyerPosition;
  List<Map<String, Object>> slides;
  final String flyerURL;

  /// a3mel eh tayeb,, I will need to fetch the list of users who saved the flyer
  /// oftenly
  ///
  /// of we should do this [SaveDocument] in a separate collection ?
  final List<String> usersIDsSavedThisFlyer;


  FlyerDocument({
    @required this.flyerID,
    @required this.authorID,
    @required this.bzID,
    this.flyerShowsAuthor = true,
    @required this.flyerType,
    @required this.keyWords, // minimum 3 keywords
    this.flyerState = FlyerState.Published,
    @required this.publishTime,
    this.flyerPosition,
    @required this.slides,
    @required this.flyerURL,
    this.usersIDsSavedThisFlyer,
  });
}

// the slides map should contain these info and look like this,, i guess this is now easy to
// store, use, edit or delete single slide and leave others
List<Map<String, Object>> slides = [
  {
    'flyerID' : '', // not needed ba2a 5alas, a slide is indivisible from the flyer.
    'slideID' : '',
    'slideIndex' : '',
    'picture' : '',
    'headline' : '',
    'descriptions' : '',
    'sharesCount' : '',
    'horuseeCount' : '',
    'savesCount' : '',
    // 'bondID' : '', // postponed to version 2
    // 'bondX' : '', // postponed to version 2
    // 'bondY' : '', // postponed to version 2
  },

];


// -----------------------------------------------
// [ call , share , view , save ]

/// view is horus,, which is a slide view when a user just swipes it,, it records one view
/// ya 7alawa
///
/// IT WOULD BE GREAT if we can store in a nested document inside the flyerDocument,,
/// that only fetched when called but not always when fetching the flyer yeegy
/// zy el 5azoo2 m3ana kol marra
///
/// as this will be called only when author wants to see a list of who called him and his team
/// and by the callerID,, we shall fetch his data [userName, userPic, userTitle ... ]
List<Map<String,Object>> callMaps = [
  {'callID' : '', 'callerID' : '', 'slideID' : '', 'callTime' : ''},
];
/// the same data solution would apply on share & view as well,,
/// only saved flyer is always to be fetched with the flyer as they are a
/// nessesary part of the main primary user usage of the app
/// bygebhom keteer ya3ny lamo2a5za
///
/// I'm not sure we can get the [sharedTo] value that says which social media
/// platform this flyer link was shared to
List<Map<String,Object>> shareMaps = [
{'shareID' : '', 'userID' : '', 'slideID' : '', 'shareTime' : '', 'sharedTo' : ''},
];

/// this is the one that will be explosive and definetly should be able to
/// fetch parts of it and paginate the shit out of it
List<Map<String,Object>> viewsMaps = [
  {'viewID' : '', 'userID' : '', 'slideID' : '', 'viewTime' : ''},
];

/// instead of [viewsMap] if we create a document for each view,, this will work
/// this way,,
/// can we nest this as a child/sub document inside the flyer but only fetch it
/// on command ?
///
/// anyways,, seems like if this works,,, this should be implemented on the
/// shares & calls as well
class ViewDocument {
  final String viewID;
  final String userID;
  final String slideID;
  final DateTime viewTime;

  ViewDocument({
    this.viewID,
    this.userID,
    this.slideID,
    this.viewTime,
  });
}

/// should we do separate collection for the saves to fetch and paginate this comfortably ?
class SaveDocument{
  final String userID;
  final String slideID;
  final String flyerID;
  final DateTime saveTime;

  SaveDocument({
   this.userID,
   this.slideID,
   this.flyerID,
   this.saveTime,
  });
}