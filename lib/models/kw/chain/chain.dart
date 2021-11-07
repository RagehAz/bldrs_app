import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/kw/chain/chain_crafts.dart';
import 'package:bldrs/models/kw/chain/chain_designs.dart';
import 'package:bldrs/models/kw/chain/chain_equipment.dart';
import 'package:bldrs/models/kw/chain/chain_products.dart';
import 'package:bldrs/models/kw/chain/chain_properties.dart';
import 'package:flutter/foundation.dart';

class Chain {
  final String id;
  final String icon;
  final List<Name> names;
  final dynamic sons;

  /// can be KWs or sub-Chains

  const Chain({
    @required this.id,
    @required this.icon,
    @required this.names,
    @required this.sons,
  });

  static const Chain bldrsChain = const Chain(
    id: 'bldrs',
    icon: Iconz.BldrsNameEn,
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
