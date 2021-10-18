import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
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

    final double _screenWidth = MediaQuery.of(context).size.width;

    const double _boxHeight = 35;

    /// - ROW OF BUTTONS
    const double _buttonSpacing = Ratioz.appBarMargin * 2;
    final double _buttonsZoneWidth = (_screenWidth - (Ratioz.appBarMargin * 12));

    // int numberOfButtons = 2;
    // double rowButtonWidth = (_buttonsZoneWidth - (numberOfButtons * _buttonSpacing) - _buttonSpacing) / numberOfButtons;
    // double rowButtonHeight = 40;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        /// --- FIELDS TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _buttonSpacing * 2, vertical: _buttonSpacing * 0.5),
          child: SuperVerse(
            verse: title,
            margin: 0,
            centered: false,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.Blue225,
            shadow: true,
          ),
        ),

        /// --- WRAP OF FIELDS
        GestureDetector(
          onTap: openList,
          child: Center(
            child: Container(
              width: _buttonsZoneWidth,
                decoration: BoxDecoration(
                    color: Colorz.White10,
                    borderRadius: BorderRadius.circular(Ratioz.boxCorner12),
                    boxShadow: <BoxShadow>[
                      CustomBoxShadow(
                          color: Colorz.Black200,
                          offset: new Offset(0,0 ),
                          blurRadius: _boxHeight * 0.15,
                          blurStyle: BlurStyle.outer),
                    ]),
              child: Padding(
                padding: const EdgeInsets.all(_buttonSpacing),
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
                              labelColor: Colorz.White50,
                              color: Colorz.White255,
                              weight: VerseWeight.bold,
                              size: 2,
                              margin: _boxHeight * 0 ,
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
