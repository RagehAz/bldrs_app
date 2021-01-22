import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class FieldTag extends StatelessWidget {
  final String tagText;

  FieldTag({@required this.tagText});

  @override
  Widget build( BuildContext context) {

    double flyerTagsCornerValue = MediaQuery.of(context).size.height * 0.0073892;
    double flyerTagTextPaddingValue = MediaQuery.of(context).size.height * 0.0064542;

    return Container(
      height: MediaQuery.of(context).size.height * 0.0233990,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 3),
      padding: EdgeInsets.only(left: flyerTagTextPaddingValue, right: flyerTagTextPaddingValue),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.only(
          topLeft: Radius.circular(flyerTagsCornerValue),
          topRight: Radius.circular(flyerTagsCornerValue),
          bottomLeft: Radius.circular(flyerTagsCornerValue),
          bottomRight: Radius.circular(flyerTagsCornerValue),
        ),
        border: Border.all(width: 0.5, color: Colorz.YellowSmoke),
        color: Colorz.WhiteAir,
      ),

      child: Text(
        Wordz.keywordTag(context),
        textAlign: TextAlign.center,
        softWrap: true,
        style: TextStyle(
          color: Colorz.White,
          fontFamily: Wordz.bodyFont(context),
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.none,
          fontSize: MediaQuery.of(context).size.height * 0.013,
          letterSpacing: 0.75,

        ),
      ),

    );//<----------------------------------FLYER TYPE TAG-

  }
}

class PublishTime extends StatelessWidget {
  final String publishTimeText;

  PublishTime({@required this.publishTimeText});

  @override
  Widget build( BuildContext context) {

    double flyerTagTextPaddingValue = MediaQuery.of(context).size.height * 0.0064542;

    return Container(
      margin: const EdgeInsets.only(right: 3),
      padding: EdgeInsets.only(left: flyerTagTextPaddingValue, right: flyerTagTextPaddingValue),

      child: Text(
        Wordz.published(context),
        textAlign: TextAlign.start,

        style: TextStyle(
          color: Colorz.White,
          fontFamily: Wordz.headlineFont(context),
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.none,
          fontSize: MediaQuery.of(context).size.height * 0.0115,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class KeywordTag extends StatelessWidget {
  final String keyTagText;

  KeywordTag({@required this.keyTagText});

  @override
  Widget build( BuildContext context) {

    double flyerTagsSpacingValue = MediaQuery.of(context).size.height * 0.0024631;
    double flyerTagsCornerValue = MediaQuery.of(context).size.height * 0.0073892;
    double flyerTagTextPaddingValue = MediaQuery.of(context).size.height * 0.0064542;

    return Container(
      height: MediaQuery.of(context).size.height * 0.0233990,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: flyerTagsSpacingValue),
      padding: EdgeInsets.only(left: flyerTagTextPaddingValue, right: flyerTagTextPaddingValue),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.all(Radius.circular(flyerTagsCornerValue)),
        border: Border.all(width: 0.5, color: Colorz.WhiteGlass),
        color: Colorz.WhiteAir,
      ),

      child: Text(
        Wordz.keywordTag(context),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colorz.White,
          fontFamily: Wordz.bodyFont(context),
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.none,
          fontSize: MediaQuery.of(context).size.height * 0.013,
          letterSpacing: 0.75,

        ),
      ),

    );

  }
}



