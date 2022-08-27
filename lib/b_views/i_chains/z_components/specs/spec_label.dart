import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class SpecLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecLabel({
    @required this.xIsOn,
    @required this.value,
    @required this.translate,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool xIsOn;
  final String value;
  final bool translate;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: 40,
      corners: 15,
      icon: xIsOn ? Iconz.xLarge : null,
      margins: const EdgeInsets.symmetric(vertical: 2.5),
      verse: value,
      translateVerse: translate,
      verseWeight: VerseWeight.thin,
      verseItalic: true,
      verseScaleFactor: 1.6,
      verseShadow: false,
      iconSizeFactor: 0.4,
      color: Colorz.black255,
      bubble: false,
      onTap: onTap,
    );

  }
}
