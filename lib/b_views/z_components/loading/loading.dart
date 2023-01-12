import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Loading({
    @required this.loading,
    this.size = 50,
    this.color = Colorz.yellow255,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double size;
  final bool loading;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN IS LOADING => TRUE
    if (loading == true){

      return SizedBox(
        width: size,
        height: size,
        child: Center(
          child: SpinKitPulse(
            color: color ?? Colorz.yellow255,
            size: size,
          )
        ),
      );

    }

    /// WHEN IS NOT LOADING => FALSE
    else {
      return const SizedBox();
    }

  }
/// --------------------------------------------------------------------------
}
