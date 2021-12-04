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

  const MultipleChoiceBubble({
    @required this.title,
    @required this.buttonsList,
    @required this.tappingAButton,
    @required this.chosenButton,
    this.buttonsInActivityList,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
        bubbleColor: Colorz.white10,
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

                    bool _inActiveMode = false;
                    if (buttonsInActivityList != null){
                      _inActiveMode = buttonsInActivityList[index];
                    }

                    return
                      DreamBox(
                        height: 40,
                        inActiveMode: _inActiveMode,
                        verse: buttonsList[index],
                        verseItalic: false,
                        color: chosenButton == buttonsList[index] ? Colorz.yellow255 : Colorz.white10,
                        verseColor: chosenButton == buttonsList[index] ? Colorz.black230 : Colorz.white255,
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
