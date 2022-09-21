import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/bz_info_part.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/bz_name_below_logo_part.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/convertible_header_strip_part.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/header_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/x_button_part.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerHeader extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerHeader({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.flyerZone,
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
  final ZoneModel flyerZone;
  final Function onHeaderTap;
  final Function onFollowTap;
  final Function onCallTap;
  final AnimationController headerAnimationController;
  final ScrollController headerScrollController;
  final bool tinyMode;
  final ValueNotifier<bool> headerIsExpanded; /// p
  final ValueNotifier<bool> followIsOn; /// p
  final ValueNotifier<double> headerPageOpacity; /// p
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
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _backgroundColorTween = ColorTween();

    _animation = CurvedAnimation(
      parent: widget.headerAnimationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
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
  /// TAMAM
  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------------

    /// BACK GROUND COLOR

    //--------------------------------o
    _backgroundColorTween
      ..begin = widget.tinyMode == true ? Colorz.nothing : Colorz.blackSemi230
      ..end = Mapper.checkCanLoopList(widget.flyerModel.slides) == false ?
      Colorz.blackSemi230
          :
      widget.flyerModel.slides[0].midColor;
    // -----------------------------------------------------------------------

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
    // -----------------------------------------------------------------------

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
    // -----------------------------------------------------------------------

    /// LOGO SIZE

    //--------------------------------o
    _logoSizeRatioTween = Tween<double>(
      begin: 1,
      end: _logoScaleRatio,
    ).animate(widget.headerAnimationController);
    // -----------------------------------------------------------------------

    /// SIDE SPACERS

    //--------------------------------o
    final double _followCallPaddingEnd = OldFollowAndCallBTs.getPaddings(flyerBoxWidth: widget.flyerBoxWidth) * 1.5;
    //--------------------------------o
    final double _maxLeftSpacer = (widget.flyerBoxWidth * 0.2) - _followCallPaddingEnd;
    //--------------------------------o
    _headerLeftSpacerTween = Tween<double>(
      begin: 0,
      end: _maxLeftSpacer,
    ).animate(widget.headerAnimationController);
    //--------------------------------o
    final double _followCallBoxWidthEnd = OldFollowAndCallBTs.getBoxWidth(flyerBoxWidth: widget.flyerBoxWidth) * 1.5;
    //--------------------------------o
    _headerRightSpacerTween = Animators.animateDouble(
      begin: 0,
      end: (widget.flyerBoxWidth * 0.2) - _followCallBoxWidthEnd - _followCallPaddingEnd,
      controller: widget.headerAnimationController,
    );
    // -----------------------------------------------------------------------

    /// HEADER HEIGHT

    //--------------------------------o
    final double _minHeaderHeight = FlyerBox.headerBoxHeight(
        flyerBoxWidth: widget.flyerBoxWidth
    );
    //--------------------------------o
    _headerHeightTween = Tween<double>(
      begin: _minHeaderHeight,
      end: FlyerBox.height(context, widget.flyerBoxWidth),
    ).animate(widget.headerAnimationController);
    // -----------------------------------------------------------------------

    /// HEADER LABELS SIZES

    //--------------------------------o
    _headerLabelsWidthTween = Tween<double>(
      begin: HeaderBox.getHeaderLabelWidth(widget.flyerBoxWidth),
      end: 0,
    ).animate(widget.headerAnimationController);
    //--------------------------------o
    _headerMiddleSpacerWidthTween = Animators.animateDouble(
      begin: 0,
      end: _followCallPaddingEnd,
      controller: widget.headerAnimationController,
    );
    // -----------------------------------------------------------------------

    return AnimatedBuilder(
      key: const ValueKey<String>('FlyerHeader_AnimationBuilder'),
      animation: widget.headerAnimationController.view,
      child: XButtonPart(
        key: const ValueKey<String>('FlyerHeader_XButtonPart'),
        headerBorders: _headerMinCorners,
        onHeaderTap: widget.onHeaderTap,
        headerIsExpanded: widget.headerIsExpanded,
      ),
      builder: (_, Widget xButton) {

        final Color _headerColor = _backgroundColorTween.evaluate(_animation);
        final BorderRadius _headerBorders = _headerCornerTween.evaluate(_animation);
        final BorderRadius _logoBorders = _logoCornersTween.evaluate(_animation);

        return HeaderBox(
          key: const ValueKey<String>('FlyerHeader_HeaderBox'),
          tinyMode: widget.tinyMode,
          onHeaderTap: widget.onHeaderTap,
          headerBorders: _headerBorders,
          flyerBoxWidth: widget.flyerBoxWidth,
          headerColor: _headerColor,
          headerHeightTween: _headerHeightTween,
          stackChildren: <Widget>[

            ListView(
              key: const PageStorageKey<String>('FlyerHeader_ListView'),
              physics: widget.tinyMode == true || widget.headerIsExpanded.value == false ?
              const NeverScrollableScrollPhysics()
                  :
              const BouncingScrollPhysics(),
              padding: EdgeInsets.zero, /// NEVER EVER DELETE THIS BITCH TOOK ME 2 DAYS
              controller: widget.headerScrollController,
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
                  logoBorders: _logoBorders,
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
                LinesBelowLogoPart(
                  key: const ValueKey<String>('FlyerHeader_BzNameBelowLogoPart'),
                  flyerBoxWidth: widget.flyerBoxWidth,
                  firstLine: Verse(
                    text: widget.bzModel.name,
                    translate: false,
                  ),
                  secondLine: ZoneModel.translateZoneString(
                    context: context,
                    zoneModel: widget.bzModel.zone,
                  ),
                  headerIsExpanded: widget.headerIsExpanded,
                ),

                /// - BZ INFO PART
                ValueListenableBuilder(
                    valueListenable: widget.headerIsExpanded,
                    builder: (_, bool isExpanded, Widget child){

                      if (isExpanded == true && widget.tinyMode == false){
                        blog('BzInfoPart SHOULD BUILD NOWWW XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
                        return child;
                      }

                      else {
                        return const SizedBox();
                      }

                    },
                  child: BzInfoPart(
                    key: const ValueKey<String>('FlyerHeader_BzInfoPart'),
                    flyerBoxWidth: widget.flyerBoxWidth,
                    bzModel: widget.bzModel,
                    flyerModel: widget.flyerModel,
                    headerPageOpacity: widget.headerPageOpacity,
                    bzCounters: widget.bzCounters,
                  ),
                ),


              ],
            ),

            /// --- CORNER X BUTTON
            if (widget.tinyMode == false)
            xButton,


          ],
        );

      },

    );

  }
// -----------------------------------------------------------------------------
}
