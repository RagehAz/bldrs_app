
import 'package:bldrs/models/enums/enum_bz_form.dart';
import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BzDocument {
  final String bzId;

  /// should we split Bzz collections by bzType ?
  BzType bzType; // was final
  /// should we split Bzz collections by bzForm ?
  BzForm bzForm; // was final
  String bzName; // was final
  dynamic bzLogo; // was final String
  /// should we save the country String or country ID ?
  final String bzCountry; // countryID
  /// should we save city string or cityID ?
  final String bzCity; // cityID
  /// bzScope was originally List<String> bzFields as for the bz creator to
  /// choose form a list of assigned keywords,, but for business reasons it's
  /// converted to an open String for any bz creator to type what he wants
  final String bzScope;
  final DateTime bzSignUpTime;
  String bzAbout; // was final
  /// Bz Admins / Authors can switch this bzShowsTeam trigger to hide or show author's data
  /// with all flyers of the Bz
  final bool bzShowsTeam;

  /// this trigger shows the user if the Bz can be contacted via whatsapp or not
  /// for the first phone number in his list of contacts
  final bool bzWhatsAppIsOn;

  /// this shows verified icon beside bzLogo for users to know that Bldrs.net
  /// certifies that this bz is officially certified in the bzCity
  /// and is obtainable when bz send his legal papers and Bldrs.net admin manually
  /// switch it on from dashboard
  final bool bzIsVerified;

  /// if the bzAdmins decide to deactivate then activate the account later
  final bool bzAccountIsDeactivated;

  /// if the business needs '2arset wedn'
  final bool bzAccountIsBanned;

  /// so this is golden solution,, map will look like this
  /// [_bzContactsSample] and we always fetch all of it and split it in client device
  /// simply put,, no duplicate values anywhere, and no null values in any parameter,

  /// and a phone number is always a must to be able to submit bzAccount form
  final List<Map<String, Object>> bzContacts;
  final GeoPoint bzPosition;

  /// here we point a reference to the following 'child' fields in [MoUser], i guess
  /// userName, userPic, userJobTitle, userPublishedFlyersIDs or reference to the flyers ba2a
  /// so maybe should be stored in a map that looks like this [bzAuthorsMap]
  List<Map<String,Object>> authorsMaps; // was final

  int bzTotalFollowers;
  int bzTotalSaves;
  int bzTotalShares;
  int bzTotalSlides;
  int bzTotalViews;
  int bzTotalCalls;
  int bzTotalConnects;

  /// just like [followedBzIDs] in [MoUser], we could save the data in form of
  /// List<String> bzIDs ...
  /// but to add request feature, we can save it in a List of Maps like
  /// [connectionsMapsSample]
  List<String> connectedBzzIDs;

  /// this changes according to which user is fetching the data, if his followedBzzIDs list
  /// contains this bzID, we conclude the bool value of this parameter
  /// walla eh ?
  bool followIsOn;

  /// instead of setting enum [defaultAccount , Premium Account , Super Account , Fucking Account],
  /// they just can be [1,2,3,4] and will decode that and shall be used to activate
  /// certain features in the app.
  int accountType;

  /// Bz account has limited amount of available slides, with each published slide,
  /// credit decreases,
  /// slides can be purchased or rewarded
  int credit;

  /// this is cool,, check this [bzProgressMaps]
  List<Map<String,Object>> progress;
  String bzURL;

  BzDocument({
    this.bzId,
    this.bzType,
    this.bzForm,
    this.bzName,
    this.bzLogo,
    this.bzCountry,
    this.bzCity,
    this.bzScope,
    this.bzSignUpTime,
    this.bzAbout,
    this.bzShowsTeam,
    this.bzWhatsAppIsOn,
    this.bzIsVerified,
    this.bzAccountIsDeactivated,
    this.bzAccountIsBanned,
    this.bzContacts,
    this.bzPosition,
    this.authorsMaps,
    this.bzTotalFollowers,
    this.bzTotalSaves,
    this.bzTotalShares,
    this.bzTotalSlides,
    this.bzTotalViews,
    this.bzTotalCalls,
    this.bzTotalConnects,
    this.followIsOn,
    this.accountType,
    this.connectedBzzIDs,
    this.credit,
    this.bzURL,
  });

}

  /// notice that you can have several entries of the same type, and always returned in a List
  /// in which we iterate in client device
  /// showInFlyerParameter is set to give bz admins freedom to choose which contact of all their
  /// contacts to show in their bzCard and in call button pop up
  List<Map<String,Object>> _bzContactsSample = [
    {'type' : 'whatsapp'  , 'value' : '01554555107'             , 'showInFlyer' : true    },
    {'type' : 'email'     , 'value' : 'rageh-@hotmail.com'      , 'showInFlyer' : true    },
    {'type' : 'website'   , 'value' : 'bldrs.net'               , 'showInFlyer' : true    },
    {'type' : 'facebook'  , 'value' : 'www.facebook.com/rageh'  , 'showInFlyer' : true    },
    {'type' : 'twitter'   , 'value' : 'www.twitter.com/rageh'   , 'showInFlyer' : true    },
    {'type' : 'linkedIn'  , 'value' : 'www.linkedIn.com/rageh'  , 'showInFlyer' : true    },
    {'type' : 'pinterest' , 'value' : 'www.pinterest.com/rageh' , 'showInFlyer' : false   },
    {'type' : 'tiktok'    , 'value' : 'www.tiktok.com/rageh'    , 'showInFlyer' : false   },
    {'type' : 'instagram' , 'value' : 'www.instagram.com/rageh' , 'showInFlyer' : true    },
    {'type' : 'snapchat'  , 'value' : 'www.snapchat.com/rageh'  , 'showInFlyer' : false   },
    {'type' : 'email'     , 'value' : 'rageh.az@gmail.com'      , 'showInFlyer' : true    },
    {'type' : 'phone'     , 'value' : '07775000'                , 'showInFlyer' : true    },
    {'type' : '3afreet'   , 'value' : 'www.3afreet.com/rageh'   , 'showInFlyer' : false   },
  ];

  List<Map<String, Object>> authorsMaps = [
    {
      'authorName'                : '',
      'authorPic'                 : '',
      'authorTitle'               : '',
      'authorFlyersIDs'           : ['',''], // mesh mabsoot ba2a a3mel fetch gdeed lel kol ID feehom nakad
      'authorContactsListOfMaps'  : ['_bzContactsSample', '_bzContactsSample'], // just to demonstrate
    },
    {
      'authorName'                : '',
      'authorPic'                 : '',
      'authorTitle'               : '',
      'authorFlyersIDs'           : ['',''], // mesh mabsoot ba2a a3mel fetch gdeed lel kol ID feehom nakad
      'authorContactsListOfMaps'  : ['_bzContactsSample', '_bzContactsSample'], // just to demonstrate
    },
  ];

