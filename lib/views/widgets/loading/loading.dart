import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double size;
  final Function onTap;
  final bool loading;

  Loading({
    this.size = 50,
    this.onTap,
    this.loading,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        color: Colorz.Nothing,
        child: Center(
          child:
          loading == true ?
          SpinKitPulse(
            color: Colorz.Yellow,
            size: size,

          ) : Container()
          ,
        ),
      ),
    );
  }
}


class LoadingFullScreenLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: superScreenWidth(context),
        height: superScreenWidth(context),
        child: Center(child: Loading()));
  }
}
