import 'package:bldrs/a_models/kw/chain/chain_crafts.dart';
import 'package:bldrs/a_models/kw/chain/chain_designs.dart';
import 'package:bldrs/a_models/kw/chain/chain_equipment.dart';
import 'package:bldrs/a_models/kw/chain/chain_products.dart';
import 'package:bldrs/a_models/kw/chain/chain_properties.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/kw/specs/spec_list_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/foundation.dart';

/// can be KWs or sub-Chains
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
  /// --------------------------------------------------------------------------
  static Chain filterSpecListChainRange(SpecList specList) {

    final List<KW> _filteredSons = <KW>[];
    Chain _filteredChain = specList.specChain;

    if (
    Mapper.canLoopList(_filteredChain.sons)
        &&
        Mapper.canLoopList(specList.range)
    ) {

      for (final KW kw in specList.specChain.sons) {

        final List<String> _strings = Mapper.getStringsFromDynamics(
            dynamics: specList.range,
        );

        if (
        Mapper.stringsContainString(
          strings: _strings,
          string: kw.id,
        ) == true
        ) {
          _filteredSons.add(kw);
        }
      }

      _filteredChain = Chain(
        id: specList.specChain.id,
        icon: specList.specChain.icon,
        sons: _filteredSons,
      );
    }

    return _filteredChain;
  }
// -----------------------------------------------------------------------------
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

/// CHECKERS

// --------------------------------------------
  static bool sonsAreChains(dynamic sons){
    final bool _areChains = sons is List<Chain>;
    return _areChains;
  }
// --------------------------------------------

}
