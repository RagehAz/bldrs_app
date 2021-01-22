import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class MultipleChoiceBubble extends StatelessWidget {
  final String title;
  final List<String> buttonsList;
  final Function tappingAButton;
  final String chosenButton;
  final List<bool> buttonsInActivityList;

  MultipleChoiceBubble({
    @required this.title,
    @required this.buttonsList,
    @required this.tappingAButton,
    @required this.chosenButton,
    this.buttonsInActivityList,
  });

  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
        bubbleColor: Colorz.WhiteAir,
        columnChildren: <Widget>[

          SuperVerse(
            verse: title,
            margin: 5,
          ),

          Wrap(
              spacing: 0,
              runSpacing: 0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.center,

              children:
              List<Widget>.generate(
                  buttonsList.length,
                      (int index) {
                    return
                      DreamBox(
                        height: 40,
                        inActiveMode: buttonsInActivityList == null ? false : buttonsInActivityList[index],
                        verse: buttonsList[index],
                        verseItalic: false,
                        color: chosenButton == buttonsList[index] ? Colorz.Yellow : Colorz.WhiteAir,
                        verseColor: chosenButton == buttonsList[index] ? Colorz.BlackBlack : Colorz.White,
                        verseWeight: chosenButton == buttonsList[index] ? VerseWeight.black :  VerseWeight.bold,
                        verseScaleFactor: 0.6,
                        boxMargins: EdgeInsets.all(5),
                        boxFunction: () => tappingAButton(index),
                      );
                  }
              )


          ),


        ]
    );
  }
}
