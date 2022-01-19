import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/new_header.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_bz_label.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/header_controller.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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

  // bool _isExpanded = false;

  ColorTween _backgroundColorTween;
  BorderRadiusTween _headerCornerTween;
  BorderRadiusTween _logoCornersTween;
  Animation<double> _headerHeightTween;
  Animation<double> _logoSizeRatioTween;
  Animation<double> _headerLeftSpacerTween;
  Animation<double> _headerRightSpacerTween;
  Animation<double> _headerLabelsWidthTween;
  Animation<double> _logoToHeaderLabelsSpacerWidthTween;
  Animation<double> _followCallButtonsScaleTween;
  CurvedAnimation _animation;
  // double _maxHeaderOpacity = 0;

  ScrollController _verticalController;

  @override
  void initState() {
    super.initState();


    _verticalController = ScrollController();
    _backgroundColorTween = ColorTween();

    /// HEADER ANIMATION CONTROLLER
    _initHeaderAnimationController();

    _animation = CurvedAnimation(parent: _headerAnimationController, curve: Curves.easeIn);
    _headerCornerTween = BorderRadiusTween();
    _logoCornersTween = BorderRadiusTween();


    _followCallButtonsScaleTween = Tween<double>(
      begin: 1,
      end: 1.5,
    ).animate(_headerAnimationController);
  }
