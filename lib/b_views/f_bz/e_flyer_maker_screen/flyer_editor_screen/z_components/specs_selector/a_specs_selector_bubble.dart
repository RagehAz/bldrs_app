import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/specs_builder.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SpecsSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsSelectorBubble({
    required this.draft,
    required this.bzModel,
    required this.onSpecTap,
    required this.onDeleteSpec,
    required this.onAddSpecsToDraft,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftFlyer? draft;
  final BzModel? bzModel;
  final Function({required SpecModel? value, required SpecModel? unit})? onSpecTap; // onAddSpecsToDraftTap
  final Function({required SpecModel? value, required SpecModel? unit})? onDeleteSpec;
  final Function onAddSpecsToDraft; // use this onAddSpecsToDraftTap
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      fadeType: draft?.flyerType == null ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.35,
      ignorePointer: draft?.flyerType == null,
      child: Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: const Verse(
            id: 'phid_specifications',
            translate: true,
          ),
        ),
        width: Bubble.bubbleWidth(context: context),
        columnChildren: <Widget>[

          const BldrsBulletPoints(
            showBottomLine: false,
            bulletPoints: <Verse>[
              Verse(id: 'phid_optional_field', translate: true),
              Verse(
                pseudo: 'Add technical specification to describe flyer contents and help the search filters find your flyer',
                id: 'phid_add_spec_to_help_search_filters',
                translate: true,
              ),
            ],
          ),

          SpecsBuilder(
            pageWidth: Bubble.clearWidth(context: context),
            specs: draft?.specs,
            onSpecTap: onSpecTap,
            onDeleteSpec: onDeleteSpec,
          ),

          BldrsBox(
            height: PhidButton.getHeight(),
            verse: Verse(
              id: Lister.checkCanLoop(draft?.specs) ? 'phid_edit_specs' : 'phid_add_specs',
              translate: true,
            ),
            bubble: false,
            color: Colorz.white20,
            verseScaleFactor: 1.5,
            verseWeight: VerseWeight.thin,
            icon: Iconz.plus,
            iconSizeFactor: 0.4,
            iconColor: Colorz.white20,
            onTap: onAddSpecsToDraft,
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
