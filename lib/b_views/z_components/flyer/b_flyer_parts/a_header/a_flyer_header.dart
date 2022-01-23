import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_info_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_name_below_logo_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/convertible_header_strip_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/x_button_part.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/header_controller.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerHeader extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerHeader({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  _FlyerHeaderState createState() => _FlyerHeaderState();
  /// --------------------------------------------------------------------------
}

class _FlyerHeaderState extends State<FlyerHeader> with SingleTickerProviderStateMixin {

  AnimationController _headerAnimationController;
  ColorTween _backgroundColorTween;
  BorderRadiusTween _headerCornerTween;
  BorderRadiusTween _logoCornersTween;
  Animation<double> _headerHeightTween;
  Animation<double> _logoSizeRatioTween;
  Animation<double> _headerLeftSpacerTween;
  Animation<double> _headerRightSpacerTween;
  Animation<double> _headerLabelsWidthTween;
  Animation<double> _headerMiddleSpacerWidthTween;
  Animation<double> _followCallButtonsScaleTween;
  CurvedAnimation _animation;
  ScrollController _verticalController;

  bool _listenToActiveFlyerProvider;

  @override
  void initState() {
    super.initState();

    _listenToActiveFlyerProvider = _checkListenToActiveFlyerProvider();

    _verticalController = ScrollController();
    _backgroundColorTween = ColorTween();

    /// HEADER ANIMATION CONTROLLER
    _initHeaderAnimationController();

    _animation = CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    _headerCornerTween = BorderRadiusTween();
    _logoCornersTween = BorderRadiusTween();


    _followCallButtonsScaleTween = Tween<double>(
      begin: 1,
      end: 1.5,
    ).animate(_headerAnimationController);
  }
// -----------------------------------------------------------------------------
  bool _checkListenToActiveFlyerProvider(){
    final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
    final String _activeFlyerID = _activeFlyerProvider.activeFlyerID;

    if (widget.flyerModel.id == _activeFlyerID){
      return true;
    }
    else {
      return false;
    }
  }
// -----------------------------------------------------------------------------
  void _initHeaderAnimationController(){

    _headerAnimationController = initializeHeaderAnimationController(
      context: context,
      vsync: this,
    );

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
    _headerAnimationController.dispose();
    _animation.dispose();
    _verticalController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onHeaderTap() async {

    await Future.delayed(const Duration(milliseconds: 100),
        () async {

          onTriggerHeader(
            context: context,
            headerAnimationController: _headerAnimationController,
            verticalController: _verticalController,
          );

        }
    );

  }
// -----------------------------------------------------------------------------
  Future<void> _onFollowTap() async {
    await onFollowTap(
        context: context,
        bzModel: widget.bzModel
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
  int _builds = 0;
  _traceBuilds(){
    _builds ++;
    blog('Builds are : $_builds for flyer : ${widget.flyerModel.id}');
  }

  @override
  Widget build(BuildContext context) {
// ----------------------------------------------------------
    final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: _listenToActiveFlyerProvider);
    final int _currentSlideIndex = _activeFlyerProvider.currentSlideIndex;
    final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;
    final CountryModel _bzCountry = _activeFlyerProvider.activeFlyerBzCountry;
    final CityModel _bzCity = _activeFlyerProvider.activeFlyerBzCity;
    final bool _followIsOn = _activeFlyerProvider.followIsOn;
    final String _activeFlyerID = _activeFlyerProvider.activeFlyerID;
    // final int _progressBarOpacity = _activeFlyerProvider.progressBarOpacity;

    _traceBuilds();
// ----------------------------------------------------------
    /// TINY MODE
    final bool _tinyMode = OldFlyerBox.isTinyMode(context, widget.flyerBoxWidth);
    // ----------------------------------------------------------

    /// BACK GROUND COLOR

    //--------------------------------o
    _backgroundColorTween
      ..begin = _tinyMode == true ? Colorz.nothing : Colorz.blackSemi230
      ..end = canLoopList(widget.flyerModel.slides) == false ?
      Colorz.blackSemi230
          :
      widget.flyerModel.slides[_currentSlideIndex].midColor;
// ----------------------------------------------------------

    /// HEADER CORNERS

    //--------------------------------o
    final BorderRadius _headerMinCorners = FlyerBox.superHeaderCorners(
      context: context,
      bzPageIsOn: false,
      flyerBoxWidth: widget.flyerBoxWidth,
    );
    //--------------------------------o
    _headerCornerTween
      ..begin = _headerMinCorners
      ..end = FlyerBox.corners(context, widget.flyerBoxWidth);
    // ----------------------------------------------------------

    /// LOGO CORNER

    //--------------------------------o
    final double _logoMinWidth = FlyerBox.logoWidth(
        bzPageIsOn: false,
        flyerBoxWidth: widget.flyerBoxWidth
    );
    //--------------------------------o
    final double _logoMaxWidth = widget.flyerBoxWidth * 0.6;
    //--------------------------------o
    final double _logoScaleRatio = _logoMaxWidth / _logoMinWidth;
    //--------------------------------o
    _logoCornersTween
      ..begin = FlyerBox.superLogoCorner(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth,
        zeroCornerIsOn: true,
      )
      ..end = FlyerBox.superLogoCorner(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth * _logoScaleRatio
      );
    // ----------------------------------------------------------

    /// LOGO SIZE

    //--------------------------------o
    _logoSizeRatioTween = Tween<double>(
      begin: 1,
      end: _logoScaleRatio,
    ).animate(_headerAnimationController);
    // ----------------------------------------------------------

    /// SIDE SPACERS

    //--------------------------------o
    final double _followCallPaddingEnd = FollowAndCallBTs.getPaddings(flyerBoxWidth: widget.flyerBoxWidth) * 1.5;
    //--------------------------------o
    final double _maxLeftSpacer = (widget.flyerBoxWidth * 0.2) - _followCallPaddingEnd;
    //--------------------------------o
    _headerLeftSpacerTween = Tween<double>(
      begin: 0,
      end: _maxLeftSpacer,
    ).animate(_headerAnimationController);
    //--------------------------------o
    final double _followCallBoxWidthEnd = FollowAndCallBTs.getBoxWidth(flyerBoxWidth: widget.flyerBoxWidth) * 1.5;
    //--------------------------------o
    _headerRightSpacerTween = Animators.animateDouble(
      begin: 0,
      end: (widget.flyerBoxWidth * 0.2) - _followCallBoxWidthEnd - _followCallPaddingEnd,
      controller: _headerAnimationController,
    );
    // ----------------------------------------------------------

    /// HEADER HEIGHT

    //--------------------------------o
    final double _minHeaderHeight = FlyerBox.headerBoxHeight(
        bzPageIsOn: false,
        flyerBoxWidth: widget.flyerBoxWidth
    );
    //--------------------------------o
    _headerHeightTween = Tween<double>(
      begin: _minHeaderHeight,
      end: FlyerBox.height(context, widget.flyerBoxWidth),
    ).animate(_headerAnimationController);
    // ----------------------------------------------------------

    /// HEADER LABELS SIZES

    //--------------------------------o
    _headerLabelsWidthTween = Tween<double>(
      begin: HeaderLabels.getHeaderLabelWidth(widget.flyerBoxWidth),
      end: 0,
    ).animate(_headerAnimationController);
    //--------------------------------o
    _headerMiddleSpacerWidthTween = Animators.animateDouble(
      begin: 0,
      end: _followCallPaddingEnd,
      controller: _headerAnimationController,
    );
// -----------------------------------------------------------------------------

    return AnimatedBuilder(
      key: const ValueKey<String>('FlyerHeader_AnimationBuilder'),
      animation: _headerAnimationController.view,
      child: XButtonPart(
        key: const ValueKey<String>('FlyerHeader_XButtonPart'),
        headerBorders: _headerMinCorners,
        onHeaderTap: _onHeaderTap,
      ),
      builder: (_, Widget child) {

        final Color _headerColor = _backgroundColorTween.evaluate(_animation);
        final BorderRadius _headerBorders = _headerCornerTween.evaluate(_animation);
        final BorderRadius _logoBorders = _logoCornersTween.evaluate(_animation);

        return HeaderBox(
          key: const ValueKey<String>('FlyerHeader_HeaderBox'),
          tinyMode: _tinyMode,
          onHeaderTap: _onHeaderTap,
          headerBorders: _headerBorders,
          flyerBoxWidth: widget.flyerBoxWidth,
          headerColor: _headerColor,
          headerHeightTween: _headerHeightTween,
          children: <Widget>[

            ListView(
              key: const ValueKey<String>('FlyerHeader_ListView'),
              physics: _tinyMode == true || _headerIsExpanded == false ?
              const NeverScrollableScrollPhysics()
                  :
              const BouncingScrollPhysics(),
              padding: EdgeInsets.zero, /// NEVER EVER DELETE THIS BITCH TOOK ME 2 DAYS
              controller: _verticalController,
              children: <Widget>[

                /// MINI HEADER STRIP
                ConvertibleHeaderStripPart(
                    key: const ValueKey<String>('FlyerHeader_ConvertibleHeaderStripPart'),
                    flyerBoxWidth: widget.flyerBoxWidth,
                    minHeaderHeight: _minHeaderHeight,
                    logoSizeRatioTween: _logoSizeRatioTween,
                    headerLeftSpacerTween: _headerLeftSpacerTween,
                    tinyMode: _tinyMode,
                    headerBorders: _headerBorders,
                    logoMinWidth: _logoMinWidth,
                    logoBorders: _logoBorders,
                    headerIsExpanded: _headerIsExpanded,
                    headerMiddleSpacerWidthTween: _headerMiddleSpacerWidthTween,
                    headerLabelsWidthTween: _headerLabelsWidthTween,
                    followCallButtonsScaleTween: _followCallButtonsScaleTween,
                    followIsOn: _followIsOn,
                    onFollowTap: _onFollowTap,
                    onCallTap: _onCallTap,
                    headerRightSpacerTween: _headerRightSpacerTween,
                    flyerModel: widget.flyerModel,
                    bzModel: widget.bzModel,
                    bzCountry: _bzCountry,
                    bzCity: _bzCity
                ),

                /// BZ NAME BELOW LOGO
                if (_activeFlyerID == widget.flyerModel.id)
                  BzNameBelowLogoPart(
                    key: const ValueKey<String>('FlyerHeader_BzNameBelowLogoPart'),
                    flyerBoxWidth: widget.flyerBoxWidth,
                    bzModel: widget.bzModel,
                    bzCountry: _bzCountry,
                    bzCity: _bzCity
                ),

                /// - BZ INFO PART
                if (_activeFlyerID == widget.flyerModel.id)
                BzInfoPart(
                  key: const ValueKey<String>('FlyerHeader_BzInfoPart'),
                  flyerBoxWidth: widget.flyerBoxWidth,
                  bzModel: widget.bzModel,
                  flyerModel: widget.flyerModel,
                ),

              ],
            ),

            /// --- CORNER X BUTTON
            child,


          ],
        );

      },

    );
  }
}
