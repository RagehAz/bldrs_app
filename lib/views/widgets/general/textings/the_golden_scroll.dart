import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:flutter/material.dart';
import 'super_verse.dart';

class GoldenScroll extends StatelessWidget {

  final String scrollScript;
  final String scrollTitle;

  const GoldenScroll({@required this.scrollScript, @required this.scrollTitle});

  @override
  Widget build(BuildContext context) {

    final double flyerTagsCornerValue = MediaQuery.of(context).size.height * 0.0073892;
    final double flyerTagTextPaddingValue = MediaQuery.of(context).size.height * 0.0064542;

    return
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
        padding: EdgeInsets.all(flyerTagTextPaddingValue),
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(flyerTagsCornerValue),
            topRight: Radius.circular(flyerTagsCornerValue),
            bottomLeft: Radius.circular(flyerTagsCornerValue),
            bottomRight: Radius.circular(flyerTagsCornerValue),
          ),
          border: Border.all(width: 0.5, color: Colorz.Yellow80),
          color: Colorz.Yellow20,
        ),

        child: Column(

          children: <Widget>[

            SuperVerse(
              verse: scrollTitle,
              color: Colorz.Yellow255,
              weight: VerseWeight.thin,
              italic: true,
              size: 1,
            ),

            SelectableText(
              scrollScript,
              toolbarOptions: ToolbarOptions(
                selectAll: true,
                copy: true,
              ),

              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colorz.White255,
                   fontFamily: Wordz.bodyFont(context),
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