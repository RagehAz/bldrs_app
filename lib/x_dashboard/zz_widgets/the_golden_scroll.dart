import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

class GoldenScroll extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GoldenScroll({
    @required this.headline,
    @required this.text,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String headline;
  final String text;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = Scale.superScreenWidth(context) * 0.7;

    return InkWell(
      onTap: () => Keyboard.copyToClipboard(context: context, copy: text),
      child: Container(
        width: _width,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: Borderers.constantCornersAll10,
          border: Border.all(
              width: 0.5,
              color: Colorz.yellow80,
          ),
          color: Colorz.yellow20,
        ),
        child: Column(
          children: <Widget>[

            SuperVerse(
              verse: Verse(
                text: headline,
                translate: false,
              ),
              color: Colorz.yellow255,
              weight: VerseWeight.thin,
              italic: true,
            ),

            SelectableText(
              text,
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
      ),
    );
  }
}
