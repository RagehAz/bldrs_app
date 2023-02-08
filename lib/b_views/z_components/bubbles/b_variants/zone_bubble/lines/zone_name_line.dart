import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';

class ZoneNameLine extends StatelessWidget {

  const ZoneNameLine({
    @required this.name,
    Key key
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {

    final double _clearWidth = Bubble.clearWidth(context);

    return SuperVerse(
      width: _clearWidth,
      verse: Verse.plain(name),

      shadow: true,
      size: 4,
      margin: 5,
      maxLines: 2,
      labelColor: Colorz.white10,
      // onTap: _onTap,
    );

  }
}
