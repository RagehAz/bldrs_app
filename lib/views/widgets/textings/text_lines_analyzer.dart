import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:flutter/material.dart';

class TextLinesAnalyzer extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final int maxLines;
  final Widget childAfterMaxLines;
  final Widget childBeforeMaxLines;

  const TextLinesAnalyzer({
    @required this.text,
    @required this.textStyle,
    @required this.maxLines,
    @required this.childAfterMaxLines,
    @required this.childBeforeMaxLines,
});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, size){

        final _span = TextSpan(
          text: text,
          style: textStyle,
        );

        final _textPainter = TextPainter(
          text: _span,
          maxLines: maxLines,
          textDirection: superTextDirectionSwitcher(text),
        );

        _textPainter.layout(maxWidth: size.maxWidth);

        // print('_textPainter.width : ${_textPainter.width}');
        // print('widget.textController.text : ${widget.textController.text}');

        if (_textPainter.didExceedMaxLines) {
          return
            childAfterMaxLines;
        }

        else {

          return
            childBeforeMaxLines;

        }

      },
    );
  }
}
