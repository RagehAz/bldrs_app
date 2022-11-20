import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter/material.dart';

@immutable
class DeckModel {
  // -----------------------------------------------------------------------------
  const DeckModel({
    @required this.all,
    @required this.properties,
    @required this.designs,
    @required this.undertakings,
    @required this.trades,
    @required this.products,
    @required this.equipment,
  });
  // -----------------------------------------------------------------------------
  final List<String> all;
  final List<String> properties;
  final List<String> designs;
  final List<String> undertakings;
  final List<String> trades;
  final List<String> products;
  final List<String> equipment;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  DeckModel copyWith({
    List<String> all,
    List<String> properties,
    List<String> designs,
    List<String> undertakings,
    List<String> trades,
    List<String> products,
    List<String> equipment,
  }){

    return DeckModel(
      all: all?? this.all,
      properties: properties?? this.properties,
      designs: designs?? this.designs,
      undertakings: undertakings?? this.undertakings,
      trades: trades?? this.trades,
      products: products?? this.products,
      equipment: equipment?? this.equipment,
    );

  }
  // --------------------
  ///
  static DeckModel newDeck(){
    return const DeckModel(
      all: <String>[],
      properties: <String>[],
      designs: <String>[],
      undertakings: <String>[],
      trades: <String>[],
      products: <String>[],
      equipment: <String>[],
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  ///
  Map<String, dynamic> toMap(){
    return {
      'all': all,
      'properties': properties,
      'designs': designs,
      'undertakings': undertakings,
      'trades': trades,
      'products': products,
      'equipment': equipment,
    };
  }
  // --------------------
  ///
  static DeckModel decipher(Map<String, dynamic> map){
    DeckModel _deck = newDeck();

    if (map != null){

      _deck = DeckModel(
          all: Stringer.getStringsFromDynamics(dynamics: map['all']),
          properties: Stringer.getStringsFromDynamics(dynamics: map['properties']),
          designs: Stringer.getStringsFromDynamics(dynamics: map['designs']),
          undertakings: Stringer.getStringsFromDynamics(dynamics: map['undertakings']),
          trades: Stringer.getStringsFromDynamics(dynamics: map['trades']),
          products: Stringer.getStringsFromDynamics(dynamics: map['products']),
          equipment: Stringer.getStringsFromDynamics(dynamics: map['equipment']),
      );

    }

    return _deck;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  ///
  static DeckModel addFlyer({
    @required FlyerModel flyer,
    @required DeckModel oldDeck,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (flyer != null){

      _newDeck = _newDeck.copyWith(
          all: Stringer.addStringToListIfDoesNotContainIt(
            strings: _newDeck.all,
            stringToAdd: flyer.id,
          )
      );

      switch(flyer.flyerType){

      /// PROPERTIES
        case FlyerType.property   :
          _newDeck = _newDeck.copyWith(
            properties: Stringer.addStringToListIfDoesNotContainIt(
              strings: _newDeck.properties,
              stringToAdd: flyer.id,
            ),
          ); break;

      /// DESIGNS
        case FlyerType.design     :
          _newDeck = _newDeck.copyWith(
            designs: Stringer.addStringToListIfDoesNotContainIt(
              strings: _newDeck.designs,
              stringToAdd: flyer.id,
            ),
          ); break;

      /// UNDERTAKING
        case FlyerType.project    :
          _newDeck = _newDeck.copyWith(
            undertakings: Stringer.addStringToListIfDoesNotContainIt(
              strings: _newDeck.undertakings,
              stringToAdd: flyer.id,
            ),
          ); break;

      /// TRADES
        case FlyerType.trade    :
          _newDeck = _newDeck.copyWith(
            trades: Stringer.addStringToListIfDoesNotContainIt(
              strings: _newDeck.trades,
              stringToAdd: flyer.id,
            ),
          ); break;

      /// PRODUCTS
        case FlyerType.product      :
          _newDeck = _newDeck.copyWith(
            products: Stringer.addStringToListIfDoesNotContainIt(
              strings: _newDeck.products,
              stringToAdd: flyer.id,
            ),
          ); break;

      /// EQUIPMENT
        case FlyerType.equipment  :
          _newDeck = _newDeck.copyWith(
            equipment: Stringer.addStringToListIfDoesNotContainIt(
              strings: _newDeck.equipment,
              stringToAdd: flyer.id,
            ),
          ); break;

        default: _newDeck = _newDeck.copyWith();
      }

    }

    return _newDeck;
  }
  // --------------------
  ///
  static DeckModel addFlyers({
    @required List<FlyerModel> flyers,
    @required DeckModel deckModel,
  }){
    DeckModel _newDeck = deckModel ?? newDeck();

    if (Mapper.checkCanLoopList(flyers) == true){

      for (final FlyerModel flyer in flyers){

        _newDeck = addFlyer(
          flyer: flyer,
          oldDeck: _newDeck,
        );

      }

    }

    return _newDeck;
  }
  // --------------------
  ///
  static DeckModel addOrRemoveFlyer({
    @required FlyerModel flyer,
    @required DeckModel oldDeck,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (flyer != null){

      _newDeck = _newDeck.copyWith(
        all: Stringer.addOrRemoveStringToStrings(
          strings: _newDeck.all,
          string: flyer.id,
        )
      );

      switch(flyer.flyerType){

        /// PROPERTIES
        case FlyerType.property   :
          _newDeck = _newDeck.copyWith(
            properties: Stringer.addOrRemoveStringToStrings(
              strings: _newDeck.properties,
              string: flyer.id,
            ),
          ); break;

          /// DESIGNS
        case FlyerType.design     :
          _newDeck = _newDeck.copyWith(
            designs: Stringer.addOrRemoveStringToStrings(
              strings: _newDeck.designs,
              string: flyer.id,
            ),
          ); break;

          /// UNDERTAKING
        case FlyerType.project    :
          _newDeck = _newDeck.copyWith(
            undertakings: Stringer.addOrRemoveStringToStrings(
              strings: _newDeck.undertakings,
              string: flyer.id,
            ),
          ); break;

          /// TRADES
        case FlyerType.trade    :
          _newDeck = _newDeck.copyWith(
            trades: Stringer.addOrRemoveStringToStrings(
              strings: _newDeck.trades,
              string: flyer.id,
            ),
          ); break;

          /// PRODUCTS
        case FlyerType.product      :
          _newDeck = _newDeck.copyWith(
            products: Stringer.addOrRemoveStringToStrings(
              strings: _newDeck.products,
              string: flyer.id,
            ),
          ); break;

          /// EQUIPMENT
        case FlyerType.equipment  :
          _newDeck = _newDeck.copyWith(
            equipment: Stringer.addOrRemoveStringToStrings(
              strings: _newDeck.equipment,
              string: flyer.id,
            ),
          ); break;

          default: _newDeck = _newDeck.copyWith();
      }

    }

    return _newDeck;
  }
  // --------------------
  ///
  static DeckModel addOrRemoveFlyers({
    @required List<FlyerModel> flyers,
    @required DeckModel deckModel,
  }){
    DeckModel _newDeck = deckModel ?? newDeck();

    if (Mapper.checkCanLoopList(flyers) == true){

      for (final FlyerModel flyer in flyers){

        _newDeck = addOrRemoveFlyer(
            flyer: flyer,
            oldDeck: _newDeck,
        );

      }

    }

    return _newDeck;
  }
  // --------------------
  ///
  static DeckModel removeFlyer({
    @required FlyerModel flyer,
    @required DeckModel oldDeck,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (flyer != null){

      _newDeck = _newDeck.copyWith(
          all: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.all,
            removeThis: [flyer.id],
          )
      );

      switch(flyer.flyerType){

      /// PROPERTIES
        case FlyerType.property   :
          _newDeck = _newDeck.copyWith(
            properties: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.properties,
              removeThis: [flyer.id],
            ),
          ); break;

      /// DESIGNS
        case FlyerType.design     :
          _newDeck = _newDeck.copyWith(
            designs: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.designs,
              removeThis: [flyer.id],
            ),
          ); break;

      /// UNDERTAKING
        case FlyerType.project    :
          _newDeck = _newDeck.copyWith(
            undertakings: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.undertakings,
              removeThis: [flyer.id],
            ),
          ); break;

      /// TRADES
        case FlyerType.trade    :
          _newDeck = _newDeck.copyWith(
            trades: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.trades,
              removeThis: [flyer.id],
            ),
          ); break;

      /// PRODUCTS
        case FlyerType.product      :
          _newDeck = _newDeck.copyWith(
            products: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.products,
              removeThis: [flyer.id],
            ),
          ); break;

      /// EQUIPMENT
        case FlyerType.equipment  :
          _newDeck = _newDeck.copyWith(
            equipment: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.equipment,
              removeThis: [flyer.id],
            ),
          ); break;

        default: _newDeck = _newDeck.copyWith();
      }

    }

