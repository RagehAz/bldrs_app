import 'package:basics/animators/helpers/animators.dart';
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';

class Loading extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Loading({
    required this.loading,
    this.size = 50,
    this.color = Colorz.yellow255,
    this.isBlackHole = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double size;
  final bool loading;
  final Color color;
  final bool isBlackHole;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN IS LOADING => TRUE
    if (loading == true) {
      return LoadingBlackHole(
        size: size,
        rpm: 400,
      );
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
    super.key
  });
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
        builder: (double val, Widget? child) {
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

      builder: (double val, Widget? child) {
        return Transform.rotate(
          angle: Numeric.degreeToRadian(360 * val)!,
          child: child,
        );
      },
    );

  }
  // -----------------------------------------------------------------------------
}
