import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ZoneNameLine extends StatelessWidget {

  const ZoneNameLine({
    required this.name,
    super.key
  });
  
  final String? name;

  @override
  Widget build(BuildContext context) {

    final double _clearWidth = Bubble.clearWidth(context: context);

    return BldrsText(
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
