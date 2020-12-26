import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProcessedFlyerData with ChangeNotifier{
// --------------------------------------------- FROM CLASS FlyerDataX
  final String flyerID;
  final String authorID;
  final bool flyerShowsAuthor;
  final FlyerType flyerType;
  final List<String> keyWords;
  // final DateTime publishTime;
  // flyer x_dummy_database.location
// --------------------------------------------- FROM CLASS BzData
  final String bzId;
  final BzType bzType;
  final String bzName;
  final String bzLogo;
  final String bzCounty;
  final String bzCity;
  final List<String> bzFieldsList;
  final int bzBirth;
  final int bldrBirth;
  final String bzAbout;
  final int bzPhone1;
  final bool bzWhatsAppIsOn;
  final int bzPhone2;
  final String bzFacebook;
  final String bzInstagram;
  final String bzLinkedIn;
  final String bzTwitter;
  final String bzEmail;
  final String bzWebSite;
  // final String BzLocation;
  final bool bzShowsTeam;
  final List<String> bzTeamIDs;
// --------------------------------------------- FROM CLASS UserData
  final String authorName;
  final String authorPic;
  final String authorTitle;
  final String authorCity;
  final String authorCountry;
  // final int authorPhone;
  final bool authorWhatsAppIsOn;
  // final String authorEmail;
  // final String authorFacebook;
  // final String authorTwitter;
  // final String authorInstagram;
  // final String authorLinkedIn;
// --------------------------------------------- COMBINED FROM SEVERAL ITEMS OF CLASS SlideData
  final List<String> slidesIDsList;
  final List<String> slidesPictures;
  final List<String> slidesHeadlines;
  // final ListString> slidesDescriptions;
  // final List<String> slidesBonds;
  // final List<String> slidesSources;
// --------------------------------------------- TO BE FIGURED OUT
  final int followersCount;
  // followingOn,
  final int galleryCount;
  final List<int> slidesSharesCounts;
  final List<int> slidesViewsCounts;
  final List<int> slidesSavesCounts;
  final int bzCallsCount;
  final int bzSlidesCount;
  final int bzViewsCount;
  final int bzSharesCount;
  final int bzSavesCount;
  final int bzConnectionsCount;
  bool flyerAnkhIsOn;

  ProcessedFlyerData({
// --------------------------------------------- FROM CLASS FlyerDataX
    @required this.flyerID,
    @required this.authorID,
    @required this.flyerShowsAuthor,
    @required this.flyerType,
    @required this.keyWords,
    // @required this.publishTime,
    // @required this.x_dummy_database.location,
    // --------------------------------------------- FROM CLASS BzData
    @required this.bzId,
    @required this.bzType,
    @required this.bzName,
    @required this.bzLogo,
    @required this.bzCounty,
    @required this.bzCity,
    @required this.bzFieldsList,
    @required this.bzBirth,
    @required this.bldrBirth,
    @required this.bzAbout,
    @required this.bzPhone1,
    @required this.bzWhatsAppIsOn,
    @required this.bzPhone2,
    @required this.bzFacebook,
    @required this.bzInstagram,
    @required this.bzLinkedIn,
    @required this.bzTwitter,
    @required this.bzEmail,
    @required this.bzWebSite,
    // BzLocation,
    @required this.bzShowsTeam,
    @required this.bzTeamIDs,
    // --------------------------------------------- FROM CLASS UserData
    @required this.authorName,
    @required this.authorPic,
    @required this.authorTitle,
    @required this.authorCity,
    @required this.authorCountry,
    // @required this.authorPhone,
    @required this.authorWhatsAppIsOn,
    // @required this.authorEmail,
    // @required this.authorFacebook,
    // @required this.authorTwitter,
    // @required this.authorInstagram,
    // @required this.authorLinkedIn,
    // --------------------------------------------- COMBINED FROM SEVERAL ITEMS OF CLASS SlideData
    @required this.slidesIDsList,
    @required this.slidesPictures,
    @required this.slidesHeadlines,
    // @required this.slidesDescriptions,
    // @required this.slidesBond,
    // @required this.slidesSources,

    // --------------------------------------------- ACTIONS
    @required this.followersCount,
    @required this.galleryCount,
    @required this.slidesSharesCounts,
    @required this.slidesViewsCounts,
    @required this.slidesSavesCounts,
    @required this.bzCallsCount,
    @required this.bzSlidesCount,
    @required this.bzViewsCount,
    @required this.bzSharesCount,
    @required this.bzSavesCount,
    @required this.bzConnectionsCount,
    @required this.flyerAnkhIsOn,
  });

  void toggleAnkh(){
    flyerAnkhIsOn = !flyerAnkhIsOn;
    notifyListeners();
  }
}
