import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:flutter/material.dart';

@immutable
class PriceModel {
  // -----------------------------------------------------------------------------
  const PriceModel({
    required this.current,
    required this.currencyID,
    this.old,
  });
  // --------------------
  final double current;
  final double? old;
  final String currencyID;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///
  PriceModel clone({
    double? current,
    double? old,
    String? currencyID,
  }) {
    return PriceModel(
      current: current ?? this.current,
      old: old ?? this.old,
      currencyID: currencyID ?? this.currencyID,
    );
  }
  // -----------------------------------------------------------------------------

  /// CIPHER

  // --------------------
  ///
  Map<String, dynamic> toMap(){

    Map<String, dynamic> _map = <String, dynamic>{
      'current': current,
      'old': old,
      'currencyID': currencyID,
    };

    if (old != null){
      _map = Mapper.insertPairInMap(
          map: _map,
          overrideExisting: true,
          key: 'old',
          value: old,
      );
    }

    return _map;
  }
  // --------------------
  ///
  static PriceModel? decipher({
    required Map<String, dynamic>? map,
  }){

    if (map == null){
      return null;
    }

    else {

      return PriceModel(
        current: map['current'],
        currencyID: map['currencyID'],
        old: map['old'],
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static int getDiscountPercentage({
    required PriceModel? price,
  }){

    if (price == null || price.old == null){
      return 0;
    }
    else {
      return Numeric.calculateDiscountPercentage(
        oldPrice: price.old,
        currentPrice: price.current,
      )!;
    }


  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  ///
  static bool checkPricesAreIdentical({
    required PriceModel? price1,
    required PriceModel? price2,
  }){

    final Map<String, dynamic>? _map1 = price1?.toMap();
    final Map<String, dynamic>? _map2 = price2?.toMap();

    return Mapper.checkMapsAreIdentical(
        map1: _map1,
        map2: _map2
    );

  }
  // -----------------------------------------------------------------------------
  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is PriceModel){
      _areIdentical = checkPricesAreIdentical(
        price1: this,
        price2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      current.hashCode^
      old.hashCode^
      currencyID.hashCode;
// -----------------------------------------------------------------------------
}
