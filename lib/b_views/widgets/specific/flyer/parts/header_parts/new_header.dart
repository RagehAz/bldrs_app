import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class NewHeader extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewHeader({
    @required this.flyerBoxWidth,
    @required this.onHeaderTap,
    @required this.bzModel,
    @required this.currentSlideIndex,
    @required this.headerIsExpanded,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.followIsOn,
    @required this.onCallTap,
    @required this.onFollowTap,
    @required this.slides,
    @required this.authorIsOn,
    @required this.authorID,
    this.initiallyExpanded = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool initiallyExpanded;
  final ValueChanged<bool> onHeaderTap;
  final BzModel bzModel;
  final int currentSlideIndex;
  final bool headerIsExpanded;
  final CountryModel bzCountry;
  final CityModel bzCity;
  final Function onFollowTap;
  final Function onCallTap;
  final bool followIsOn;
  final List<SlideModel> slides;
  final bool authorIsOn;
  final String authorID;
  /// --------------------------------------------------------------------------
  @override
  _NewHeaderState createState() => _NewHeaderState();
  /// --------------------------------------------------------------------------
}

class _NewHeaderState extends State<NewHeader> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _isExpanded = false;
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
  double _maxHeaderOpacity = 0;

  ScrollController _verticalController;

  @override
  void initState() {
    super.initState();

    // widget.superFlyer.flyerShowsAuthor = true;
    // widget.superFlyer.authorID = widget.superFlyer.bz.bzAuthors[0].userID;
    // widget.superFlyer.flyerTinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(widget.superFlyer.bz.bzAuthors[0]);

    _verticalController = ScrollController();
    _controller = AnimationController(
            duration: Ratioz.durationFading200,
            vsync: this
        );

    _backgroundColorTween = ColorTween();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _headerCornerTween = BorderRadiusTween();
    _logoCornersTween = BorderRadiusTween();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;

    if (_isExpanded) {
      _controller.value = 1.0;
    }

    _followCallButtonsScaleTween = Tween<double>(
      begin: 1,
      end: 1.5,
    ).animate(_controller);
  }

// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// -----------------------------------------------------------------------------
  void expand() {
    _setExpanded(true);
  }

// -----------------------------------------------------------------------------
  void collapse() {
    _setExpanded(false);
  }

// -----------------------------------------------------------------------------
  void toggle() {
    _setExpanded(!_isExpanded);
  }

// -----------------------------------------------------------------------------
  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _statelessFadeMaxHeader();
        _isExpanded = isExpanded;

        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse().then<void>((dynamic value) async {
            await _verticalController.animateTo(0,
                duration: Ratioz.durationSliding410, curve: Curves.easeOut);

            setState(() {
              // Rebuild without widget.children.
            });
          });
        }

        PageStorage.of(context)?.writeState(context, _isExpanded);
        // widget.superFlyer.nav.bzPageIsOn = !widget.superFlyer.nav.bzPageIsOn;
      });

      widget.onHeaderTap(_isExpanded);

      // if (widget.onHeaderTap != null) {
      //   widget.onHeaderTap(_isExpanded);
      // }

    }
  }

// -----------------------------------------------------------------------------
  void _statelessFadeMaxHeader() {
    blog('_maxHeaderOpacity = $_maxHeaderOpacity');

    Future<void>.delayed(Ratioz.durationFading200, () {
      if (_maxHeaderOpacity == 1) {
        _maxHeaderOpacity = 0;
      } else {
        _maxHeaderOpacity = 1;
      }
    });
  }

