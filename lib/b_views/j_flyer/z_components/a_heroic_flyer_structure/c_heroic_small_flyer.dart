import 'dart:async';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/d_heroic_flyer_big_view.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/e_heroic_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/flyer_affiliate_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';

class HeroicSmallFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeroicSmallFlyer({
    @required this.renderedFlyer,
    @required this.flyerBoxWidth,
    @required this.heroTag,
    @required this.gridHeight,
    @required this.gridWidth,
    this.onMoreTap,
    this.flightDirection = FlightDirection.non,
    this.canBuildBigFlyer = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel renderedFlyer;
  final Function onMoreTap;
  final FlightDirection flightDirection;
  final String heroTag;
  final bool canBuildBigFlyer;
  final double gridWidth;
  final double gridHeight;
  // --------------------------------------------------------------------------
  /*
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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _openFullScreenFlyer({
    @required BuildContext context,
    @required bool flyerIsBigNow,
  }) async {

    if (flyerIsBigNow == false){

      unawaited(Sounder.playSound(
          mp3Asset: BldrsThemeSounds.whip_high,
          wavAssetForAndroid: BldrsThemeSounds.whip_high_wav,
      )
      );

      // flyerModel.blogFlyer(invoker: '_openFullScreenFlyer');

      unawaited(recordFlyerView(
        index: 0,
        flyerModel: renderedFlyer,
      ));

      final FlyerModel _renderBigFlyer = await FlyerProtocols.renderBigFlyer(
        flyerModel: renderedFlyer,
      );

      await getMainContext().pushTransparentRoute(
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
  /*
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
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _tweenValue = _bakeTweenValue(context:  context);

    final bool _flyerIsFullScreen = FlyerDim.checkFlyerIsFullScreen(
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      flyerBoxWidth: flyerBoxWidth,
    );

    blog('_flyerIsFullScreen : $_flyerIsFullScreen');

    final bool _flyerIsBigNow = _flyerIsFullScreen == true && flightDirection == FlightDirection.non;
    // && _tweenValue == 1;

    // final FadeType _fadeType = _getFadeType(flyerIsBigNow: _flyerIsBigNow);
    // final Duration _duration = _getFadeDuration(flyerIsBigNow: _flyerIsBigNow);
    //
    // final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
    //   context: context,
    //   listen: true,
    // );

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
        if (_flyerIsBigNow == false)
        SingleSlide(
          flyerBoxWidth: flyerBoxWidth,
          flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
            flyerBoxWidth: flyerBoxWidth,
          ),
          slideModel: renderedFlyer?.slides?.first,
          tinyMode: false,
          onSlideNextTap: null,
          onSlideBackTap: null,
          onDoubleTap: null,
          canTapSlide: false,
          blurLayerIsOn: true,
          slideShadowIsOn: true,
          // canAnimateMatrix: true,
          canUseFilter: false,
          canPinch: false,
        ),

        /// STATIC HEADER
        if (_flyerIsBigNow == false)
        StaticHeader(
          flyerBoxWidth: flyerBoxWidth,
          bzModel: renderedFlyer.bzModel,
          bzImageLogo: renderedFlyer?.bzLogoImage,
          authorID: renderedFlyer?.authorID,
          flyerShowsAuthor: renderedFlyer?.showsAuthor,
          flightDirection: flightDirection,
          // onTap: ,
        ),

        /// STATIC FOOTER
        if (_flyerIsBigNow == false)
        StaticFooter(
          flyerBoxWidth: flyerBoxWidth,
          flyerID: renderedFlyer?.id,
          optionsButtonIsOn: false,
        ),

        /// AFFILIATE BUTTON
        FlyerAffiliateButton(
          flyerBoxWidth: flyerBoxWidth,
          flyerModel: renderedFlyer,
          inStack: true,
        ),

        /// BIG FLYER
        if (canBuildBigFlyer == true && _flyerIsBigNow == true)
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

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
