import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';

abstract class ChainDesigns {

  static const Chain chain = const Chain(
    id: 'designs',
    icon: Iconz.bxDesignsOff,
    names: <Name>[Name(code: 'en', value: 'Designs'), Name(code: 'ar', value: '')],
    sons: <KW>[
      KW(
        id: 'designType_architecture',
        names: <Name>[
          Name(code: 'en', value: 'Architectural design'),
          Name(code: 'ar', value: 'تصميم معماري')
        ],
      ),
      KW(id: 'designType_interior', names: <Name>[Name(code: 'en', value: 'Interior design & Décor'), Name(code: 'ar', value: 'تصميم داخلي و ديكور')],),
      KW(id: 'designType_facade', names: <Name>[Name(code: 'en', value: 'Façade exterior design'), Name(code: 'ar', value: 'تصميم واجهات خارجية')],),
      KW(id: 'designType_urban', names: <Name>[Name(code: 'en', value: 'Urban design'), Name(code: 'ar', value: 'تصميم حضري')],),
      KW(id: 'designType_furniture', names: <Name>[Name(code: 'en', value: 'Furniture design'), Name(code: 'ar', value: 'تصميم مفروشات')],),
      KW(id: 'designType_lighting', names: <Name>[Name(code: 'en', value: 'Lighting design'), Name(code: 'ar', value: 'تصميم إضاءة')],),
      KW(id: 'designType_landscape', names: <Name>[Name(code: 'en', value: 'Landscape design'), Name(code: 'ar', value: 'تصميم لاندسكيب')],),
      KW(id: 'designType_structural', names: <Name>[Name(code: 'en', value: 'Structural design'), Name(code: 'ar', value: 'تصميم إنشائي')],),
      KW(id: 'designType_infrastructure', names: <Name>[Name(code: 'en', value: 'Infrastructure design'), Name(code: 'ar', value: 'تصميم بنية تحتية')],),
      KW(id: 'designType_kiosk', names: <Name>[Name(code: 'en', value: 'Kiosk design'), Name(code: 'ar', value: 'تصميم كشك')],),
    ],
  );

}