import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
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
    return Bubble(
        bubbleColor: Colorz.White10,
        columnChildren: <Widget>[

          SuperVerse(
            verse: title,
            margin: 5,
            redDot: true,
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
                        color: chosenButton == buttonsList[index] ? Colorz.Yellow255 : Colorz.White10,
                        verseColor: chosenButton == buttonsList[index] ? Colorz.Black230 : Colorz.White255,
                        verseWeight: chosenButton == buttonsList[index] ? VerseWeight.black :  VerseWeight.bold,
                        verseScaleFactor: 0.6,
                        margins: const EdgeInsets.all(5),
                        onTap: () => tappingAButton(index),
                      );
                  }
              )


          ),

        ]
    );
  }
}
