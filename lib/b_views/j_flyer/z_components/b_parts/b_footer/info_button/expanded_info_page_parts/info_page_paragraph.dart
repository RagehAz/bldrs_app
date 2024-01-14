import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';

import 'package:flutter/material.dart';

class InfoPageParagraph extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageParagraph({
    required this.pageWidth,
    required this.flyerInfo,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final String flyerInfo;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      key: const ValueKey<String>('InfoPageParagraph'),
      child: Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
      ),
        width: pageWidth,
        // padding: const EdgeInsets.symmetric(horizontal: 5),
        columnChildren: <Widget>[

          BldrsText(
            verse: Verse(
              id: flyerInfo,
              translate: false,
            ),
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
