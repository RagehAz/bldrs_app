import 'package:basics/bldrs_theme/classes/shadowers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

/// THE OLD
class SlideBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideBox({
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.tinyMode,
    required this.slideMidColor,
    required this.stackChildren,
    this.shadowIsOn = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final Color? slideMidColor;
  final List<Widget> stackChildren;
  final bool shadowIsOn;
  // -----------------------------------------------------------------------------
  bool _canTapSlide(){
    bool _canTap = false;

    if (tinyMode == false){
      _canTap = true;
    }

    return _canTap;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius _flyerBorders = FlyerDim.flyerCorners(flyerBoxWidth);

    return AbsorbPointer(
      absorbing: !_canTapSlide(),
      child: SizedBox(
        width: flyerBoxWidth,
        height: flyerBoxHeight,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[

            Container(
              width: flyerBoxWidth,
              height: flyerBoxHeight,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: _flyerBorders,
                color: slideMidColor,
                boxShadow: shadowIsOn == true ? Shadower.flyerZoneShadow : null,
                // image: slideModel.pic,
              ),
              child: ClipRRect(
                borderRadius: _flyerBorders,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: stackChildren,
                ),
              ),
            ),

          ],
        ),
      ),

    );

  }
// -----------------------------------------------------------------------------
}

/// NEW PROPOSAL
// import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
// import 'package:flutter/material.dart';
//
// class SlideBox extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SlideBox({
//     required this.flyerBoxWidth,
//     required this.flyerBoxHeight,
//     required this.tinyMode,
//     required this.slideMidColor,
//     required this.stackChildren,
//     this.shadowIsOn = false,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   final double flyerBoxHeight;
//   final bool tinyMode;
//   final Color? slideMidColor;
//   final List<Widget> stackChildren;
//   final bool shadowIsOn;
//   // -----------------------------------------------------------------------------
//   bool _canTapSlide(){
//     bool _canTap = false;
//
//     if (tinyMode == false){
//       _canTap = true;
//     }
//
//     return _canTap;
//   }
//   // --------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return TapLayer(
//       isDisabled: !_canTapSlide(),
//       width: flyerBoxWidth,
//       height: flyerBoxHeight,
//       alignment: Alignment.topCenter,
//       boxColor: slideMidColor,
//       corners: FlyerDim.flyerCorners(flyerBoxWidth),
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: stackChildren,
//       ),
//     );
//
//     /// DEPRECATED : WORKED PERFECT
//     /*
//     return AbsorbPointer(
//       absorbing: !_canTapSlide(),
//       child: SizedBox(
//         width: flyerBoxWidth,
//         height: flyerBoxHeight,
//         child: ListView(
//           physics: const NeverScrollableScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           children: <Widget>[
//
//             Container(
//               width: flyerBoxWidth,
//               height: flyerBoxHeight,
//               alignment: Alignment.topCenter,
//               decoration: BoxDecoration(
//                 borderRadius: _flyerBorders,
//                 color: slideMidColor,
//                 // boxShadow: shadowIsOn == true ? Shadower.flyerZoneShadow : null,
//                 // image: slideModel.pic,
//               ),
//               child: ClipRRect(
//                 borderRadius: _flyerBorders,
//                 child: Stack(
//                   alignment: Alignment.topCenter,
//                   children: stackChildren,
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//
//     );
//      */
//
//   }
// // -----------------------------------------------------------------------------
// }
