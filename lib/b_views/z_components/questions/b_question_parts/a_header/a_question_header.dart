import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/x_button_part.dart';
import 'package:bldrs/b_views/z_components/questions/b_question_parts/a_header/b_convertible_question_header_strip_part.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/xxx_lab/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class QuestionHeader extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const QuestionHeader({
    @required this.flyerBoxWidth,
    @required this.questionModel,
    @required this.userModel,
    @required this.onHeaderTap,
    @required this.headerAnimationController,
    @required this.headerScrollController,
    @required this.tinyMode,
    @required this.headerIsExpanded,
    @required this.followIsOn,
    @required this.headerPageOpacity,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final QuestionModel questionModel;
  final UserModel userModel;
  final Function onHeaderTap;
  final AnimationController headerAnimationController;
  final ScrollController headerScrollController;
  final bool tinyMode;
  final ValueNotifier<bool> headerIsExpanded;
  final ValueNotifier<bool> followIsOn;
  final ValueNotifier<double> headerPageOpacity;
  /// --------------------------------------------------------------------------
  @override
  _QuestionHeaderState createState() => _QuestionHeaderState();
/// --------------------------------------------------------------------------
}

class _QuestionHeaderState extends State<QuestionHeader> with SingleTickerProviderStateMixin {

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
    _animation.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
//   int _builds = 0;
//   _traceBuilds(){
//     _builds ++;
//     // blog('Builds are : $_builds for flyer : ${widget.flyerModel.id}');
//   }

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: _listenToActiveFlyerProvider);
//     final int _currentSlideIndex = _activeFlyerProvider.currentSlideIndex;
//     final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;
//     final CountryModel _bzCountry = _activeFlyerProvider.activeFlyerBzCountry;
//     final CityModel _bzCity = _activeFlyerProvider.activeFlyerBzCity;
//     final bool _followIsOn = _activeFlyerProvider.followIsOn;
//     final String _activeFlyerID = _activeFlyerProvider.activeFlyerID;
    // final int _progressBarOpacity = _activeFlyerProvider.progressBarOpacity;

    // _traceBuilds();
// -----------------------------------------------------------------------------

    /// BACK GROUND COLOR

    //--------------------------------o
    _backgroundColorTween
      ..begin = widget.tinyMode == true ? Colorz.nothing : Colorz.blackSemi230
      ..end = Colorz.blackSemi230;
// -----------------------------------------------------------------------------

    /// HEADER CORNERS

    //--------------------------------o
    final double _minHeaderHeight = FlyerBox.headerBoxHeight(
        flyerBoxWidth: widget.flyerBoxWidth
    );
    //--------------------------------o
    final double _headerMinCornersValue = _minHeaderHeight * 0.5;
    //--------------------------------o
    final BorderRadius _headerMinCorners = superBorderAll(context, _headerMinCornersValue);
    //--------------------------------o
    _headerCornerTween
      ..begin = _headerMinCorners
      ..end = FlyerBox.corners(context, widget.flyerBoxWidth);
// -----------------------------------------------------------------------------

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
// -----------------------------------------------------------------------------

    /// LOGO SIZE

    //--------------------------------o
    _logoSizeRatioTween = Tween<double>(
      begin: 1,
      end: _logoScaleRatio,
    ).animate(widget.headerAnimationController);
// -----------------------------------------------------------------------------

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
// -----------------------------------------------------------------------------

    /// HEADER HEIGHT

    //--------------------------------o
    _headerHeightTween = Tween<double>(
      begin: _minHeaderHeight,
      end: FlyerBox.height(context, widget.flyerBoxWidth),
    ).animate(widget.headerAnimationController);
// -----------------------------------------------------------------------------

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
// -----------------------------------------------------------------------------

    return AnimatedBuilder(
      key: const ValueKey<String>('FlyerHeader_AnimationBuilder'),
      animation: widget.headerAnimationController.view,
      child: XButtonPart(
        key: const ValueKey<String>('FlyerHeader_XButtonPart'),
        headerBorders: _headerMinCorners,
        onHeaderTap: widget.onHeaderTap,
        headerIsExpanded: widget.headerIsExpanded,
      ),
      builder: (_, Widget child) {

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
          children: <Widget>[

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
                ConvertibleQuestionHeaderStripPart(
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
                  headerRightSpacerTween: _headerRightSpacerTween,
                  questionModel: widget.questionModel,
                  userModel: widget.userModel,
                ),

                // /// BZ NAME BELOW LOGO
                // // if (_activeFlyerID == widget.flyerModel.id)
                // BzNameBelowLogoPart(
                //   key: const ValueKey<String>('FlyerHeader_BzNameBelowLogoPart'),
                //   flyerBoxWidth: widget.flyerBoxWidth,
                //   bzModel: widget.bzModel,
                //   bzZone: widget.bzZone,
                //   headerIsExpanded: widget.headerIsExpanded,
                // ),
                //
                // /// - BZ INFO PART
                // // if (_activeFlyerID == widget.flyerModel.id)
                // BzInfoPart(
                //   key: const ValueKey<String>('FlyerHeader_BzInfoPart'),
                //   flyerBoxWidth: widget.flyerBoxWidth,
                //   bzModel: widget.bzModel,
                //   flyerModel: widget.flyerModel,
                //   headerPageOpacity: widget.headerPageOpacity,
                // ),

              ],
            ),

            // ValueListenableBuilder<bool>(
            //     valueListenable: widget.headerIsExpanded,
            //     builder: (_, bool headerIsExpanded, Widget child){
            //
            //       return ;
            //
            //     }
            // ),

            /// --- CORNER X BUTTON
            child,


          ],
        );

      },

    );
  }
}
