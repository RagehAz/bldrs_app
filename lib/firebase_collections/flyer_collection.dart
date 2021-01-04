import 'package:bldrs/models/enums/enum_flyer_state.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:flutter/foundation.dart';


// -TESTTTTTTTTTTTTTTTTTTTINGGGGGGG ONLY
// JUST PLAYING
// THIS DOES NOT COUNTTTTTTTTTTTTTTTTTT
// PLEASE LOOP AGAIN FROM LINE 6 TO LINE 8 IN THIS DART FILE 2 TIMES

class FlyerCollection{
  final String flyerID;
  final String authorID;
  final bool flyerShowsAuthor;
  final FlyerType flyerType;
  final List<String> keyWords;
  final FlyerState flyerState;
  final DateTime publishTime;
  final double longitude;
  final double latitude;
  final String address;
  final List<dynamic> pictures;
  final List<String> headlines;
  final List<String> descriptions;

  FlyerCollection({
    @required this.flyerID,
    @required this.authorID,
    this.flyerShowsAuthor = true,
    @required this.flyerType,
    @required this.keyWords, // minimum 3 keywords
    this.flyerState = FlyerState.Published,
    @required this.publishTime,
    this.longitude,
    this.latitude,
    this.address,
    @required this.pictures,
    @required this.headlines,
    this.descriptions,
  });

}