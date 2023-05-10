import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animators/animators.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:numeric/numeric.dart';
import 'package:widget_fader/widget_fader.dart';

class Loading extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Loading({
    @required this.loading,
    this.size = 50,
    this.color = Colorz.yellow255,
    this.isBlackHole = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double size;
  final bool loading;
  final Color color;
  final bool isBlackHole;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN IS LOADING => TRUE
    if (loading == true){

      if (isBlackHole == true){
        return LoadingBlackHole(
          size: size,
          rpm: 400,
        );
      }

      else {
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

    }

    /// WHEN IS NOT LOADING => FALSE
    else {
      return const SizedBox();
    }

  }
/// --------------------------------------------------------------------------
}

class LoadingBlackHole extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LoadingBlackHole({
    this.size = 50,
    this.rpm = 350,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double size;
  final double rpm;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      fadeType: FadeType.repeatForwards,
      duration: Duration(milliseconds: (60 / rpm * 1000).round()),
      curve: Curves.linear,

      child: WidgetFader(
        fadeType: FadeType.repeatAndReverse,
        duration: Duration(milliseconds: (60 / (rpm*0.05) * 1000).round()),
        curve: Curves.slowMiddle,
        builder: (double val, Widget child) {
          return BldrsBox(
            width: size,
            height: size,
            icon: Iconz.dvBlackHole,
            iconSizeFactor: Animators.limitTweenImpact(
              maxDouble: 1.8,
              minDouble: 0,
              tweenValue: val,
            ),
            bubble: false,
            color: Colorz.black255,
            corners: size / 2,
            // greyscale: false,
          );
        },
      ),

      builder: (double val, Widget child) {
        return Transform.rotate(
          angle: Numeric.degreeToRadian(360 * val),
          child: child,
        );
      },
    );

  }
  // -----------------------------------------------------------------------------
}
