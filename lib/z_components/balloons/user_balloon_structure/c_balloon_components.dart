import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/colors/colorizer.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/loading/loading.dart';
import 'package:flutter/material.dart';

class BalloonComponents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BalloonComponents({
    required this.balloonWidth,
    required this.blackAndWhite,
    required this.pic,
    required this.child,
    this.balloonColor,
    this.loading = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double balloonWidth;
  final Color? balloonColor;
  final bool blackAndWhite;
  final bool? loading;
  final dynamic pic;
  final Widget? child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Color? _balloonColor = pic == null ? balloonColor : null;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        /// USER IMAGE LAYER
        Container(
          // color: Colorz.Yellow,
            width: balloonWidth,
            height: balloonWidth,
            color: _balloonColor,
            child: ColorFiltered(
                colorFilter: Colorizer.desaturationColorFilter(
                    isItBlackAndWhite: blackAndWhite
                ),
                child: Mapper.boolIsTrue(loading) == true ?
                Loading(loading: loading!)
                    :
                _balloonColor == null ?
                BldrsImage(
                  pic: pic,
                  width: balloonWidth,
                  height: balloonWidth,
                  // boxFit: BoxFit.cover,
                )
                    :
                Container()
            )
        ),

        /// BUTTON OVAL HIGHLIGHT
        Container(
          width: 2 * balloonWidth * 0.5 * 0.7,
          height: 1.4 * balloonWidth * 0.5 * 0.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(balloonWidth * 0.8 * 0.5, balloonWidth * 0.7 * 0.8 * 0.5)),
              color: Colorz.nothing,
              /// TOO EXPENSIVE
            // boxShadow: <CustomBoxShadow>[
            //   CustomBoxShadow(
            //       color: Colorz.white80,
            //       offset: Offset(0, balloonWidth * 0.5 * -0.5),
            //       blurRadius: balloonWidth * 0.2),
            // ]
          ),
        ),

        /// BUTTON GRADIENT
        // Container(
        //   height: balloonWidth,
        //   width: balloonWidth,
        //   decoration: BoxDecoration(
        //     gradient:
        //     RadialGradient(
        //       colors: <Color>[_bubbleDarkness(), Colorz.BlackNothing],
        //       stops: <double>[0.0, 0.3],
        //       radius: 1,
        //       center: const Alignment(0, 0),
        //       focal: const Alignment(0, 0),
        //       focalRadius: 0.5,
        //       tileMode: TileMode.mirror,
        //
        //     ),
        //
        //   ),
        //
        // ),

        /// Child
        if (child != null)
          child!,

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
