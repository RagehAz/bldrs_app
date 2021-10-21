import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class PrintStrip extends StatelessWidget {
  final String verse;

  const PrintStrip({
    @required this.verse,
});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Bubble(
        bubbleColor: Colorz.black230,
        centered: true,
        stretchy: false,
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
