import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:space_time/space_time.dart';
import 'package:flutter/foundation.dart';

@immutable
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

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return
      {
        'cityID' : cityID,
        'flyerID' : flyerID,
        'from' : Timers.cipherTime(time: from, toJSON: toJSON),
        'to' : Timers.cipherTime(time: to, toJSON: toJSON),
        'districtsIDs' : districtsIDs,
      };
  }
  // --------------------
  static FlyerPromotion decipherFlyerPromotion({
    @required Map<String, dynamic> map,
    bool fromJSON = false,
  }){

    FlyerPromotion _promotion;

    if (map != null){

      return
        _promotion = FlyerPromotion(
          cityID: map['cityID'],
          flyerID: map['flyerID'],
          from: Timers.decipherTime(time: map['from'], fromJSON: fromJSON),
          to: Timers.decipherTime(time: map['to'], fromJSON: fromJSON),
          districtsIDs: Stringer.getStringsFromDynamics(dynamics: map['districtsIDs']),
        );

    }

    return _promotion;
  }
  // --------------------
  static List<Map<String, dynamic>> cipherFlyersPromotions({
    @required List<FlyerPromotion> flyersPromotions,
    @required bool toJSON,
  }){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(flyersPromotions)){

      for (final FlyerPromotion promo in flyersPromotions){

        final Map<String, dynamic> _promoMap = promo.toMap(toJSON: toJSON);
        _maps.add(_promoMap);
      }

    }

    return _maps;
  }
  // --------------------
  static List<FlyerPromotion> decipherFlyersPromotions({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }){
    final List<FlyerPromotion> _promotions = <FlyerPromotion>[];

    if (Mapper.checkCanLoopList(maps)){

      for (final Map<String, dynamic> map in maps){

        final FlyerPromotion _promo = decipherFlyerPromotion(map: map, fromJSON: fromJSON);
        _promotions.add(_promo);
      }

    }

    return _promotions;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static List<String> getFlyersIDsFromFlyersPromotions({
    @required List<FlyerPromotion> promotions
  }){

    final List<String> _flyersIDs = <String>[];

    if (Mapper.checkCanLoopList(promotions)){

      for (final FlyerPromotion promo in promotions){

        _flyersIDs.add(promo.flyerID);

      }

    }

    return _flyersIDs;
  }
// --------------------
  /*

  /// OVERRIDES

// ----------------------------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
// ----------------------------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is BzCounterModel){
      _areIdentical = checkBzCounterModelsAreIdentical(
        counter1: this,
        counter2: other,
      );
    }

    return _areIdentical;
  }
// ----------------------------------------
  @override
  int get hashCode =>
      bzID.hashCode^
      follows.hashCode^
      calls.hashCode^
      allSaves.hashCode^
      allShares.hashCode^
      allSlides.hashCode^
      allViews.hashCode^
      allReviews.hashCode;

   */
// -----------------------------------------------------------------------------
}
