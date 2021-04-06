import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'in_pyramids_bubble.dart';

class ParagraphBubble extends StatelessWidget {
  final String title;
  final String paragraph;
  final int maxLines;
  final bool centered;
  final String actionBtIcon;

  ParagraphBubble({
    @required this.title,
    @required this.paragraph,
    this.maxLines = 5,
    this.centered = false,
    this.actionBtIcon,
});

  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
        title: title,
        centered: centered,
        actionBtIcon: actionBtIcon,
        columnChildren: <Widget>[

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin),
            child: SuperVerse(
              verse: paragraph,
              maxLines: maxLines,
              weight: VerseWeight.thin,
              centered: centered,
            ),
          ),

        ]
    );
  }
}
