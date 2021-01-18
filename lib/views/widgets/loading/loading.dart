import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double size;

  Loading({
    this.size = 50,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      // color: Colorz.BlackSmoke,
      child: Center(
        child: SpinKitPulse(
          color: Colorz.Yellow,
          size: size,

        ),
      ),
    );
  }
}
