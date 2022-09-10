import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_specs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class SpecsSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsSelectorBubble({
    @required this.draft,
    @required this.draftNotifier,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftFlyerModel draft;
  final ValueNotifier<DraftFlyerModel> draftNotifier;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _translatedFlyerType = FlyerTyper.translateFlyerType(
      context: context,
      flyerType: draft.flyerType,
      pluralTranslation: false,
    );
    // --------------------
    return WidgetFader(
      fadeType: draft.flyerType == null ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.35,
      absorbPointer: draft.flyerType == null,
      child: Bubble(
        headerViewModel: const BubbleHeaderVM(
          headlineVerse: 'phid_specifications',
        ),
        width: Bubble.bubbleWidth(context),
        columnChildren: <Widget>[

          BubbleBulletPoints(
            bulletPoints: <String>[
              '##Add $_translatedFlyerType specification to describe and allow advanced search criteria',
            ],
            translateBullets: true,
          ),

          InfoPageSpecs(
            pageWidth: Bubble.clearWidth(context),
            specs: draft.specs,
            flyerType: draft.flyerType,
          ),

          DreamBox(
            height: PhidButton.getHeight(),
            // width: Bubble.clearWidth(context),
            verse: Mapper.checkCanLoopList(draft.keywordsIDs) ? 'Edit Specifications' : 'Add Specifications',
            bubble: false,
            color: Colorz.white20,
            verseScaleFactor: 1.5,
            verseWeight: VerseWeight.thin,
            icon: Iconz.plus,
            iconSizeFactor: 0.4,
            iconColor: Colorz.white20,
            onTap: () => onAddSpecsTap(
              context: context,
              draft: draftNotifier,
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
