import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class PropertyUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;


    bool designMode = true;

    // - ROW OF BUTTONS
    double buttonSpacing = Ratioz.appBarMargin*2;
    double buttonsZoneWidth = (screenWidth - (Ratioz.appBarMargin * 12));

    int numberOfButtons = 2;
    double rowButtonWidth = (buttonsZoneWidth - (numberOfButtons * buttonSpacing) - buttonSpacing) / numberOfButtons;
    double rowButtonHeight = 40;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SuperVerse(
          verse: 'Property Use',
          margin: Ratioz.appBarMargin * 2,
          centered: false,
          italic: true,
          weight: VerseWeight.thin,
          color: Colorz.White225,
          shadow: false,
          designMode: designMode,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            DreamBox(
              width: rowButtonWidth,
              height: rowButtonHeight,
              verse: 'For Sale',
              verseWeight: VerseWeight.regular,
              verseScaleFactor: 0.8,
              color: Colorz.Blue80,
            ),


          ],
        ),
      ],
    );
  }
}
