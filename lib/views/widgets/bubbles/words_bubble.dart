import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class KeywordsBubble extends StatelessWidget {
  final String title;
  final List<Keyword> keywords;
  final int verseSize;
  final Function onTap;
  final bool bubbles;
  final Color bubbleColor;
  final List<dynamic> selectedWords;
  final double bubbleWidth;
  final dynamic margins;
  final dynamic corners;

  KeywordsBubble({
    @required this.title,
    @required this.keywords,
    this.verseSize = 2,
    this.onTap,
    this.bubbles,
    this.bubbleColor = Colorz.White20,
    @required this.selectedWords,
    this.bubbleWidth,
    this.margins,
    this.corners,
  });
// -----------------------------------------------------------------------------
  String _getKeywordName(BuildContext context, int index){
    return
      Keyword.getKeywordNameByKeywordID(context, keywords[index].keywordID);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double abPadding = Ratioz.appBarPadding;
    double contactBoxHeight = 35;

    return InPyramidsBubble(
      centered: false,
      bubbleColor: bubbleColor,
      margins: margins,
      corners: corners,
      title: title,
      bubbleWidth: bubbleWidth,
      columnChildren: <Widget>[

        // --- STRINGS
        Wrap(
          spacing: abPadding,
          children: <Widget>[

            ...List<Widget>.generate(
                keywords.length,
                    (index){

                  String _keywordName = _getKeywordName(context, index);

                  bool wordIsSelected(){
                    bool _wordIsSelected = selectedWords.contains(keywords[index]) ?? false;
                    return _wordIsSelected;
                  }

                  Color _buttonColor = wordIsSelected() ? Colorz.Yellow255 : Colorz.White20;
                  Color _verseColor = wordIsSelected() ? Colorz.Black230 : Colorz.White255;
                  VerseWeight _verseWeight = wordIsSelected() ? VerseWeight.bold : VerseWeight.thin;

                      return

                  bubbles == true ?

                  DreamBox(
                    height: 40,
                    verse: _keywordName,
                    verseScaleFactor: 0.6,
                    verseWeight: _verseWeight,
                    verseColor: _verseColor,
                    margins: const EdgeInsets.all(5),
                    bubble: true,
                    color: _buttonColor,
                    onTap: () => onTap(keywords[index]),
                  )
                      :
                  SuperVerse(
                      verse: _keywordName,
                      margin: 0,
                      color: _verseColor,
                      weight: _verseWeight,
                      italic: true,
                      shadow: false,
                      labelColor: _buttonColor,
                      onTap: () => onTap(keywords[index]),
                    );

                }
            ),

          ],
        ),

      ],
    );
  }
}
