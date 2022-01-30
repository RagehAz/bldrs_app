import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/horizontalBouncer.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/gallery_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/single_slide.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerSlides extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSlides({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.horizontalController,
    @required this.onSwipeSlide,
    @required this.onSlideNextTap,
    @required this.onSlideBackTap,
    @required this.currentSlideIndex,
    @required this.canShowGalleryPage,
    @required this.numberOfSlides,
    this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final PageController horizontalController;
  final ValueChanged<int> onSwipeSlide;
  final Function onSlideNextTap;
  final Function onSlideBackTap;
  final ValueNotifier currentSlideIndex;
  final String heroTag;
  final bool canShowGalleryPage;
  final int numberOfSlides;
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

      return HorizontalBouncer(
        numberOfSlides: numberOfSlides,
        child: PageView.builder(
          // key: const ValueKey<String>('FlyerSlides_PageView'),
          key: const PageStorageKey<String>('FlyerSlides_PageView'),
          controller: horizontalController,
          physics: tinyMode ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
          clipBehavior: Clip.antiAlias,
          // restorationId: flyerModel.id,
          onPageChanged: (int i) => onSwipeSlide(i),
          itemCount: numberOfSlides + 1,
          itemBuilder: (_, int index){

            final bool _isRealSlides = index < flyerModel.slides.length;

            /// WHEN AT FLYER SLIDES
            if (_isRealSlides){

              final SlideModel _slide = flyerModel.slides[index];

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

            else if (index == numberOfSlides){
              return Container();
            }

            /// WHEN AT GALLERY SLIDE
            else {

              return GallerySlide(
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: flyerBoxHeight,
                flyerModel: flyerModel,
                bzModel: bzModel,
                heroTag: heroTag,
              );

            }

          },
        ),
      );

    }

  }
}