// -----------------------------------------------------------------------------
  void _initHeaderAnimationController(){

    _headerAnimationController = initializeHeaderAnimationController(
      context: context,
      vsync: this,
    );

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      _uiProvider.startController(
              () async {

          }
      );

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _headerAnimationController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _onHeaderTap(){
    onTriggerHeader(
      context: context,
      headerAnimationController: _headerAnimationController,
      verticalController: _verticalController,
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
  @override
  Widget build(BuildContext context) {
// ----------------------------------------------------------
    final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: true);
    final int _currentSlideIndex = _activeFlyerProvider.currentSlideIndex;
    final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;
    final CountryModel _bzCountry = _activeFlyerProvider.activeFlyerBzCountry;
    final CityModel _bzCity = _activeFlyerProvider.activeFlyerBzCity;
    final bool _followIsOn = _activeFlyerProvider.followIsOn;
    final double _maxHeaderOpacity = _activeFlyerProvider.headerPageOpacity;
    final int _progressBarOpacity = _activeFlyerProvider.progressBarOpacity;
// ----------------------------------------------------------
    /// TINY MODE
    final bool _tinyMode = OldFlyerBox.isTinyMode(context, widget.flyerBoxWidth);
    // ----------------------------------------------------------

    /// BACK GROUND COLOR

    //--------------------------------o
    final Color _minHeaderBackgroundColor =
    _tinyMode == true ?
    Colorz.nothing
        :
    Colorz.blackSemi230;
    //--------------------------------o
    final Color _maxHeaderBackgroundColor =
    canLoopList(widget.flyerModel.slides) == false ?
    Colorz.blackSemi230
        :
    widget.flyerModel.slides[_currentSlideIndex].midColor;
    //--------------------------------o
    _backgroundColorTween
      ..begin = _minHeaderBackgroundColor
      ..end = _maxHeaderBackgroundColor;
// ----------------------------------------------------------

    /// HEADER CORNERS

    //--------------------------------o
    final BorderRadius _headerMinCorners = FlyerBox.superHeaderCorners(
      context: context,
      bzPageIsOn: false,
      flyerBoxWidth: widget.flyerBoxWidth,
    );
    //--------------------------------o
    final BorderRadius _headerMaxCorners = FlyerBox.corners(context, widget.flyerBoxWidth);
    //--------------------------------o
    _headerCornerTween
      ..begin = _headerMinCorners
      ..end = _headerMaxCorners;
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
    final BorderRadius _logoMinCorners = FlyerBox.superLogoCorner(
      context: context,
      flyerBoxWidth: widget.flyerBoxWidth,
      zeroCornerIsOn: true,
    );
    //--------------------------------o
    final BorderRadius _logoMaxCorners = FlyerBox.superLogoCorner(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth * _logoScaleRatio
    );
    //--------------------------------o
    _logoCornersTween
      ..begin = _logoMinCorners//widget.superFlyer.flyerShowsAuthor)
      ..end = _logoMaxCorners;
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
    const double _followCallScaleEnd = 1.5;
    final double _followCallPaddingEnd = FollowAndCallBTs.getPaddings(flyerBoxWidth: widget.flyerBoxWidth) * _followCallScaleEnd;
    //--------------------------------o
    final double _maxLeftSpacer = (widget.flyerBoxWidth * 0.2) - _followCallPaddingEnd;
    //--------------------------------o
    _headerLeftSpacerTween = Tween<double>(
      begin: 0, //Ratioz.xxflyerHeaderMainPadding * widget.flyerBoxWidth,
      end: _maxLeftSpacer,
    ).animate(_headerAnimationController);
    //--------------------------------o
    final double _followCallBoxWidthEnd = FollowAndCallBTs.getBoxWidth(flyerBoxWidth: widget.flyerBoxWidth) * 1.5;
    //--------------------------------o
    final double _maxRightSpacer = (widget.flyerBoxWidth * 0.2) - _followCallBoxWidthEnd - _followCallPaddingEnd;
    //--------------------------------o
    _headerRightSpacerTween = Animators.animateDouble(
      begin: 0,
      end: _maxRightSpacer,
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
    final double _miniHeaderStripHeight = (_minHeaderHeight * _logoSizeRatioTween.value) + (_headerLeftSpacerTween.value);
    //--------------------------------o
    final double _maxHeaderHeight = FlyerBox.height(context, widget.flyerBoxWidth);
    //--------------------------------o
    _headerHeightTween = Tween<double>(
      begin: _minHeaderHeight,
      end: _maxHeaderHeight,
    ).animate(_headerAnimationController);
    // ----------------------------------------------------------

    /// HEADER LABELS SIZES

    //--------------------------------o
    final double _labelsWidth = HeaderLabels.getHeaderLabelWidth(_minHeaderHeight);
    final double _labelsHeight = _minHeaderHeight * (Ratioz.xxflyerHeaderMiniHeight - (2 * Ratioz.xxflyerHeaderMainPadding));
    //--------------------------------o
    final double _maxHeaderLabelsWidth = HeaderLabels.getHeaderLabelWidth(widget.flyerBoxWidth);
    //--------------------------------o
    _headerLabelsWidthTween = Tween<double>(
      begin: _maxHeaderLabelsWidth,
      end: 0,
    ).animate(_headerAnimationController);
    //--------------------------------o
    _logoToHeaderLabelsSpacerWidthTween = Animators.animateDouble(
      begin: 0,
      end: _followCallPaddingEnd,
      controller: _headerAnimationController,
    );
    // ----------------------------------------------------------
    final bool _closed = _headerIsExpanded == false && _headerAnimationController.isDismissed == true;
    //------------------------------------------------------------o
    final double _slideHeightWithoutHeader = FlyerBox.height(context, widget.flyerBoxWidth) - _minHeaderHeight;
// -----------------------------------------------------------------------------

    blog('header is expanded : $_headerIsExpanded');

    return AnimatedBuilder(
      animation: _headerAnimationController.view,
      builder: (BuildContext ctx, Widget child) {

        final Color _headerColor = _backgroundColorTween.evaluate(_animation);
        final BorderRadius _headerBorders = _headerCornerTween.evaluate(_animation);
        final BorderRadius _logoBorders = _logoCornersTween.evaluate(_animation);

        return GestureDetector(
          onTap: _tinyMode == true ? null : _onHeaderTap,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: widget.flyerBoxWidth,
              height: _headerHeightTween.value,
              // margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: _headerColor,
                borderRadius: _headerBorders,
              ),
              alignment: Alignment.topCenter,
              child: ClipRRect(
                borderRadius: _headerBorders,
                child: MaxBounceNavigator(
                  child: ListView(
                    physics: _tinyMode == true || _headerIsExpanded == false ?
                    const NeverScrollableScrollPhysics()
                        :
                    const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero, /// NEVER EVER DELETE THIS BITCH TOOK ME 2 DAYS
                    controller: _verticalController,
                    children: <Widget>[

                      /// MINI HEADER STRIP
                      Container(
                        color: Colorz.bloodTest,
                        child: Container(
                          width: widget.flyerBoxWidth,
                          height: (_minHeaderHeight * _logoSizeRatioTween.value) + (_headerLeftSpacerTween.value),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: _headerLeftSpacerTween.value),
                          decoration: BoxDecoration(
                            color: _tinyMode == true ? Colorz.white50 : Colorz.black80,
                            borderRadius: Borderers.superBorderOnly(
                              context: context,
                              enTopRight: _headerBorders.topRight.x,
                              enTopLeft: _headerBorders.topRight.x,
                              enBottomRight: 0,
                              enBottomLeft: 0,
                            ),
                          ),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            key: const PageStorageKey<String>('miniHeaderStrip'),
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              /// HEADER LEFT SPACER
                              Container(
                                color: Colorz.red255,
                                child: Center(
                                  child: SizedBox(
                                    width: _headerLeftSpacerTween.value,
                                    height: _logoMinWidth * _logoSizeRatioTween.value,
                                    // color: Colorz.BloodTest,
                                  ),
                                ),
                              ),

                              /// LOGO
                              BzLogo(
                                width: _logoMinWidth * _logoSizeRatioTween.value,
                                image: widget.bzModel?.logo,
                                tinyMode: FlyerBox.isTinyMode(context, widget.flyerBoxWidth),
                                corners: _logoBorders,
                                bzPageIsOn: _headerIsExpanded,
                                zeroCornerIsOn: widget.flyerModel.showsAuthor,
                                // onTap:
                                //superFlyer.onHeaderTap,
                                // (){
                                //   setState(() {
                                //     _statelessFadeMaxHeader();
                                //   });
                                // }
                              ),

                              /// LOGO TO HEADER LABELS SPACER
                              Container(
                                color: Colorz.yellow125,
                                child: Center(
                                  child: SizedBox(
                                    width: _logoToHeaderLabelsSpacerWidthTween.value,
                                    height: _logoMinWidth * _logoSizeRatioTween.value,
                                  ),
                                ),
                              ),

                              /// HEADER LABELS
                              Container(
                                color: Colorz.blue80,
                                child: Center(
                                  child: SizedBox(
                                    width: _headerLabelsWidthTween.value,
                                    height: _logoMinWidth * _logoSizeRatioTween.value,
                                    child: ListView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      children: <Widget>[

                                        HeaderLabels(
                                          flyerBoxWidth: widget.flyerBoxWidth  * _logoSizeRatioTween.value,
                                          authorID: widget.flyerModel.authorID,
                                          bzCity: _bzCity,
                                          bzCountry: _bzCountry,
                                          bzModel: widget.bzModel,
                                          headerIsExpanded: false, //_headerIsExpanded,
                                          flyerShowsAuthor: widget.flyerModel.showsAuthor,
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// FOLLOW AND CALL
                              Container(
                                color: Colorz.blue80,
                                child: Center(
                                  child: Container(
                                    width: FollowAndCallBTs.getBoxWidth(flyerBoxWidth: widget.flyerBoxWidth) * _followCallButtonsScaleTween.value,
                                    height: _logoMinWidth * _logoSizeRatioTween.value,
                                    alignment: Alignment.topCenter,
                                    // color: Colorz.BloodTest,
                                    child: FollowAndCallBTs(
                                      flyerBoxWidth: widget.flyerBoxWidth * _followCallButtonsScaleTween.value,
                                      followIsOn: _followIsOn,
                                      onCallTap: _onCallTap,
                                      onFollowTap: _onFollowTap,
                                      headerIsExpanded: false, /// KEEP THIS NOW
                                    ),
                                  ),
                                ),
                              ),

                              /// HEADER RIGHT SPACER
                              Center(
                                child: SizedBox(
                                  width: _headerRightSpacerTween.value,
                                  height: _logoMinWidth * _logoSizeRatioTween.value,
                                  // color: Colorz.BloodTest,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),

                      /// Bz name below logo
                      Container(
                        color: Colorz.black80,
                        child: BzPageHeadline(
                          flyerBoxWidth: widget.flyerBoxWidth,
                          bzPageIsOn: true,
                          bzModel: widget.bzModel,
                          country: _bzCountry,
                          city: _bzCity,
                        ),
                      ),

                      // /// MAX HEADER
                      // if (_headerIsExpanded == true)
                      //   AnimatedOpacity(
                      //     duration: Ratioz.durationSliding400,
                      //     curve: Curves.easeIn,
                      //     opacity: _maxHeaderOpacity,
                      //     child: SizedBox(
                      //       width: widget.flyerBoxWidth,
                      //       // height: 400,
                      //       // color: Colorz.Yellow200,
                      //       child: MaxHeader(
                      //         flyerBoxWidth: widget.flyerBoxWidth,
                      //         bzPageIsOn: _headerIsExpanded,
                      //         bzModel: widget.bzModel,
                      //       ),
                      //     ),
                      //   ),

                    ],
                  ),
                ),
              ),

              // child:
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: <Widget>[
              //
              //     // /// COLLAPSED ZONE
              //     // GestureDetector(
              //     //   onTap: toggle,
              //     //   child: MiniHeaderStrip(
              //     //     superFlyer: widget.superFlyer,
              //     //     flyerBoxWidth: widget.flyerBoxWidth,
              //     //   ),
              //     // ),
              //     //
              //     // /// EXPANDABLE ZONE
              //     // ClipRRect(
              //     //   borderRadius: Borderers.superBorderOnly(
              //     //     context: context,
              //     //     enTopLeft: 0,
              //     //     enTopRight: 0,
              //     //     enBottomLeft: Ratioz.xxflyerBottomCorners * widget.flyerBoxWidth,
              //     //     enBottomRight: Ratioz.xxflyerBottomCorners * widget.flyerBoxWidth,
              //     //   ),
              //     //   child: new Align(
              //     //     heightFactor: _animation.value,
              //     //     child: child,
              //     //   ),
              //     // ),
              //
              //   ],
              // ),
            ),
          ),
        );
      },

      child: _closed == true ? null :
      Container(
        width: widget.flyerBoxWidth,
        height: _slideHeightWithoutHeader,
        decoration: BoxDecoration(
          color: Colorz.bloodTest,
          borderRadius: Borderers.superBorderOnly(
            context: context,
            enTopLeft: 0,
            enTopRight: 0,
            enBottomLeft: Ratioz.xxflyerBottomCorners * widget.flyerBoxWidth,
            enBottomRight: Ratioz.xxflyerBottomCorners * widget.flyerBoxWidth,
          ),
        ),
      ),
    );
  }
}
