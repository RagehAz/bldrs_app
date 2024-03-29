import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/h_navigation/mirage/mirage.dart';
import 'package:bldrs/z_components/buttons/keywords_buttons/f_phid_button.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class PhidButtonClone extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PhidButtonClone({
    required this.onTap,
    required this.isSelected,
    this.verse,
    this.icon,
    this.height,
    this.buttonColor,
    this.selectedButtonColor,
    super.key
  });
  // --------------------
  final Verse? verse;
  final dynamic icon;
  final bool isSelected;
  final Function onTap;
  final double? height;
  final Color? buttonColor;
  final Color? selectedButtonColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Color _buttonColor = buttonColor ?? Colorz.white20;
    final Color _selectedButtonColor = selectedButtonColor ?? Colorz.yellow125;
    // --------------------
    return BldrsBox(
      height: height ?? PhidButton.getHeight(),
      verse: verse,
      verseColor: MirageButton.getVerseColor(isDisabled: false, isSelected: isSelected),
      icon: icon,
      iconSizeFactor: PhidButton.getVerseScaleFactor(xIsOn: false),
      color: isSelected == true ? _selectedButtonColor : _buttonColor,
      margins: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enRight: 5,
      ),
      onTap: onTap,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
