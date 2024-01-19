import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BzSlideHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzSlideHeadline({
    required this.flyerBoxWidth,
    required this.firstLine,
    required this.secondLine,
    required this.headerIsExpanded,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Verse firstLine;
  final Verse secondLine;
  final ValueNotifier<bool> headerIsExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      height: flyerBoxWidth * 0.3,
      width: flyerBoxWidth,
      color: Colorz.black80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// BUSINESS NAME
          BldrsText(
            width: flyerBoxWidth,
            verse: firstLine,
            size: 3,
            shadow: true,
            maxLines: 2,
            scaleFactor: flyerBoxWidth * 0.003,
            margin: EdgeInsets.symmetric(
              horizontal: flyerBoxWidth * 0.03,
            ),
          ),

          /// BUSINESS LOCALE
          BldrsText(
            width: flyerBoxWidth,
            verse: secondLine,
            italic: true,
            weight: VerseWeight.regular,
            color: Colorz.white200,
            scaleFactor: flyerBoxWidth * 0.0025,
          ),

        ],
      ),
    );

    // return ValueListenableBuilder<bool>(
    //   valueListenable: headerIsExpanded,
    //   builder: (_, bool _headerIsExpanded, Widget child){
    //
    //     // if (_headerIsExpanded == true){
    //       return child;
    //     // }
    //     //
    //     // else {
    //     //   return const SizedBox();
    //     // }
    //
    //   },
    //   child: Container(
    //     height: flyerBoxWidth * 0.3,
    //     width: flyerBoxWidth,
    //     color: Colorz.black80,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //
    //         /// BUSINESS NAME
    //         SuperVerse(
    //           verse: firstLine,
    //           size: 5,
    //           shadow: true,
    //           maxLines: 2,
    //         ),
    //
    //         /// BUSINESS LOCALE
    //         SuperVerse(
    //           verse: secondLine,
    //           italic: true,
    //           weight: VerseWeight.regular,
    //           color: Colorz.white200,
    //         ),
    //
    //       ],
    //     ),
    //   ),
    // );

  }
/// --------------------------------------------------------------------------
}
