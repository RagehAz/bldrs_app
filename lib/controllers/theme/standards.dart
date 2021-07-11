

import 'package:bldrs/models/bz_model.dart';

class Standards{
// -----------------------------------------------------------------------------
  static const int maxFlyerSlidesFreeAccount = 3;
  static const int maxFlyerSlidesPremiumAccount = 7;
  static const int maxFlyerSlidesFreeSuper = 15;

  static const int maxDraftsAtOnce = 5;

  static const int flyerTitleMaxLength = 50;
// -----------------------------------------------------------------------------
  static int getMaxFlyersSlidesByAccountType(BzAccountType accountType){

    switch (accountType){
      case BzAccountType.Default:   return  maxFlyerSlidesFreeAccount;     break;
      case BzAccountType.Premium:   return  maxFlyerSlidesPremiumAccount;  break;
      case BzAccountType.Super:     return  maxFlyerSlidesFreeSuper;       break;
      default : return   maxFlyerSlidesFreeAccount;
    }

  }
// -----------------------------------------------------------------------------
}