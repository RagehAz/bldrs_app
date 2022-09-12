import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/black_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzPgFields extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPgFields({
    @required this.flyerBoxWidth,
    @required this.bzScope,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final List<String> bzScope;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BlackBox(
      width: flyerBoxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[

          SuperVerse(
            verse: Verse(
              text: 'phid_scopeOfServices',
              translate: true,
            ),
            weight: VerseWeight.thin,
            margin: 10,
            color: Colorz.grey255,
            maxLines: 2,
          ),

          /// TASK : ADD BZ SCOPE TO BZ PAGE
          // Wrap(
          //     alignment: WrapAlignment.center,
          //     crossAxisAlignment: WrapCrossAlignment.center,
          //     runAlignment: WrapAlignment.center,
          //     children: bzScope == '' ?
          //     <Widget>[Container()]
          //         :
          //     List<Widget>.generate(1, (int index) {
          //       return SuperVerse(
          //         verse: bzScope,
          //         labelColor: Colorz.white50,
          //         margin: flyerBoxWidth * 0.02 * 0,
          //       );
          //     }
          //     )
          // ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
