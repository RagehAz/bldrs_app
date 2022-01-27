import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/single_slide.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerSlides extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSlides({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.flyerModel,
    @required this.horizontalController,
    @required this.onSwipeSlide,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final FlyerModel flyerModel;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (flyerModel.slides.isEmpty){
      return Container(
        width: flyerBoxWidth,
        height: flyerBoxHeight,
        color: Colorz.white50,
      );
    }

    else {

      return PageView(
        controller: horizontalController,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.antiAlias,
        // restorationId: flyerModel.id,
        onPageChanged: (int i) => onSwipeSlide(i),
        children: <Widget>[

          ...List<Widget>.generate(flyerModel.slides.length, (int i) {

            final SlideModel _slide = flyerModel.slides[i];

            // ------------------------------------------------------o
            return Stack(
              children: <Widget>[

                SingleSlide(
                  key: const ValueKey<String>('slide_key'),
                  flyerBoxWidth: flyerBoxWidth,
                  flyerBoxHeight: flyerBoxHeight,
                  slideModel: _slide,
                  tinyMode: tinyMode,
                  onSlideNextTap: onSlideNextTap,
                  onSlideBackTap: onSlideBackTap,
                ),

                /// ---------

                // FlyerFooter(
                //   flyerBoxWidth: flyerBoxWidth,
                //   saves: superFlyer.edit.firstTimer == true ? 0
                //       :
                //   superFlyer.mSlides[superFlyer.currentSlideIndex].savesCount,
                //   shares: superFlyer.edit.firstTimer == true ? 0 : superFlyer
                //       .mSlides[superFlyer.currentSlideIndex]
                //       .sharesCount,
                //   views: superFlyer.edit.firstTimer == true ? 0
                //       :
                //   superFlyer.mSlides[superFlyer.currentSlideIndex].viewsCount,
                //   onShareTap: () => superFlyer.rec.onShareTap(),
                //   onCountersTap: () => superFlyer.rec
                //       .onCountersTap(), //onSlideCounterTap(context),
                // ),

                // /// TAP AREAS


              ],
            );
          }
          ),

        ],
      );

    }

  }
}
