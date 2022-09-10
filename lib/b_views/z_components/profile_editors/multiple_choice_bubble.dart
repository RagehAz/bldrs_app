import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
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
    this.bulletPoints,
    this.translateBullets = true,
    this.inactiveButtons,
    this.validator,
    this.autoValidate = true,
    this.isRequired = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String title;
  final List<String> bulletPoints;
  final List<String> buttonsList;
  final ValueChanged<int> onButtonTap;
  final List<String> selectedButtons;
  final List<String> inactiveButtons;
  final bool translateBullets;
  final String Function() validator;
  final bool autoValidate;
  final bool isRequired;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.bubbleWidth(context: context);

    return Bubble(
        screenWidth: _bubbleWidth,
        bubbleColor: Colorizer.ValidatorColor(
          validator: validator,
        ),
        headerViewModel: BubbleHeaderVM(
          headlineVerse: title,
          redDot: isRequired,
          headerWidth: _bubbleWidth - 20,
        ),
        columnChildren: <Widget>[

          /// BULLET POINTS
          if (bulletPoints != null)
            BubbleBulletPoints(
              bulletPoints: bulletPoints,
              translateBullets: translateBullets,
            ),

          /// BUTTONS
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

          /// VALIDATOR
          if (validator != null)
            SuperValidator(
              width: Bubble.clearWidth(context) - 20,
              validator: validator,
              autoValidate: autoValidate,
            ),

        ]
    );

  }
/// --------------------------------------------------------------------------
}
