import 'dart:math' as math;
import 'package:flutter/material.dart';

class BldrsArcText extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BldrsArcText({
    required this.radius,
    required this.text,
    required this.textStyle,
    required this.startAngle,
    required this.appIsLTR,
    super.key,
  });
  // --------------------
  final double radius;
  final String text;
  final double startAngle;
  final TextStyle textStyle;
  final bool appIsLTR;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context){

    /// ENGLISH => LTR
    if (appIsLTR == true){
      return CustomPaint(
        painter: _LTRPainter(
          radius: radius,
          text: text,
          textStyle: textStyle,
          initialAngle: startAngle,
        ),
      );
    }

    /// ARABIC => RTL
    else {

      final double _extraAngle = text.split(' ').length == 1 ? -0.2 : 0;
      return CustomPaint(
          painter: _RTLPainter(
            radius: radius,
            text: text,
            textStyle: textStyle,
            initialAngle: startAngle + _extraAngle,
            offsetFromBorder: 10,
            spacingMultiplier: 1.6,
          )
      );
    }

  }
  // --------------------------------------------------------------------------
}

class _LTRPainter extends CustomPainter {

  _LTRPainter({
    required this.radius,
    required this.text,
    required this.textStyle,
    this.initialAngle = 0
  });

  final num radius;
  final String text;
  final double initialAngle;
  final TextStyle textStyle;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2 - radius);

    if (initialAngle != 0) {
      final d = 2 * radius * math.sin(initialAngle / 2);
      final rotationAngle = _calculateRotationAngle(0, initialAngle);
      canvas.rotate(rotationAngle);
      canvas.translate(d, 0);
    }

    double angle = initialAngle;
    for (int i = 0; i < text.length; i++) {
      angle = _drawLetter(canvas, text[i], angle);
    }
  }

  double _drawLetter(Canvas canvas, String letter, double prevAngle) {
    _textPainter.text = TextSpan(text: letter, style: textStyle);
    _textPainter.layout(
      // minWidth: 0,
      maxWidth: double.maxFinite,
    );

    final double d = _textPainter.width;
    final double alpha = 2 * math.asin(d / (2 * radius));

    final newAngle = _calculateRotationAngle(prevAngle, alpha);
    canvas.rotate(newAngle);

    _textPainter.paint(canvas, Offset(0, -_textPainter.height));
    canvas.translate(d, 0);

    return alpha;
  }

  double _calculateRotationAngle(double prevAngle, double alpha) =>
      (alpha + prevAngle) / 2;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}

class _RTLPainter extends CustomPainter {
  // --------------------------------------------------------------------------
  _RTLPainter({
    required this.radius,
    required this.text,
    required this.textStyle,
    required this.initialAngle,
    required this.offsetFromBorder,
    required this.spacingMultiplier,
  });
  // --------------------
  final double radius;
  final String text;
  final TextStyle textStyle;
  final double initialAngle;
  final double offsetFromBorder;
  final double spacingMultiplier;
  // --------------------------------------------------------------------------
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    final words = text.split(' ');
    final int wordCount = words.length;
    final double spaceBetweenWords = textStyle.fontSize! * spacingMultiplier;

    final double totalTextWidth = _calculateTotalTextWidth(words) + (wordCount - 1) * spaceBetweenWords;
    final double circumference = 2 * math.pi * (radius + offsetFromBorder);
    final double angleIncrement = totalTextWidth / circumference * 2 * math.pi;
     // Adjusted to subtract angle Increment / 2
    double currentAngle = initialAngle - angleIncrement / 1.9;

    canvas.rotate(-math.pi / 3);

    for (int i = wordCount - 1; i >= 0; i--) {
      final word = words[i];
      final double wordWidth = _measureTextWidth(word, textStyle);

      final double dx = (radius + offsetFromBorder) * math.cos(currentAngle);
      final double dy = (radius + offsetFromBorder) * math.sin(currentAngle);

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(math.pi / 2 + currentAngle);
      _drawText(canvas, word);
      canvas.restore();

      final double _waw = i == 1 ? 3 : 0;

      currentAngle += (wordWidth + spaceBetweenWords + _waw) / (radius + offsetFromBorder);
    }
  }

  void _drawText(Canvas canvas, String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final double dx = -textPainter.width / 2;
    final double dy = -textPainter.height / 2;
    textPainter.paint(canvas, Offset(dx, dy));
  }

  double _calculateTotalTextWidth(List<String> words) {
    double totalWidth = 0;
    for (final word in words) {
      totalWidth += _measureTextWidth(word, textStyle) * 2;
    }
    return totalWidth;
  }

  double _measureTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width * 0.2;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
  // --------------------------------------------------------------------------
}
