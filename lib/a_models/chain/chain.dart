import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_crafts.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_designs.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_equipment.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_products.dart';
import 'package:bldrs/a_models/chain/raw_data/keywords_chains/chain_properties.dart';
import 'package:bldrs/a_models/chain/raw_data/specs/raw_specs.dart' as specsChain;
import 'package:bldrs/a_models/chain/spec_models/spec_list_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class Chain {
  /// --------------------------------------------------------------------------
  const Chain({
    @required this.id,
    @required this.icon,
    @required this.sons,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String icon;
  final dynamic sons;
// -----------------------------------------------------------------------------

  /// CYPHERS

// --------------------------------------------
  Map<String, dynamic> toMap(){
    return
        {
          'id': id,
          'icon': icon,
          'sons': _cipherSons(sons),
        };
  }
// --------------------------------------------
  static dynamic _cipherSons(dynamic sons){
    /// can either be DataCreator or List<String> or List<Chain>
    final bool _sonsAreChains = sonsAreChains(sons);
    final bool _sonsAreString = sonsAreStrings(sons);
    final bool _sonsAreDataCreator = sonsAreDataCreator(sons);

    if (_sonsAreChains == true){
      return cipherChains(sons); // List<Map<String, dynamic>>
    }
    else if (_sonsAreString == true){
      return sons; // List<String>
    }
    else if ( _sonsAreDataCreator == true){
      return _cipherDataCreator(sons);
    }
    else {
      return null;
    }

  }
// --------------------------------------------
  static String _cipherDataCreator(dynamic sons){
    switch (sons){
      case DataCreator.price:               return 'price';               break;
      case DataCreator.currency:            return 'currency';            break;
      case DataCreator.country:             return 'country';             break;
      case DataCreator.boolSwitch:          return 'boolSwitch';          break;
      case DataCreator.doubleCreator:       return 'doubleCreator';       break;
      case DataCreator.doubleRangeSlider:   return 'doubleRangeSlider';   break;
      case DataCreator.doubleSlider:        return 'doubleSlider';        break;
      case DataCreator.integerIncrementer:  return 'integerIncrementer';  break;
      default: return null;
    }
  }
// --------------------------------------------
  static DataCreator _decipherDataCreator(String string){
    switch (string){
      case 'price':               return DataCreator.price;               break;
      case 'currency':            return DataCreator.currency;            break;
      case 'country':             return DataCreator.country;             break;
      case 'boolSwitch':          return DataCreator.boolSwitch;          break;
      case 'doubleCreator':       return DataCreator.doubleCreator;       break;
      case 'doubleRangeSlider':   return DataCreator.doubleRangeSlider;   break;
      case 'doubleSlider':        return DataCreator.doubleSlider;        break;
      case 'integerIncrementer':  return DataCreator.integerIncrementer;  break;
      default: return null;
    }
  }
// --------------------------------------------
  static List<Map<String, dynamic>> cipherChains(List<Chain> chains){

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(chains) == true){

      for (final Chain chain in chains){
        final Map<String, dynamic> _map = chain.toMap();
        _maps.add(_map);
      }

    }

    return _maps;
  }
// --------------------------------------------
  static Chain decipherChain(Map<String, dynamic> map){
    Chain _chain;

    if (map != null){
      _chain = Chain(
        id: map['id'],
        icon: map['icon'],
        sons: _decipherSons(map['sons']),
      );
    }

    return _chain;
  }
// --------------------------------------------
  static dynamic _decipherSons(dynamic sons){
    dynamic _output;

    if (sons != null){

      if (sons is List<Map<String, dynamic>>){
        _output = decipherChains(sons);
      }
      else if (sons is List<String>){
        _output = Mapper.getStringsFromDynamics(dynamics: sons);
      }
      else if (sons is String){
        _output = _decipherDataCreator(sons);
      }


    }

    return  _output;
  }
// --------------------------------------------
  static List<Chain> decipherChains(List<Map<String, dynamic>> maps){
    final List<Chain> _chains = <Chain>[];

    if (Mapper.canLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){
        final Chain _chain = decipherChain(map);
        _chains.add(_chain);
      }

    }

    return _chains;
  }
// -----------------------------------------------------------------------------

  /// FILTERS

// --------------------------------------------
//   /// TASK : REVISION
  static Chain filterSpecListChainRange({
    @required BuildContext context,
    @required SpecList specList,
}) {

    final List<String> _filteredIDs = <String>[];
    Chain _filteredChain = superGetChain(context, specList.chainID);

    if (
        Mapper.canLoopList(_filteredChain.sons)
        &&
        Mapper.canLoopList(specList.range)
    ) {

      final List<String> _rangeIDs = Mapper.getStringsFromDynamics(
        dynamics: specList.range,
      );

      for (final String son in _filteredChain.sons) {

        final bool _rangeContainsThisID = Mapper.stringsContainString(
          strings: _rangeIDs,
          string: son,
        ) == true;

        if (_rangeContainsThisID == true) {
          _filteredIDs.add(son);
        }

      }

      _filteredChain = Chain(
        id: _filteredChain.id,
        icon: _filteredChain.icon,
        sons: _filteredIDs,
      );
    }

    return _filteredChain;
  }
