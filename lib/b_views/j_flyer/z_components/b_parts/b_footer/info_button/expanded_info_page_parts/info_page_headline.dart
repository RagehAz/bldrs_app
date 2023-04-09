import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class InfoPageHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageHeadline({
    @required this.pageWidth,
    @required this.verse,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final Verse verse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: pageWidth,
      alignment: BldrsAligners.superCenterAlignment(context),
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 10),
      child: BldrsText(
        verse: verse,
        centered: false,
        size: 3,
        leadingDot: true,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
