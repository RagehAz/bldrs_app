import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:flutter/material.dart';

class NotesCreatorHomeButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotesCreatorHomeButton({
    @required this.height,
    @required this.text,
    @required this.icon,
    @required this.onTap,
    Key key
  }) : super(key: key);

  final double height;
  final String text;
  final String icon;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: PageBubble.width(context),
      icon: icon,
      verse: Verse(
        text: text,
        translate: false,
        casing: Casing.upperCase,
      ),
      verseCentered: false,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      iconSizeFactor: 0.4,
      verseScaleFactor: 1.8,
      onTap: onTap,
      margins: const EdgeInsets.only(bottom: 10),
    );

  }
/// --------------------------------------------------------------------------
}
