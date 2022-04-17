import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:flutter/foundation.dart';

// -----------------------------------------------------------------------------
const int maxFlyerSlidesFreeAccount = 50;

/// TASK : should be save on firestore
const int maxFlyerSlidesPremiumAccount = 7;
const int maxFlyerSlidesFreeSuper = 25;

const int maxDraftsAtOnce = 5;

const int flyerTitleMaxLength = 50;

const int maxAuthorsPerBz = 20;

// const int maxSlidesPerFlyer = 10;

const int maxUserFollows = 500;
const int maxUserSavedFlyers = 1000;
const int maxUserBzz = 10;

const int maxTrigramLength = 7;

const int maxLocationFetchSeconds = 10;

const String ipRegistryAPIKey = '89i23ivki8p5tsqj';
// -----------------------------------------------------------------------------
int getMaxSlidesCount({
  @required BzAccountType bzAccountType,
}) {
  switch (bzAccountType) {
    case BzAccountType.normal:  return maxFlyerSlidesFreeAccount;     break;
    case BzAccountType.premium: return maxFlyerSlidesPremiumAccount;  break;
    case BzAccountType.sphinx:  return maxFlyerSlidesFreeSuper;       break;
    default:  return maxFlyerSlidesFreeAccount;
  }
}
// -----------------------------------------------------------------------------
bool canAddMoreSlides({
  @required BzAccountType bzAccountType,
  @required int numberOfSlide,
}) {
  bool _canAdd = false;

    final int _maxSlides = getMaxSlidesCount(
      bzAccountType: bzAccountType,
    );

    if (numberOfSlide < _maxSlides) {
      _canAdd = true;
    }

  return _canAdd;
}

// -----------------------------------------------------------------------------
bool canDeleteSlide({
  @required int numberOfSlides,
}) {
  bool _canDelete = false;

    if (numberOfSlides != 0) {
      // if(superFlyer.firstTimer == true){
      _canDelete = true;
      // }
    }

  return _canDelete;
}
