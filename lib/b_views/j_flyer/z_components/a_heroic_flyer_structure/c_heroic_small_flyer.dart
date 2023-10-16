import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/a_heroic_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/d_heroic_flyer_big_view.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/e_heroic_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/top_button/top_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class HeroicSmallFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeroicSmallFlyer({
    required this.renderedFlyer,
    required this.flyerBoxWidth,
    required this.heroTag,
    required this.gridHeight,
    required this.gridWidth,
    this.onMoreTap,
    this.flightDirection = FlightDirection.non,
    this.canBuildBigFlyer = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel? renderedFlyer;
  final Function? onMoreTap;
  final FlightDirection flightDirection;
  final String heroTag;
  final bool canBuildBigFlyer;
  final double gridWidth;
  final double gridHeight;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _openFullScreenFlyer({
    required BuildContext context,
    required bool flyerIsBigNow,
    required FlyerModel? smallRenderedFlyer,
    required double flyerBowWidth,
    required String heroTag,
  }) async {

    if (flyerIsBigNow == false){

      unawaited(recordFlyerView(
        index: 0,
        flyerModel: smallRenderedFlyer,
      ));

      // unawaited(Sounder.playSound(
      //     mp3Asset: BldrsThemeSounds.whip_high,
      //     wavAssetForAndroid: BldrsThemeSounds.whip_high_wav,
      // ));

      await getMainContext().pushTransparentRoute(
          HeroicFlyerBigView(
            key: const ValueKey<String>('Flyer_Full_Screen'),
            renderedFlyer: smallRenderedFlyer,
            flyerBoxWidth: flyerBowWidth,
            heroPath: heroTag,
          ),
        transitionDuration: HeroicFlyer.heroDuration,
        reverseTransitionDuration: HeroicFlyer.heroDuration,
        backgroundColor: Colorz.black125,
      );

    }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    // final double _tweenValue = _bakeTweenValue(context:  context);

    final bool _flyerIsFullScreen = FlyerDim.checkFlyerIsFullScreen(
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      flyerBoxWidth: flyerBoxWidth,
    );

    final bool _flyerIsBigNow = _flyerIsFullScreen == true && flightDirection == FlightDirection.non;
    // && _tweenValue == 1;

    // final FadeType _fadeType = _getFadeType(flyerIsBigNow: _flyerIsBigNow);
    // final Duration _duration = _getFadeDuration(flyerIsBigNow: _flyerIsBigNow);
    //
    // final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
    //   context: context,
    //   listen: true,
    // );

    final List<SlideModel> _slides = renderedFlyer?.slides ?? <SlideModel>[];
    final SlideModel? _firstSlide = Mapper.checkCanLoopList(_slides) == true ? _slides.first : null;

    return FlyerBox(
      key: const ValueKey<String>('StaticFlyer'),
      flyerBoxWidth: flyerBoxWidth,
      // boxColor: flyerModel.slides[0].midColor,
      onTap: () => _openFullScreenFlyer(
        context: context,
        flyerIsBigNow: _flyerIsBigNow,
        flyerBowWidth: flyerBoxWidth,
        heroTag: heroTag,
        smallRenderedFlyer: renderedFlyer,
      ),
      stackWidgets: <Widget>[

        /// STATIC SINGLE SLIDE
        if (_flyerIsBigNow == false && _firstSlide != null)
        SingleSlide(
          flyerBoxWidth: flyerBoxWidth,
          flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
            flyerBoxWidth: flyerBoxWidth,
          ),
          slideModel: _firstSlide,
          slidePicType: SlidePicType.small,
          loading: false,
          tinyMode: false,
          onSlideNextTap: null,
          onSlideBackTap: null,
          onDoubleTap: null,
          canTapSlide: false,
          slideShadowIsOn: true,
          // canAnimateMatrix: true,
          canUseFilter: false,
          canPinch: false,
        ),

        /// STATIC HEADER
        if (_flyerIsBigNow == false)
        StaticHeader(
          flyerBoxWidth: flyerBoxWidth,
          bzModel: renderedFlyer?.bzModel,
          bzImageLogo: renderedFlyer?.bzLogoImage,
          authorID: renderedFlyer?.authorID,
          flyerShowsAuthor: renderedFlyer?.showsAuthor,
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
        TopButton(
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
  // -----------------------------------------------------------------------------
}

// class XHeroicSmallFlyer extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const XHeroicSmallFlyer({
//     required this.renderedFlyer,
//     required this.flyerBoxWidth,
//     required this.heroTag,
//     required this.gridHeight,
//     required this.gridWidth,
//     this.onMoreTap,
//     this.flightDirection = FlightDirection.non,
//     this.canBuildBigFlyer = false,
//     super.key
//   });
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   final FlyerModel? renderedFlyer;
//   final Function? onMoreTap;
//   final FlightDirection flightDirection;
//   final String heroTag;
//   final bool canBuildBigFlyer;
//   final double gridWidth;
//   final double gridHeight;
//   /// --------------------------------------------------------------------------
//   @override
//   State<XHeroicSmallFlyer> createState() => _XHeroicSmallFlyerState();
// }
//
// class _XHeroicSmallFlyerState extends State<XHeroicSmallFlyer> {
//   // -----------------------------------------------------------------------------
//   /// --- LOADING
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // --------------------
//   Future<void> _triggerLoading({required bool setTo}) async {
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//     );
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       asyncInSync(() async {
//
//         await _triggerLoading(setTo: true);
//         /// GO BABY GO
//         await _triggerLoading(setTo: false);
//
//       });
//
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   /*
//   @override
//   void didUpdateWidget(TheStatefulScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.thing != widget.thing) {
//       unawaited(_doStuff());
//     }
//   }
//    */
//   // --------------------
//   @override
//   void dispose() {
//     _loading.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _openFullScreenFlyer({
//     required BuildContext context,
//     required bool flyerIsBigNow,
//     required ValueNotifier<bool> loading,
//   }) async {
//
//     if (flyerIsBigNow == false){
//
//       await _triggerLoading(setTo: true);
//
//       // flyerModel.blogFlyer(invoker: '_openFullScreenFlyer');
//
//       unawaited(recordFlyerView(
//         index: 0,
//         flyerModel: widget.renderedFlyer,
//       ));
//
//       // final FlyerModel? _renderBigFlyer = await FlyerProtocols.renderSmallFlyer(
//       //   flyerModel: widget.renderedFlyer,
//       //   onlyFirstSlide: false,
//       //   onRenderEachSlide: (FlyerModel flyer){},
//       // );
//
//       await _triggerLoading(setTo: false);
//
//       // unawaited(Sounder.playSound(
//       //     mp3Asset: BldrsThemeSounds.whip_high,
//       //     wavAssetForAndroid: BldrsThemeSounds.whip_high_wav,
//       // ));
//
//       await getMainContext().pushTransparentRoute(
//           HeroicFlyerBigView(
//             key: const ValueKey<String>('Flyer_Full_Screen'),
//             renderedFlyer: widget.renderedFlyer,
//             flyerBoxWidth: widget.flyerBoxWidth,
//             heroPath: widget.heroTag,
//           ),
//         transitionDuration: HeroicFlyer.heroDuration,
//         reverseTransitionDuration: HeroicFlyer.heroDuration,
//         backgroundColor: Colorz.black125,
//       );
//
//     }
//
//   }
//   // --------------------
//   @override
//   Widget build(BuildContext context) {
//
//     // final double _tweenValue = _bakeTweenValue(context:  context);
//
//     final bool _flyerIsFullScreen = FlyerDim.checkFlyerIsFullScreen(
//       gridWidth: widget.gridWidth,
//       gridHeight: widget.gridHeight,
//       flyerBoxWidth: widget.flyerBoxWidth,
//     );
//
//     blog('_flyerIsFullScreen : $_flyerIsFullScreen');
//
//     final bool _flyerIsBigNow = _flyerIsFullScreen == true && widget.flightDirection == FlightDirection.non;
//     // && _tweenValue == 1;
//
//     // final FadeType _fadeType = _getFadeType(flyerIsBigNow: _flyerIsBigNow);
//     // final Duration _duration = _getFadeDuration(flyerIsBigNow: _flyerIsBigNow);
//     //
//     // final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
//     //   context: context,
//     //   listen: true,
//     // );
//
//     return FlyerBox(
//       key: const ValueKey<String>('StaticFlyer'),
//       flyerBoxWidth: widget.flyerBoxWidth,
//       // boxColor: flyerModel.slides[0].midColor,
//       onTap: () => _openFullScreenFlyer(
//         context: context,
//         flyerIsBigNow: _flyerIsBigNow,
//         loading: _loading,
//       ),
//       stackWidgets: <Widget>[
//
//         /// STATIC SINGLE SLIDE
//         if (_flyerIsBigNow == false && widget.renderedFlyer?.slides?.first != null)
//         SingleSlide(
//           flyerBoxWidth: widget.flyerBoxWidth,
//           flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(
//             flyerBoxWidth: widget.flyerBoxWidth,
//           ),
//           slideModel: widget.renderedFlyer!.slides!.first,
//           slidePicType: SlidePicType.small,
//           loading: false,
//           tinyMode: false,
//           onSlideNextTap: null,
//           onSlideBackTap: null,
//           onDoubleTap: null,
//           canTapSlide: false,
//           slideShadowIsOn: true,
//           // canAnimateMatrix: true,
//           canUseFilter: false,
//           canPinch: false,
//         ),
//
//         /// STATIC HEADER
//         if (_flyerIsBigNow == false)
//         StaticHeader(
//           flyerBoxWidth: widget.flyerBoxWidth,
//           bzModel: widget.renderedFlyer?.bzModel,
//           bzImageLogo: widget.renderedFlyer?.bzLogoImage,
//           authorID: widget.renderedFlyer?.authorID,
//           flyerShowsAuthor: widget.renderedFlyer?.showsAuthor,
//           // onTap: ,
//         ),
//
//         /// STATIC FOOTER
//         if (_flyerIsBigNow == false)
//         StaticFooter(
//           flyerBoxWidth: widget.flyerBoxWidth,
//           flyerID: widget.renderedFlyer?.id,
//           optionsButtonIsOn: false,
//         ),
//
//         /// AFFILIATE BUTTON
//         FlyerAffiliateButton(
//           flyerBoxWidth: widget.flyerBoxWidth,
//           flyerModel: widget.renderedFlyer,
//           inStack: true,
//         ),
//
//         /// BIG FLYER
//         if (widget.canBuildBigFlyer == true && _flyerIsBigNow == true)
//         HeroicBigFlyer(
//           heroPath: widget.heroTag,
//           flyerBoxWidth: widget.flyerBoxWidth,
//           renderedFlyer: widget.renderedFlyer,
//           canBuild: widget.canBuildBigFlyer == true && _flyerIsBigNow == true,
//           showGallerySlide: canShowGalleryPage(
//             bzModel: widget.renderedFlyer?.bzModel,
//             canShowGallerySlide: checkFlyerHeroTagHasGalleryFlyerID(widget.heroTag),
//           ),
//         ),
//
//         /// LOADING LAYER
//         ValueListenableBuilder(
//             valueListenable: _loading,
//             builder: (_, bool loading, Widget? child){
//
//               if (loading == true){
//                 return child!;
//               }
//
//               else {
//                 return const SizedBox();
//               }
//
//             },
//           child: FlyerLoading(
//             flyerBoxWidth: widget.flyerBoxWidth,
//             animate: true,
//             loadingColor: Colorz.white50,
//             boxColor: Colorz.black50,
//           ),
//         ),
//
//       ],
//     );
//
//   }
//   // -----------------------------------------------------------------------------
// }
