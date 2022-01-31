import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/a_flyer_header.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slides_stack.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/d_progress_bar/progress_bar.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/header_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/slides_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerTree extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerTree({
    @required this.flyerModel,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.flyerBoxWidth,
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
  final CountryModel bzCountry;
  final CityModel bzCity;
  final bool loading;
  final String heroTag;
  /// --------------------------------------------------------------------------
  // static const double flyerSmallWidth = 200;
  /// --------------------------------------------------------------------------
  @override
  State<FlyerTree> createState() => _FlyerTreeState();
}

class _FlyerTreeState extends State<FlyerTree> with SingleTickerProviderStateMixin {
// -----------------------------------------------------------------------------
  /// FOR HEADER
  AnimationController _headerAnimationController;
  ScrollController _headerScrollController;
  /// FOR SLIDES
  PageController _horizontalController;
  /// FOR FOOTER
  PageController _footerPageController;
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
    _horizontalController = PageController(); // (initialPage: _initialPage);

    // ------------------------------------------
    /// FOLLOW IS ON
    final _followIsOn = _checkFollowIsOn();
    _setFollowIsOn(_followIsOn);
    // ------------------------------------------
    /// FOR FOOTER
    _footerPageController = PageController();

    final int _numberOfSlide = widget.flyerModel.slides.length - 1;
    final double _totalRealSlidesWidth = widget.flyerBoxWidth * _numberOfSlide;
    _horizontalController.addListener(() {

      final bool _reachedGallerySlide = _horizontalController.page > _numberOfSlide;
      final bool _atBackBounce = _horizontalController.position.pixels < 0;

      /// WHEN AT INITIAL SLIDE
      if (_atBackBounce == true){
        final double _correctedPixels = _horizontalController.position.pixels;
        _footerPageController.position.correctPixels(_correctedPixels);
        _footerPageController.position.notifyListeners();
      }

      /// WHEN AT LAST REAL SLIDE
      if (_reachedGallerySlide == true){
        final double _correctedPixels = _horizontalController.position.pixels - _totalRealSlidesWidth;
        _footerPageController.position.correctPixels(_correctedPixels);
        _footerPageController.position.notifyListeners();
      }

    });

  }
// -----------------------------------------------------------------------------
//   bool _isInit = true;
  @override
  void didChangeDependencies() {
    // if (_isInit) {
    // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    // _uiProvider.startController(
    //         () async {
    //
    //     }
    // );
    // }
    // _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _headerAnimationController.dispose();
    _headerScrollController.dispose();
  }
// -----------------------------------------------------------------------------
  /// FOLLOW IS ON
  final ValueNotifier<bool> _followIsOn = ValueNotifier(false);
  void _setFollowIsOn(bool setTo) => _followIsOn.value = setTo;
// --------------------------------
  bool _checkFollowIsOn(){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final _followIsOn = _bzzProvider.checkFollow(context: context, bzID: widget.bzModel.id);
    return _followIsOn;
  }
// -----------------------------------------------------------------------------
  /// CURRENT SLIDE INDEX
  final ValueNotifier<int> _currentSlideIndex = ValueNotifier(0);
  /// PROGRESS BAR OPACITY
  final ValueNotifier<double> _progressBarOpacity = ValueNotifier(1);
  /// HEADER IS EXPANDED
  final ValueNotifier<bool> _headerIsExpanded = ValueNotifier(false);
  /// HEADER PAGE OPACITY
  final ValueNotifier<double> _headerPageOpacity = ValueNotifier(0);
  /// SWIPE DIRECTION
  final ValueNotifier<SwipeDirection> _swipeDirection = ValueNotifier(SwipeDirection.next);
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
      currentSlideIndex: _currentSlideIndex,
      swipeDirection: _swipeDirection,
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _onSlideNextTap() async {

    final int _lastIndex = widget.flyerModel.slides.length;

    /// WHEN AT LAST INDEX
    if (_currentSlideIndex.value == _lastIndex){
      goBack(context);
    }

    /// WHEN AT ANY OTHER INDEX
    else {

      final int _newIndex = await slideToNextAndGetNewIndex(
        slidingController: _horizontalController,
        numberOfSlides: widget.flyerModel.slides.length + 1,
        currentSlide: _currentSlideIndex.value,
      );

      blog('_onSlideNextTap : _newIndex : $_newIndex');
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onSlideBackTap() async {

    /// WHEN AT FIRST INDEX
    if (_currentSlideIndex.value == 0){
      goBack(context);
    }

    /// WHEN AT ANY OTHER SLIDE
    else {
      final int _newIndex = await slideToBackAndGetNewIndex(_horizontalController, _currentSlideIndex.value);
      blog('onSlideBackTap _newIndex : $_newIndex');
    }

  }
// -----------------------------------------------------------------------------
  bool _canShowGalleryPage(){
    bool _canShowGallery = false;

    /// only CAN SHOW : WHEN BZ FLYERS ARE MORE THAN THE SHOWN FLYER
    final bool _bzHasMoreThanOneFlyer = widget.bzModel.flyersIDs.length > 1;

    /// & only CAN SHOW : WHEN HERO TAG CONTAINS MORE THAN 1 FLYER ID
    final List<String> _heroFlyersIDs = FlyerHero.splitHeroTagIntoFlyersIDs(heroTag: widget.heroTag);
    final bool _heroTagHasMoreThanOneFlyerID = _heroFlyersIDs.length > 1;

    /// & only CAN SHOW : WHEN HERO TAG HAS LESS THAN 3 FLYERS IDS
    final bool _heroTagHasLessThanThreeFlyersIDs = _heroFlyersIDs.length < 3;

    /// so :-
    if (_bzHasMoreThanOneFlyer == true){

      if (_heroTagHasMoreThanOneFlyerID == true){

        if (_heroTagHasLessThanThreeFlyersIDs == true){

          _canShowGallery = true;

        }

      }

    }

    return _canShowGallery;
  }
// -----------------------------------------------------------------------------
  int _getNumberOfSlides(){
    int _numberOfSlides;

    final bool _canShowGallery = _canShowGalleryPage();

    if (_canShowGallery == true){
      _numberOfSlides = widget.flyerModel.slides.length + 1;
    }

    else {
      _numberOfSlides = widget.flyerModel.slides.length;
    }

    return _numberOfSlides;
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _flyerIsSaved = ValueNotifier(false);
  Future<void> _onSaveFlyer() async {

    await Future.delayed(Ratioz.durationFading200, (){
      _flyerIsSaved.value = !_flyerIsSaved.value;
    });

  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _flyerBoxHeight = FlyerBox.height(context, widget.flyerBoxWidth);
    final bool _tinyMode = FlyerBox.isTinyMode(context, widget.flyerBoxWidth);

    final bool _canShowGallery = _canShowGalleryPage();
    final int _numberOfSlides = _getNumberOfSlides();

    return FlyerBox(
      key: const ValueKey<String>('FlyerTree_FlyerBox'),
      flyerBoxWidth: widget.flyerBoxWidth,
      stackWidgets: <Widget>[

        /// SLIDES
        SlidesStack(
          key: const ValueKey<String>('FlyerTree_SlidesStack'),
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerBoxHeight: _flyerBoxHeight,
          tinyMode: _tinyMode,
          currentSlideIndex: _currentSlideIndex,
          horizontalController: _horizontalController,
          onSwipeSlide: _onSwipeSlide,
          onSlideNextTap: _onSlideNextTap,
          onSlideBackTap: _onSlideBackTap,
          heroTag: widget.heroTag,
          numberOfSlides: _numberOfSlides,
          canShowGalleryPage: _canShowGallery,
        ),

        /// HEADER
        FlyerHeader(
          key: const ValueKey<String>('FlyerTree_FlyerHeader'),
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
          bzCountry: widget.bzCountry,
          bzCity: widget.bzCity,
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
        FlyerFooter(
          flyerBoxWidth: widget.flyerBoxWidth,
          tinyMode: _tinyMode,
          flyerIsSaved: _flyerIsSaved,
          onSaveFlyer: _onSaveFlyer,
          footerPageController: _footerPageController,
        ),

        /// PROGRESS BAR
        ProgressBar(
          flyerBoxWidth: widget.flyerBoxWidth,
          progressBarOpacity: _progressBarOpacity,
          numberOfSlides: _numberOfSlides,
          swipeDirection: _swipeDirection,
          currentSlideIndex: _currentSlideIndex,
          tinyMode: _tinyMode,
          loading: widget.loading,
        ),

        // Consumer<ActiveFlyerProvider>(
        //   child: Container(),
        //   builder: (_, ActiveFlyerProvider activeFlyerProvider, Widget child){
        //
        //     final int _currentSlideIndex = activeFlyerProvider.currentSlideIndex;
        //     final double _progressBarOpacity = activeFlyerProvider.progressBarOpacity;
        //     final SwipeDirection _swipeDirection = activeFlyerProvider.swipeDirection;
        //
        //     blog('flyer id : ${widget.flyerModel.id} : _progressBarOpacity : $_progressBarOpacity');
        //
        //     return OldProgressBar(
        //       numberOfSlides: widget.flyerModel?.slides?.length ?? 0,
        //       index: _currentSlideIndex,
        //       opacity: _progressBarOpacity,
        //       flyerBoxWidth: _flyerBoxWidth,
        //       swipeDirection: _swipeDirection,
        //       loading: false,
        //     );
        //
        //   },
        // ),


        /// PRICE TAG

      ],
    );

  }
}
