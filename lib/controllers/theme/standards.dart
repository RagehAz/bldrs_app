import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';

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
  static bool canAddMoreSlides({SuperFlyer superFlyer}){
    bool _canAdd = false;

    if (superFlyer != null){
      final int _maxSlides = getMaxSlidesCount(superFlyer.bz.accountType);
      final int _numberOfSlides = superFlyer.mSlides.length;

      if (_numberOfSlides < _maxSlides){
        _canAdd = true;
      }
    }

    return _canAdd;
  }
// -----------------------------------------------------------------------------
static bool canDeleteSlide({SuperFlyer superFlyer}){
    bool _canDelete = false;

    if (superFlyer != null){
      if(superFlyer.numberOfSlides != 0){
        // if(superFlyer.firstTimer == true){
          _canDelete = true;
        // }
      }
    }


    return _canDelete;
}
// -----------------------------------------------------------------------------

}