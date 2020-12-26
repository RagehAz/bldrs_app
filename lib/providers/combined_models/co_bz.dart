import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/contact_model.dart';
import 'package:bldrs/models/location_model.dart';
import 'package:flutter/foundation.dart';
import 'co_author.dart';

class CoBz with ChangeNotifier{
  final BzModel bz;
  final List<ContactModel> bzContacts;
  final LocationModel bzLocation;
  final List<CoAuthor> coAuthors;
  int followsCount;
  int bzTotalSaves;
  int bzTotalShares;
  int bzTotalSlides;
  int bzTotalViews;
  int callsCount;
  int bzConnects;
  // bool followIsOn;

  CoBz({
    @required this.bz,
    @required this.bzContacts,
    @required this.bzLocation,
    @required this.coAuthors,
    @required this.followsCount,
    @required this.bzTotalSaves,
    @required this.bzTotalShares,
    @required this.bzTotalSlides,
    @required this.bzTotalViews,
    @required this.callsCount,
    @required this.bzConnects,
    // this.followIsOn = false,
  });

  // void toggleFollow(){
  //   followIsOn = !followIsOn;
  //   notifyListeners();
  // }
}
