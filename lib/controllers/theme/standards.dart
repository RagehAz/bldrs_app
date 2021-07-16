

import 'package:bldrs/models/bz_model.dart';

class Standards{
// -----------------------------------------------------------------------------
  static const int maxFlyerSlidesFreeAccount = 50; /// TASK : should be save on firestore
  static const int maxFlyerSlidesPremiumAccount = 7;
  static const int maxFlyerSlidesFreeSuper = 25;

  static const int maxDraftsAtOnce = 5;

  static const int flyerTitleMaxLength = 50;
// -----------------------------------------------------------------------------
  static int getMaxSlidesCount(BzAccountType accountType){

    switch (accountType){
      case BzAccountType.Default:   return  maxFlyerSlidesFreeAccount;     break;
      case BzAccountType.Premium:   return  maxFlyerSlidesPremiumAccount;  break;
      case BzAccountType.Super:     return  maxFlyerSlidesFreeSuper;       break;
      default : return   maxFlyerSlidesFreeAccount;
    }

  }
// -----------------------------------------------------------------------------
}