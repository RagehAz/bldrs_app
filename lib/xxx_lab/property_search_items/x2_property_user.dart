import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class PropertyUse extends StatelessWidget {
  const PropertyUse({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;


    ///  ROW OF BUTTONS
    const double buttonSpacing = Ratioz.appBarMargin*2;
    final double buttonsZoneWidth = (screenWidth - (Ratioz.appBarMargin * 12));

    const int numberOfButtons = 2;
    final double rowButtonWidth = (buttonsZoneWidth - (numberOfButtons * buttonSpacing) - buttonSpacing) / numberOfButtons;
    const double rowButtonHeight = 40;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SuperVerse(
          verse: 'Property Use',
          margin: Ratioz.appBarMargin * 2,
          centered: false,
          italic: true,
          weight: VerseWeight.thin,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            DreamBox(
              width: rowButtonWidth,
              height: rowButtonHeight,
              verse: 'For Sale',
              verseWeight: VerseWeight.regular,
              verseScaleFactor: 0.8,
              color: Colorz.blue80,
            ),


          ],
        ),
      ],
    );
  }
}
