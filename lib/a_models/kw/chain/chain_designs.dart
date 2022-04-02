import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainDesigns {

  static const Chain chain = Chain(
    id: 'phid_k_flyer_type_design',
    icon: Iconz.bxDesignsOff,
    sons: <String>[

      'phid_k_designType_architecture',
      'phid_k_designType_interior',
      'phid_k_designType_facade',
      'phid_k_designType_urban',
      'phid_k_designType_furniture',
      'phid_k_designType_lighting',
      'phid_k_designType_landscape',
      'phid_k_designType_structural',
      'phid_k_designType_infrastructure',
      'phid_k_designType_kiosk',

    ],
  );

}
