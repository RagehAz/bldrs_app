// ignore_for_file: avoid_returning_null

import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class ConfirmButtonModel{
  /// --------------------------------------------------------------------------
  const ConfirmButtonModel({
    @required this.onTap,
    @required this.firstLine,
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

double getWidth({
  @required BuildContext context,
  @required ConfirmButtonModel model,
}){

  if (model?.isWide == true){
    return BldrsAppBar.width(context);
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
    @required this.confirmButtonModel,
    this.positionedAlignment,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ConfirmButtonModel confirmButtonModel;
  final Alignment positionedAlignment;
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
        key: const ValueKey<String>('EditorConfirmButton'),
        enAlignment: positionedAlignment,
        appIsLTR: UiProvider.checkAppIsLeftToRight(context),
        child: _button,
      );
    }
    // --------------------
    else {
      return SuperPositioned(
        key: const ValueKey<String>('EditorConfirmButton'),
        enAlignment: positionedAlignment,
        appIsLTR: UiProvider.checkAppIsLeftToRight(context),
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
