import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

import 'super_text.dart';
import 'super_text_helpers.dart';

class TextBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TextBuilder({
    @required this.text,
    this.style,
    this.highlight,
    this.lineHeight,
    this.labelColor,
    this.maxLines = 1,
    this.centered = true,
    this.highlightColor = Colorz.bloodTest,
    this.textDirection = TextDirection.ltr,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String text;
  final TextStyle style;
  final double lineHeight;
  final Color labelColor;
  final ValueNotifier<dynamic> highlight;
  final int maxLines;
  final bool centered;
  final Color highlightColor;
  final TextDirection textDirection;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<TextSpan> _generateTextSpans({
    @required String verse,
    @required String highlighted,
    @required TextStyle defaultStyle,
    @required Color highlightColor,
  }){
    if (highlighted == null || highlighted.isEmpty || !verse.toLowerCase().contains(highlighted.trim().toLowerCase())) {
      return [ TextSpan(text: verse) ];
    }

    else {

      final Iterable<Match> matches = highlighted.toLowerCase().allMatches(verse.toLowerCase());
      int lastMatchEnd = 0;

      final List<TextSpan> children = <TextSpan>[];

      for (var i = 0; i < matches.length; i++) {
        final Match match = matches.elementAt(i);

        if (match.start != lastMatchEnd) {

          children.add(
              TextSpan(
                text: verse.substring(lastMatchEnd, match.start),
                style: defaultStyle,
              )
          );

        }

        children.add(
            TextSpan(
              text: verse.substring(match.start, match.end),
              style: defaultStyle.copyWith(backgroundColor: highlightColor),
            )
        );

        if (i == matches.length - 1 && match.end != verse.length) {
          children.add(
              TextSpan(
                text: verse.substring(match.end, verse.length),
                style: defaultStyle,
              )
          );
        }

        lastMatchEnd = match.end;
      }
      return children;

    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// VERSE IS NULL
    if (stringIsEmpty(text) == true){
      return const SizedBox();
    }

    /// VERSE HAS VALUE
    else {
      // --------------------
      final double _sidePaddingValues = lineHeight * 0.15;
      final double _sidePaddings = labelColor == null ? 0 : _sidePaddingValues;
      // --------------------
      final double _labelCornerValues = lineHeight * 0.3;
      final double _labelCorner = labelColor == null ? 0 : _labelCornerValues;
      // --------------------
      final TextAlign _textAlign = SuperText.getTextAlign(centered: centered);
      // --------------------
      return Flexible(
        key: const ValueKey<String>('TextBuilder'),
        child: Container(
          padding: EdgeInsets.only(
            right: _sidePaddings,
            left: _sidePaddings,
          ),
          margin: EdgeInsets.all(_sidePaddings * 0.25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_labelCorner)),
            color: labelColor,
          ),
          child:
          highlight == null ?
          Text(
            text,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            textAlign: _textAlign,
            textScaleFactor: 1,
            textDirection: textDirection,
            // locale: Localizer.getSupportedLocales()[1],
            style: style,
          )
              :
          ValueListenableBuilder(
              valueListenable: highlight,
              builder: (_, dynamic _highlight, Widget child){

                String _highLightedText ='';

                if (_highlight is TextEditingValue){
                  final TextEditingValue _t = _highlight;
                  _highLightedText = _t.text;
                }

                else if (_highlight is String){
                  _highLightedText = _highlight;
                }

                return RichText(
                  maxLines: maxLines,
                  textAlign: _textAlign,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textDirection: textDirection,
                  // textScaleFactor: 1,
                  text: TextSpan(
                    style: style,
                    children: _generateTextSpans(
                      verse: text,
                      highlighted: _highLightedText,
                      defaultStyle: style,
                      highlightColor: highlightColor,
                    ),
                  ),
                );


              }
          ),
        ),
      );
      // --------------------
    }

  }
// -----------------------------------------------------------------------------
}
