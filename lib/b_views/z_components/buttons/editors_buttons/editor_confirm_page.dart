import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class EditorConfirmPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditorConfirmPage({
    required this.onConfirmTap,
    required this.verse,
    required this.canConfirm,
    required this.modelHasChanged,
    required this.onPreviousTap,
    this.previewWidget,
    this.onSkipTap,
    this.bulletPoints,
    super.key,
  });
  /// --------------------------------------------------------------------------
  final Function onConfirmTap;
  final Verse verse;
  final Widget? previewWidget;
  final bool canConfirm;
  final bool modelHasChanged;
  final Function onPreviousTap;
  final Function? onSkipTap;
  final List<Verse>? bulletPoints;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    final double _buttonWidth = Bubble.bubbleWidth(context: context) - 20;

    return BldrsFloatingList(
      mainAxisAlignment: MainAxisAlignment.end,
      boxAlignment: Alignment.bottomCenter,
      columnChildren: <Widget>[

        if (previewWidget != null)
        previewWidget!,

        /// VALIDATION NOTICE
        if (canConfirm == false)
        BldrsText(
          width: _buttonWidth,
          centered: false,
          margin: const EdgeInsets.symmetric(vertical: 10),
          maxLines: 5,
          leadingDot: modelHasChanged,
          weight: VerseWeight.thin,
            italic: true,
            color: modelHasChanged == false ? Colorz.blue255 : Colorz.red255,
            verse: modelHasChanged == false ?
                const Verse(id: 'phid_no_changes_happened', translate: true)
                :
                const Verse(id: 'phid_complete_mandatory_info', translate: true),
        ),

        /// CONFIRM BUTTON
        BldrsBox(
          isDisabled: !canConfirm,
          height: 100,
          width: _buttonWidth,
          verse: verse.copyWith(
            casing: Casing.upperCase,
          ),
          verseItalic: true,
          color: Colorz.yellow255,
          verseColor: canConfirm == true ? Colorz.black255 : Colorz.white200,
          verseWeight: canConfirm == true ? VerseWeight.black : VerseWeight.bold,
          verseScaleFactor: 0.6,
          onTap: onConfirmTap,
          verseMaxLines: 2,
        ),

        if (canConfirm == true && Mapper.checkCanLoopList(bulletPoints) == true)
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BldrsBulletPoints(
            bulletPoints: bulletPoints,
            centered: true,
          ),
        ),

        /// SWIPING BUTTONS
        EditorSwipingButtons(
          onPrevious: onPreviousTap,
          onSkipTap: onSkipTap,
        ),

        const Horizon(
          heightFactor: 1.1,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
