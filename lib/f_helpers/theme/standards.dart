import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';

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
int getMaxSlidesCount(BzAccountType accountType) {
  switch (accountType) {
    case BzAccountType.normal:
      return maxFlyerSlidesFreeAccount;
      break;
    case BzAccountType.premium:
      return maxFlyerSlidesPremiumAccount;
      break;
    case BzAccountType.sphinx:
      return maxFlyerSlidesFreeSuper;
      break;
    default:
      return maxFlyerSlidesFreeAccount;
  }
}

// -----------------------------------------------------------------------------
bool canAddMoreSlides({SuperFlyer superFlyer}) {
  bool _canAdd = false;

  if (superFlyer != null) {
    final int _maxSlides = getMaxSlidesCount(superFlyer.bz.accountType);
    final int _numberOfSlides = superFlyer.mSlides.length;

    if (_numberOfSlides < _maxSlides) {
      _canAdd = true;
    }
  }

  return _canAdd;
}

// -----------------------------------------------------------------------------
bool canDeleteSlide({SuperFlyer superFlyer}) {
  bool _canDelete = false;

  if (superFlyer != null) {
    if (superFlyer.numberOfSlides != 0) {
      // if(superFlyer.firstTimer == true){
      _canDelete = true;
      // }
    }
  }

  return _canDelete;
}
