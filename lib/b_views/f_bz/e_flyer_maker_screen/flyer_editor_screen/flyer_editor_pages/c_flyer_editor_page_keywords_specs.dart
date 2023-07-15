import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/a_specs_selector_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/b_phids_selector_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:flutter/material.dart';

class FlyerEditorPage2KeywordsSpecs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerEditorPage2KeywordsSpecs({
    required this.draft,
    required this.onPhidTap,
    required this.onPhidLongTap,
    required this.onAddPhidsTap,
    required this.onSpecTap,
    required this.onDeleteSpec,
    required this.onAddSpecsToDraft,
    required this.canValidate,
    required this.canGoNext,
    required this.onNextTap,
    required this.onPreviousTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftFlyer? draft;
  final Function(String phid) onPhidTap;
  final Function(String phid) onPhidLongTap;
  final Function onAddPhidsTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onSpecTap;
  final Function({required SpecModel? value, required SpecModel? unit})? onDeleteSpec;
  final Function onAddSpecsToDraft;
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

        /// PHIDS
        PhidsSelectorBubble(
          bzModel: draft?.bzModel,
          draft: draft,
          onPhidTap: onPhidTap,
          onPhidLongTap: onPhidLongTap,
          onAdd: onAddPhidsTap,
          canValidate: canValidate,
        ),

        /// SPECS
        SpecsSelectorBubble(
          draft: draft,
          bzModel: draft?.bzModel,
          onSpecTap: onSpecTap,
          onDeleteSpec: onDeleteSpec,
          onAddSpecsToDraft: onAddSpecsToDraft,
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
