import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_bz_pg_counter.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class CensusLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CensusLine({
    @required this.verse,
    @required this.icon,
    @required this.count,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final String icon;
  final int count;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BzPgCounter(
      flyerBoxWidth: Scale.screenWidth(context),
      verse: verse,
      count: count,
      icon: icon,
      iconSizeFactor: 0.95,
    );

  }
/// --------------------------------------------------------------------------
}
