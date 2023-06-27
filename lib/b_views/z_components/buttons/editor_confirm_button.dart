// ignore_for_file: avoid_returning_null
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class ConfirmButtonModel{
  /// --------------------------------------------------------------------------
  const ConfirmButtonModel({
    required this.onTap,
    required this.firstLine,
    this.secondLine,
    this.isDeactivated = false,
    this.onSkipTap,
    this.isWide = false,
  });
  /// --------------------------------------------------------------------------
  final Function onTap;
  final Verse firstLine;
  final Verse secondLine;
  final bool isDeactivated;
  final Function onSkipTap;
  final bool isWide;
  /// --------------------------------------------------------------------------
}

double? getWidth({
  required BuildContext context,
  required ConfirmButtonModel model,
}){

  if (model?.isWide == true){
    return Bubble.bubbleWidth(context: context);
  }

  else if (model.firstLine.id.length > 20){
    return 200;
  }
  else {
    return null;
  }

}

class ConfirmButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ConfirmButton({
    required this.confirmButtonModel,
    this.positionedAlignment,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ConfirmButtonModel confirmButtonModel;
  final Alignment? positionedAlignment;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Widget _button = BldrsBox(
      isDisabled: confirmButtonModel.isDeactivated,
      height: 50,
      width: getWidth(
        context: context,
        model: confirmButtonModel,
      ),
      verseMaxLines: 2,
      color: Colorz.yellow255,
      verseColor: Colorz.black230,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      verse: confirmButtonModel.firstLine.copyWith(casing: Casing.upperCase),
      secondLine: confirmButtonModel.secondLine,
      secondLineColor: Colorz.black255,
      verseScaleFactor: 0.7,
      margins: const EdgeInsets.all(10),
      onTap: confirmButtonModel.onTap,
    );
    // --------------------
    if (positionedAlignment == null){
      return _button;
    }
    // --------------------
    else if (confirmButtonModel.onSkipTap == null){
      return SuperPositioned(
        key: const ValueKey<String>('EditorConfirmButton.onSkipTap'),
        enAlignment: positionedAlignment,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        child: _button,
      );
    }
    // --------------------
    else {
      return SuperPositioned(
        key: const ValueKey<String>('EditorConfirmButton'),
        enAlignment: positionedAlignment,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        child: Row(
          children: <Widget>[

            _button,

            ConfirmButton(
              confirmButtonModel: ConfirmButtonModel(
                firstLine: const Verse(
                  id: 'phid_skip',
                  translate: true,
                ),
                onTap: confirmButtonModel.onSkipTap,
                // secondLine: null,
                // isDeactivated: false,
                // onSkipTap: null,
              ),
            )

          ],
        ),
      );
    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
