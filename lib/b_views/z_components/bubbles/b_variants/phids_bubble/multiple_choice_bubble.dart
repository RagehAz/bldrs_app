import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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
    this.wrapButtons = true,
    this.focusNode,
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
  final bool wrapButtons;
  final FocusNode focusNode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.bubbleWidth(context);

    return Bubble(
        width: _bubbleWidth,
        bubbleColor: Formers.validatorBubbleColor(
          validator: validator == null ? null : () => validator(),
        ),
        bubbleHeaderVM: BubbleHeaderVM(
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
          _ButtonsBuilder(
            width: Bubble.clearWidth(context),
            buttonsVerses: buttonsVerses,
            onButtonTap: onButtonTap,
            selectedButtonsPhids: selectedButtonsPhids,
            inactiveButtons: inactiveButtons,
            wrapButtons: wrapButtons,
          ),

          /// VALIDATOR
          if (validator != null)
            SuperValidator(
              width: Bubble.clearWidth(context) - 20,
              validator: validator,
              autoValidate: autoValidate,
              focusNode: focusNode,
            ),

        ]
    );

  }
/// --------------------------------------------------------------------------
}

class _ButtonsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _ButtonsBuilder({
    @required this.width,
    @required this.buttonsVerses,
    @required this.onButtonTap,
    @required this.selectedButtonsPhids,
    this.inactiveButtons = const [],
    this.wrapButtons = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final bool wrapButtons;
  final List<Verse> buttonsVerses;
  final ValueChanged<int> onButtonTap;
  final List<String> selectedButtonsPhids;
  final List<Verse> inactiveButtons;
  /// --------------------------------------------------------------------------
  static const double buttonHeight = 40;
  static const double margins = 5;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(buttonsVerses) == false){
      return const SizedBox();
    }

    else {

      /// WRAPPED BUTTONS
      if (wrapButtons == true){
        return Wrap(
            runAlignment: WrapAlignment.center,
            children: List<Widget>.generate(buttonsVerses.length, (int index) {

              final Verse _buttonVerse = buttonsVerses[index];

              final bool _isSelected = Stringer.checkStringsContainString(
                strings: selectedButtonsPhids,
                string: _buttonVerse.text,
              );

              final bool _isDeactivated = Stringer.checkStringsContainString(
                strings: Verse.getTextsFromVerses(inactiveButtons),
                string: _buttonVerse.text,
              );

              return _TheButton(
                icon: null,
                verse: _buttonVerse,
                isDeactivated: _isDeactivated,
                isSelected: _isSelected,
                onTap: () => onButtonTap(index),
              );

            }
            )
        );
      }

      /// LIST BUTTONS
      else {

        final double _boxHeight = (buttonHeight + margins*2) * buttonsVerses.length;

        return SizedBox(
          width: width,
          height: _boxHeight,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttonsVerses.length,
              itemBuilder: (_, int index){

                final Verse _buttonVerse = buttonsVerses[index];

                final bool _isSelected = Stringer.checkStringsContainString(
                  strings: selectedButtonsPhids,
                  string: _buttonVerse.text,
                );

                final bool _isDeactivated = Stringer.checkStringsContainString(
                  strings: Verse.getTextsFromVerses(inactiveButtons),
                  string: _buttonVerse.text,
                );

                return Align(
                  alignment: Aligners.superCenterAlignment(context),
                  child: _TheButton(
                    icon: null,
                    verse: buttonsVerses[index],
                    isDeactivated: _isDeactivated,
                    isSelected: _isSelected,
                    onTap: () => onButtonTap(index),
                  ),
                );

              }
          ),
        );
      }


    }

  }
  /// --------------------------------------------------------------------------
}

class _TheButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _TheButton({
    @required this.isDeactivated,
    @required this.verse,
    @required this.isSelected,
    @required this.onTap,
    @required this.icon,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isDeactivated;
  final Verse verse;
  final bool isSelected;
  final Function onTap;
  final String icon;
  /// --------------------------------------------------------------------------
  static const double buttonHeight = 40;
  static const double margins = 5;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: buttonHeight,
      icon: icon,
      isDeactivated: isDeactivated,
      verse: verse,
      color: isSelected == true ?
      Colorz.yellow255
          :
      Colorz.white10,
      verseColor: isSelected == true ?
      Colorz.black230
          :
      Colorz.white255,
      verseWeight: isSelected == true ?
      VerseWeight.black
          :
      VerseWeight.bold,
      verseScaleFactor: 0.6,
      margins: const EdgeInsets.all(margins),
      onTap: onTap,
    );

  }
  /// --------------------------------------------------------------------------
}
