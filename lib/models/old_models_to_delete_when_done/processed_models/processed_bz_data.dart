import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:flutter/foundation.dart';

class ProcessedBzData with ChangeNotifier{
  final String bzId;
  final BzType bzType;
  final String bzName;
  final String bzLogo;
  final String bzCountry; // countryID
  final String bzCity; // cityID
  final List<String> bzFieldsList;
  final int bzBirth;
  final int bldrBirth;
  final String bzAbout;
  final bool bzShowsTeam;
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
  // bzIsVerified
  // bzAccountCanPublish;
  // bzAccountIsPublished;

  ProcessedBzData({
    @required this.bzId,
    @required this.bzType,
    @required this.bzName,
    @required this.bzLogo,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.bzFieldsList,
    @required this.bzBirth,
    @required this.bldrBirth,
    @required this.bzAbout,
    @required this.bzShowsTeam,
    this.bzPhone1,
    this.bzWhatsAppIsOn,
    this.bzPhone2,
    this.bzFacebook,
    this.bzInstagram,
    this.bzLinkedIn,
    this.bzTwitter,
    this.bzEmail,
    this.bzWebSite,
    // @required this.BzLocation,
  });

  void toggleFollow(){
    // flyerAnkhIsOn = !flyerAnkhIsOn;
    notifyListeners();
  }
}
