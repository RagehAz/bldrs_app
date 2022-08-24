import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ConfirmButtonModel{
  /// --------------------------------------------------------------------------
  const ConfirmButtonModel({
    @required this.onTap,
    @required this.firstLine,
    this.secondLine,
    this.isDeactivated = false,
    this.onSkipTap,
  });
  /// --------------------------------------------------------------------------
  final Function onTap;
  final String firstLine;
  final String secondLine;
  final bool isDeactivated;
  final Function onSkipTap;
/// --------------------------------------------------------------------------
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

    final double _width = confirmButtonModel.firstLine.length > 20 ? 200 : null;

    final Widget _button = DreamBox(
      isDeactivated: confirmButtonModel.isDeactivated,
      height: 50,
      width: _width,
      verseMaxLines: 2,
      color: Colorz.yellow255,
      verseColor: Colorz.black230,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      verse: confirmButtonModel.firstLine,
      secondLine: confirmButtonModel.secondLine,
      secondLineColor: Colorz.black255,
      verseScaleFactor: 0.7,
      margins: const EdgeInsets.all(10),
      onTap: confirmButtonModel.onTap,
    );

    if (positionedAlignment == null){
      return _button;
    }

    else if (confirmButtonModel.onSkipTap == null){
      return SuperPositioned(
        key: const ValueKey<String>('EditorConfirmButton'),
        enAlignment: positionedAlignment,
        child: _button,
      );
    }

    else {
      return SuperPositioned(
        key: const ValueKey<String>('EditorConfirmButton'),
        enAlignment: positionedAlignment,
        child: Row(
          children: <Widget>[

            _button,

            ConfirmButton(
                confirmButtonModel: ConfirmButtonModel(
                  firstLine: 'Skip',
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


  }
}
