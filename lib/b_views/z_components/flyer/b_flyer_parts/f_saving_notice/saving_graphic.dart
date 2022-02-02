import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SavedGraphic extends StatelessWidget {

  const SavedGraphic({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.isSaved,
    @required this.ankh,
    Key key
  }) : super(key: key);

  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool isSaved;
  final Widget ankh;

  @override
  Widget build(BuildContext context) {

    final String _verse = isSaved ? 'saved' : 'unSaved';

    return SizedBox(
      width: flyerBoxWidth,
      height: flyerBoxHeight,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          ankh,

          Positioned(
            bottom: flyerBoxWidth * 0.58,
            child: SuperVerse(
              verse: _verse.toUpperCase(),
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
}