    return _newDeck;
  }
  // --------------------
  ///
  static DeckModel removeFlyers({
    @required List<FlyerModel> flyers,
    @required DeckModel oldDeck,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (Mapper.checkCanLoopList(flyers) == true){

      for (final FlyerModel flyer in flyers){

        _newDeck = removeFlyer(
          flyer: flyer,
          oldDeck: _newDeck,
        );

      }

    }

    return _newDeck;
  }
  // --------------------
  ///
  static DeckModel removeFlyerByID({
    @required DeckModel oldDeck,
    @required String flyerID,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (flyerID != null){

      final bool _contains = Stringer.checkStringsContainString(
          strings: oldDeck.all,
          string: flyerID,
      );

      if (_contains == true){

        /// REMOVE FROM ALL
        _newDeck = _newDeck.copyWith(all: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.all,
              removeThis: [flyerID],
          ),);

        /// PROPERTIES
        if (Stringer.checkStringsContainString(strings: _newDeck.properties, string: flyerID)){
          _newDeck = _newDeck.copyWith(properties: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.properties,
            removeThis: [flyerID],
          ),);
        }
        /// DESIGNS
        else if (Stringer.checkStringsContainString(strings: _newDeck.designs, string: flyerID)){
          _newDeck = _newDeck.copyWith(designs: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.designs,
            removeThis: [flyerID],
          ),);
        }
        /// UNDERTAKINGS
        else if (Stringer.checkStringsContainString(strings: _newDeck.undertakings, string: flyerID)){
          _newDeck = _newDeck.copyWith(undertakings: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.undertakings,
            removeThis: [flyerID],
          ),);
        }
        /// TRADES
        else if (Stringer.checkStringsContainString(strings: _newDeck.trades, string: flyerID)){
          _newDeck = _newDeck.copyWith(trades: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.trades,
            removeThis: [flyerID],
          ),);
        }
        /// PRODUCTS
        else if (Stringer.checkStringsContainString(strings: _newDeck.products, string: flyerID)){
          _newDeck = _newDeck.copyWith(products: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.products,
            removeThis: [flyerID],
          ),);
        }
        /// EQUIPMENT
        else if (Stringer.checkStringsContainString(strings: _newDeck.equipment, string: flyerID)){
          _newDeck = _newDeck.copyWith(equipment: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.equipment,
            removeThis: [flyerID],
          ),);
        }
      }

    }

    return _newDeck;
  }
  // --------------------
  ///
  static DeckModel removeFlyersByIDs({
    @required DeckModel oldDeck,
    @required List<String> flyersIDs,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (Mapper.checkCanLoopList(flyersIDs) == true){

      for (final String flyerID in flyersIDs){

        _newDeck = removeFlyerByID(
          flyerID: flyerID,
          oldDeck: oldDeck,
        );

      }

    }

    return _newDeck;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static int getCountByFlyerType({
    @required FlyerType flyerType,
    @required DeckModel deckModel,
  }){
    int _output;

    if (flyerType != null && deckModel != null){

      switch (flyerType) {
        case FlyerType.all        : return _output = deckModel.all.length;          break;
        case FlyerType.property   : return _output = deckModel.properties.length;   break;
        case FlyerType.design     : return _output = deckModel.designs.length;      break;
        case FlyerType.project    : return _output = deckModel.undertakings.length; break;
        case FlyerType.trade      : return _output = deckModel.trades.length;       break;
        case FlyerType.product    : return _output = deckModel.products.length;     break;
        case FlyerType.equipment  : return _output = deckModel.equipment.length;    break;
        default: _output = 0;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  ///
  static bool checkDecksAreIdentical({
    @required DeckModel deck1,
    @required DeckModel deck2,
  }){
    bool _areIdentical = false;

    if (deck1 == null && deck2 == null){
      _areIdentical = true;
    }

    else if (deck1 != null && deck2 != null){

      if (
        Mapper.checkListsAreIdentical(list1: deck1.all,           list2: deck2.all) == true &&
        Mapper.checkListsAreIdentical(list1: deck1.properties,    list2: deck2.properties) == true &&
        Mapper.checkListsAreIdentical(list1: deck1.designs,       list2: deck2.designs) == true &&
        Mapper.checkListsAreIdentical(list1: deck1.undertakings,  list2: deck2.undertakings) == true &&
        Mapper.checkListsAreIdentical(list1: deck1.trades,        list2: deck2.trades) == true &&
        Mapper.checkListsAreIdentical(list1: deck1.products,      list2: deck2.products) == true &&
        Mapper.checkListsAreIdentical(list1: deck1.equipment,     list2: deck2.equipment) == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
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
    if (other is DeckModel){
      _areIdentical = checkDecksAreIdentical(
        deck1: this,
        deck2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      all.hashCode^
      properties.hashCode^
      designs.hashCode^
      undertakings.hashCode^
      trades.hashCode^
      products.hashCode^
      equipment.hashCode;
  // -----------------------------------------------------------------------------
}
