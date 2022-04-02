import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainCrafts {

  static const Chain chain = Chain(
    id: 'phid_k_flyer_type_crafts',
    icon: Iconz.bxCraftsOff,
    sons: <String>[

      'phid_k_con_trade_carpentry',
      'phid_k_con_trade_electricity',
      'phid_k_con_trade_insulation',
      'phid_k_con_trade_masonry',
      'phid_k_con_trade_plumbing',
      'phid_k_con_trade_blacksmithing',
      'phid_k_con_trade_labor',
      'phid_k_con_trade_painting',
      'phid_k_con_trade_plaster',
      'phid_k_con_trade_landscape',
      'phid_k_con_trade_hardscape',
      'phid_k_con_trade_hvac',
      'phid_k_con_trade_firefighting',
      'phid_k_con_trade_elevators',
      'phid_k_con_trade_tiling',
      'phid_k_con_trade_transportation',
      'phid_k_con_trade_concrete',

    ],
  );

}
