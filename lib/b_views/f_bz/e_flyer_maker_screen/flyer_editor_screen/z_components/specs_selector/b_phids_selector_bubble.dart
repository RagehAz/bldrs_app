import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/phids_wrapper.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class PhidsSelectorBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PhidsSelectorBubble({
    required this.draft,
    required this.onPhidTap,
    required this.onPhidLongTap,
    required this.onAdd,
    required this.canValidate,
    super.key
  });
  // -------------------------
  final DraftFlyer? draft;
  final Function(String phid) onPhidTap;
  final Function(String phid) onPhidLongTap;
  final Function onAdd;
  final bool canValidate;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context: context);

    return WidgetFader(
      key: const ValueKey('PhidsSelectorBubble'),
      fadeType: draft?.flyerType == null ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.35,
      ignorePointer: draft?.flyerType == null,
      child: Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: const Verse(
            id: 'phid_keywords',
            translate: true,
          ),
          redDot: true,
        ),
        bubbleColor: Formers.validatorBubbleColor(
          validator: () => Formers.flyerPhidsValidator(
            phids: draft?.phids,
            flyerType: draft?.flyerType,
            canValidate: canValidate,
          ),
        ),
        width: Bubble.bubbleWidth(context: context),
        columnChildren: <Widget>[

          /// BULLETS
          const BldrsBulletPoints(
            showBottomLine: false,
            bulletPoints: <Verse>[
              Verse(
                id: 'phid_add_keywords_to_help_search_filters',
                translate: true,
              ),
            ],
          ),

          /// SELECTED PHIDS
          if (Lister.checkCanLoop(draft?.phids) == true)
            PhidsWrapper(
              width: _bubbleClearWidth,
              phids: draft?.phids ?? [],
              onPhidLongTap: onPhidLongTap,
              onPhidTap: onPhidTap,
              margins: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
            ),

          /// ADD BUTTON
          BldrsBox(
            height: PhidButton.getHeight(),
            verse: Verse(
              id: Lister.checkCanLoop(draft?.specs) ? 'phid_edit_keywords' : 'phid_add_keywords',
              translate: true,
            ),
            bubble: false,
            color: Colorz.white20,
            verseScaleFactor: 1.5,
            verseWeight: VerseWeight.thin,
            icon: Iconz.plus,
            iconSizeFactor: 0.4,
            iconColor: Colorz.white20,
            onTap: onAdd,
          ),

          /// VALIDATOR
          BldrsValidator(
            width: _bubbleClearWidth - 20,
            validator: () => Formers.flyerPhidsValidator(
              phids: draft?.phids,
              flyerType: draft?.flyerType,
              canValidate: canValidate,
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
