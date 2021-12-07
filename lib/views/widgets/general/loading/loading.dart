import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// -----------------------------------------------------------------------------
class Loading extends StatelessWidget {
  final double size;
  final Function onTap;
  final bool loading;

  const Loading({
    @required this.loading,
    this.size = 50,
    this.onTap,
    Key key,
  }) : super(key: key);

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
  const LoadingFullScreenLayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenWidth(context),
        child: const Center(child: const Loading(loading: true,)));
  }
}
