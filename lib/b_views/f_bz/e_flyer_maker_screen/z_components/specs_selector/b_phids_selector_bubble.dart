import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:widget_fader/widget_fader.dart';

class PhidsSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsSelectorBubble({
    @required this.draft,
    @required this.draftNotifier,
    @required this.bzModel,
    @required this.onPhidTap,
    @required this.onPhidLongTap,
    @required this.onAdd,
    @required this.canValidate,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftFlyer draft;
  final ValueNotifier<DraftFlyer> draftNotifier;
  final BzModel bzModel;
  final Function(String phid) onPhidTap;
  final Function(String phid) onPhidLongTap;
  final Function onAdd;
  final bool canValidate;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      key: const ValueKey('PhidsSelectorBubble'),
      fadeType: draft?.flyerType == null ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.35,
      ignorePointer: draft?.flyerType == null,
      child: Bubble(
        bubbleHeaderVM: const BubbleHeaderVM(
          headlineVerse: Verse(
            text: 'phid_keywords',
            translate: true,
          ),
        ),
        width: Bubble.bubbleWidth(context),
        columnChildren: <Widget>[

          const BulletPoints(
            bulletPoints: <Verse>[
              Verse(
                text: 'phid_add_keywords_to_help_search_filters',
                translate: true,
              ),
            ],
          ),

          /// SELECTED PHIDS
          ValueListenableBuilder(
              valueListenable: draftNotifier,
              builder: (_, DraftFlyer draft, Widget child){

                if (Mapper.checkCanLoopList(draft?.keywordsIDs) == true){
                  return PhidsViewer(
                    pageWidth: Bubble.clearWidth(context),
                    phids: draft.keywordsIDs,
                    onPhidLongTap: onPhidLongTap,
                    onPhidTap: onPhidTap,

                  );
                }

                else {
                  return const SizedBox();
                }

              },
          ),

          /// ADD BUTTON
          DreamBox(
            height: PhidButton.getHeight(),
            verse: Verse(
              text: Mapper.checkCanLoopList(draft?.specs) ? 'phid_edit_keywords' : 'phid_add_keywords',
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
            width: Bubble.clearWidth(context) - 20,
            validator: () => Formers.flyerPhidsValidator(
              phids: draft.keywordsIDs,
              context: context,
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
