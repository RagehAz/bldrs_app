import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DreamBoxHighlight extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamBoxHighlight({
    @required this.width,
    @required this.height,
    @required this.corners,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final dynamic corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.27,
      decoration: BoxDecoration(
        // color: Colorz.White,
          borderRadius: BorderRadius.circular(Borderers.getCornersAsDouble(corners) - (height * 0.8) ),
          boxShadow: <BoxShadow>[
            Shadowz.CustomBoxShadow(
                color: Colorz.white50,
                offset: Offset(0, height * -0.33),
                blurRadius: height * 0.2
            ),
          ]
      ),
    );
  }
}
