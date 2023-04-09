import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class AuthorRoleButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuthorRoleButton({
    @required this.verse,
    @required this.isOn,
    @required this.icon,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final Function onTap;
  final bool isOn;
  final String icon;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: 50,
      width: 300,
      verse: verse.copyWith(casing: isOn == true ? Casing.upperCase : Casing.non),
      icon: icon,
      iconSizeFactor: 0.6,
      verseScaleFactor: 1.5,
      color: isOn == true ? Colorz.yellow255 : Colorz.nothing,
      iconColor: isOn == true ? Colorz.black255 : Colorz.white255,
      verseColor: isOn == true ? Colorz.black255 : Colorz.white255,
      verseShadow: false,
      verseWeight: isOn == true ? VerseWeight.black : VerseWeight.thin,
      verseItalic: true,
      margins: const EdgeInsets.only(bottom: 10),
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
