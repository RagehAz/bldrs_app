import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class MultipleChoiceBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MultipleChoiceBubble({
    @required this.titleVerse,
    @required this.buttonsVerses,
    @required this.onButtonTap,
    @required this.selectedButtonsPhids,
    this.bulletPoints,
    this.inactiveButtons,
    this.validator,
    this.autoValidate = true,
    this.isRequired = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse titleVerse;
  final List<Verse> bulletPoints;
  final List<Verse> buttonsVerses;
  final ValueChanged<int> onButtonTap;
  final List<String> selectedButtonsPhids;
  final List<Verse> inactiveButtons;
  final String Function() validator;
  final bool autoValidate;
  final bool isRequired;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.bubbleWidth(context);

    return Bubble(
        width: _bubbleWidth,
        bubbleColor: Formers.validatorBubbleColor(
          validator: validator == null ? null : () => validator(),
        ),
        headerViewModel: BubbleHeaderVM(
          headlineVerse: titleVerse,
          redDot: isRequired,
          headerWidth: _bubbleWidth - 20,
        ),
        columnChildren: <Widget>[

          /// BULLET POINTS
          if (bulletPoints != null)
            BulletPoints(
              bulletPoints: bulletPoints,
            ),

          /// BUTTONS
          Wrap(
              runAlignment: WrapAlignment.center,
              children: List<Widget>.generate(buttonsVerses.length, (int index) {

                final Verse _buttonVerse = buttonsVerses[index];

                final bool _isSelected = Stringer.checkStringsContainString(
                  strings: selectedButtonsPhids,
                  string: _buttonVerse.text,
                );

                final bool _isInactive = Stringer.checkStringsContainString(
                  strings: Verse.getTextsFromVerses(inactiveButtons),
                  string: _buttonVerse.text,
                );

                return DreamBox(
                  height: 40,
                  isDeactivated: _isInactive,
                  verse: buttonsVerses[index],
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
