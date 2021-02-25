import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class WordsBubble extends StatelessWidget {
  final String title;
  final List<String> words;
  final int verseSize;
  final Function onTap;
  final bool bubbles;

  WordsBubble({
    @required this.title,
    @required this.words,
    this.verseSize = 2,
    this.onTap,
    this.bubbles,
  });

  @override
  Widget build(BuildContext context) {


    double abPadding = Ratioz.ddAppBarPadding;
    double contactBoxHeight = 35;

    return InPyramidsBubble(
      centered: false,
      columnChildren: <Widget>[

        InBubbleTitle(
          title: title,
        ),

        // --- STRINGS
        Wrap(
          spacing: abPadding,
          children: <Widget>[

            ...List<Widget>.generate(
                words.length,
                    (index){
                  return

                  bubbles == true ?

                  DreamBox(
                    height: 40,
                    verse: words[index],
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.thin,
                    boxMargins: EdgeInsets.all(5),
                    bubble: true,
                    color: Colorz.WhiteGlass,
                    boxFunction: () => onTap(words[index]),
                  )
                      :
                    SuperVerse(
                      verse: words[index],
                      margin: 0,
                      color: Colorz.White,
                      weight: VerseWeight.thin,
                      italic: true,
                      shadow: false,
                      labelColor: Colorz.WhiteGlass,
                      labelTap: () => onTap(words[index]),
                    );

                }
            ),

          ],
        ),

      ],
    );
  }
}
