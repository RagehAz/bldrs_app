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
    @required this.onPaste,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final double width;
  final double height;
  final dynamic margins;
  final double corners;
  final Function onPaste;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (onPaste == null){
      return Container(
        key: const ValueKey<String>('SuperTextFieldBox'),
        width: width,
        margin: Scale.superMargins(margins: margins),
        decoration: BoxDecoration(
          borderRadius: Borderers.cornerAll(context, corners),
        ),
        alignment: Alignment.topCenter,
        child: child,
      );
    }

    else {
      return const SizedBox();
      // return Container(
      //   key: const ValueKey<String>('SuperTextFieldBoxWithPaste'),
      //   width: width,
      //   margin: Scale.superMargins(margins: margins),
      //   alignment: Alignment.topCenter,
      //   child: Row(
      //     children: <Widget>[
      //
      //       child,
      //
      //       const SizedBox(
      //         width: 5,
      //         height: 5,
      //       ),
      //
      //       DreamBox(
      //         height: height,
      //         width: ,
      //       ),
      //
      //     ],
      //   ),
      // );
    }


  }
/// --------------------------------------------------------------------------
}
