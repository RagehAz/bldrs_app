import 'dart:async';

import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/bz_counter_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_footer_controller.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_header_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_flyer_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/gallery_header/gallery_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/a_flyer_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/slides_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/a_progress_bar.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/saving_notice_layer/a_saving_notice.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class HeroicBigFlyer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HeroicBigFlyer({
    required this.renderedFlyer, // will never be null at this point
    required this.heroPath,
    required this.flyerBoxWidth,
    required this.canBuild,
    required this.showGallerySlide,
    super.key
  });
  /// --------------------------------------------------------------------------
  final FlyerModel? renderedFlyer;
  final String heroPath;
  final double flyerBoxWidth;
  final bool canBuild;
  final bool showGallerySlide;
  /// --------------------------------------------------------------------------
  @override
  _HeroicBigFlyerState createState() => _HeroicBigFlyerState();
  /// --------------------------------------------------------------------------
}

class _HeroicBigFlyerState extends State<HeroicBigFlyer> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  final ValueNotifier<FlyerModel?> _flyer = ValueNotifier(null);
  final ValueNotifier<bool> _flyerIsSaved = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _followIsOn = ValueNotifier<bool>(false);
  // --------------------
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  // --------------------
  /// FOR HEADER
  late AnimationController _headerAnimationController;
  final ScrollController _headerScrollController = ScrollController();
  /// FOR SLIDES
  late PageController _horizontalSlidesController;
  /// FOR FOOTER
  final PageController _footerPageController = PageController();
  /// FOR SAVING GRAPHIC
  late AnimationController _savingAnimationController;
  // --------------------
  /// PROGRESS BAR OPACITY
  final ValueNotifier<double> _progressBarOpacity = ValueNotifier(1);
  /// HEADER IS EXPANDED
  final ValueNotifier<bool> _headerIsExpanded = ValueNotifier(false);
  /// HEADER PAGE OPACITY
  final ValueNotifier<double> _headerPageOpacity = ValueNotifier(0);
  // --------------------
  final ValueNotifier<BzCounterModel?> _bzCounters = ValueNotifier(null);
  // --------------------
  /// FOOTER
  final ValueNotifier<bool?> _infoButtonExpanded = ValueNotifier(null);
  // --------------------
  final ValueNotifier<bool> _graphicIsOn = ValueNotifier(false);
  final ValueNotifier<double> _graphicOpacity = ValueNotifier(1);
  // -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    if (widget.canBuild == true){
    blog('HH- BIG FLYER BigFlyer initState');
      _initializations();
    }

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit == true && _flyer.value != null && mounted == true) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        if (widget.canBuild == true){
          await _preparations();
        }

        await _triggerLoading(setTo: false);
        // ----------
      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(HeroicBigFlyer oldWidget) {
    if (oldWidget.canBuild != widget.canBuild){
      if (widget.canBuild == true){
        setState(() {
        _initializations();
        unawaited(_preparations());
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }
  // --------------------
  @override
  void dispose() {
    _disposeBigFlyer();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  void _initializations(){

    setNotifier(
      notifier: _flyer,
      mounted: mounted,
      value: widget.renderedFlyer,
    );

    setNotifier(
      notifier: _flyerIsSaved,
      mounted: mounted,
      value: UserModel.checkFlyerIsSaved(
        userModel: UsersProvider.proGetMyUserModel(
            context: context,
            listen: false,
        ),
        flyerID: _flyer.value?.id,
      ),
    );

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel(
        swipeDirection: SwipeDirection.next,
        index: getPossibleStartingIndex(
          flyerModel: _flyer.value,
          bzModel: _flyer.value?.bzModel,
          heroTag: widget.heroPath,
          startFromIndex: 0,
        ),
        numberOfStrips: getNumberOfSlides(
          flyerModel: _flyer.value,
          showGallerySlide: widget.showGallerySlide,
          bzModel: _flyer.value?.bzModel,
          // heroPath: widget.heroPath,

        ),
      ),
    );

    // ----------
    /// FOR HEADER
    _headerAnimationController = initializeHeaderAnimationController(
      context: context,
      vsync: this,
    );
    // ----------
    /// FOR SLIDES
    _horizontalSlidesController = PageController(initialPage: _progressBarModel.value?.index ?? 0);
    // ----------
    /// FOR FOOTER & PRICE TAG
    _horizontalSlidesController.addListener(_listenToHorizontalController);
    // ----------
    /// FOR SAVING GRAPHIC
    _savingAnimationController = AnimationController(
      vsync: this,
      duration: Ratioz.durationFading200,
      reverseDuration: Ratioz.durationFading200,
    );
    // ----------

  }
  // --------------------
  void _listenToHorizontalController(){

    final int _realSlidesLength = _flyer.value?.slides?.length ?? 1;
    final int _numberOfSlide = _realSlidesLength - 1;
    final double _totalRealSlidesWidth = widget.flyerBoxWidth * _numberOfSlide;

    final bool _reachedGallerySlide = (_horizontalSlidesController.page ?? 0) > _numberOfSlide;
    final bool _atBackBounce = _horizontalSlidesController.position.pixels < 0;

    /// WHEN AT INITIAL SLIDE
    if (_atBackBounce == true){
      final double _correctedPixels = _horizontalSlidesController.position.pixels;
      if (mounted == true){
        _footerPageController.position.correctPixels(_correctedPixels);
        _footerPageController.position.notifyListeners();
      }

    }

    /// WHEN AT LAST REAL SLIDE
    if (_reachedGallerySlide == true){
      final double _correctedPixels = _horizontalSlidesController.position.pixels - _totalRealSlidesWidth;
      if (mounted == true){
        _footerPageController.position.correctPixels(_correctedPixels);
        _footerPageController.position.notifyListeners();
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// PREPARATIONS

  // --------------------
  Future<void> _preparations() async {

    if (_flyer.value?.id  != null){

      unawaited(_imagifyFlyer());

      setNotifier(
        notifier: _bzCounters,
        mounted: mounted,
        value: BzCounterModel.createInitialModel(_flyer.value?.id),
      );

      setNotifier(
        notifier: _followIsOn,
        mounted: mounted,
        value: checkFollowIsOn(bzModel: _flyer.value?.bzModel),
      );

    }

  }
  // --------------------
  ///
  Future<void> _imagifyFlyer() async {

    if (_flyer.value != null){

      /// SMALL
      FlyerModel? _rendered = await FlyerProtocols.renderBigFlyer(
        flyerModel: _flyer.value,
        slidePicType: SlidePicType.small,
        onRenderEachSlide: (FlyerModel flyer){
          setNotifier(
            notifier: _flyer,
            mounted: mounted,
            value: flyer,
          );
        }
      );

      /// BIG
      _rendered = await FlyerProtocols.renderBigFlyer(
        flyerModel: _rendered,
        slidePicType: SlidePicType.med,
        onRenderEachSlide: (FlyerModel flyer){
          setNotifier(
            notifier: _flyer,
            mounted: mounted,
            value: flyer,
          );
        }
      );

      setNotifier(
        notifier: _flyer,
        mounted: mounted,
        value: _rendered,
      );

      // assert(_rendered != null, 'received flyer with imagified slides is null');
      // assert(_rendered.slides[_rendered.slides.length - 1].uiImage != null, 'last slide uiImage is null');

    }

  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  void _disposeBigFlyer(){

    if (widget.canBuild == true){

      _flyer.dispose();
      _loading.dispose();
      _progressBarModel.dispose();
      _flyerIsSaved.dispose();
      _headerAnimationController.dispose();
      _headerScrollController.dispose();
      _savingAnimationController.dispose();
      _horizontalSlidesController.dispose();
      _footerPageController.dispose();
      _followIsOn.dispose();
      _progressBarOpacity.dispose();
      _headerIsExpanded.dispose();
      _headerPageOpacity.dispose();
      _graphicIsOn.dispose();
      _graphicOpacity.dispose();
      _bzCounters.dispose();
    }


  }
  // -----------------------------------------------------------------------------

  /// HEADER INTERACTIONS

  // --------------------
  Future<void> _onHeaderTap() async {

    await onTriggerHeader(
      context: context,
      headerAnimationController: _headerAnimationController,
      verticalController: _headerScrollController,
      headerIsExpanded: _headerIsExpanded,
      progressBarOpacity: _progressBarOpacity,
      headerPageOpacity: _headerPageOpacity,
      mounted: mounted,
    );

    final bool _tinyMode = FlyerDim.isTinyMode(
      flyerBoxWidth: widget.flyerBoxWidth,
      gridWidth: Scale.screenWidth(context),
      gridHeight: Scale.screenHeight(context),
    );

    if (_headerIsExpanded.value  == true && _tinyMode == false){
      await readBzCounters(
        bzID: _flyer.value?.bzID,
        bzCounters: _bzCounters,
        mounted: mounted,
      );
    }

  }
  // --------------------
  Future<void> _onFollowTap() async {
    await onFollowTap(
      bzModel: _flyer.value?.bzModel,
      flyerID: _flyer.value?.id,
      followIsOn: _followIsOn,
      mounted: mounted,
    );
  }
  // --------------------
  Future<void> _onCallTap() async {
    await onCallTap(
      bzModel: _flyer.value?.bzModel,
      flyerModel: _flyer.value,
    );
  }
  // -----------------------------------------------------------------------------

  /// SWIPING

  // --------------------
  void _onSwipeSlide(int index){

    // blog('OPENING SLIDE INDEX : $index');

    unawaited(recordFlyerView(
      index: index,
      flyerModel: _flyer.value,
    ));

    ProgressBarModel.onSwipe(
      context: context,
      newIndex: index,
      progressBarModel: _progressBarModel,
      mounted: mounted,
    );

    // blog('index has become ${widget.currentSlideIndex.value}');

  }
  // --------------------
  Future<void> _onSlideNextTap() async {

    final int _lastIndex = _flyer.value?.slides?.length ?? 0;

    /// WHEN AT LAST INDEX
    if (_progressBarModel.value?.index == _lastIndex){
      // await Nav.goBack(
      //   context: context,
      //   invoker: '_onSlideNextTap',
      // );
    }

    /// WHEN AT ANY OTHER INDEX
    else {

      final int _newIndex = await Sliders.slideToNextAndGetNewIndex(
        pageController: _horizontalSlidesController,
        numberOfSlides: (_flyer.value?.slides?.length ?? 0) + 1,
        currentSlide: _progressBarModel.value?.index ?? 0,
      );

      blog('_onSlideNextTap : _newIndex : $_newIndex');
    }

  }
  // --------------------
  Future<void> _onSlideBackTap() async {

    /// WHEN AT FIRST INDEX
    if (_progressBarModel.value?.index == 0){
      // await Nav.goBack(
      //   context: context,
      //   invoker: '_onSlideBackTap',
      // );
    }

    /// WHEN AT ANY OTHER SLIDE
    else {

      final int _newIndex = await Sliders.slideToBackAndGetNewIndex(
        pageController: _horizontalSlidesController,
        currentSlide: _progressBarModel.value?.index ?? 0,
      );

      blog('onSlideBackTap _newIndex : $_newIndex');

    }

  }
  // -----------------------------------------------------------------------------

  /// FOOTER INTERACTIONS

  // --------------------
  Future<void> _onSaveFlyer() async {

    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (Authing.userIsSignedUp(_user?.signInMethod) == true){

      if (mounted == true){

        await Future.wait(<Future>[
          _triggerAnimation(!_flyerIsSaved.value),
          onSaveFlyer(
            flyerModel: _flyer.value,
            slideIndex: _progressBarModel.value?.index ?? 0,
            flyerIsSaved: _flyerIsSaved,
            mounted: mounted,
          ),
        ]);

      }

    }

    else {

      await Dialogs.youNeedToBeSignedUpDialog(
        afterHomeRouteName: RouteName.flyerPreview,
        afterHomeRouteArgument: _flyer.value?.id,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// ANIMATIONS

  // --------------------
  Future<void> _triggerAnimation(bool isSaved) async {

    if (isSaved == true){

      /// 1 - GRAPHIC IS ALREADY OFF => SWITCH ON
      setNotifier(notifier: _graphicIsOn, mounted: mounted, value: true);
      setNotifier(notifier: _graphicOpacity, mounted: mounted, value: 1.0);

      // blog('-1 - _graphicIsOn => ${_graphicIsOn.value}');

      /// 2 - ANIMATE CONTROLLER
      await _savingAnimationController.forward(from: 0);
      // blog('-2 - _animatedController => $isSaved');

      /// 3 - START FADE OUT AND WAIT FOR IT
      if (mounted){
        setNotifier(notifier: _graphicOpacity, mounted: mounted, value: 0.0);
      }
      // blog('-3 - _graphicOpacity => ${_graphicOpacity.value}');

      /// 4 - WAIT FOR FADE THEN SWITCH OFF GRAPHIC
      await Future.delayed(const Duration(milliseconds: 220), (){
        if (mounted){
          setNotifier(notifier: _graphicIsOn, mounted: mounted, value: false);
        }
        // blog('-4 - _graphicIsOn => ${_graphicIsOn.value}');
      });

      /// 5 - READY THE FADE FOR THE NEXT ANIMATION
      await Future.delayed(const Duration(milliseconds: 200), (){
        if (mounted){
          setNotifier(notifier: _graphicOpacity, mounted: mounted, value: 1.0);
        }
      });
      // blog('-5 - _canStartFadeOut => ${_graphicOpacity.value}');

    }

  }
  // --------------------
  /// DEPRECATED
  /*
    //   Future<void> _slideToZeroIndex() async {
    //     await Sliders.slideToBackFrom(_horizontalSlidesController, widget.currentSlideIndex.value);
    //   }
   */
  // --------------------
  /// DEPRECATED
  /*
  void autoAnimateToFirstSlide(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      // if (
      // widget.flightDirection == FlightDirection.pop
      //     &&
      //     _horizontalSlidesController.hasClients
      // ){
      //
      //   unawaited(_horizontalSlidesController
      //       .animateToPage(0,
      //       duration: const Duration(milliseconds: 200),
      //       curve: Curves.easeOut
      //   ));
      //
      //   widget.progressBarModel.value  = widget.progressBarModel.value.copyWith(
      //     index: 0,
      //   );
      //
      // }

    });
  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.canBuild == false){
      return const SizedBox();
    }

    else {

      final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
        flyerBoxWidth: widget.flyerBoxWidth,
      );

      final bool _tinyMode = FlyerDim.isTinyMode(
        flyerBoxWidth: widget.flyerBoxWidth,
        gridWidth: Scale.screenWidth(context),
        gridHeight: Scale.screenHeight(context),
      );

      return ValueListenableBuilder(
        valueListenable: _flyer,
        builder: (_, FlyerModel? flyerModel, Widget? savingNotice) {

          return FlyerBox(
            key: const ValueKey<String>('FullScreenFlyer'),
            flyerBoxWidth: widget.flyerBoxWidth,
            // boxColor: Colorz.bloodTest,
            stackWidgets: <Widget>[

              /// SLIDES
              SlidesBuilder(
                flyerModel: flyerModel,
                slidePicType: SlidePicType.med,
                flyerBoxWidth: widget.flyerBoxWidth,
                flyerBoxHeight: _flyerBoxHeight,
                tinyMode: false,
                horizontalController: _horizontalSlidesController,
                onSwipeSlide: _onSwipeSlide,
                onSlideBackTap: _onSlideBackTap,
                onSlideNextTap: _onSlideNextTap,
                onDoubleTap: _onSaveFlyer,
                heroTag: widget.heroPath,
                progressBarModel: _progressBarModel,
                flightDirection: FlightDirection.non,
                canTapSlides: true,
                showSlidesShadows: true,
                canAnimateSlides: true,
                onHorizontalExit: (){
                  // Nav.goBack(
                  //     context: context,
                  //     invoker: 'HeroicBigFlyer',
                  // );
                },
                onVerticalExit: (){
                  Nav.goBack(
                      context: context,
                      invoker: 'HeroicBigFlyer',
                  );
                },
                canPinch: false,
                canUseFilter: false,
                showGallerySlide: widget.showGallerySlide,
              ),

              /// HEADER
              FlyerHeader(
                flyerBoxWidth: widget.flyerBoxWidth,
                flyerModel: flyerModel,
                onHeaderTap: _onHeaderTap,
                onFollowTap: _onFollowTap,
                onCallTap: _onCallTap,
                headerAnimationController: _headerAnimationController,
                headerScrollController: _headerScrollController,
                tinyMode: _tinyMode,
                headerIsExpanded: _headerIsExpanded,
                followIsOn: _followIsOn,
                headerPageOpacity: _headerPageOpacity,
                bzCounters: _bzCounters,
              ),

              /// GALLERY HEADER
              GalleryHeader(
                flyerBoxWidth: widget.flyerBoxWidth,
                bzModel: flyerModel?.bzModel,
                flyerModel: flyerModel,
                showGallerySlide: widget.showGallerySlide,
                progressBarModel: _progressBarModel,
              ),

              /// FOOTER
              FlyerFooter(
                flyerBoxWidth: widget.flyerBoxWidth,
                flyerModel: flyerModel,
                tinyMode: _tinyMode,
                onSaveFlyer: _onSaveFlyer,
                footerPageController: _footerPageController,
                headerIsExpanded: _headerIsExpanded,
                inFlight: false,
                flyerIsSaved: _flyerIsSaved,
                infoButtonExpanded: _infoButtonExpanded,
              ),

              /// PROGRESS BAR
              ProgressBar(
                flyerBoxWidth: widget.flyerBoxWidth,
                progressBarOpacity: _progressBarOpacity,
                progressBarModel: _progressBarModel,
                tinyMode: _tinyMode,
                loading: false,
              ),

              /// SAVING NOTICE
              if (savingNotice != null)
              savingNotice,

            ],
          );

        },
        child: SavingNotice(
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerBoxHeight: _flyerBoxHeight,
          flyerIsSaved: _flyerIsSaved,
          animationController: _savingAnimationController,
          graphicIsOn: _graphicIsOn,
          graphicOpacity: _graphicOpacity,
        ),

      );

    }

  }
  // -----------------------------------------------------------------------------
}
