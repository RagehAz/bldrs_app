// ignore_for_file: avoid_returning_null, avoid_redundant_argument_values
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class ConfirmButtonModel{
  // --------------------------------------------------------------------------
  const ConfirmButtonModel({
    required this.onTap,
    required this.firstLine,
    this.secondLine,
    this.isDisabled = false,
    this.onSkipTap,
    this.isWide = false,
  });
  // --------------------
  final Function? onTap;
  final Verse firstLine;
  final Verse? secondLine;
  final bool isDisabled;
  final Function? onSkipTap;
  final bool isWide;
  // --------------------------------------------------------------------------
}


class ConfirmButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ConfirmButton({
    required this.confirmButtonModel,
    this.enAlignment,
    super.key
  });
  // --------------------
  final ConfirmButtonModel? confirmButtonModel;
  final Alignment? enAlignment;
  // --------------------
  static const double narrowConfirmButtonWidth = 180;
  static const double skipButtonWidth = 80;
  static const double spacing = 10;
  static const double buttonHeight = 50;
  // --------------------
  static double? getConfirmButtonWidth({
    required ConfirmButtonModel? model,
  }){
    final double _skipWidth = model?.onSkipTap == null ? 0 : skipButtonWidth + spacing;

    if (Mapper.boolIsTrue(model?.isWide) == true){
      return Bubble.bubbleWidth(context: getMainContext()) - _skipWidth;
    }

    else if ((getWord(model?.firstLine.id).length) > 20){
      return narrowConfirmButtonWidth - _skipWidth;
    }
    else {
      return null;
    }
  }
  // --------------------
  static Widget button({
    required Verse firstLine,
    required Function onTap,
    bool isWide = false,
    Verse? secondLine,
    Function? onSkipTap,
    bool isDisabled = false,
    Alignment enAlignment = Alignment.bottomCenter,
  }){

    return ConfirmButton(
      enAlignment: enAlignment,
      confirmButtonModel: ConfirmButtonModel(
        firstLine: firstLine,
        secondLine: secondLine,
        onSkipTap: onSkipTap,
        isWide: isWide,
        onTap: onTap,
        isDisabled: isDisabled,
      ),
    );

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Widget _confirmButton = BldrsBox(
      isDisabled: confirmButtonModel?.isDisabled,
      height: buttonHeight,
      width: getConfirmButtonWidth(
        model: confirmButtonModel,
      ),
      verseMaxLines: 2,
      color: Colorz.yellow255,
      verseColor: Colorz.black230,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      verse: confirmButtonModel?.firstLine.copyWith(casing: Casing.upperCase),
      secondLine: confirmButtonModel?.secondLine,
      secondLineColor: Colorz.black255,
      verseScaleFactor: 0.7,
      onTap: confirmButtonModel?.onTap,
    );
    // --------------------
    if (enAlignment == null){
      return _confirmButton;
    }
    // --------------------
    else if (confirmButtonModel?.onSkipTap == null){
      return SuperPositioned(
        key: const ValueKey<String>('EditorConfirmButton.onSkipTap'),
        enAlignment: enAlignment ?? Alignment.bottomCenter,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        verticalOffset: spacing,
        horizontalOffset: spacing,
        child: _confirmButton,
      );
    }
    // --------------------
    else {
      return SuperPositioned(
        key: const ValueKey<String>('EditorConfirmButton'),
        enAlignment: enAlignment ?? Alignment.bottomCenter,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        verticalOffset: spacing,
        horizontalOffset: spacing,
        child: Row(
          children: <Widget>[

            /// SKIP BUTTON
            BldrsBox(
              height: buttonHeight,
              width: skipButtonWidth,
              verseMaxLines: 2,
              color: Colorz.blackSemi255,
              verseItalic: true,
              verse: const Verse(
                id: 'phid_skip',
                translate: true,
              ),
              verseScaleFactor: 0.7,
              onTap: confirmButtonModel?.onSkipTap,
            ),

            /// SPACING
            const Spacing(size: spacing),

            ///CONFIRM BUTTON
            _confirmButton,

          ],
        ),
      );
    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
