import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class WordsBubble extends StatelessWidget {
  final String title;
  final List<dynamic> words;
  final int verseSize;
  final Function onTap;
  final bool bubbles;
  final Color bubbleColor;
  final List<String> selectedWords;

  WordsBubble({
    @required this.title,
    @required this.words,
    this.verseSize = 2,
    this.onTap,
    this.bubbles,
    this.bubbleColor,
    @required this.selectedWords,
  });

  @override
  Widget build(BuildContext context) {

    double abPadding = Ratioz.ddAppBarPadding;
    double contactBoxHeight = 35;


    return InPyramidsBubble(
      centered: false,
      bubbleColor: bubbleColor,
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

                  bool wordIsSelected(){
                    bool _wordIsSelected = selectedWords.contains(words[index]) ?? false;
                    return _wordIsSelected;
                  }

                  Color _buttonColor = wordIsSelected() ? Colorz.Yellow : Colorz.WhiteGlass;
                  Color _verseColor = wordIsSelected() ? Colorz.BlackBlack : Colorz.White;
                  VerseWeight _verseWeight = wordIsSelected() ? VerseWeight.bold : VerseWeight.thin;

                      return

                  bubbles == true ?

                  DreamBox(
                    height: 40,
                    verse: words[index],
                    verseScaleFactor: 0.6,
                    verseWeight: _verseWeight,
                    verseColor: _verseColor,
                    boxMargins: EdgeInsets.all(5),
                    bubble: true,
                    color: _buttonColor,
                    boxFunction: () => onTap(words[index]),
                  )
                      :
                  SuperVerse(
                      verse: words[index],
                      margin: 0,
                      color: _verseColor,
                      weight: _verseWeight,
                      italic: true,
                      shadow: false,
                      labelColor: _buttonColor,
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
