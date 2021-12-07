import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';

abstract class ChainCrafts {

  static const Chain chain = Chain(
    id: 'crafts',
    icon: Iconz.bxCraftsOff,
    names: <Name>[
      Name(code: 'en', value: 'Crafts'),
      Name(code: 'ar', value: '')
    ],
    sons: <KW>[
      KW(
        id: 'con_trade_carpentry',
        names: <Name>[
          Name(code: 'en', value: 'Carpentry'),
          Name(code: 'ar', value: 'نجارة')
        ],
      ),
      KW(
        id: 'con_trade_electricity',
        names: <Name>[
          Name(code: 'en', value: 'Electricity'),
          Name(code: 'ar', value: 'كهرباء')
        ],
      ),
      KW(
        id: 'con_trade_insulation',
        names: <Name>[
          Name(code: 'en', value: 'Insulation'),
          Name(code: 'ar', value: 'عزل')
        ],
      ),
      KW(
        id: 'con_trade_masonry',
        names: <Name>[
          Name(code: 'en', value: 'Masonry'),
          Name(code: 'ar', value: 'مباني')
        ],
      ),
      KW(
        id: 'con_trade_plumbing',
        names: <Name>[
          Name(code: 'en', value: 'Plumbing'),
          Name(code: 'ar', value: 'صحي و سباكة')
        ],
      ),
      KW(
        id: 'con_trade_blacksmithing',
        names: <Name>[
          Name(code: 'en', value: 'Blacksmithing'),
          Name(code: 'ar', value: 'حدادة')
        ],
      ),
      KW(
        id: 'con_trade_labor',
        names: <Name>[
          Name(code: 'en', value: 'Site labor'),
          Name(code: 'ar', value: 'عمالة موقع')
        ],
      ),
      KW(
        id: 'con_trade_painting',
        names: <Name>[
          Name(code: 'en', value: 'Painting'),
          Name(code: 'ar', value: 'نقاشة')
        ],
      ),
      KW(
        id: 'con_trade_plaster',
        names: <Name>[
          Name(code: 'en', value: 'Plaster'),
          Name(code: 'ar', value: 'محارة')
        ],
      ),
      KW(
        id: 'con_trade_landscape',
        names: <Name>[
          Name(code: 'en', value: 'Landscape'),
          Name(code: 'ar', value: 'لاندسكيب')
        ],
      ),
      KW(
        id: 'con_trade_hardscape',
        names: <Name>[
          Name(code: 'en', value: 'Hardscape'),
          Name(code: 'ar', value: 'هاردسكيب')
        ],
      ),
      KW(
        id: 'con_trade_hvac',
        names: <Name>[
          Name(code: 'en', value: 'HVAC'),
          Name(code: 'ar', value: 'تدفئة، تهوية و تكيفات')
        ],
      ),
      KW(
        id: 'con_trade_firefighting',
        names: <Name>[
          Name(code: 'en', value: 'Fire fighting'),
          Name(code: 'ar', value: 'مقاومة جرائق')
        ],
      ),
      KW(
        id: 'con_trade_elevators',
        names: <Name>[
          Name(code: 'en', value: 'Elevators / Escalators'),
          Name(code: 'ar', value: 'مصاعد / مدارج متحركة')
        ],
      ),
      KW(
        id: 'con_trade_tiling',
        names: <Name>[
          Name(code: 'en', value: 'Tiling'),
          Name(code: 'ar', value: 'تبليط')
        ],
      ),
      KW(
        id: 'con_trade_transportation',
        names: <Name>[
          Name(code: 'en', value: 'Transportation'),
          Name(code: 'ar', value: 'نقل')
        ],
      ),
      KW(
        id: 'con_trade_concrete',
        names: <Name>[
          Name(code: 'en', value: 'Concrete'),
          Name(code: 'ar', value: 'خرسانة')
        ],
      ),
    ],
  );

}
