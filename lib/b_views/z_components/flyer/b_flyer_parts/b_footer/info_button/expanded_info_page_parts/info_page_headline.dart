import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:flutter/material.dart';

class InfoPageHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageHeadline({
    @required this.pageWidth,
    @required this.headlineVerse,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final Verse headlineVerse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: pageWidth,
      alignment: Aligners.superCenterAlignment(context),
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 10),
      child: SuperVerse(
        verse: headlineVerse,
        centered: false,
        size: 3,
        leadingDot: true,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
