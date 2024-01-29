import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

/// OLD PROPOSAL
class SlideShadow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideShadow({
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );

    return IgnorePointer(
      child: SizedBox(
        key: const ValueKey<String>('SlideShadow'),
        width: flyerBoxWidth,
        height: _height,
        // decoration: BoxDecoration(
        //   borderRadius: Borderers.superHeaderShadowCorners(context, flyerBoxWidth),
        // ),
        // alignment: Alignment.topCenter,
        child: WebsafeSvg.asset(
          Iconz.headerShadow,
          fit: BoxFit.cover,
          width: flyerBoxWidth,
          height: _height,
          // package: Iconz.bldrsTheme,
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}

/// NEW PROPOSAL
// class SlideShadow extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SlideShadow({
//     required this.flyerBoxWidth,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double _height = FlyerDim.flyerHeightByFlyerWidth(
//       flyerBoxWidth: flyerBoxWidth,
//     );
//
//     return IgnorePointer(
//       child: WebsafeSvg.asset(
//         Iconz.headerShadow,
//         fit: BoxFit.cover,
//         width: flyerBoxWidth,
//         height: _height,
//         // package: Iconz.bldrsTheme,
//       ),
//     );
//
//   }
// /// --------------------------------------------------------------------------
// }
