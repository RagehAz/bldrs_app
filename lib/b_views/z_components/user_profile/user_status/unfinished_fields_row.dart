import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FieldsRow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FieldsRow({
    @required this.openList,
    @required this.fieldsVerses,
    @required this.titleVerse,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function openList;
  final List<Verse> fieldsVerses;
  final Verse titleVerse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = MediaQuery.of(context).size.width;
    const double _boxHeight = 35;
    // --------------------
    /// - ROW OF BUTTONS
    const double _buttonSpacing = Ratioz.appBarMargin * 2;
    // int numberOfButtons = 2;
    // double rowButtonWidth = (_buttonsZoneWidth - (numberOfButtons * _buttonSpacing) - _buttonSpacing) / numberOfButtons;
    // double rowButtonHeight = 40;
    final double _buttonsZoneWidth = _screenWidth - (Ratioz.appBarMargin * 12);
    // --------------------
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// --- FIELDS TITLE
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: _buttonSpacing * 2, vertical: _buttonSpacing * 0.5
          ),
          child: SuperVerse(
            verse: titleVerse,
            margin: 0,
            centered: false,
            italic: true,
            weight: VerseWeight.thin,
            color: Colorz.blue255,
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
                  color: Colorz.white10,
                  borderRadius: BorderRadius.circular(Ratioz.boxCorner12),
                  boxShadow: const <BoxShadow>[
                    CustomBoxShadow(
                        color: Colorz.black200,
                        blurRadius: _boxHeight * 0.15,
                        style: BlurStyle.outer,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(_buttonSpacing),
                child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: List<Widget>.generate(fieldsVerses.length, (int index) {
                      return SuperVerse(
                        verse: fieldsVerses[index],
                        labelColor: Colorz.white50,
                        margin: _boxHeight * 0,
                      );
                    })),
              ),
            ),
          ),
        ),
      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
