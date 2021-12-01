import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DreamBoxGradient extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius corners;

  const DreamBoxGradient({
    @required this.width,
    @required this.height,
    @required this.corners,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        // color: Colorz.Grey,
        borderRadius: corners,
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colorz.black0, Colorz.black125],
            stops: <double>[0.5, 0.95]),
      ),
    );
  }
}
