import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SuperHeadline extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SuperHeadline({
    required this.verse,
    this.width,
    this.color = Colorz.white255,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Verse verse;
  final double? width;
  final Color color;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsText(
      verse: verse,
      width: width ?? BldrsAppBar.width(),
      size: 5,
      maxLines: 2,
      color: color,
      centered: false,
      margin: 20,
      shadow: true,
      italic: true,
    );

  }
  // -----------------------------------------------------------------------------
}
