import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mappers;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:flutter/foundation.dart';

class FlyerPromotion {
// -----------------------------------------------------------------------------
  const FlyerPromotion({
    @required this.cityID,
    @required this.flyerID,
    @required this.from,
    @required this.to,
    @required this.districtsIDs,
});
// -----------------------------------------------------------------------------
  final String cityID;
  final String flyerID;
  final DateTime from;
  final DateTime to;
  final List<String> districtsIDs;
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({bool toJSON = false}){
    return
        {
          'cityID' : cityID,
          'flyerID' : flyerID,
          'from' : Timers.cipherTime(time: from, toJSON: toJSON),
          'to' : Timers.cipherTime(time: to, toJSON: toJSON),
          'districtsIDs' : districtsIDs,
        };
  }
// -----------------------------------------------------------------------------
  static FlyerPromotion decipherFlyerPromotion({@required Map<String, dynamic> map, bool fromJSON = false}){

    FlyerPromotion _promotion;

    if (map != null){

      return
        _promotion = FlyerPromotion(
              cityID: map['cityID'],
              flyerID: map['flyerID'],
              from: Timers.decipherTime(time: map['from'], fromJSON: fromJSON),
              to: Timers.decipherTime(time: map['to'], fromJSON: fromJSON),
              districtsIDs: Mappers.getStringsFromDynamics(dynamics: map['districtsIDs']),
          );

    }

    return _promotion;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherFlyersPromotions({@required List<FlyerPromotion> flyersPromotions, bool toJSON = false}){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mappers.canLoopList(flyersPromotions)){

      for (final FlyerPromotion promo in flyersPromotions){

        final Map<String, dynamic> _promoMap = promo.toMap(toJSON: toJSON);
        _maps.add(_promoMap);
      }

    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static List<FlyerPromotion> decipherFlyersPromotions({@required List<Map<String, dynamic>> maps, bool fromJSON = false}){
    final List<FlyerPromotion> _promotions = <FlyerPromotion>[];

    if (Mappers.canLoopList(maps)){

      for (final Map<String, dynamic> map in maps){

        final FlyerPromotion _promo = decipherFlyerPromotion(map: map, fromJSON: fromJSON);
        _promotions.add(_promo);
      }

    }

    return _promotions;
  }
// -----------------------------------------------------------------------------
  static List<String> getFlyersIDsFromFlyersPromotions({@required List<FlyerPromotion> promotions}){

    final List<String> _flyersIDs = <String>[];

    if (Mappers.canLoopList(promotions)){

      for (final FlyerPromotion promo in promotions){

        _flyersIDs.add(promo.flyerID);

      }

    }

    return _flyersIDs;
  }
// -----------------------------------------------------------------------------
}