// -----------------------------------------------------------------------------

/// CHECKERS

// --------------------------------------------
  static bool sonsAreChains(dynamic sons){
    final bool _areChains = sons is List<Chain>;
    return _areChains;
  }
// --------------------------------------------
  static bool sonsAreDataCreator(dynamic sons){
    final bool _sonsAreChain = sonsAreChains(sons);
    final bool _sonsAreStrings = sonsAreStrings(sons);
    final bool _areDataCreator = _sonsAreChain == false && _sonsAreStrings == false;
    return _areDataCreator;
  }
// --------------------------------------------
  static bool sonsAreStrings(dynamic sons){
    final bool _areString = sons.runtimeType.toString() == 'List<String>';
    return _areString;
  }
// -----------------------------------------------------------------------------

  /// BLOGGERS

// --------------------------------------------
  void blogChain(){

    blog('Chain : $id : icon : $icon : sons :  $sons');

  }
// --------------------------------------------
  static void blogChains(List<Chain> chains){

    int _count = 1;
    blog('Blogging ${chains.length} chains ------------------------------------------------ START');
    for (final Chain chain in chains){

      blog('Number : $_count');
      chain.blogChain();
      _count++;
    }
    blog('Blogging ${chains.length} chains ------------------------------------------------ END');
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// --------------------------------------------
  static Chain getChainFromChainsByID({
    @required String chainID,
    @required List<Chain> chains,
}){

    Chain _chain;

    if (Mapper.canLoopList(chains) == true){

      for (final Chain chain in chains){

        if (chain.id == chainID){
          _chain = chain;
          break;
        }
        else if (sonsAreChains(chain.sons) == true){

          final Chain _son = getChainFromChainsByID(
              chainID: chainID,
              chains: chain.sons,
          );

          if (_son != null){
            _chain = _son;
            break;
          }

        }

      }

    }

    return _chain;
  }
// -----------------------------------------------------------------------------

/// SECTIONS / KEYWORDS CHAINS

// --------------------------------------------
  static const Chain bldrsChain = Chain(
    id: 'phid_sections',
    icon: Iconz.bldrsNameEn,
    sons: <Chain>[

      /// PROPERTIES
      ChainProperties.chain,

      /// DESIGN
      ChainDesigns.chain,

      /// CRAFTS
      ChainCrafts.chain,

      /// PRODUCTS
      ChainProducts.chain,

      /// EQUIPMENT
      ChainEquipment.chain,

    ],
  );
// -----------------------------------------------------------------------------

/// SPECS CHAINS

// --------------------------------------------
  static const Chain allSpecsChain = Chain(
    id: 'phid_s_specs_chain',
    icon: null,
    sons: <Chain>[
      specsChain.style,
      specsChain.color,
      specsChain.contractType,
      specsChain.paymentMethod,
      specsChain.price,
      specsChain.currency,
      specsChain.unitPriceInterval,
      specsChain.numberOfInstallments,
      specsChain.installmentsDuration,
      specsChain.installmentsDurationUnit,
      specsChain.duration,
      specsChain.durationUnit,
      specsChain.propertyArea,
      specsChain.propertyAreaUnit,
      specsChain.lotArea,
      specsChain.lotAreaUnit,
      specsChain.propertyForm,
      specsChain.propertyLicense,
      specsChain.propertySpaces,
      specsChain.propertyFloorNumber,
      specsChain.propertyDedicatedParkingLotsCount,
      specsChain.propertyNumberOfBedrooms,
      specsChain.propertyNumberOfBathrooms,
      specsChain.propertyView,
      specsChain.propertyIndoorFeatures,
      specsChain.propertyFinishingLevel,
      specsChain.buildingNumberOfFloors,
      specsChain.buildingAgeInYears,
      specsChain.buildingTotalParkingLotsCount,
      specsChain.buildingTotalUnitsCount,
      specsChain.inACompound,
      specsChain.amenities,
      specsChain.communityServices,
      specsChain.constructionActivityMeasurementMethod,
      specsChain.width,
      specsChain.length,
      specsChain.height,
      specsChain.thickness,
      specsChain.diameter,
      specsChain.radius,
      specsChain.linearMeasurementUnit,
      specsChain.footPrint,
      specsChain.areaMeasureUnit,
      specsChain.volume,
      specsChain.volumeMeasurementUnit,
      specsChain.weight,
      specsChain.weightMeasurementUnit,
      specsChain.count,
      specsChain.size,
      specsChain.wattage,
      specsChain.voltage,
      specsChain.ampere,
      specsChain.inStock,
      specsChain.deliveryAvailable,
      specsChain.deliveryDuration,
      specsChain.deliveryDurationUnit,
      specsChain.madeIn,
      specsChain.warrantyDuration,
      specsChain.warrantyDurationUnit,
    ],
  );
// -----------------------------------------------------------------------------
}
