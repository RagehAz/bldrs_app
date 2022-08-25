import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class MultipleChoiceBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MultipleChoiceBubble({
    @required this.title,
    @required this.buttonsList,
    @required this.onButtonTap,
    @required this.selectedButtons,
    @required this.isInError,
    this.bulletPoints,
    this.inactiveButtons,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final List<String> bulletPoints;
  final List<String> buttonsList;
  final ValueChanged<int> onButtonTap;
  final List<String> selectedButtons;
  final List<String> inactiveButtons;
  final bool isInError;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
        columnChildren: <Widget>[

          SuperVerse(
            verse: title,
            margin: 5,
            redDot: true,
          ),

          if (bulletPoints != null)
            BubbleBulletPoints(
              bulletPoints: bulletPoints,
            ),

          Wrap(
              runAlignment: WrapAlignment.center,
              children: List<Widget>.generate(buttonsList.length, (int index) {

                final String _button = buttonsList[index];

                final bool _isSelected = Stringer.checkStringsContainString(
                    strings: selectedButtons,
                    string: _button,
                );

                final bool _isInactive = Stringer.checkStringsContainString(
                  strings: inactiveButtons,
                  string: _button,
                );

                return DreamBox(
                  height: 40,
                  isDeactivated: _isInactive,
                  verse: buttonsList[index],
                  color: _isSelected == true ?
                  Colorz.yellow255
                      :
                  Colorz.white10,

                  verseColor: _isSelected == true ?
                  Colorz.black230
                      :
                  Colorz.white255,
                  verseWeight: _isSelected == true ?
                  VerseWeight.black
                      :
                  VerseWeight.bold,
                  verseScaleFactor: 0.6,
                  margins: const EdgeInsets.all(5),
                  onTap: () => onButtonTap(index),
                );

              }
              )
          ),

        ]
    );
  }
}
