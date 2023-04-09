import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class SavedGraphic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedGraphic({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.isSaved,
    @required this.ankh,
    this.isStarGraphic = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool isSaved;
  final Widget ankh;
  final bool isStarGraphic;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyerBox(
      flyerBoxWidth: flyerBoxWidth,
      // height: flyerBoxHeight,
      boxColor: Colorz.yellow200,
      stackWidgets: <Widget>[

        ankh,

        Positioned(
          bottom: flyerBoxWidth * 0.58,
          child: BldrsText(
            verse: Verse(
              id: isStarGraphic ? 'phid_nice' : isSaved ? 'phid_saved' : 'phid_unsaved',
              translate: true,
              casing: Casing.upperCase,
            ),
            size: 5,
            scaleFactor: 3,
            weight: VerseWeight.black,
            italic: true,
            shadow: true,
          ),
        ),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
