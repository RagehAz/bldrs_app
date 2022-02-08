import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class InfoPageParagraph extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageParagraph({
    @required this.pageWidth,
    @required this.flyerInfo,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final String flyerInfo;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey<String>('InfoPageParagraph'),
      child: Container(
        width: pageWidth,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SuperVerse(
          verse: flyerInfo,
          maxLines: 500,
          centered: false,
          weight: VerseWeight.thin,
          size: 3,
        ),
      ),
    );
  }
}
