import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

class GoldenScroll extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GoldenScroll({
    @required this.scrollScript,
    @required this.scrollTitle,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String scrollScript;
  final String scrollTitle;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double flyerTagsCornerValue = MediaQuery.of(context).size.height * 0.0073892;
    final double flyerTagTextPaddingValue = MediaQuery.of(context).size.height * 0.0064542;

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      padding: EdgeInsets.all(flyerTagTextPaddingValue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(flyerTagsCornerValue),
          topRight: Radius.circular(flyerTagsCornerValue),
          bottomLeft: Radius.circular(flyerTagsCornerValue),
          bottomRight: Radius.circular(flyerTagsCornerValue),
        ),
        border: Border.all(width: 0.5, color: Colorz.yellow80),
        color: Colorz.yellow20,
      ),
      child: Column(
        children: <Widget>[

          SuperVerse(
            verse: scrollTitle,
            color: Colorz.yellow255,
            weight: VerseWeight.thin,
            italic: true,
            size: 1,
          ),

          SelectableText(
            scrollScript,
            toolbarOptions: const ToolbarOptions(
              selectAll: true,
              copy: true,
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colorz.white255,
              fontFamily: Words.bodyFont(context),
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.none,
              fontSize: MediaQuery.of(context).size.height * 0.02,
              letterSpacing: 0.75,
            ),
          ),

        ],
      ),
    );
  }
}
