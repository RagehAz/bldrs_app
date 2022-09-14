
// Future<void> bypassUpdate() async {
//
//   await _nourBypassEndPoint(
//     collName: collname,
//     docName: docName,
//     mapToInsert: { // Map<String, dynamic>
//       'x' : '',
//     },
//   );
//
// }

/// NEED  TO DELETE MULTIPLE FIRE DOCS BY CLOUD FUNCTIONS (fireBypassDelete) as transaction
/// NEED TO DELETE MULTIPLE REAL DOCS BY CLOUD FUNCTION (realBypassDelete) as transaction
/// NEED TO DELETE MULTIPLE FIRE STORAGE FILE BY CLOUD FUNCTION (storageBypassDelete) as transaction

/*

DB CLOUD FUNCTIONS

XX - bypassUpdate() : update specific field in specific doc or sub doc
    => sometimes from client i need to bypass security ma3lesh

    Future<void> bypassUpdate({
      String collName
      String docName
      Map<String, dynamic> input
    }){
        Map<String, dynamic> _existingMap = db.collName.docNam;
        for each key in input
        if _existingMap[key] field exists => update _existingKey[key] = input[key]
    }

xx - cloud function to delete storage file

YY -- collect User Records and send each 10 seconds list of records to increment their fields
      in db
      - with each record => increment global / country / city statistics field :-
      'totalSaves' / 'totalViews' / 'totalViewsDurations' / 'totalShares' / 'totalFollows' / 'totalCalls'

xx -- create statistics "dailySnapshot" document

A - increment number of bzz (onCreate bz doc) / decrement onDelete
    - in "GlobalBzzCount" field in statistics doc
    - in "GlobalBzzOfThisTypeCount" field in statistics doc
    - in "CountryBzzCount" field in country doc
    - in "CountryBzzOfThisType" field
    - in "CityBzzCount"
    - in "CityBzzOfThisType" field

B - increment number of flyers (onCreate Flyer Doc) / decrement onDelete
    - in "GlobalFlyersCount"
    - in "GlobalFlyersOfThisTypeCount"
    - in "CountryFlyersCount"
    - in "CountryFlyersOfThisType"
    - in "CityFlyersCount"
    - in "CityFlyersOfThisType"
    - INCREMENT 'keywordUsage' for each keyword/spec used in flyer for that city

C - increment number of users (onCreate User Doc) / decrement onDelete
    - in "GlobalUsersCount"
    - in "CountryUsersCount"
    - in "CityUsersCount"

1 - SEND FCM (on create new Note Doc) in (firestore/note/{noteID}

2 - CITY ACTIVE KEYWORDS TRIGGERS (when keyword is used > numberOfTimes in flyers of that city)
    adds keyword to "activeKeywords" field in CityModel

3 - CITY IS PUBLIC TRIGGER (when number of business account and number of flyers reach a specific count)
    - trigger "cityIsPublic" field to true
    - and increment "ldbVersion" in appState Doc
    - increment "PublicCountriesCount" in statistics doc

4 - COUNTRY IS GLOBAL TRIGGER (when number of flyers and number of bzz reach specific count)
    - trigger "countryIsGlobal" field to true
    - and increment "ldbVersion" in appState Doc
    - increment "globalCountriesCount" in statistics doc


5 - CALCULATE FLYER SCORE (keeps listening until it reaches a certain minimum as it descends by time)

 */

// import 'package:flutter/material.dart';

// double calculateFlyerScore({
//   // @required bool isMasterAccount,
//   // @required bool isPremiumAccount,
//   // @required int saves,
//   // @required int age, // inDays
//
// }){
//
// }


///----------------------------------------------------------------------------------
