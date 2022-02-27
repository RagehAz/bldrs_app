import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:flutter/material.dart';

class InfoPageHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageHeadline({
    @required this.pageWidth,
    @required this.headline,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final String headline;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: pageWidth,
      alignment: Aligners.superCenterAlignment(context),
      // padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 10),
      child: SuperVerse(
        verse: headline,
        centered: false,
        size: 3,
        leadingDot: true,
      ),
    );
  }
}
