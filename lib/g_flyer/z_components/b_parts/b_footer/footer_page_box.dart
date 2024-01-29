import 'package:flutter/material.dart';

class FooterPageBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterPageBox({
    required this.width,
    required this.height,
    required this.borders,
    required this.child,
    required this.alignment,
    required this.scrollerIsOn,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BorderRadius borders;
  final double width;
  final double height;
  final Widget child;
  final Alignment alignment;
  final bool scrollerIsOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.zero,

      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: <Widget>[

        ClipRRect(
          borderRadius: borders,
          child: Container(
            width: width,
            height: height,
            alignment: alignment,
            child: child,
          ),
        ),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
