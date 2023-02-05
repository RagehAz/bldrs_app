import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';

class TextLinesAnalyzer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TextLinesAnalyzer({
    @required this.text,
    @required this.textStyle,
    @required this.maxLines,
    @required this.childIfExceededMaxLines,
    @required this.childIfWithinMaxLines,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String text;
  final TextStyle textStyle;
  final int maxLines;
  final Widget childIfExceededMaxLines;
  final Widget childIfWithinMaxLines;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints size) {

        final TextSpan _span = TextSpan(
          text: text,
          style: textStyle,
        );

        final TextPainter _textPainter = TextPainter(
          text: _span,
          maxLines: maxLines,
          textDirection: TextDir.autoSwitchTextDirection(
            val: text,
            context: context,
            appIsLTR: UiProvider.checkAppIsLeftToRight(context)
          ),
        );

        _textPainter.layout(maxWidth: size.maxWidth);

        // print('_textPainter.width : ${_textPainter.width}');
        // print('widget.textController.text : ${widget.textController.text}');

        if (_textPainter.didExceedMaxLines) {
          return childIfExceededMaxLines;
        }

        else {
          return childIfWithinMaxLines;
        }

      },
    );

  }
  /// --------------------------------------------------------------------------
}
