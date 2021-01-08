import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/contact_model.dart';
import 'package:bldrs/models/location_model.dart';
import 'package:flutter/foundation.dart';
import 'co_author.dart';

class CoBz with ChangeNotifier{
  BzModel bz; // was final
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
     this.bz, // -- was @required
     this.bzContacts, // -- was @required
     this.bzLocation, // -- was @required
     this.coAuthors, // -- was @required
     this.followsCount, // -- was @required
     this.bzTotalSaves, // -- was @required
     this.bzTotalShares, // -- was @required
     this.bzTotalSlides, // -- was @required
     this.bzTotalViews, // -- was @required
     this.callsCount, // -- was @required
     this.bzConnects, // -- was @required
    // this.followIsOn = false,
  });

  // void toggleFollow(){
  //   followIsOn = !followIsOn;
  //   notifyListeners();
  // }
}
