import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:flutter/foundation.dart';

/// TASK : should be save on firestore to be able to edit them from dashboard
class Standards {

  Standards();

// -----------------------------------------------------------------------------

/// FLYER STANDARDS

// ----------------------------------
  /// MAX SLIDES PER BZ ACCOUNT TYPE
  static const int maxFlyerSlidesFreeAccount = 50;
  static const int maxFlyerSlidesPremiumAccount = 7;
  static const int maxFlyerSlidesFreeSuper = 25;
// ----------------------------------
  static int getMaxSlidesCount({
    @required BzAccountType bzAccountType,
  }) {
    switch (bzAccountType) {
      case BzAccountType.normal:  return Standards.maxFlyerSlidesFreeAccount;     break;
      case BzAccountType.premium: return Standards.maxFlyerSlidesPremiumAccount;  break;
      case BzAccountType.sphinx:  return Standards.maxFlyerSlidesFreeSuper;       break;
      default:  return Standards.maxFlyerSlidesFreeAccount;
    }
  }
// ----------------------------------
  /// FLYER HEADLINE LENGTH
  static const int flyerHeadlineMaxLength = 50;
  static const int flyerHeadlineMinLength = 5;
// -----------------------------------------------------------------------------

/// BZ STANDARDS

// ----------------------------------
  static const int maxUserBzz = 10;
  static const int maxAuthorsPerBz = 20;
// -----------------------------------------------------------------------------

/// USER RECORDS STANDARDS

// ----------------------------------
  static const int maxUserFollows = 500;
  static const int maxUserSavedFlyers = 1000;
// -----------------------------------------------------------------------------

/// OTHER STANDARDS

// ----------------------------------
  static const int maxTrigramLength = 7;
  static const int maxLocationFetchSeconds = 10;
  static const String ipRegistryAPIKey = '89i23ivki8p5tsqj';

}
