import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SendButton({
    @required this.text,
    @required this.onTap,
    this.isDeactivated = false,
    this.height = 40,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String text;
  final Function onTap;
  final bool isDeactivated;
  final double height;
  // -----------------------------------------------------------------------------
  static const double width = 80;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: width,
      verse: Verse.plain(text),
      verseScaleFactor: 0.5,
      verseColor: Colorz.black255,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      color: Colorz.yellow255,
      onTap: onTap,
      isDeactivated: isDeactivated,
      margins: Scale.superInsets(
        context: context,
        enRight: 5,
        enLeft: 5,
        bottom: 5,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
