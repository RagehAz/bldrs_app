import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SavedGraphic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedGraphic({
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.isSaved,
    required this.saveIcon,
    this.isStarGraphic = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool isSaved;
  final Widget? saveIcon;
  final bool isStarGraphic;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: flyerBoxWidth,
      height: flyerBoxHeight,
      child: Stack(
        // flyerBoxWidth: flyerBoxWidth,
        // // height: flyerBoxHeight,
        // boxColor: Colorz.black80,
        alignment: Alignment.center,
        children: <Widget>[

          /// SAVE ICON
          if (saveIcon != null)
          saveIcon!,

          /// SAVED TEXT
          SizedBox(
            width: flyerBoxWidth * 0.8,
            height: flyerBoxWidth * 0.8,
            child: FittedBox(
              child: BldrsText(
                verse: Verse(
                  id: isStarGraphic ? 'phid_nice' : isSaved ? 'phid_saved' : 'phid_unsaved',
                  translate: true,
                  casing: Casing.upperCase,
                ),
                size: 5,
                scaleFactor: 3,
                color: Colorz.black150,
                weight: VerseWeight.black,
                italic: true,
                shadow: true,
              ),
            ),
          ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
