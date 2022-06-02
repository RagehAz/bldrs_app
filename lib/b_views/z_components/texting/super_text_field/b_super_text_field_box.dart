import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:flutter/material.dart';

class SuperTextFieldBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperTextFieldBox({
    @required this.child,
    @required this.width,
    @required this.margins,
    @required this.corners,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final double width;
  final dynamic margins;
  final double corners;
  /// --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('SuperTextFieldBox'),
      width: width,
      margin: Scale.superMargins(margins: margins),
      decoration: BoxDecoration(
        borderRadius: Borderers.superBorderAll(context, corners),
      ),
      alignment: Alignment.topCenter,
      child: child,
    );

  }
}
