import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:flutter/material.dart';

class SuperHeadline extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SuperHeadline({
    @required this.verse,
    this.width,
    this.color = Colorz.white255,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final Verse verse;
  final double width;
  final Color color;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperVerse(
      verse: verse,
      width: width ?? BldrsAppBar.width(context),
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
