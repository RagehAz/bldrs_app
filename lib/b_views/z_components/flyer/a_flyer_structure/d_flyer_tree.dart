import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/a_flyer_header.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/a_flyer_footer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/flyer_slides.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/d_progress_bar/progress_bar.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/f_saving_notice/a_saving_notice.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/header_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/i_flyer_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/slides_controller.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerTree extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerTree({
    @required this.flyerModel,
    @required this.bzModel,
    @required this.bzZone,
    @required this.flyerZone,
    @required this.flyerBoxWidth,
    @required this.flightDirection,
    @required this.currentSlideIndex,
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
  final ZoneModel bzZone;
  final ZoneModel flyerZone;
  final bool loading;
  final String heroTag;
  final FlightDirection flightDirection;
  final ValueNotifier<int> currentSlideIndex;
  /// --------------------------------------------------------------------------
  // static const double flyerSmallWidth = 200;
  /// --------------------------------------------------------------------------
  @override
  State<FlyerTree> createState() => _FlyerTreeState();
}

class _FlyerTreeState extends State<FlyerTree> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  /// FOR HEADER
  AnimationController _headerAnimationController;
  ScrollController _headerScrollController;
  /// FOR SLIDES
  PageController _horizontalSlidesController;
  /// FOR FOOTER
  PageController _footerPageController;
  /// FOR SAVING GRAPHIC
  AnimationController _animationController;

  bool _canShowGallery;
  int _numberOfSlides;
// ----------------------------------------------
  @override
  void initState() {
    super.initState();

    // ------------------------------------------
    /// FOR HEADER
    _headerScrollController = ScrollController();
    _headerAnimationController = initializeHeaderAnimationController(
      context: context,
      vsync: this,
    );
    // ------------------------------------------
    /// FOR SLIDES
    _horizontalSlidesController = PageController(initialPage: widget.currentSlideIndex.value);
    // ------------------------------------------
    /// FOLLOW IS ON
    final _followIsOn = checkFollowIsOn(
      context: context,
      bzModel: widget.bzModel,
    );
    _setFollowIsOn(_followIsOn);
    // ------------------------------------------
    /// FOR FOOTER & PRICE TAG
    _footerPageController = PageController();
    _horizontalSlidesController.addListener(_listenToHorizontalController);
    // ------------------------------------------
    /// FOR SAVING GRAPHIC
    _animationController = AnimationController(
      vsync: this,
      duration: Ratioz.durationFading200,
      reverseDuration: Ratioz.durationFading200,
    );
    // ------------------------------------------

    blog('FLYER IN FLIGHT : ${widget.flightDirection} : width : ${widget.flyerBoxWidth}');

    _canShowGallery = canShowGalleryPage(
      bzModel: widget.bzModel,
      heroTag: widget.heroTag,
    );
    _numberOfSlides = getNumberOfSlides(
      flyerModel: widget.flyerModel,
      bzModel: widget.bzModel,
      heroTag: widget.heroTag,
    );



    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.flightDirection == FlightDirection.pop && _horizontalSlidesController.hasClients){

        unawaited(
            _horizontalSlidesController.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.easeOut)
        );
        // blog('THE FUCKING INDEX WAS : ${widget.currentSlideIndex.value}');
        widget.currentSlideIndex.value = 0;
        // blog('THE FUCKING INDEX ISSS : ${widget.currentSlideIndex.value}');

      }
    });

  }
// -----------------------------------------------------------------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//     final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//     _uiProvider.startController(
//             () async {
//
//               if (widget.currentSlideIndex.value == widget.flyerModel.slides.length && widget.inFlight == true){
//
//                 // await _slideToZeroIndex();
//                 blog('condition ahooooooooooooo is blah blah');
//
//               }
//
//
//         }
//     );
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _headerAnimationController.dispose();
    _headerScrollController.dispose();
    _animationController.dispose();
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
// -----------------------------------------------------------------------------
  /// FOLLOW IS ON
  final ValueNotifier<bool> _followIsOn = ValueNotifier(false);
  void _setFollowIsOn(bool setTo) => _followIsOn.value = setTo;
// -----------------------------------------------------------------------------


  /// PROGRESS BAR OPACITY
  final ValueNotifier<double> _progressBarOpacity = ValueNotifier(1);
  /// HEADER IS EXPANDED
  final ValueNotifier<bool> _headerIsExpanded = ValueNotifier(false);
  /// HEADER PAGE OPACITY
  final ValueNotifier<double> _headerPageOpacity = ValueNotifier(0);
  /// SWIPE DIRECTION
  final ValueNotifier<Sliders.SwipeDirection> _swipeDirection = ValueNotifier(Sliders.SwipeDirection.next);
// -----------------------------------------------------------------------------
  Future<void> _onHeaderTap() async {

    // await Future.delayed(const Duration(milliseconds: 100),
    //         () async {

          await onTriggerHeader(
            context: context,
            headerAnimationController: _headerAnimationController,
            verticalController: _headerScrollController,
            headerIsExpanded: _headerIsExpanded,
            progressBarOpacity: _progressBarOpacity,
            headerPageOpacity: _headerPageOpacity,
          );

        // }
    // );

  }
