import 'package:flutter/foundation.dart';

class FlyerDataz {
  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---  Header
  final String f01flyerID;
  final int f02Index;
  // final String f02bType;

  final String f03bzLogo;
  final String f04bzName; // - max 50 charecters no more

  final String f05bzCity;
  final String f06bzCountry;
  final List<String> f13bzFields;

  final String f07aPic;
  final String f08aName;
  final String f09aTitle;

  final int f10followers;

  final bool f11followIsOn ;
  final int f12galleryCount;
  final String phoneNumber;
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- MultiSlidesData
  // final FlyerField f13fieldKey; // became flyerType
  // final List<String> f14typeKey; // became flyerKeyWords

  // final DateTime f15publishedTime;

  // final List<String> f16slidesId;
  final List<String> f17headlines;
  final List<String> f18pictures;
  // final List<String> f19descriptions;

  final List<int> f20shares;
  final List<int> f21views;
  final List<int> f22saves;
  final List<bool> f23ankhsOn;

  FlyerDataz({
    @required this.f01flyerID,
    @required this.f02Index,
    // @required this.f15publishedTime,
    @required this.f03bzLogo,
    @required this.f04bzName,
    @required this.f05bzCity,
    @required this.f06bzCountry,
    @required this.f07aPic,
    @required this.f08aName,
    @required this.f09aTitle,
    @required this.f10followers,
    @required this.f11followIsOn,
    @required this.f12galleryCount,

    // --- --- --- --- --- --- --- ---

    @required this.f13bzFields,
    // @required this.typeKey,

    // @required this.publishedTime,

    // @required this.slidesId,
    @required this.f17headlines,
    @required this.f18pictures,
    // @required this.descriptions,

    @required this.f20shares,
    @required this.f21views,
    @required this.f22saves,
    @required this.f23ankhsOn,
    @required this.phoneNumber,
  });
}


// class FlyerScore {
//   final String flyerId;
//   final int score;
//
//   FlyerScore ({
//     @required this.score,
//     @required this.flyerId,
// });
// }


class SlideStates {
  final int shares;
  final int views;
  final int saves;
  final bool ankhIsOn;

  SlideStates({
    @required this.shares,
    @required this.views,
    @required this.saves,
    @required this.ankhIsOn,
});
}