/// i guess we don't need the time parameters is separate location in database that would
/// force us to split the connections data
/// we can use acronyms for [accepted, declined, pending] to be [a,d,p] or [1,2,3] and decode that
/// just to decrease data size,, and this concept can be implemented on all enums in all models
///
/// i can think of two main useCases fetching connections
///
/// first use case is a user wants to see all connection data,, then we have the maps here and
/// fetch those Bzz by the bzzIDs we have here
///
/// I think no reason to save an entry on state of request declined,, on the moment of bz declining the request
/// it triggers a function to delete the entry and send whatever other action or notification elsewhere w 5lesna
/// why save if for life ? hat3ayro biha ? walla for statistics ? maybe ...
///
/// no need for a connectionID,, as each map is unique in this list, as bz can not connect to same bz twice
  List<Map<String,Object>> connectionsMapsSample = [
    {'bzID' : '', 'requestingAuthorID' : '', 'requestTime': '', 'responseTime' : '', 'connectionState' : 'accepted'},
    {'bzID' : '', 'requestingAuthorID' : '', 'requestTime': '', 'responseTime' : '', 'connectionState' : 'pending'},
    {'bzID' : '', 'requestingAuthorID' : '', 'requestTime': '', 'responseTime' : '', 'connectionState' : 'declined'},
  ];

/// with this,, we can add any number of new challenges,, and keep track of their progress that
/// initiates when a user does a certain action in app that triggers a function that adds or edits
/// the values of these maps
///
/// and surely we can use proper acronyms for the challenges
///
/// the claimed parameter is needed to let the user take it and visually views this taking action
/// then at that claimFunction rewards the [Credit] with certain amounts depending on which challenge
/// that the rewards values will be controlled manually from dashboard
  List<Map<String,Object>> bzProgressMaps = [
    {'challenge' : 'completeAccount',     'progress' : 100 , 'claimed' : true},
    {'challenge' : 'verifyAccount',       'progress' : 0   , 'claimed' : false},
    {'challenge' : 'publish 10 flyers',   'progress' : 90  , 'claimed' : false},
    {'challenge' : 'publish 100 flyers',  'progress' : 9   , 'claimed' : false},
  ];