import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
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
      child: Bubble(
        headerViewModel: const BubbleHeaderVM(),
        width: pageWidth,
        // padding: const EdgeInsets.symmetric(horizontal: 5),
        columnChildren: <Widget>[

          SuperVerse(
            verse: flyerInfo,
            maxLines: 500,
            centered: false,
            weight: VerseWeight.thin,
            size: 3,
          ),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
