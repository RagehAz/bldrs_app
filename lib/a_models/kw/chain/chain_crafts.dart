import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

abstract class ChainCrafts {

  static const Chain chain = Chain(
    id: 'crafts',
    icon: Iconz.bxCraftsOff,
    phraseID: 'phid_k_crafts_keywords',
    sons: <KW>[

      KW(
        id: 'con_trade_carpentry',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Carpentry'),
          Phrase(langCode: 'ar', value: 'نجارة')
        ],
      ),
      KW(
        id: 'con_trade_electricity',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Electricity'),
          Phrase(langCode: 'ar', value: 'كهرباء')
        ],
      ),
      KW(
        id: 'con_trade_insulation',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Insulation'),
          Phrase(langCode: 'ar', value: 'عزل')
        ],
      ),
      KW(
        id: 'con_trade_masonry',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Masonry'),
          Phrase(langCode: 'ar', value: 'مباني')
        ],
      ),
      KW(
        id: 'con_trade_plumbing',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Plumbing'),
          Phrase(langCode: 'ar', value: 'صحي و سباكة')
        ],
      ),
      KW(
        id: 'con_trade_blacksmithing',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Blacksmithing'),
          Phrase(langCode: 'ar', value: 'حدادة')
        ],
      ),
      KW(
        id: 'con_trade_labor',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Site labor'),
          Phrase(langCode: 'ar', value: 'عمالة موقع')
        ],
      ),
      KW(
        id: 'con_trade_painting',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Painting'),
          Phrase(langCode: 'ar', value: 'نقاشة')
        ],
      ),
      KW(
        id: 'con_trade_plaster',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Plaster'),
          Phrase(langCode: 'ar', value: 'محارة')
        ],
      ),
      KW(
        id: 'con_trade_landscape',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Landscape'),
          Phrase(langCode: 'ar', value: 'لاندسكيب')
        ],
      ),
      KW(
        id: 'con_trade_hardscape',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Hardscape'),
          Phrase(langCode: 'ar', value: 'هاردسكيب')
        ],
      ),
      KW(
        id: 'con_trade_hvac',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'HVAC'),
          Phrase(langCode: 'ar', value: 'تدفئة، تهوية و تكيفات')
        ],
      ),
      KW(
        id: 'con_trade_firefighting',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Fire fighting'),
          Phrase(langCode: 'ar', value: 'مقاومة جرائق')
        ],
      ),
      KW(
        id: 'con_trade_elevators',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Elevators / Escalators'),
          Phrase(langCode: 'ar', value: 'مصاعد / مدارج متحركة')
        ],
      ),
      KW(
        id: 'con_trade_tiling',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Tiling'),
          Phrase(langCode: 'ar', value: 'تبليط')
        ],
      ),
      KW(
        id: 'con_trade_transportation',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Transportation'),
          Phrase(langCode: 'ar', value: 'نقل')
        ],
      ),
      KW(
        id: 'con_trade_concrete',
        names: <Phrase>[
          Phrase(langCode: 'en', value: 'Concrete'),
          Phrase(langCode: 'ar', value: 'خرسانة')
        ],
      ),

    ],
  );

}
