import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/general_buttons/main_button.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class AuthorRoleButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorRoleButton({
    required this.verse,
    required this.isOn,
    required this.icon,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse verse;
  final Function? onTap;
  final bool isOn;
  final String icon;
  /// --------------------------------------------------------------------------
  static double getWidth(BuildContext context){
    return MainButton.getButtonWidth(context: context);
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: 50,
      width: getWidth(context),
      verse: verse.copyWith(casing: isOn == true ? Casing.upperCase : Casing.non),
      icon: icon,
      iconSizeFactor: 0.6,
      verseScaleFactor: 0.7 / 0.6,
      color: isOn == true ? Colorz.yellow255 : Colorz.nothing,
      iconColor: isOn == true ? Colorz.black255 : Colorz.white255,
      verseColor: isOn == true ? Colorz.black255 : Colorz.white255,
      // verseShadow: false,
      verseWeight: isOn == true ? VerseWeight.black : VerseWeight.thin,
      verseItalic: true,
      margins: const EdgeInsets.only(bottom: 10),
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
