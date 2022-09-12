import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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

    final String _verse = isStarGraphic ? 'phid_nice' : isSaved ? 'phid_saved' : 'phid_unsaved';

    return Container(
      width: flyerBoxWidth,
      height: flyerBoxHeight,
      color: Colorz.yellow200,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          ankh,

          Positioned(
            bottom: flyerBoxWidth * 0.58,
            child: SuperVerse(
              verse: Verse(
                text: _verse,
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
      ),
    );

  }
/// --------------------------------------------------------------------------
}
