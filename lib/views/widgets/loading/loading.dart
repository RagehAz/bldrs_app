import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// // LOADING BLOCK -----------------------------------------------------------
/// bool _loading = false;
/// void _triggerLoading(){
///   print('loading------------------');
///   setState(() {
///     _loading = !_loading;
///   });
///   print('loading complete --------');
///
/// }
/// // -------------------------------------------------------------------------

class Loading extends StatelessWidget {
  final double size;
  final Function onTap;
  final bool loading;

  Loading({
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
        color: Colorz.Nothing,
        child: Center(
          child:
          loading == true ?
          SpinKitPulse(
            color: Colorz.Yellow225,
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
        child: Center(child: Loading(loading: true,)));
  }
}
