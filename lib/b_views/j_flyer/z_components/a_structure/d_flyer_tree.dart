import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_header_controllers.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_slides_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_structure/a_flyer_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/a_flyer_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/slides_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/a_progress_bar.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/f_saving_notice/a_saving_notice.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerTree extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerTree({
    @required this.flyerModel,
    @required this.bzModel,
    @required this.flyerZone,
    @required this.flyerBoxWidth,
    @required this.flightDirection,
    @required this.progressBarModel,
    @required this.onSaveFlyer,
    @required this.flyerIsSaved,
    this.onTap,
    this.loading = false,
    this.heroTag,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function onTap;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final ZoneModel flyerZone;
  final bool loading;
  final String heroTag;
  final FlightDirection flightDirection;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final Function onSaveFlyer;
  final ValueNotifier<bool> flyerIsSaved;
  /// --------------------------------------------------------------------------
  // static const double flyerSmallWidth = 200;
  /// --------------------------------------------------------------------------
  @override
  State<FlyerTree> createState() => _FlyerTreeState();
  /// --------------------------------------------------------------------------
}

class _FlyerTreeState extends State<FlyerTree> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  /// FOR HEADER
  AnimationController _headerAnimationController;
  final ScrollController _headerScrollController = ScrollController();
  /// FOR SLIDES
  PageController _horizontalSlidesController;
  /// FOR FOOTER
  final PageController _footerPageController = PageController();
  /// FOR SAVING GRAPHIC
  AnimationController _animationController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // ------------------------------------------
    _bzCounters.value = BzCounterModel.createInitialModel(widget.bzModel.id);
    // ------------------------------------------
    /// FOR HEADER
    _headerAnimationController = initializeHeaderAnimationController(
      context: context,
      vsync: this,
    );
    // ------------------------------------------
    /// FOR SLIDES
    _horizontalSlidesController = PageController(initialPage: widget.progressBarModel.value.index);
    // ------------------------------------------
    /// FOLLOW IS ON
    final _followIsOn = checkFollowIsOn(
      context: context,
      bzModel: widget.bzModel,
    );
    _setFollowIsOn(_followIsOn);
    // ------------------------------------------
    /// FOR FOOTER & PRICE TAG
    _horizontalSlidesController.addListener(_listenToHorizontalController);
    // ------------------------------------------
    /// FOR SAVING GRAPHIC
    _animationController = AnimationController(
      vsync: this,
      duration: Ratioz.durationFading200,
      reverseDuration: Ratioz.durationFading200,
    );
    // ------------------------------------------

    // blog('FLYER IN FLIGHT [ ${widget.flyerModel.id} ] : ${widget.flightDirection} : width : ${widget.flyerBoxWidth}');

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      if (
          widget.flightDirection == FlightDirection.pop
          &&
          _horizontalSlidesController.hasClients
      ){

        unawaited(_horizontalSlidesController
            .animateToPage(0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut
        ));

        widget.progressBarModel.value = widget.progressBarModel.value.copyWith(
          index: 0,
        );

      }
    });

  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.startController(
            () async {

              if (widget.currentSlideIndex.value == widget.flyerModel.slides.length && widget.inFlight == true){

                // await _slideToZeroIndex();
                blog('condition ahooooooooooooo is blah blah');

              }


        }
    );
    }
    _isInit = false;
    super.didChangeDependencies();
  }
   */
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _headerAnimationController.dispose();
    _headerScrollController.dispose();
    _animationController.dispose();
    _horizontalSlidesController.dispose();
    _footerPageController.dispose();
    _followIsOn.dispose();
    _progressBarOpacity.dispose();
    _headerIsExpanded.dispose();
    _headerPageOpacity.dispose();
    _graphicIsOn.dispose();
    _graphicOpacity.dispose();
    _bzCounters.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void _listenToHorizontalController(){

    final int _numberOfSlide = widget.flyerModel.slides.length - 1;
    final double _totalRealSlidesWidth = widget.flyerBoxWidth * _numberOfSlide;

    final bool _reachedGallerySlide = _horizontalSlidesController.page > _numberOfSlide;
    final bool _atBackBounce = _horizontalSlidesController.position.pixels < 0;

    /// WHEN AT INITIAL SLIDE
    if (_atBackBounce == true){
      final double _correctedPixels = _horizontalSlidesController.position.pixels;
      _footerPageController.position.correctPixels(_correctedPixels);
      _footerPageController.position.notifyListeners();

    }

    /// WHEN AT LAST REAL SLIDE
    if (_reachedGallerySlide == true){
      final double _correctedPixels = _horizontalSlidesController.position.pixels - _totalRealSlidesWidth;
      _footerPageController.position.correctPixels(_correctedPixels);
      _footerPageController.position.notifyListeners();

    }

  }
  // --------------------
  /// FOLLOW IS ON
  final ValueNotifier<bool> _followIsOn = ValueNotifier(false);
  void _setFollowIsOn(bool setTo){
    setNotifier(
        notifier: _followIsOn,
        mounted: mounted,
        value: setTo,
    );
  }
  // --------------------
  /// PROGRESS BAR OPACITY
  final ValueNotifier<double> _progressBarOpacity = ValueNotifier(1);
  /// HEADER IS EXPANDED
  final ValueNotifier<bool> _headerIsExpanded = ValueNotifier(false);
  /// HEADER PAGE OPACITY
  final ValueNotifier<double> _headerPageOpacity = ValueNotifier(0);
  // --------------------
  final ValueNotifier<BzCounterModel> _bzCounters = ValueNotifier(null);
  // --------------------
  Future<void> _onHeaderTap() async {

    await onTriggerHeader(
      context: context,
      headerAnimationController: _headerAnimationController,
      verticalController: _headerScrollController,
      headerIsExpanded: _headerIsExpanded,
      progressBarOpacity: _progressBarOpacity,
      headerPageOpacity: _headerPageOpacity,
    );

    final bool _tinyMode = FlyerBox.isTinyMode(context, widget.flyerBoxWidth);

    if (_headerIsExpanded.value == true && _tinyMode == false){
      await readBzCounters(
        context: context,
        bzID: widget.bzModel.id,
        bzCounters: _bzCounters,
      );
    }


  }
  // --------------------
  Future<void> _onFollowTap() async {
    await onFollowTap(
      context: context,
      bzModel: widget.bzModel,
      followIsOn: _followIsOn,
    );
  }
  // --------------------
  Future<void> _onCallTap() async {
    await onCallTap(
        context: context,
        bzModel: widget.bzModel,
    );
  }
  // --------------------
  void _onSwipeSlide(int index){

    blog('OPENING SLIDE INDEX : $index');

    unawaited(recordFlyerView(
      context: context,
      index: index,
      flyerModel: widget.flyerModel,
    ));

    onHorizontalSlideSwipe(
      context: context,
      newIndex: index,
      progressBarModel: widget.progressBarModel,
    );

    // blog('index has become ${widget.currentSlideIndex.value}');

  }
  // --------------------
  Future<void> _onSlideNextTap() async {

    final int _lastIndex = widget.flyerModel.slides.length;

    /// WHEN AT LAST INDEX
    if (widget.progressBarModel.value.index == _lastIndex){
      await Nav.goBack(
        context: context,
        invoker: '_onSlideNextTap',
      );
    }

    /// WHEN AT ANY OTHER INDEX
    else {

      final int _newIndex = await Sliders.slideToNextAndGetNewIndex(
        slidingController: _horizontalSlidesController,
        numberOfSlides: widget.flyerModel.slides.length + 1,
        currentSlide: widget.progressBarModel.value.index,
      );

      blog('_onSlideNextTap : _newIndex : $_newIndex');
    }

  }
  // --------------------
  Future<void> _onSlideBackTap() async {

    /// WHEN AT FIRST INDEX
    if (widget.progressBarModel.value.index == 0){
      await Nav.goBack(
        context: context,
        invoker: '_onSlideBackTap',
      );
    }

    /// WHEN AT ANY OTHER SLIDE
    else {

      final int _newIndex = await Sliders.slideToBackAndGetNewIndex(
          pageController: _horizontalSlidesController,
          currentSlide: widget.progressBarModel.value.index,
      );

      blog('onSlideBackTap _newIndex : $_newIndex');

    }

  }
  // --------------------
  Future<void> _onSaveFlyer() async {

    if (AuthModel.userIsSignedIn() == true){

      if (widget.flyerIsSaved.value == true){
        await Nav.goBack(
          context: context,
          invoker: '_onSaveFlyer',
        );
      }

      if (mounted == true){
        await widget.onSaveFlyer();
      }

      // await Future.delayed(Ratioz.durationFading200, () async {

      // await _flyersProvider.saveOrUnSaveFlyer(
      //   context: context,
      //   inputFlyer: widget.flyerModel,
      // );
      //
      // _flyerIsSaved.value = !_flyerIsSaved.value;
      await _triggerAnimation(widget.flyerIsSaved.value);

      // });

    }

    else {

      await Dialogs.youNeedToBeSignedInDialog(context);

    }

  }
  // --------------------
  final ValueNotifier<bool> _graphicIsOn = ValueNotifier(false);
  final ValueNotifier<double> _graphicOpacity = ValueNotifier(1);
  // --------------------
  Future<void> _triggerAnimation(bool isSaved) async {

    if (isSaved == true){

    /// 1 - GRAPHIC IS ALREADY OFF => SWITCH ON
    _graphicIsOn.value = true;
    _graphicOpacity.value = 1;

    // blog('-1 - _graphicIsOn => ${_graphicIsOn.value}');

    /// 2 - ANIMATE CONTROLLER
    await _animationController.forward(from: 0);
    // blog('-2 - _animatedController => $isSaved');

    /// 3 - START FADE OUT AND WAIT FOR IT
    if (mounted){
    _graphicOpacity.value = 0;
    }
    // blog('-3 - _graphicOpacity => ${_graphicOpacity.value}');

    /// 4 - WAIT FOR FADE THEN SWITCH OFF GRAPHIC
    await Future.delayed(const Duration(milliseconds: 220), (){
      if (mounted){
        _graphicIsOn.value = false;
      }
      // blog('-4 - _graphicIsOn => ${_graphicIsOn.value}');
    });

    /// 5 - READY THE FADE FOR THE NEXT ANIMATION
    await Future.delayed(const Duration(milliseconds: 200), (){
      if (mounted){
        _graphicOpacity.value = 1;
      }
    });
    // blog('-5 - _canStartFadeOut => ${_graphicOpacity.value}');

    }

  }
  // --------------------
  /*
//   Future<void> _slideToZeroIndex() async {
//     await Sliders.slideToBackFrom(_horizontalSlidesController, widget.currentSlideIndex.value);
//   }
   */
  // --------------------
  bool _inFlight(){

    if (widget.flightDirection == FlightDirection.non){
      return false;
    }
    else {
      return true;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxHeight = FlyerBox.height(context, widget.flyerBoxWidth);
    final bool _tinyMode = FlyerBox.isTinyMode(context, widget.flyerBoxWidth);

    return FlyerBox(
      key: const ValueKey<String>('FlyerTree_FlyerBox'),
      flyerBoxWidth: widget.flyerBoxWidth,
      stackWidgets: <Widget>[

        /// SLIDES
        SlidesBuilder(
            flyerModel: widget.flyerModel,
            bzModel: widget.bzModel,
            flyerBoxWidth: widget.flyerBoxWidth,
            flyerBoxHeight: _flyerBoxHeight,
            tinyMode: _tinyMode,
            horizontalController: _horizontalSlidesController,
            onSwipeSlide: _onSwipeSlide,
            onSlideBackTap: _onSlideBackTap,
            onSlideNextTap: _onSlideNextTap,
            onDoubleTap: _onSaveFlyer,
            heroTag: widget.heroTag,
            progressBarModel: widget.progressBarModel,
            flightDirection: widget.flightDirection,

          ),

        /// HEADER
        FlyerHeader(
          key: const ValueKey<String>('FlyerTree_FlyerHeader'),
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          flyerZone: widget.flyerZone,
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

        /// FOOTER
        // if (_tinyMode == false)
        FlyerFooter(
          key: const ValueKey<String>('FlyerTree_FlyerFooter'),
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerModel: widget.flyerModel,
          flyerZone: widget.flyerZone,
          tinyMode: _tinyMode,
          onSaveFlyer: _onSaveFlyer,
          footerPageController: _footerPageController,
          headerIsExpanded: _headerIsExpanded,
          inFlight: _inFlight(),
          flyerIsSaved: widget.flyerIsSaved,
        ),

        /// PROGRESS BAR
        if (_tinyMode == false || widget.flightDirection == FlightDirection.non)
        ProgressBar(
          key: const ValueKey<String>('FlyerTree_ProgressBar'),
          flyerBoxWidth: widget.flyerBoxWidth,
          progressBarOpacity: _progressBarOpacity,
          progressBarModel: widget.progressBarModel,
          tinyMode: _tinyMode,
          loading: widget.loading,
        ),

        /// SAVING NOTICE
        if (_tinyMode == false || widget.flightDirection == FlightDirection.non)
        SavingNotice(
          key: const ValueKey<String>('SavingNotice'),
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerBoxHeight: _flyerBoxHeight,
          flyerIsSaved: widget.flyerIsSaved,
          animationController: _animationController,
          graphicIsOn: _graphicIsOn,
          graphicOpacity: _graphicOpacity,
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
