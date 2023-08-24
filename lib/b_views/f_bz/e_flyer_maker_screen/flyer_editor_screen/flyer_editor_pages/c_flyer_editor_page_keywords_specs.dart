import 'package:basics/super_box/super_box.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/price_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/b_phids_selector_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/c_price_selector_bubble.dart';
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
    required this.onOldPriceChanged,
    required this.onCurrentPriceChanged,
    required this.onCurrencyChanged,
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
  final Function(double val) onOldPriceChanged;
  final Function(double val) onCurrentPriceChanged;
  final Function() onCurrencyChanged;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsFloatingList(
      columnChildren: <Widget>[

        /// PHIDS
        PhidsSelectorBubble(
          draft: draft,
          onPhidTap: onPhidTap,
          onPhidLongTap: onPhidLongTap,
          onAdd: onAddPhidsTap,
          canValidate: canValidate,
        ),

        /// PRICE
        Disabler(
          isDisabled: !PriceModel.canShowPriceInFlyerCreator(flyerType: draft?.flyerType),
          isHidden: !PriceModel.checkBzMayHavePriceInFlyerCreator(bzTypes: draft?.bzModel?.bzTypes),
          child: PriceSelectorBubble(
            draft: draft,
            onCurrentPriceChanged: onCurrentPriceChanged,
            onOldPriceChanged: onOldPriceChanged,
            onCurrencyChanged: onCurrencyChanged,
          ),
        ),

        // /// SPECS
        // SpecsSelectorBubble(
        //   draft: draft,
        //   bzModel: draft?.bzModel,
        //   onSpecTap: onSpecTap,
        //   onDeleteSpec: onDeleteSpec,
        //   onAddSpecsToDraft: onAddSpecsToDraft,
        // ),

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
