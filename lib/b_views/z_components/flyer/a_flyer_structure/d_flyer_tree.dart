import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/a_flyer_header.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slides_stack.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/header_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/slides_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerTree extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerTree({
    @required this.flyerModel,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    this.flyerWidthFactor = 1,
    this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerWidthFactor;
  final Function onTap;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;
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
  final ValueNotifier<double> _progressBarOpacity = ValueNotifier(0);
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

          onTriggerHeader(
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

    final int _lastIndex = widget.flyerModel.slides.length - 1;

    /// WHEN AT LAST INDEX
    if (_currentSlideIndex.value == _lastIndex){
      goBack(context);
    }

    /// WHEN AT ANY OTHER INDEX
    else {
      final int _newIndex = await slideToNextAndGetNewIndex(_horizontalController, widget.flyerModel.slides.length, _currentSlideIndex.value);
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
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxWidth = FlyerBox.width(context, widget.flyerWidthFactor);
    final double _flyerBoxHeight = FlyerBox.height(context, _flyerBoxWidth);
    final double _footerHeight = FlyerFooter.boxHeight(context: context, flyerBoxWidth: _flyerBoxWidth);
    final bool _tinyMode = FlyerBox.isTinyMode(context, _flyerBoxWidth);

    // blog('THE Fu*king thing is doing good aho yabn el gazma : sizeFactor : $flyerWidthFactor');

    return FlyerBox(
      key: const ValueKey<String>('FlyerTree_FlyerBox'),
      flyerWidthFactor: widget.flyerWidthFactor,
      stackWidgets: <Widget>[

        /// SLIDES
        SlidesStack(
          flyerModel: widget.flyerModel,
          flyerBoxWidth: _flyerBoxWidth,
          flyerBoxHeight: _flyerBoxHeight,
          tinyMode: _tinyMode,
          currentSlideIndex: _currentSlideIndex,
          horizontalController: _horizontalController,
          onSwipeSlide: _onSwipeSlide,
          onSlideNextTap: _onSlideNextTap,
          onSlideBackTap: _onSlideBackTap,
        ),

        /// HEADER
        FlyerHeader(
          key: const ValueKey<String>('FlyerTree_FlyerHeader'),
          flyerBoxWidth: _flyerBoxWidth,
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
        Positioned(
          bottom: 0,
          child: Container(
            width: _flyerBoxWidth,
            height: _footerHeight,
            color: Colorz.blue20,
          ),
        ),

        /// PROGRESS BAR
        // Container(
        //   color: Colorz.yellow50,
        //   child: ProgressBar(
        //     flyerBoxWidth: _flyerBoxWidth,
        //   ),
        // ),

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
