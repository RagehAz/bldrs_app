import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_footer_controller.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_header_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_flyer_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/a_flyer_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/slides_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/a_progress_bar.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/f_saving_notice/a_saving_notice.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BigFlyer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BigFlyer({
    @required this.flyerModel, // will never be null at this point
    @required this.bzModel,
    @required this.heroPath,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final String heroPath;
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  _BigFlyerState createState() => _BigFlyerState();
  /// --------------------------------------------------------------------------
}

class _BigFlyerState extends State<BigFlyer> with TickerProviderStateMixin {
  // --------------------
  final ValueNotifier<bool> _flyerIsSaved = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _followIsOn = ValueNotifier<bool>(false);
  // --------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  // --------------------
  /// FOR HEADER
  AnimationController _headerAnimationController;
  final ScrollController _headerScrollController = ScrollController();
  /// FOR SLIDES
  PageController _horizontalSlidesController;
  /// FOR FOOTER
  final PageController _footerPageController = PageController();
  /// FOR SAVING GRAPHIC
  AnimationController _savingAnimationController;
  // --------------------
  /// PROGRESS BAR OPACITY
  final ValueNotifier<double> _progressBarOpacity = ValueNotifier(1);
  /// HEADER IS EXPANDED
  final ValueNotifier<bool> _headerIsExpanded = ValueNotifier(false);
  /// HEADER PAGE OPACITY
  final ValueNotifier<double> _headerPageOpacity = ValueNotifier(0);
  // --------------------
  final ValueNotifier<BzCounterModel> _bzCounters = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true);
  // --------------------
  Future<void> _triggerLoading({
    @required setTo,
  }) async {

    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _flyerIsSaved.value = UserModel.checkFlyerIsSaved(
      userModel: UsersProvider.proGetMyUserModel(context: context, listen: false),
      flyerID: widget.flyerModel.id,
    );

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel(
        swipeDirection: SwipeDirection.next,
        index: getPossibleStartingIndex(
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          heroTag: widget.heroPath,
          startFromIndex: 0,
        ),
        numberOfStrips: getNumberOfSlides(
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          heroPath: widget.heroPath,
        ),
      ),
      addPostFrameCallBack: false,
    );

    blog('progModel : '
        'index ${_progressBarModel.value?.index} : '
        'strips ${_progressBarModel.value?.numberOfStrips} : '
        'swipe ${_progressBarModel.value?.swipeDirection}');
    // ----------
    /// FOR HEADER
    _headerAnimationController = initializeHeaderAnimationController(
      context: context,
      vsync: this,
    );
    // ----------
    /// FOR SLIDES
    _horizontalSlidesController = PageController(initialPage: _progressBarModel?.value?.index ?? 0);
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
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit == true && widget.flyerModel != null) {

      _triggerLoading(setTo: true).then((_) async {


        setNotifier(
          notifier: _bzCounters,
          mounted: mounted,
          value: BzCounterModel.createInitialModel(widget.bzModel.id),
          addPostFrameCallBack: false,
        );

        if (mounted == true){
          // ----------
          /// FOLLOW IS ON
          final _followIsOn = checkFollowIsOn(
            context: context,
            bzModel: widget.bzModel,
          );
          _setFollowIsOn(_followIsOn);
          // ----------
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
            //   widget.progressBarModel.value = widget.progressBarModel.value.copyWith(
            //     index: 0,
            //   );
            //
            // }

          });
        }
        // ----------
        await _triggerLoading(setTo: false);
        // ----------
      });

      _isInit = false;
    }

    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading?.dispose();
    _progressBarModel?.dispose();
    _flyerIsSaved?.dispose();
    _headerAnimationController?.dispose();
    _headerScrollController?.dispose();
    _savingAnimationController?.dispose();
    _horizontalSlidesController?.dispose();
    _footerPageController?.dispose();
    _followIsOn?.dispose();
    _progressBarOpacity?.dispose();
    _headerIsExpanded?.dispose();
    _headerPageOpacity?.dispose();
    _graphicIsOn?.dispose();
    _graphicOpacity?.dispose();
    _bzCounters?.dispose();
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
  // --------------------
  /// FOLLOW IS ON
  void _setFollowIsOn(bool setTo){
    setNotifier(
      notifier: _followIsOn,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
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

    final bool _tinyMode = FlyerDim.isTinyMode(context, widget.flyerBoxWidth);

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

    ProgressBarModel.onSwipe(
      context: context,
      newIndex: index,
      progressBarModel: _progressBarModel,
    );

    // blog('index has become ${widget.currentSlideIndex.value}');

  }
  // --------------------
  Future<void> _onSlideNextTap() async {

    final int _lastIndex = widget.flyerModel.slides.length;

    /// WHEN AT LAST INDEX
    if (_progressBarModel.value.index == _lastIndex){
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
        currentSlide: _progressBarModel.value.index,
      );

      blog('_onSlideNextTap : _newIndex : $_newIndex');
    }

  }
  // --------------------
  Future<void> _onSlideBackTap() async {

    /// WHEN AT FIRST INDEX
    if (_progressBarModel.value.index == 0){
      await Nav.goBack(
        context: context,
        invoker: '_onSlideBackTap',
      );
    }

    /// WHEN AT ANY OTHER SLIDE
    else {

      final int _newIndex = await Sliders.slideToBackAndGetNewIndex(
        pageController: _horizontalSlidesController,
        currentSlide: _progressBarModel.value.index,
      );

      blog('onSlideBackTap _newIndex : $_newIndex');

    }

  }
  // --------------------
  Future<void> _onSaveFlyer() async {

    if (AuthModel.userIsSignedIn() == true){

      if (mounted == true){


        await Future.wait(<Future>[
          _triggerAnimation(!_flyerIsSaved.value),
          onSaveFlyer(
              context: context,
              flyerModel: widget.flyerModel,
              slideIndex: _progressBarModel.value.index,
              flyerIsSaved: _flyerIsSaved
          ),
        ]);
      }

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
      await _savingAnimationController.forward(from: 0);
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, widget.flyerBoxWidth);
    final bool _tinyMode = FlyerDim.isTinyMode(context, widget.flyerBoxWidth);

    return ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool loading, Widget child){

          if (loading == true){
            return const SizedBox();
          }

          else {

            blog('BUILDING FLYER');

            return child;
          }

        },

      child: FlyerBox(
        key: const ValueKey<String>('FullScreenFlyer'),
        flyerBoxWidth: widget.flyerBoxWidth,
        // boxColor: Colorz.bloodTest,
        stackWidgets: <Widget>[

          /// SLIDES
          SlidesBuilder(
            flyerModel: widget.flyerModel,
            bzModel: widget.bzModel,
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
          ),

          /// HEADER
          FlyerHeader(
            flyerBoxWidth: widget.flyerBoxWidth,
            flyerModel: widget.flyerModel,
            bzModel: widget.bzModel,
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
          FlyerFooter(
            flyerBoxWidth: widget.flyerBoxWidth,
            flyerModel: widget.flyerModel,
            tinyMode: _tinyMode,
            onSaveFlyer: _onSaveFlyer,
            footerPageController: _footerPageController,
            headerIsExpanded: _headerIsExpanded,
            inFlight: false,
            flyerIsSaved: _flyerIsSaved,
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
          SavingNotice(
            flyerBoxWidth: widget.flyerBoxWidth,
            flyerBoxHeight: _flyerBoxHeight,
            flyerIsSaved: _flyerIsSaved,
            animationController: _savingAnimationController,
            graphicIsOn: _graphicIsOn,
            graphicOpacity: _graphicOpacity,
          ),

        ],
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
