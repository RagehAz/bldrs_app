import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class PrintStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PrintStrip({
    @required this.verse,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String verse;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Bubble(
        bubbleColor: Colorz.black230,
        centered: true,
        columnChildren: <Widget>[
          SuperVerse(
            verse: verse ?? 'print Area',
            maxLines: 12,
            weight: VerseWeight.thin,
            color: verse == null ? Colorz.white20 : Colorz.white255,
          ),
        ],
      ),
    );
  }
}
