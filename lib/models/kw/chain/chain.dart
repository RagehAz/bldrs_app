import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/kw/chain/chain_crafts.dart';
import 'package:bldrs/models/kw/chain/chain_designs.dart';
import 'package:bldrs/models/kw/chain/chain_equipment.dart';
import 'package:bldrs/models/kw/chain/chain_products.dart';
import 'package:bldrs/models/kw/chain/chain_properties.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/kw/specs/spec_list_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:flutter/foundation.dart';

  /// can be KWs or sub-Chains
class Chain {
  /// --------------------------------------------------------------------------
  const Chain({
    @required this.id,
    @required this.icon,
    @required this.names,
    @required this.sons,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String icon;
  final List<Name> names;
  final dynamic sons;
  /// --------------------------------------------------------------------------
  static Chain filterSpecListChainRange(SpecList specList){

    final List<KW> _filteredSons = <KW>[];
    Chain _filteredChain = specList.specChain;

    if (Mapper.canLoopList(_filteredChain.sons) && Mapper.canLoopList(specList.range)){

      for (final KW kw in specList.specChain.sons){
        final List<String> _strings = Mapper.getStringsFromDynamics(dynamics: specList.range);
        if (Mapper.stringsContainString(strings: _strings, string: kw.id)){
          _filteredSons.add(kw);
        }
      }

      _filteredChain = Chain(
        id: specList.specChain.id,
        icon: specList.specChain.icon,
        names: specList.specChain.names,
        sons: _filteredSons,
      );

    }

    return _filteredChain;
  }
// -----------------------------------------------------------------------------
  static const Chain bldrsChain = Chain(
    id: 'bldrs',
    icon: Iconz.bldrsNameEn,
    names: <Name>[
      Name(code: 'en', value: 'Bldrs.net'),
      Name(code: 'ar', value: 'بلدرز.نت')
    ],
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
}
