import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
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

  /// CONSTANTS

  // --------------------
  static const PriceModel emptyPrice = PriceModel(
    current: 0,
    old: 0,
    currencyID: CurrencyModel.usaCurrencyID,
  );
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  PriceModel copyWith({
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool canShowPriceInFlyerCreator({
    required FlyerType? flyerType,
  }){
    bool _output = false;

    if (flyerType != null){
      switch(flyerType){
        case FlyerType.general:      _output = true   ;  break;
        case FlyerType.property:     _output = true   ;  break;
        case FlyerType.design:       _output = false  ;  break;
        case FlyerType.undertaking:  _output = false  ;  break;
        case FlyerType.trade:        _output = false  ;  break;
        case FlyerType.product:      _output = true   ;  break;
        case FlyerType.equipment:    _output = true   ;  break;
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBzMayHavePriceInFlyerCreator({
    required List<BzType>? bzTypes,
  }){
    bool _output = false;

    if (Lister.checkCanLoopList(bzTypes) == true){

      for (final bzType in bzTypes!){

        switch(bzType){
          case BzType.developer:     _output = true;  break;
          case BzType.broker:        _output = true;  break;
          case BzType.designer:      _output = false;  break;
          case BzType.contractor:    _output = false;  break;
          case BzType.artisan:       _output = false;  break;
          case BzType.manufacturer:  _output = true;  break;
          case BzType.supplier:      _output = true;  break;
        }

        if (_output == true){
          break;
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanShowDiscount({
    required PriceModel? price,
  }){
    bool _output = false;

    if (price != null && price.old != null){

      if (price.current > 0 && price.old! > 0){
        _output = true;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse generatePriceDiscountLine({
    required PriceModel? price,
  }){
    final String _discount = getWord('phid_discount');
    final int _number = getDiscountPercentage(price: price);
    final String _sentence = '$_number % $_discount';
    return Verse(
      id: _sentence,
      translate: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
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
   @override
   String toString() => 'PriceModel(current: $current, currencyID: $currencyID : old : $old)';
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
