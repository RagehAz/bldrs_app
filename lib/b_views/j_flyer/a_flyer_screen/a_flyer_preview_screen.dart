// ignore_for_file: unused_element
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/animators/widgets/widget_waiter.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/a_flyer_reviews_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_light_flyer_structure/b_light_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/future_model_builders/flyer_builder.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class FlyerPreviewScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerPreviewScreen({
    required this.flyerID,
    this.reviewID,
    super.key,
  });
  /// --------------------------------------------------------------------------
  final String? flyerID;
  final String? reviewID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

    final double _flyerWidth = ZGridScale.getBigItemWidth(
      gridWidth: _screenWidth,
      gridHeight: _screenHeight,
      itemAspectRatio: FlyerDim.flyerAspectRatio(),
    );

    return MainLayout(
      onBack: () => BldrsNav.backFromPreviewScreen(),
      skyType: SkyType.non,
      appBarType: AppBarType.non,
      // pyramidsAreOn: false,
      child: WidgetWaiter(
          waitDuration: const Duration(milliseconds: 500),
          child: FlyerBuilder(
              flyerBoxWidth: _flyerWidth,
              slidePicType: SlidePicType.med,
              onlyFirstSlide: false,
              flyerID: flyerID,
              renderFlyer: RenderFlyer.allSlides,
              onFlyerInitialLoaded: (FlyerModel? flyer) async {

                if (reviewID != null){

                  await Nav.goToNewScreen(
                    context: context,
                    screen: FlyerReviewsScreen(
                      flyerModel: flyer,
                      highlightReviewID: reviewID,
                    ),
                  );

                }

              },
              builder: (bool loading, FlyerModel? flyerModel) {

                if (loading == true && flyerModel == null){
                  return const LoadingFullScreenLayer();
                }

                else if (flyerModel == null){
                  return const _NoFlyerFoundView();
                }

                else {
                  return WidgetFader(
                    fadeType: FadeType.fadeIn,
                    duration: const Duration(milliseconds: 500),
                    child: DismissiblePage(
                      onDismissed: () => Nav.goBack(context: context),
                      child: LightBigFlyer(
                        flyerBoxWidth: _flyerWidth,
                        renderedFlyer: flyerModel,
                        onVerticalExit: () => BldrsNav.backFromPreviewScreen(),
                        onHorizontalExit: (){},
                      ),
                    ),
                  );
                }

              }
              ),
        ),
    );

    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: Colorz.black255,
    //     body: WidgetWaiter(
    //       waitDuration: const Duration(milliseconds: 500),
    //       child: FlyerBuilder(
    //           flyerBoxWidth: _flyerWidth,
    //           slidePicType: SlidePicType.med,
    //           onlyFirstSlide: false,
    //           flyerID: flyerID,
    //           renderFlyer: RenderFlyer.allSlides,
    //           onFlyerInitialLoaded: (FlyerModel? flyer) async {
    //
    //             if (reviewID != null){
    //
    //               await Nav.goToNewScreen(
    //                 context: context,
    //                 screen: FlyerReviewsScreen(
    //                   flyerModel: flyer,
    //                   highlightReviewID: reviewID,
    //                 ),
    //               );
    //
    //             }
    //
    //           },
    //           builder: (bool loading, FlyerModel? flyerModel) {
    //
    //             if (loading == true && flyerModel == null){
    //               return const LoadingFullScreenLayer();
    //             }
    //
    //             else if (flyerModel == null){
    //               return const _NoFlyerFoundView();
    //             }
    //
    //             else {
    //               return WidgetFader(
    //                 fadeType: FadeType.fadeIn,
    //                 duration: const Duration(milliseconds: 500),
    //                 child: DismissiblePage(
    //                   onDismissed: () => Nav.goBack(context: context),
    //                   child: LightBigFlyer(
    //                     flyerBoxWidth: _flyerWidth,
    //                     renderedFlyer: flyerModel,
    //                     onVerticalExit: (){},
    //                     onHorizontalExit: (){},
    //                   ),
    //                 ),
    //               );
    //             }
    //
    //           }
    //           ),
    //     ),
    //   ),
    // );

  }
}

class _NoFlyerFoundView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _NoFlyerFoundView({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _shortest = Scale.screenShortestSide(context);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[

        const Sky(
          skyType: SkyType.stars,
          skyColor: Colorz.black255,
        ),

        BldrsBox(
          height: _shortest,
          width: _shortest,
          icon: Iconz.flyer,
          bubble: false,
          opacity: 0.04,
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const BldrsText(
              verse: Verse(
                id: 'phid_flyer_not_found',
                translate: true,
              ),
              size: 3,
              maxLines: 2,
            ),

            BldrsBox(
              width: _shortest * 0.5,
              height: 50,
              icon: Iconizer.superBackIcon(context),
              color: Colorz.white20,
              iconSizeFactor: 0.7,
              verse: const Verse(id: 'phid_go_back', translate: true),
              onTap: () => Nav.goBack(context: context),
              margins: 20,
            ),

          ],
        ),

        const Pyramids(
          pyramidType: PyramidType.crystalYellow,
          listenToHideLayout: false,
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
