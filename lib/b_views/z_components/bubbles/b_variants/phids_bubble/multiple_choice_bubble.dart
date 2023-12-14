// ignore_for_file: unused_element
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class MultipleChoiceBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MultipleChoiceBubble({
    required this.titleVerse,
    required this.buttonsVerses,
    required this.onButtonTap,
    required this.selectedButtonsPhids,
    this.bulletPoints,
    this.inactiveButtons,
    this.validator,
    this.autoValidate = true,
    this.isRequired = true,
    this.wrapButtons = true,
    this.focusNode,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse titleVerse;
  final List<Verse>? bulletPoints;
  final List<Verse> buttonsVerses;
  final ValueChanged<int> onButtonTap;
  final List<String> selectedButtonsPhids;
  final List<Verse>? inactiveButtons;
  final String? Function()? validator;
  final bool autoValidate;
  final bool isRequired;
  final bool wrapButtons;
  final FocusNode? focusNode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.bubbleWidth(context: context);
    final double _clearWidth = Bubble.clearWidth(context: context);

    return Bubble(
        width: _bubbleWidth,
        bubbleColor: Formers.validatorBubbleColor(
          validator: validator == null ? null : () => validator?.call(),
        ),
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: titleVerse,
          redDot: isRequired,
          headerWidth: _bubbleWidth - 20,
        ),
        columnChildren: <Widget>[

          /// BULLET POINTS
          if (bulletPoints != null)
            BldrsBulletPoints(
              bulletPoints: bulletPoints,
              showBottomLine: false,
            ),

          /// BUTTONS
          _ButtonsBuilder(
            width: _clearWidth,
            buttonsVerses: buttonsVerses,
            onButtonTap: onButtonTap,
            selectedButtonsPhids: selectedButtonsPhids,
            inactiveButtons: inactiveButtons,
            wrapButtons: wrapButtons,
          ),

          /// VALIDATOR
          if (validator != null)
            BldrsValidator(
              width: _clearWidth - 20,
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
    required this.width,
    required this.buttonsVerses,
    required this.onButtonTap,
    required this.selectedButtonsPhids,
    this.inactiveButtons = const [],
    this.wrapButtons = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final bool wrapButtons;
  final List<Verse> buttonsVerses;
  final ValueChanged<int> onButtonTap;
  final List<String> selectedButtonsPhids;
  final List<Verse>? inactiveButtons;
  /// --------------------------------------------------------------------------
  static const double buttonHeight = 40;
  static const double margins = 5;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(buttonsVerses) == false){
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
                string: _buttonVerse.id,
              );

              final bool _isDeactivated = Stringer.checkStringsContainString(
                strings: Verse.getVersesIDs(inactiveButtons),
                string: _buttonVerse.id,
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
                  string: _buttonVerse.id,
                );

                final bool _isDeactivated = Stringer.checkStringsContainString(
                  strings: Verse.getVersesIDs(inactiveButtons),
                  string: _buttonVerse.id,
                );

                return Align(
                  alignment: BldrsAligners.superCenterAlignment(context),
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
    required this.isDeactivated,
    required this.verse,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool isDeactivated;
  final Verse verse;
  final bool isSelected;
  final Function onTap;
  final String? icon;
  /// --------------------------------------------------------------------------
  static const double buttonHeight = 40;
  static const double margins = 5;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: buttonHeight,
      icon: icon,
      isDisabled: isDeactivated,
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
      verseScaleFactor: 0.8,
      margins: const EdgeInsets.all(margins),
      onTap: onTap,
    );

  }
  /// --------------------------------------------------------------------------
}
