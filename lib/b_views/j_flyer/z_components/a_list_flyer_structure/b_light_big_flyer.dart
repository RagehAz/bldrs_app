import 'dart:async';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_footer_controller.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_header_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_flyer_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/a_flyer_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/slides_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/a_progress_bar.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/saving_notice_layer/a_saving_notice.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class LightBigFlyer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LightBigFlyer({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.onHorizontalExit,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final Function onHorizontalExit;
  /// --------------------------------------------------------------------------
  @override
  _LightBigFlyerState createState() => _LightBigFlyerState();
  /// --------------------------------------------------------------------------
}

class _LightBigFlyerState extends State<LightBigFlyer> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  final ValueNotifier<FlyerModel> _flyer = ValueNotifier(null);
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
  // --------------------
  final ValueNotifier<bool> _graphicIsOn = ValueNotifier(false);
  final ValueNotifier<double> _graphicOpacity = ValueNotifier(1);
  // --------------------
  String _heroPath;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
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
    _initializations();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await _preparations();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(LightBigFlyer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (
    oldWidget.flyerModel != widget.flyerModel ||
    oldWidget.bzModel != widget.bzModel
    ) {

      blog('LightBigFlyer : didUpdateWidget '
          ': oldWidget.flyerModel != widget.flyerModel '
          '|| '
          'oldWidget.bzModel != widget.bzModel'
      );

    }

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

    _heroPath = 'lightBigFlyer/${widget.flyerModel?.id}';

    setNotifier(
      notifier: _flyer,
      mounted: mounted,
      value: widget.flyerModel,
    );

    setNotifier(
      notifier: _flyerIsSaved,
      mounted: mounted,
      value: UserModel.checkFlyerIsSaved(
        userModel: UsersProvider.proGetMyUserModel(context: context, listen: false),
        flyerID: widget.flyerModel?.id,
      ),
    );

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel(
        swipeDirection: SwipeDirection.next,
        index: 0,
        numberOfStrips: getNumberOfSlides(
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          heroPath: _heroPath,
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
  void _listenToHorizontalController(){

    final int _realSlidesLength = widget.flyerModel?.slides?.length ?? 1;
    final int _numberOfSlide = _realSlidesLength - 1;
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
  // -----------------------------------------------------------------------------

  /// PREPARATIONS

  // --------------------
  Future<void> _preparations() async {

    if (widget.flyerModel?.id  != null){

      unawaited(_imagifyFlyer());

      setNotifier(
        notifier: _bzCounters,
        mounted: mounted,
        value: BzCounterModel.createInitialModel(widget.bzModel.id),
      );

      setNotifier(
        notifier: _followIsOn,
        mounted: mounted,
        value: checkFollowIsOn(context: context, bzModel: widget.bzModel,),
      );

    }

  }
  // --------------------
  Future<void> _imagifyFlyer() async {

    // FlyerModel _imagified = widget.flyerModel;

    if (widget.flyerModel != null){

      await Future.wait(<Future>[

        /// DOWNLOAD SLIDES
        PicProtocols.downloadPics(SlideModel.getSlidePicsPaths(_flyer.value.slides)),

        /// DOWNLOAD AUTHOR PIC
        if (_flyer.value.showsAuthor == true)
        PicProtocols.downloadPic(Storage.generateAuthorPicPath(
          authorID: _flyer.value.authorID,
          bzID: _flyer.value.bzID,
        ))

        // /// IMAGIFY REMAINING SLIDES
        // FlyerProtocols.imagifySlides(widget.flyerModel)
        //     .then((FlyerModel flyer){
        //   _imagified = _imagified.copyWith(
        //     slides: flyer.slides,
        //   );
        // }),

        // /// IMAGIFY AUTHOR PIC
        // if (_imagified.showsAuthor == true)
        //   FlyerProtocols.imagifyAuthorPic(widget.flyerModel)
        //       .then((FlyerModel flyer){
        //     _imagified = _imagified.copyWith(
        //       authorImage: flyer.authorImage,
        //     );
        //   }),

      ]);

      // assert(_imagified != null, 'received flyer with imagified slides is null');
      // assert(_imagified.slides[_imagified.slides.length - 1].uiImage != null, 'last slide uiImage is null');
      //
      // setNotifier(
      //   notifier: _flyer,
      //   mounted: mounted,
      //   value: _imagified,
      // );

    }

  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  void _disposeBigFlyer(){

      // /// DISPOSE SLIDES IMAGES
      // for (final SlideModel slide in _flyer.value.slides){
      //   blog('yyyyy - === >>> disposing flyer[${slide.slideIndex}] SLIDE IMAGE');
      //   slide.uiImage?.dispose();
      //   if (slide.uiImage?.debugDisposed)
      // }

      /// DISPOSE AUTHOR IMAGE
      // blog('yyyyy - === >>> disposing flyer AUTHOR IMAGE');
      // _flyer.value.authorImage?.dispose();

      // / TASK : DISPOSE BZ LOGO

      _flyer.dispose();
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

    final bool _tinyMode = FlyerDim.isTinyMode(context, widget.flyerBoxWidth);

    if (_headerIsExpanded.value  == true && _tinyMode == false){
      await readBzCounters(
        bzID: widget.bzModel.id,
        bzCounters: _bzCounters,
        mounted: mounted,
      );
    }

  }
  // --------------------
  Future<void> _onFollowTap() async {
    await onFollowTap(
      context: context,
      bzModel: widget.bzModel,
      followIsOn: _followIsOn,
      mounted: mounted,
    );
  }
  // --------------------
  Future<void> _onCallTap() async {
    await onCallTap(
      context: context,
      bzModel: widget.bzModel,
      flyerModel: widget.flyerModel,
    );
  }
  // -----------------------------------------------------------------------------

  /// SWIPING

  // --------------------
  void _onSwipeSlide(int index){

    // blog('OPENING SLIDE INDEX : $index');

    unawaited(recordFlyerView(
      index: index,
      flyerModel: widget.flyerModel,
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

    final int _lastIndex = widget.flyerModel?.slides?.length ?? 0;

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
        numberOfSlides: (widget.flyerModel?.slides?.length ?? 0) + 1,
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
  // -----------------------------------------------------------------------------

  /// FOOTER INTERACTIONS

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
            flyerIsSaved: _flyerIsSaved,
            mounted: mounted,
          ),
        ]);

      }

    }

    else {

      await Dialogs.youNeedToBeSignedInDialog(context);

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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, widget.flyerBoxWidth);
    final bool _tinyMode = FlyerDim.isTinyMode(context, widget.flyerBoxWidth);

    return ValueListenableBuilder(
      valueListenable: _flyer,
      builder: (_, FlyerModel flyerModel, Widget savingNotice) {

        return FlyerBox(
          key: const ValueKey<String>('FullScreenFlyer'),
          flyerBoxWidth: widget.flyerBoxWidth,
          // boxColor: Colorz.bloodTest,
          stackWidgets: <Widget>[

            /// SLIDES
            SlidesBuilder(
              flyerModel: flyerModel,
              bzModel: widget.bzModel,
              flyerBoxWidth: widget.flyerBoxWidth,
              flyerBoxHeight: _flyerBoxHeight,
              tinyMode: false,
              horizontalController: _horizontalSlidesController,
              onSwipeSlide: _onSwipeSlide,
              onSlideBackTap: _onSlideBackTap,
              onSlideNextTap: _onSlideNextTap,
              onDoubleTap: _onSaveFlyer,
              heroTag: _heroPath,
              progressBarModel: _progressBarModel,
              flightDirection: FlightDirection.non,
              onHorizontalExit: widget.onHorizontalExit,
            ),

            /// HEADER
            FlyerHeader(
              flyerBoxWidth: widget.flyerBoxWidth,
              flyerModel: flyerModel,
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
              flyerModel: flyerModel,
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
    // --------------------
  }
// -----------------------------------------------------------------------------
}
