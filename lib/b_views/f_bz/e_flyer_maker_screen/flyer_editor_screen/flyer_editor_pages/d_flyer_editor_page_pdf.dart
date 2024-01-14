import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/z_components/bubbles/b_variants/pdf_bubble/pdf_selection_bubble.dart';
import 'package:bldrs/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class FlyerEditorPage3PDF extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerEditorPage3PDF({
    required this.draft,
    required this.onChangePDF,
    required this.onDeletePDF,
    required this.canValidate,
    required this.canGoNext,
    required this.onNextTap,
    required this.onPreviousTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftFlyer? draft;
  final ValueChanged<PDFModel?> onChangePDF;
  final Function onDeletePDF;
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

        /// PDF SELECTOR
        if (draft != null && draft?.id != null)
          PDFSelectionBubble(
            flyerID: draft!.id,
            bzID: draft!.bzID,
            appBarType: AppBarType.non,
            formKey: draft!.formKey,
            existingPDF: draft!.pdfModel,
            canValidate: canValidate,
            onChangePDF: onChangePDF,
            onDeletePDF: onDeletePDF,
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
