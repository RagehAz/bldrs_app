import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class FlyerEditorPage4Zone extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerEditorPage4Zone({
    required this.draft,
    required this.onZoneChanged,
    required this.canValidate,
    required this.canGoNext,
    required this.onNextTap,
    required this.onPreviousTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftFlyer? draft;
  final ValueChanged<ZoneModel?> onZoneChanged;
  final bool canValidate;
  final bool canGoNext;
  final Function onNextTap;
  final Function onPreviousTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsFloatingList(
      columnChildren: <Widget>[

        /// ZONE SELECTOR
        ZoneSelectionBubble(
          zoneViewingEvent: ViewingEvent.flyerEditor,
          depth: ZoneDepth.city,
          titleVerse: const Verse(
            id: 'phid_flyer_target_city',
            translate: true,
          ),
          bulletPoints: const <Verse>[
            Verse(
              id: 'phid_select_city_you_want_to_target',
              translate: true,
            ),
            Verse(
              id: 'phid_each_flyer_target_one_city',
              translate: true,
            ),
          ],
          currentZone: draft?.zone,
          viewerZone: draft?.bzModel?.zone,
          onZoneChanged: onZoneChanged,
          validator: () => Formers.zoneValidator(
            zoneModel: draft?.zone,
            selectCountryIDOnly: false,
            canValidate: canValidate,
          ),
        ),

        /// SWIPING BUTTONS
        EditorSwipingButtons(
          onNext: onNextTap,
          onPrevious: onPreviousTap,
          canGoNext: canGoNext,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
