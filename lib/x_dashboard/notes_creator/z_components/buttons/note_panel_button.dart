import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class NotePanelButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NotePanelButton({
    @required this.text,
    @required this.onTap,
    this.isDeactivated = false,
    this.height = 50,
    this.width = 50,
    this.icon,
    this.verseScaleFactor = 0.5,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String text;
  final Function onTap;
  final bool isDeactivated;
  final double height;
  final double width;
  final String icon;
  final double verseScaleFactor;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: width,
      icon: icon,
      verse: Verse.plain(text),
      verseScaleFactor: verseScaleFactor,
      verseColor: Colorz.black255,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      color: Colorz.yellow255,
      onTap: onTap,
      isDeactivated: isDeactivated,
    );

  }
  // -----------------------------------------------------------------------------
}
