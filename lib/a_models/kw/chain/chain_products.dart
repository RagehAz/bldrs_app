import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/chain/chain_products_sons.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainProducts {

  static const Chain chain = Chain(
    id: 'phid_k_products',
    icon: Iconz.bxProductsOff,
    phraseID: 'phid_k_products_keywords',
    sons: <Chain>[

      appliancesChain,
      doorsAndWindowsChain,
      electricityChain,
      fireFightingChain,
      floorsAndSkirtingChain,
      furnitureChain,
      hvacChain,
      plantingAndLandscapeChain,
      lightingChain,
      constructionMaterials,
      plumbingAndSanitaryChain,
      poolsAndSpaChain,
      roofingChain,
      safetyChain,
      smartHomeChain,
      stairsChain,
      lightStructureChain,
      wallsAndRoomsPartitions,

    ],
  );
}
