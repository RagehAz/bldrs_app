import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FieldsRow extends StatelessWidget {
  final Function openList;
  final List<String> fields;
  final String title;


  FieldsRow({
    @required this.openList,
    @required this.fields,
    @required this.title,
});


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    double boxHeight = 35;

    bool designMode = false;

    // - ROW OF BUTTONS
    double buttonSpacing = Ratioz.ddAppBarMargin*2;
    double buttonsZoneWidth = (screenWidth - (Ratioz.ddAppBarMargin * 12));

    // int numberOfButtons = 2;
    // double rowButtonWidth = (buttonsZoneWidth - (numberOfButtons * buttonSpacing) - buttonSpacing) / numberOfButtons;
    // double rowButtonHeight = 40;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        // --- FIELDS TITLE
        Padding(
          padding: EdgeInsets.symmetric(horizontal: buttonSpacing * 2, vertical: buttonSpacing * 0.5),
          child: SuperVerse(
            verse: title,
            margin: 0,
            centered: false,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.BabyBlue,
            shadow: true,
            designMode: designMode,
          ),
        ),

        // --- WRAP OF FIELDS
        GestureDetector(
          onTap: openList,
          child: Center(
            child: Container(
              width: buttonsZoneWidth,
                decoration: BoxDecoration(
                    color: Colorz.WhiteAir,
                    borderRadius: BorderRadius.circular(Ratioz.ddBoxCorner *1.5),
                    boxShadow: [
                      CustomBoxShadow(
                          color: Colorz.BlackLingerie,
                          offset: new Offset(0,0 ),
                          blurRadius: boxHeight * 0.15,
                          blurStyle: BlurStyle.outer),
                    ]),
              child: Padding(
                padding:  EdgeInsets.all(buttonSpacing),
                child: Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.center,
                    children:
                    List<Widget>.generate(
                        fields.length,
                            (int index) {
                          return
                            SuperVerse(
                              verse: fields[index],
                              italic: false,
                              shadow: false,
                              labelColor: Colorz.WhiteZircon,
                              color: Colorz.White,
                              weight: VerseWeight.bold,
                              size: 2,
                              margin: boxHeight * 0 ,
                            );
                        }
                  )
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
