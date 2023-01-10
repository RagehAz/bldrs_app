import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/d_heroic_flyer_big_view.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/e_heroic_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:widget_fader/widget_fader.dart';

class HeroicSmallFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeroicSmallFlyer({
    @required this.renderedFlyer,
    @required this.flyerBoxWidth,
    @required this.heroTag,
    this.onMoreTap,
    this.flightTweenValue = 0,
    this.flightDirection = FlightDirection.non,
    this.canBuildBigFlyer = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel renderedFlyer;
  final Function onMoreTap;
  final double flightTweenValue;
  final FlightDirection flightDirection;
  final String heroTag;
  final bool canBuildBigFlyer;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  double _bakeTweenValue({
    @required BuildContext context,
  }){
    double _opacity = 1;

    if (flightDirection == FlightDirection.non){
      final bool _isFullScreen = flyerBoxWidth == Scale.screenWidth(context);
      _opacity = _isFullScreen == true ? 1 : 0;
    }
    else {
      _opacity = flightTweenValue;
    }

    return _opacity;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _openFullScreenFlyer({
    @required BuildContext context,
    @required bool flyerIsBigNow,
  }) async {

    if (flyerIsBigNow == false){

      unawaited(Sounder.playAssetSound(BldrsThemeSounds.whip_high));

      // flyerModel.blogFlyer(invoker: '_openFullScreenFlyer');

      unawaited(recordFlyerView(
        index: 0,
        flyerModel: renderedFlyer,
      ));

      final FlyerModel _renderBigFlyer = await FlyerProtocols.renderBigFlyer(
        context: context,
        flyerModel: renderedFlyer,
      );

      await context.pushTransparentRoute(
          HeroicFlyerBigView(
            key: const ValueKey<String>('Flyer_Full_Screen'),
            renderedFlyer: _renderBigFlyer,
            flyerBoxWidth: flyerBoxWidth,
            heroPath: heroTag,
          )
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  FadeType _getFadeType({
    @required bool flyerIsBigNow,
  }){
    return flyerIsBigNow == true ? FadeType.fadeOut : FadeType.stillAtMax;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Duration _getFadeDuration({
    @required bool flyerIsBigNow,
  }){
    return flyerIsBigNow == true ? const Duration(milliseconds: 500) : const Duration(milliseconds: 300);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tweenValue = _bakeTweenValue(context:  context);

    final bool _flyerIsBigNow = FlyerDim.checkFlyerIsFullScreen(context, flyerBoxWidth) == true
        && flightDirection == FlightDirection.non
        && _tweenValue == 1;

    final FadeType _fadeType = _getFadeType(flyerIsBigNow: _flyerIsBigNow);
    final Duration _duration = _getFadeDuration(flyerIsBigNow: _flyerIsBigNow);

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    return FlyerBox(
      key: const ValueKey<String>('StaticFlyer'),
      flyerBoxWidth: flyerBoxWidth,
      // boxColor: flyerModel.slides[0].midColor,
      onTap: () => _openFullScreenFlyer(
        context: context,
        flyerIsBigNow: _flyerIsBigNow,
      ),
      stackWidgets: <Widget>[

        /// STATIC SINGLE SLIDE
        WidgetFader(
          fadeType: _fadeType,
          duration: _duration,
          child: SingleSlide(
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth),
            slideModel: renderedFlyer?.slides?.first,
            tinyMode: false,
            onSlideNextTap: null,
            onSlideBackTap: null,
            onDoubleTap: null,
            canTapSlide: false,
            blurLayerIsOn: true,
            slideShadowIsOn: true,
            canAnimateMatrix: true,
            canUseFilter: true,
            canPinch: false,
          ),
        ),

        /// STATIC HEADER
        WidgetFader(
          fadeType: _fadeType,
          duration: _duration,
          child: StaticHeader(
            flyerBoxWidth: flyerBoxWidth,
            bzModel: renderedFlyer.bzModel,
            bzImageLogo: renderedFlyer?.bzLogoImage,
            authorID: renderedFlyer?.authorID,
            flyerShowsAuthor: renderedFlyer?.showsAuthor,
            flightTweenValue: _tweenValue,
            flightDirection: flightDirection,
            // onTap: ,
          ),
        ),

        /// STATIC FOOTER
        WidgetFader(
          fadeType: _fadeType,
          duration: _duration,
          child: StaticFooter(
            flyerBoxWidth: flyerBoxWidth,
            isSaved: UserModel.checkFlyerIsSaved(
              userModel: _myUserModel,
              flyerID: renderedFlyer?.id,
            ),
            onMoreTap: onMoreTap,
            flightTweenValue: _tweenValue,
          ),
        ),

        // ----------------------------------<<
       /// TASK : FIX FLYER REBUILDING & ANIMATION FLICKERING ISSUE
        /*
            - will revisit widget matrix animator and flyer building issue that flickers animation later
            - its because BigFlyer widget gets called twice with each SmallFlyer Build
            - because Hero animation starts animation with tween value 1 then 0 then moves to 1 again
            - so the first 1 fires BigFlyer then the second 1 fires BigFlyer Again
        */
        // ----------------------------------<<
        /// BIG FLYER
        HeroicBigFlyer(
          heroPath: heroTag,
          flyerBoxWidth: flyerBoxWidth,
          renderedFlyer: renderedFlyer,
          canBuild: canBuildBigFlyer == true && _flyerIsBigNow == true,
          showGallerySlide: canShowGalleryPage(
            bzModel: renderedFlyer?.bzModel,
            canShowGallerySlide: checkFlyerHeroTagHasGalleryFlyerID(heroTag),
          ),
        ),
        /// -------
        // FutureBuilder(
        //   future: Future<void>.delayed(const Duration(milliseconds: 300)),
        //   builder: (_, AsyncSnapshot<void> snapshot) {
        //
        //     if (snapshot.connectionState == ConnectionState.done){
        //       return BigFlyer(
        //         heroPath: heroTag,
        //         flyerBoxWidth: flyerBoxWidth,
        //         flyerModel: flyerModel,
        //         bzModel: bzModel,
        //         canBuild: canBuildBigFlyer == true && _flyerIsBigNow == true,
        //       );
        //     }
        //
        //     else {
        //       return const SizedBox.shrink();
        //     }
        //     },
        // ),
        /// -------
        // WidgetFader(
        //   fadeType: FadeType.fadeIn,
        //   duration: const Duration(milliseconds: 200),
        //   child: BigFlyer(
        //       heroPath: heroTag,
        //       flyerBoxWidth: flyerBoxWidth,
        //       flyerModel: flyerModel,
        //       bzModel: bzModel,
        //       canBuild: canBuildBigFlyer == true && _flyerIsBigNow == true
        //   ),
        // ),
        /// -------
      ],
    );

  }
  /// --------------------------------------------------------------------------
}
