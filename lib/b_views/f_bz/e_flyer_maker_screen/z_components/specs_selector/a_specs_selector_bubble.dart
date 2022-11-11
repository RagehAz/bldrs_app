import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/specs_builder.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
  final DraftFlyer draft;
  final ValueNotifier<DraftFlyer> draftNotifier;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      fadeType: draft.flyerType == null ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.35,
      absorbPointer: draft.flyerType == null,
      child: Bubble(
        headerViewModel: const BubbleHeaderVM(
          headlineVerse: Verse(
            text: 'phid_specifications',
            translate: true,
          ),
        ),
        width: Bubble.bubbleWidth(context),
        columnChildren: <Widget>[

          const BulletPoints(
            bulletPoints: <Verse>[
              Verse(
                pseudo: 'Add technical specification to describe flyer contents and help the search filters find your flyer',
                text: 'phid_add_spec_to_help_search_filters',
                translate: true,
              ),
            ],
          ),

          SpecsBuilder(
            pageWidth: Bubble.clearWidth(context),
            specs: draft.specs,
            onSpecTap: ({SpecModel value, SpecModel unit}) => onAddSpecsToDraftTap(
              context: context,
              draft: draftNotifier,
            ),
            onDeleteSpec: ({SpecModel value, SpecModel unit}){
              blog('SpecsSelectorBubble : value : ${value.value}');
            },
          ),

          DreamBox(
            height: PhidButton.getHeight(),
            verse: Verse(
              text: Mapper.checkCanLoopList(draft.specs) ? 'phid_edit_specs' : 'phid_add_specs',
              translate: true,
            ),
            bubble: false,
            color: Colorz.white20,
            verseScaleFactor: 1.5,
            verseWeight: VerseWeight.thin,
            icon: Iconz.plus,
            iconSizeFactor: 0.4,
            iconColor: Colorz.white20,
            onTap: () => onAddSpecsToDraftTap(
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
