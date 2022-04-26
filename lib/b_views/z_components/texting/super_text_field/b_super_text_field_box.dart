import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class SuperTextFieldBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperTextFieldBox({
    @required this.child,
    @required this.width,
    @required this.height,
    @required this.margins,
    @required this.corners,
    @required this.fieldColor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final double width;
  final double height;
  final dynamic margins;
  final double corners;
  final Color fieldColor;
  /// --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      margin: superMargins(margins: margins),
      decoration: BoxDecoration(
        borderRadius: superBorderAll(context, corners),
        color: fieldColor,
      ),
      alignment: Alignment.topCenter,
      child: child,
    );

  }
}