// -----------------------------------------------------------------------------
  Animation<double> animateDouble(
      {double begin, double end, AnimationController controller}) {
    return Tween<double>(
      begin: begin,
      end: end,
    ).animate(controller)

        /// can do stuff here
        //   ..addListener(() {
        //   // setState(() {
        //   //
        //   // });
        // })
        //   ..addStatusListener((status) {
        //     // if (status == AnimationStatus.completed) {
        //     //   _controller.reverse();
        //     // } else if (status == AnimationStatus.dismissed) {
        //     //   _controller.forward();
        //     // }
        //   })
        ;
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    const double _followCallScaleEnd = 1.5;
    final double _followCallPaddingEnd = OldFollowAndCallBTs.getPaddings(flyerBoxWidth: widget.flyerBoxWidth) * _followCallScaleEnd;
    final double _followCallBoxWidthEnd = OldFollowAndCallBTs.getBoxWidth(flyerBoxWidth: widget.flyerBoxWidth) * 1.5;
    final double _logoSizeBegin = OldFlyerBox.logoWidth(
        bzPageIsOn: false,
        flyerBoxWidth: widget.flyerBoxWidth
    );
    final double _logoSizeEnd = widget.flyerBoxWidth * 0.6;
    final double _logoScaleRatio = _logoSizeEnd / _logoSizeBegin;

    final bool _tinyMode = OldFlyerBox.isTinyMode(context, widget.flyerBoxWidth);

    final double _headerBoxHeight = OldFlyerBox.headerBoxHeight(
        bzPageIsOn: false,
        flyerBoxWidth: widget.flyerBoxWidth
    );
    //--------------------------------o
    _backgroundColorTween
      ..begin = _tinyMode == true ? Colorz.nothing : Colorz.blackSemi230
      ..end =
          widget.slides == null || widget.slides.isEmpty
              ? Colorz.blackSemi230
              : widget.slides[widget.currentSlideIndex]
                  .midColor;

    _headerCornerTween
      ..begin = FlyerBox.superHeaderCorners(
        context: context,
        bzPageIsOn: false,
        flyerBoxWidth: widget.flyerBoxWidth,
      )
      ..end = FlyerBox.corners(context, widget.flyerBoxWidth);
    // ..begin = Scale.superHeaderHeight(false, widget.flyerBoxWidth)
    // ..end = Scale.superFlyerZoneHeight(context, widget.flyerBoxWidth);

    _logoCornersTween
      ..begin = FlyerBox.superLogoCorner(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth,
        zeroCornerIsOn: true,
      ) //widget.superFlyer.flyerShowsAuthor)
      ..end = FlyerBox.superLogoCorner(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth * _logoScaleRatio);

    _headerHeightTween = Tween<double>(
      begin: _headerBoxHeight,
      end: OldFlyerBox.height(context, widget.flyerBoxWidth),
    ).animate(_controller);

    _logoSizeRatioTween = Tween<double>(
      begin: 1,
      end: _logoScaleRatio,
    ).animate(_controller);

    _headerLeftSpacerTween = Tween<double>(
      begin: 0, //Ratioz.xxflyerHeaderMainPadding * widget.flyerBoxWidth,
      end: (widget.flyerBoxWidth * 0.2) - _followCallPaddingEnd,
    ).animate(_controller);

    _headerRightSpacerTween = animateDouble(
      begin: 0,
      end: (widget.flyerBoxWidth * 0.2) -
          _followCallBoxWidthEnd -
          _followCallPaddingEnd,
      controller: _controller,
    );

    _headerLabelsWidthTween = Tween<double>(
      begin: OldHeaderLabels.getHeaderLabelWidth(widget.flyerBoxWidth),
      end: 0,
    ).animate(_controller);

    _logoToHeaderLabelsSpacerWidthTween = animateDouble(
      begin: 0,
      end: _followCallPaddingEnd,
      controller: _controller,
    );

    final bool _closed = _isExpanded == false && _controller.isDismissed == true;
    //------------------------------------------------------------o
    final double _slideHeightWithoutHeader = OldFlyerBox.height(context, widget.flyerBoxWidth) - _headerBoxHeight;

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext ctx, Widget child) {

        final Color _headerColor = _backgroundColorTween.evaluate(_animation);
        final BorderRadius _headerBorders = _headerCornerTween.evaluate(_animation);
        final BorderRadius _logoBorders = _logoCornersTween.evaluate(_animation);

        return GestureDetector(
          onTap: _tinyMode == true ? null : toggle,
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
                child: OldMaxBounceNavigator(
                  child: ListView(
                    physics: _tinyMode == true || _isExpanded == false ?
                    const NeverScrollableScrollPhysics()
                        :
                    const BouncingScrollPhysics(),
                    controller: _verticalController,
                    children: <Widget>[

                      /// MINI HEADER STRIP
                      Container(
                        width: widget.flyerBoxWidth,
                        height: (_headerBoxHeight * _logoSizeRatioTween.value) +
                            (_headerLeftSpacerTween.value),
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
                            Center(
                              child: SizedBox(
                                width: _headerLeftSpacerTween.value,
                                height: _logoSizeBegin * _logoSizeRatioTween.value,
                                // color: Colorz.BloodTest,
                              ),
                            ),

                            /// LOGO
                            BzLogo(
                              width: _logoSizeBegin * _logoSizeRatioTween.value,
                              image: widget.bzModel?.logo,
                              tinyMode: OldFlyerBox.isTinyMode(context, widget.flyerBoxWidth),
                              corners: _logoBorders,
                              zeroCornerIsOn: widget.authorIsOn,
                              // onTap:
                              //superFlyer.onHeaderTap,
                              // (){
                              //   setState(() {
                              //     _statelessFadeMaxHeader();
                              //   });
                              // }
                            ),

                            /// LOGO TO HEADER LABELS SPACER
                            Center(
                              child: SizedBox(
                                width:
                                    _logoToHeaderLabelsSpacerWidthTween.value,
                                height:
                                    _logoSizeBegin * _logoSizeRatioTween.value,
                              ),
                            ),

                            /// HEADER LABELS
                            Center(
                              child: SizedBox(
                                width: _headerLabelsWidthTween.value,
                                height:
                                _logoSizeBegin * _logoSizeRatioTween.value,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    OldHeaderLabels(
                                      authorID: widget.authorID,
                                      bzCity: widget.bzCity,
                                      bzCountry: widget.bzCountry,
                                      bzModel: widget.bzModel,
                                      headerIsExpanded: widget.headerIsExpanded,
                                      flyerShowsAuthor: widget.authorIsOn,
                                      flyerBoxWidth: widget.flyerBoxWidth * _logoSizeRatioTween.value,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            /// FOLLOW AND CALL
                            Center(
                              child: Container(
                                width: OldFollowAndCallBTs.getBoxWidth(
                                        flyerBoxWidth: widget.flyerBoxWidth) *
                                    _followCallButtonsScaleTween.value,
                                height:
                                    _logoSizeBegin * _logoSizeRatioTween.value,
                                alignment: Alignment.topCenter,
                                // color: Colorz.BloodTest,
                                child: OldFollowAndCallBTs(
                                  flyerBoxWidth: widget.flyerBoxWidth * _followCallButtonsScaleTween.value,
                                  onFollowTap: widget.onFollowTap,
                                  onCallTap: widget.onCallTap,
                                  followIsOn: widget.followIsOn,
                                  headerIsExpanded: widget.headerIsExpanded,
                                ),
                              ),
                            ),

                            /// HEADER RIGHT SPACER
                            Center(
                              child: SizedBox(
                                width: _headerRightSpacerTween.value,
                                height: _logoSizeBegin * _logoSizeRatioTween.value,
                                // color: Colorz.BloodTest,
                              ),
                            ),

                          ],
                        ),
                      ),

                      /// Bz name below logo
                      Container(
                        color: Colorz.black80,
                        child: OldBzPageHeadline(
                          flyerBoxWidth: widget.flyerBoxWidth,
                          bzPageIsOn: true,
                          bzModel: widget.bzModel,
                          country: widget.bzCountry,
                          city: widget.bzCity,
                        ),
                      ),

                      /// MAX HEADER
                      if (_isExpanded == true)
                        AnimatedOpacity(
                          duration: Ratioz.durationSliding400,
                          curve: Curves.easeIn,
                          opacity: _maxHeaderOpacity,
                          child: SizedBox(
                            width: widget.flyerBoxWidth,
                            // height: 400,
                            // color: Colorz.Yellow200,
                            child: MaxHeader(
                              flyerBoxWidth: widget.flyerBoxWidth,
                              bzModel: widget.bzModel,
                            ),
                          ),
                        ),

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
      child: _closed == true ? null
          :
      Container(
        width: widget.flyerBoxWidth,
        height: _slideHeightWithoutHeader,
        decoration: BoxDecoration(
          color: Colorz.bloodTest,
          borderRadius: Borderers.superBorderOnly(
            context: context,
            enTopLeft: 0,
            enTopRight: 0,
            enBottomLeft:
            Ratioz.xxflyerBottomCorners * widget.flyerBoxWidth,
            enBottomRight:
            Ratioz.xxflyerBottomCorners * widget.flyerBoxWidth,
          ),
        ),
      ),

    );
  }
}