// -----------------------------------------------------------------------------
  Future<void> _onFollowTap() async {
    await onFollowTap(
      context: context,
      bzModel: widget.bzModel,
      followIsOn: _followIsOn,
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _onCallTap() async {
    await onCallTap(
        context: context,
        bzModel: widget.bzModel,
    );
  }
// -----------------------------------------------------------------------------
  void _onSwipeSlide(int index){

    onHorizontalSlideSwipe(
      context: context,
      newIndex: index,
      currentSlideIndex: widget.currentSlideIndex,
      swipeDirection: _swipeDirection,
    );

    blog('index has become ${widget.currentSlideIndex.value}');

  }
// -----------------------------------------------------------------------------
  Future<void> _onSlideNextTap() async {

    final int _lastIndex = widget.flyerModel.slides.length;

    /// WHEN AT LAST INDEX
    if (widget.currentSlideIndex.value == _lastIndex){
      goBack(context);
    }

    /// WHEN AT ANY OTHER INDEX
    else {

      final int _newIndex = await Sliders.slideToNextAndGetNewIndex(
        slidingController: _horizontalSlidesController,
        numberOfSlides: widget.flyerModel.slides.length + 1,
        currentSlide: widget.currentSlideIndex.value,
      );

      blog('_onSlideNextTap : _newIndex : $_newIndex');
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onSlideBackTap() async {

    /// WHEN AT FIRST INDEX
    if (widget.currentSlideIndex.value == 0){
      goBack(context);
    }

    /// WHEN AT ANY OTHER SLIDE
    else {
      final int _newIndex = await Sliders.slideToBackAndGetNewIndex(_horizontalSlidesController, widget.currentSlideIndex.value);
      blog('onSlideBackTap _newIndex : $_newIndex');
    }

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _flyerIsSaved = ValueNotifier(false);
  Future<void> _onSaveFlyer() async {

    // await Future.delayed(Ratioz.durationFading200, (){
      _flyerIsSaved.value = !_flyerIsSaved.value;
      await _triggerAnimation(_flyerIsSaved.value);
    // });

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _graphicIsOn = ValueNotifier(false);
  final ValueNotifier<double> _graphicOpacity = ValueNotifier(1);
// -----------------------------------------------------------------------------
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
    _graphicOpacity.value = 0;
    // blog('-3 - _graphicOpacity => ${_graphicOpacity.value}');

    /// 4 - WAIT FOR FADE THEN SWITCH OFF GRAPHIC
    await Future.delayed(const Duration(milliseconds: 220), (){
      _graphicIsOn.value = false;
      // blog('-4 - _graphicIsOn => ${_graphicIsOn.value}');
    });

    /// 5 - READY THE FADE FOR THE NEXT ANIMATION
    await Future.delayed(const Duration(milliseconds: 200), (){
      _graphicOpacity.value = 1;
    });
    // blog('-5 - _canStartFadeOut => ${_graphicOpacity.value}');

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _slideToZeroIndex() async {
    await Sliders.slideToBackFrom(_horizontalSlidesController, widget.currentSlideIndex.value);
  }
// -----------------------------------------------------------------------------
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

    // blog('${widget.flyerModel.slides[0].headline} : flight is : ${widget.inFlight}');

    final double _flyerBoxHeight = FlyerBox.height(context, widget.flyerBoxWidth);
    final bool _tinyMode = FlyerBox.isTinyMode(context, widget.flyerBoxWidth);

    // blog('numberOfSlides : $_numberOfSlides : ')

    return FlyerBox(
      key: const ValueKey<String>('FlyerTree_FlyerBox'),
      flyerBoxWidth: widget.flyerBoxWidth,
      stackWidgets: <Widget>[

        /// SLIDES
        if (widget.currentSlideIndex?.value != null)
          FlyerSlides(
            key: const ValueKey<String>('FlyerTree_FlyerSlides'),
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
            currentSlideIndex: widget.currentSlideIndex,
            heroTag: widget.heroTag,
            canShowGalleryPage : _canShowGallery,
            numberOfSlides: _numberOfSlides,
            flightDirection: widget.flightDirection,
          ),

        /// HEADER
        FlyerHeader(
          key: const ValueKey<String>('FlyerTree_FlyerHeader'),
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          bzZone: widget.bzZone,
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
        ),

        /// FOOTER
        // if (widget.inFlight != true)
        FlyerFooter(
          key: const ValueKey<String>('FlyerTree_FlyerFooter'),
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerModel: widget.flyerModel,
          flyerZone: widget.flyerZone,
          tinyMode: _tinyMode,
          flyerIsSaved: _flyerIsSaved,
          onSaveFlyer: _onSaveFlyer,
          footerPageController: _footerPageController,
          headerIsExpanded: _headerIsExpanded,
          inFlight: _inFlight(),
        ),

        /// PROGRESS BAR
        if (widget.flightDirection == FlightDirection.non)
        ProgressBar(
          key: const ValueKey<String>('FlyerTree_ProgressBar'),
          flyerBoxWidth: widget.flyerBoxWidth,
          progressBarOpacity: _progressBarOpacity,
          numberOfSlides: _numberOfSlides,
          swipeDirection: _swipeDirection,
          currentSlideIndex: widget.currentSlideIndex,
          tinyMode: _tinyMode,
          loading: widget.loading,
        ),

        /// SAVING NOTICE
        if (_tinyMode != true && widget.flightDirection == FlightDirection.non)
        SavingNotice(
          key: const ValueKey<String>('SavingNotice'),
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerBoxHeight: _flyerBoxHeight,
          flyerIsSaved: _flyerIsSaved,
          animationController: _animationController,
          graphicIsOn: _graphicIsOn,
          graphicOpacity: _graphicOpacity,
        ),

      ],
    );

  }
}
