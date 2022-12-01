import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/a_convertible_header_strip_part.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_header_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/c_bz_slide_headline/a_bz_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/a_bz_slide_tree.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerHeader extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerHeader({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.onHeaderTap,
    @required this.onFollowTap,
    @required this.onCallTap,
    @required this.headerAnimationController,
    @required this.headerScrollController,
    @required this.tinyMode,
    @required this.headerIsExpanded,
    @required this.followIsOn,
    @required this.headerPageOpacity,
    @required this.bzCounters,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final Function onHeaderTap;
  final Function onFollowTap;
  final Function onCallTap;
  final AnimationController headerAnimationController;
  final ScrollController headerScrollController;
  final bool tinyMode;
  final ValueNotifier<bool> headerIsExpanded;
  final ValueNotifier<bool> followIsOn;
  final ValueNotifier<double> headerPageOpacity;
  final ValueNotifier<BzCounterModel> bzCounters;
  /// --------------------------------------------------------------------------
  @override
  _FlyerHeaderState createState() => _FlyerHeaderState();
  /// --------------------------------------------------------------------------
}

class _FlyerHeaderState extends State<FlyerHeader> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
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
  // --------------------
  bool _canBounce = true;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _animation = CurvedAnimation(
      parent: widget.headerAnimationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    _backgroundColorTween = ColorTween(
      begin: FlyerColors.headerColorBeginColor(tinyMode: widget.tinyMode),
      end: FlyerColors.headerEndColor(slides: widget.flyerModel.slides),
    );

    _headerCornerTween = BorderRadiusTween();
    _logoCornersTween = BorderRadiusTween();

    _followCallButtonsScaleTween = Tween<double>(
      begin: 1,
      end: 1.5,
    ).animate(widget.headerAnimationController);

  }
  // --------------------
  /*
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
   */
  // --------------------
  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------------

    /// HEADER CORNERS

    //--------------------------------o
    /*
    final BorderRadius _headerMinCorners = FlyerDim.headerSlateCorners(
      context: context,
      flyerBoxWidth: widget.flyerBoxWidth,
    );
     */
    //--------------------------------o
    _headerCornerTween = BorderRadiusTween(
      begin: FlyerDim.headerSlateCorners(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth,
      ),
      end: FlyerDim.flyerCorners(context, widget.flyerBoxWidth),
    );
    // -----------------------------------------------------------------------

    /// LOGO CORNER

    //--------------------------------o
    final double _logoMinWidth = FlyerDim.logoWidth(widget.flyerBoxWidth);
    //--------------------------------o
    final double _logoMaxWidth = widget.flyerBoxWidth * 0.6;
    //--------------------------------o
    final double _logoScaleRatio = _logoMaxWidth / _logoMinWidth;
    //--------------------------------o
    _logoCornersTween = BorderRadiusTween(
      begin: FlyerDim.logoCornersByFlyerBoxWidth(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth,
        zeroCornerIsOn: true,
      ),
      end: FlyerDim.logoCornersByFlyerBoxWidth(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth * _logoScaleRatio
      ),
    );
    // -----------------------------------------------------------------------

    /// LOGO SIZE

    //--------------------------------o
    _logoSizeRatioTween = Animators.animateDouble(
      begin: 1,
      end: _logoScaleRatio,
      controller: widget.headerAnimationController,
    );
    // -----------------------------------------------------------------------

    /// SIDE SPACERS

    //--------------------------------o
    final double _followCallPaddingEnd = FlyerDim.headerSlatePaddingValue(widget.flyerBoxWidth) * 1.5;
    //--------------------------------o
    final double _maxLeftSpacer = (widget.flyerBoxWidth * 0.2) - _followCallPaddingEnd;
    //--------------------------------o
    _headerLeftSpacerTween = Animators.animateDouble(
      begin: 0,
      end: _maxLeftSpacer,
      controller: widget.headerAnimationController,
    );
    //--------------------------------o
    final double _followCallBoxWidthEnd = FlyerDim.followAndCallBoxWidth(widget.flyerBoxWidth) * 1.5;
    //--------------------------------o
    _headerRightSpacerTween = Animators.animateDouble(
      begin: 0,
      end: (widget.flyerBoxWidth * 0.2) - _followCallBoxWidthEnd - _followCallPaddingEnd,
      controller: widget.headerAnimationController,
    );
    // -----------------------------------------------------------------------

    /// HEADER HEIGHT

    //--------------------------------o
    final double _minHeaderHeight = FlyerDim.headerSlateHeight(widget.flyerBoxWidth);
    //--------------------------------o
    _headerHeightTween = Animators.animateDouble(
      begin: _minHeaderHeight,
      end: FlyerDim.flyerHeightByFlyerWidth(context, widget.flyerBoxWidth),
      controller: widget.headerAnimationController,
    );
    // -----------------------------------------------------------------------

    /// HEADER LABELS SIZES

    //--------------------------------o
    _headerLabelsWidthTween = Animators.animateDouble(
      begin: FlyerDim.headerLabelsWidth(widget.flyerBoxWidth),
      end: 0,
      controller: widget.headerAnimationController,
    );
    //--------------------------------o
    _headerMiddleSpacerWidthTween = Animators.animateDouble(
      begin: 0,
      end: _followCallPaddingEnd,
      controller: widget.headerAnimationController,
    );
    // -----------------------------------------------------------------------

    return AnimatedBuilder(
      key: const ValueKey<String>('FlyerHeader'),
      animation: widget.headerAnimationController.view,
      builder: (_, Widget bzSlideTree) {

        final Color _headerColor = _backgroundColorTween.evaluate(_animation);
        final BorderRadius _headerBorders = _headerCornerTween.evaluate(_animation);
        final BorderRadius _logoBorders = _logoCornersTween.evaluate(_animation);

        return HeaderBox(
          key: const ValueKey<String>('FlyerHeader_HeaderBox'),
          onHeaderTap: widget.onHeaderTap,
          headerBorders: _headerBorders,
          flyerBoxWidth: widget.flyerBoxWidth,
          headerColor: _headerColor,
          headerHeightTween: _headerHeightTween,
          child: MaxBounceNavigator(
            onNavigate: () async {

              if (_canBounce = true) {
                _canBounce = false;
                blog('Bouncing back : $_canBounce');
                await widget.onHeaderTap();
                /// to wait header shrinkage until allowing new shrinkage
                await Future.delayed(Ratioz.duration750ms, (){
                  _canBounce = true;
                });
              }

            },
            // isOn: _canBounce,
            boxDistance: FlyerDim.flyerHeightByFlyerWidth(context, widget.flyerBoxWidth),
            // numberOfScreens: 2,
            child: SingleChildScrollView(
              physics: widget.tinyMode == true || widget.headerIsExpanded.value == false ?
              const NeverScrollableScrollPhysics()
                  :
              const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,/// NEVER EVER DELETE THIS BITCH TOOK ME 2 DAYS
              controller: widget.headerScrollController,
              child: Column(
                key: const PageStorageKey<String>('FlyerHeader_ListView'),
                children: <Widget>[

                  /// MINI HEADER STRIP
                  ConvertibleHeaderStripPart(
                    key: const ValueKey<String>('FlyerHeader_ConvertibleHeaderStripPart'),
                    flyerBoxWidth: widget.flyerBoxWidth,
                    minHeaderHeight: _minHeaderHeight,
                    logoSizeRatioTween: _logoSizeRatioTween,
                    headerLeftSpacerTween: _headerLeftSpacerTween,
                    tinyMode: widget.tinyMode,
                    headerBorders: _headerBorders,
                    logoMinWidth: _logoMinWidth,
                    logoCorners: _logoBorders,
                    headerIsExpanded: widget.headerIsExpanded,
                    headerMiddleSpacerWidthTween: _headerMiddleSpacerWidthTween,
                    headerLabelsWidthTween: _headerLabelsWidthTween,
                    followCallButtonsScaleTween: _followCallButtonsScaleTween,
                    followIsOn: widget.followIsOn,
                    onFollowTap: widget.onFollowTap,
                    onCallTap: widget.onCallTap,
                    headerRightSpacerTween: _headerRightSpacerTween,
                    flyerModel: widget.flyerModel,
                    bzModel: widget.bzModel,
                  ),

                  /// BZ NAME BELOW LOGO
                  BzSlideHeadline(
                    key: const ValueKey<String>('FlyerHeader_BzNameBelowLogoPart'),
                    flyerBoxWidth: widget.flyerBoxWidth,
                    firstLine: Verse(
                      text: widget.bzModel.name,
                      translate: false,
                    ),
                    secondLine: ZoneModel.generateInZoneVerse(
                      context: context,
                      zoneModel: widget.bzModel.zone,
                    ),
                    headerIsExpanded: widget.headerIsExpanded,
                  ),

                  /// - BZ SLIDE
                  bzSlideTree,

                ],
              ),

            ),

          ),
        );

      },

      child: BzSlideTree(
        key: const ValueKey<String>('FlyerHeader_BzInfoPart'),
        flyerBoxWidth: widget.flyerBoxWidth,
        bzModel: widget.bzModel,
        flyerModel: widget.flyerModel,
        headerPageOpacity: widget.headerPageOpacity,
        bzCounters: widget.bzCounters,
        headerIsExpanded: widget.headerIsExpanded,
        tinyMode: widget.tinyMode,
      ),

    );

  }
// -----------------------------------------------------------------------------
}
