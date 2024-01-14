import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class DeckModel {
  // -----------------------------------------------------------------------------
  const DeckModel({
    required this.all,
    required this.general,
    required this.properties,
    required this.designs,
    required this.undertakings,
    required this.trades,
    required this.products,
    required this.equipment,
  });
  // -----------------------------------------------------------------------------
  final List<String> all;
  final List<String> general;
  final List<String> properties;
  final List<String> designs;
  final List<String> undertakings;
  final List<String> trades;
  final List<String> products;
  final List<String> equipment;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED: WORKS PERFECT
  DeckModel copyWith({
    List<String>? all,
    List<String>? general,
    List<String>? properties,
    List<String>? designs,
    List<String>? undertakings,
    List<String>? trades,
    List<String>? products,
    List<String>? equipment,
  }){

    return DeckModel(
      all: all?? this.all,
      general: general?? this.general,
      properties: properties?? this.properties,
      designs: designs?? this.designs,
      undertakings: undertakings?? this.undertakings,
      trades: trades?? this.trades,
      products: products?? this.products,
      equipment: equipment?? this.equipment,
    );

  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static DeckModel newDeck(){
    return const DeckModel(
      all: <String>[],
      general: <String>[],
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
  /// TESTED: WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'all': all,
      'general': general,
      'properties': properties,
      'designs': designs,
      'undertakings': undertakings,
      'trades': trades,
      'products': products,
      'equipment': equipment,
    };
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static DeckModel decipher(Map<String, dynamic>? map){
    DeckModel _deck = newDeck();

    if (map != null){

      _deck = DeckModel(
          all: Stringer.getStringsFromDynamics(map['all']),
          general: Stringer.getStringsFromDynamics(map['general']),
          properties: Stringer.getStringsFromDynamics(map['properties']),
          designs: Stringer.getStringsFromDynamics(map['designs']),
          undertakings: Stringer.getStringsFromDynamics(map['undertakings']),
          trades: Stringer.getStringsFromDynamics(map['trades']),
          products: Stringer.getStringsFromDynamics(map['products']),
          equipment: Stringer.getStringsFromDynamics(map['equipment']),
      );

    }

    return _deck;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED: WORKS PERFECT
  static DeckModel addFlyer({
    required FlyerModel? flyer,
    required DeckModel? oldDeck,
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

        /// GENERAL
        case FlyerType.general:
          _newDeck = _newDeck.copyWith(
              general: Stringer.addStringToListIfDoesNotContainIt(
                strings: _newDeck.general,
                stringToAdd: flyer.id,
              )
          );
          break;

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
        case FlyerType.undertaking    :
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
  /// TESTED: WORKS PERFECT
  static DeckModel addFlyers({
    required List<FlyerModel>? flyers,
    required DeckModel? deckModel,
  }){
    DeckModel _newDeck = deckModel ?? newDeck();

    if (Lister.checkCanLoop(flyers) == true){

      for (final FlyerModel flyer in flyers!){

        _newDeck = addFlyer(
          flyer: flyer,
          oldDeck: _newDeck,
        );

      }

    }

    return _newDeck;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static DeckModel addOrRemoveFlyer({
    required FlyerModel? flyer,
    required DeckModel? oldDeck,
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

        /// GENERAL
        case FlyerType.general:
          _newDeck = _newDeck.copyWith(
            general: Stringer.addOrRemoveStringToStrings(
              strings: _newDeck.general,
              string: flyer.id,
            )
          );
          break;

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
        case FlyerType.undertaking    :
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
  /// TESTED: WORKS PERFECT
  static DeckModel addOrRemoveFlyers({
    required List<FlyerModel>? flyers,
    required DeckModel? deckModel,
  }){
    DeckModel _newDeck = deckModel ?? newDeck();

    if (Lister.checkCanLoop(flyers) == true){

      for (final FlyerModel flyer in flyers!){

        _newDeck = addOrRemoveFlyer(
            flyer: flyer,
            oldDeck: _newDeck,
        );

      }

    }

    return _newDeck;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static DeckModel removeFlyer({
    required FlyerModel? flyer,
    required DeckModel? oldDeck,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (flyer?.id != null){

      _newDeck = _newDeck.copyWith(
          all: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.all,
            removeThis: [flyer!.id!],
          )
      );

      switch(flyer.flyerType){

      /// GENERAL
      case FlyerType.general:
        _newDeck = _newDeck.copyWith(
          general: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.general,
            removeThis: [flyer.id!],
          )
        );
        break;

      /// PROPERTIES
        case FlyerType.property   :
          _newDeck = _newDeck.copyWith(
            properties: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.properties,
              removeThis: [flyer.id!],
            ),
          ); break;

      /// DESIGNS
        case FlyerType.design     :
          _newDeck = _newDeck.copyWith(
            designs: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.designs,
              removeThis: [flyer.id!],
            ),
          ); break;

      /// UNDERTAKING
        case FlyerType.undertaking    :
          _newDeck = _newDeck.copyWith(
            undertakings: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.undertakings,
              removeThis: [flyer.id!],
            ),
          ); break;

      /// TRADES
        case FlyerType.trade    :
          _newDeck = _newDeck.copyWith(
            trades: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.trades,
              removeThis: [flyer.id!],
            ),
          ); break;

      /// PRODUCTS
        case FlyerType.product      :
          _newDeck = _newDeck.copyWith(
            products: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.products,
              removeThis: [flyer.id!],
            ),
          ); break;

      /// EQUIPMENT
        case FlyerType.equipment  :
          _newDeck = _newDeck.copyWith(
            equipment: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.equipment,
              removeThis: [flyer.id!],
            ),
          ); break;

        default: _newDeck = _newDeck.copyWith();
      }

    }

    return _newDeck;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static DeckModel removeFlyers({
    required List<FlyerModel>? flyers,
    required DeckModel? oldDeck,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (Lister.checkCanLoop(flyers) == true){

      for (final FlyerModel flyer in flyers!){

        _newDeck = removeFlyer(
          flyer: flyer,
          oldDeck: _newDeck,
        );

      }

    }

    return _newDeck;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static DeckModel removeFlyerByID({
    required DeckModel? oldDeck,
    required String? flyerID,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (flyerID != null){

      final bool _contains = Stringer.checkStringsContainString(
          strings: _newDeck.all,
          string: flyerID,
      );

      if (_contains == true){

        /// REMOVE FROM ALL
        _newDeck = _newDeck.copyWith(all: Stringer.removeStringsFromStrings(
              removeFrom: _newDeck.all,
              removeThis: [flyerID],
          ),);

        /// GENERAL
        if (Stringer.checkStringsContainString(strings: _newDeck.general, string: flyerID,) == true){
          _newDeck = _newDeck.copyWith(general: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.general,
            removeThis: [flyerID],
          ),);
        }
        /// PROPERTIES
        else if (Stringer.checkStringsContainString(strings: _newDeck.properties, string: flyerID) == true){
          _newDeck = _newDeck.copyWith(properties: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.properties,
            removeThis: [flyerID],
          ),);
        }
        /// DESIGNS
        else if (Stringer.checkStringsContainString(strings: _newDeck.designs, string: flyerID) == true){
          _newDeck = _newDeck.copyWith(designs: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.designs,
            removeThis: [flyerID],
          ),);
        }
        /// UNDERTAKINGS
        else if (Stringer.checkStringsContainString(strings: _newDeck.undertakings, string: flyerID) == true){
          _newDeck = _newDeck.copyWith(undertakings: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.undertakings,
            removeThis: [flyerID],
          ),);
        }
        /// TRADES
        else if (Stringer.checkStringsContainString(strings: _newDeck.trades, string: flyerID) == true){
          _newDeck = _newDeck.copyWith(trades: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.trades,
            removeThis: [flyerID],
          ),);
        }
        /// PRODUCTS
        else if (Stringer.checkStringsContainString(strings: _newDeck.products, string: flyerID) == true){
          _newDeck = _newDeck.copyWith(products: Stringer.removeStringsFromStrings(
            removeFrom: _newDeck.products,
            removeThis: [flyerID],
          ),);
        }
        /// EQUIPMENT
        else if (Stringer.checkStringsContainString(strings: _newDeck.equipment, string: flyerID) == true){
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
  /// TESTED: WORKS PERFECT
  static DeckModel removeFlyersByIDs({
    required DeckModel? oldDeck,
    required List<String>? flyersIDs,
  }){
    DeckModel _newDeck = oldDeck ?? newDeck();

    if (Lister.checkCanLoop(flyersIDs) == true){

      for (final String flyerID in flyersIDs!){

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
  /// TESTED: WORKS PERFECT
  static int? getCountByFlyerType({
    required FlyerType? flyerType,
    required DeckModel? deckModel,
  }){
    int? _output;

    if (flyerType != null && deckModel != null){

      switch (flyerType) {
        case FlyerType.general      : return _output = deckModel.general.length;
        case FlyerType.property     : return _output = deckModel.properties.length;
        case FlyerType.design       : return _output = deckModel.designs.length;
        case FlyerType.undertaking  : return _output = deckModel.undertakings.length;
        case FlyerType.trade        : return _output = deckModel.trades.length;
        case FlyerType.product      : return _output = deckModel.products.length;
        case FlyerType.equipment    : return _output = deckModel.equipment.length;
        default: _output = 0;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED: WORKS PERFECT
  static bool checkDecksAreIdentical({
    required DeckModel? deck1,
    required DeckModel? deck2,
  }){
    bool _areIdentical = false;

    if (deck1 == null && deck2 == null){
      _areIdentical = true;
    }

    else if (deck1 != null && deck2 != null){

      if (
        Lister.checkListsAreIdentical(list1: deck1.general,       list2: deck2.general) == true &&
        Lister.checkListsAreIdentical(list1: deck1.all,           list2: deck2.all) == true &&
        Lister.checkListsAreIdentical(list1: deck1.properties,    list2: deck2.properties) == true &&
        Lister.checkListsAreIdentical(list1: deck1.designs,       list2: deck2.designs) == true &&
        Lister.checkListsAreIdentical(list1: deck1.undertakings,  list2: deck2.undertakings) == true &&
        Lister.checkListsAreIdentical(list1: deck1.trades,        list2: deck2.trades) == true &&
        Lister.checkListsAreIdentical(list1: deck1.products,      list2: deck2.products) == true &&
        Lister.checkListsAreIdentical(list1: deck1.equipment,     list2: deck2.equipment) == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString() =>
      'DeckModel(\n'
      '   all :          \n       $all\n'
      '   general :      \n       $general\n'
      '   properties :   \n       $properties\n'
      '   designs :      \n       $designs\n'
      '   undertakings : \n       $undertakings\n'
      '   trades :       \n       $trades\n'
      '   products :     \n       $products\n'
      '   equipment :    \n       $equipment\n'
      ')';
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
      general.hashCode^
      properties.hashCode^
      designs.hashCode^
      undertakings.hashCode^
      trades.hashCode^
      products.hashCode^
      equipment.hashCode;
  // -----------------------------------------------------------------------------
}
