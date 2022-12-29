import 'package:flutter/material.dart';

class LeadingDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LeadingDot({
    @required this.dotSize,
    @required this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double dotSize;
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
      padding: EdgeInsets.all(dotSize),
      margin: EdgeInsets.only(top: dotSize),
      child: dot(
        dotSize: dotSize,
        color: color,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
