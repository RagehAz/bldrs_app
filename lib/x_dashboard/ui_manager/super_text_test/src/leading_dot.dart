import 'package:flutter/material.dart';

class LeadingDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LeadingDot({
    @required this.lineHeight,
    @required this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double lineHeight;
  final Color color;
  /// --------------------------------------------------------------------------
  static Widget dot({
    @required double dotSize,
    @required Color color,
  }){
    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('the_leading_dot'),
      padding: EdgeInsets.all(lineHeight * 0.2),
      // color: Colorz.bloodTest,
      // margin: EdgeInsets.only(top: lineHeight),
      child: dot(
        dotSize: lineHeight * 0.3,
        color: color,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
