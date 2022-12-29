import 'package:flutter/material.dart';
import 'super_text_helpers.dart';

class SuperTextBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperTextBox({
    @required this.onTap,
    @required this.margin,
    @required this.centered,
    @required this.leadingDot,
    @required this.redDot,
    @required this.children,
    @required this.onDoubleTap,
    @required this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final dynamic margin;
  final bool centered;
  final bool leadingDot;
  final bool redDot;
  final List<Widget> children;
  final Function onDoubleTap;
  final double width;
  /// --------------------------------------------------------------------------
  static MainAxisAlignment _getMainAxisAlignment({
    @required bool centered,
  }){
    return centered == true ?
    MainAxisAlignment.center
        :
    MainAxisAlignment.start;
  }
  // --------------------
  static CrossAxisAlignment _getCrossAxisAlignment({
    @required bool redDot,
    @required bool leadingDot,
  }){
    return
      redDot == true ?
      CrossAxisAlignment.center
          :
      leadingDot == true ?
      CrossAxisAlignment.start
          :
      CrossAxisAlignment.center;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      key: const ValueKey<String>('SuperTextBox'),
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        width: width,
        margin: superMargins(margin: margin),
        child: Row(
          mainAxisAlignment: _getMainAxisAlignment(centered: centered,),
          crossAxisAlignment: _getCrossAxisAlignment(
            leadingDot: leadingDot,
            redDot: redDot,
          ),
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
