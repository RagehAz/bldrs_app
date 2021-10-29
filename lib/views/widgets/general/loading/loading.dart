import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// -----------------------------------------------------------------------------
class Loading extends StatelessWidget {
  final double size;
  final Function onTap;
  final bool loading;

  const Loading({
    this.size = 50,
    this.onTap,
    @required this.loading,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        color: Colorz.nothing,
        child: Center(
          child:
          loading == true ?
          SpinKitPulse(
            color: Colorz.yellow255,
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
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenWidth(context),
        child: const Center(child: const Loading(loading: true,)));
  }
}
