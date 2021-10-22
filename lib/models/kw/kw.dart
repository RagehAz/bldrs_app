import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/kw/chain_crafts.dart';
import 'package:bldrs/models/kw/chain_designs.dart';
import 'package:bldrs/models/kw/chain_equipment.dart';
import 'package:bldrs/models/kw/chain_products.dart';
import 'package:bldrs/models/kw/chain_properties.dart';
import 'package:flutter/cupertino.dart';

class KW {
  final String id;
  final List<Name> names;

  const KW({
    @required this.id,
    @required this.names,
  });
}

class Chain {
  final String id;
  final List<Name> names;
  final List<dynamic> sons;

  /// can be KWs or sub-Chains

  const Chain({
    @required this.id,
    @required this.names,
    @required this.sons,
  });

  static Chain bldrsChain() {
    return const Chain(
      id: 'bldrs',
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
  }
}
