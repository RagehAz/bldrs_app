import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_bz_label.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/header_controller.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerHeader extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerHeader({
    @required this.flyerModel,
    @required this.bzModel,
    @required this.flyerBoxWidth,
    this.initiallyExpanded = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final double flyerBoxWidth;
  final bool initiallyExpanded;
  /// --------------------------------------------------------------------------
  @override
  _FlyerHeaderState createState() => _FlyerHeaderState();
/// --------------------------------------------------------------------------
}

class _FlyerHeaderState extends State<FlyerHeader> with SingleTickerProviderStateMixin {

  AnimationController _headerAnimationController;
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
    _headerAnimationController = AnimationController(
        duration: Ratioz.durationFading200,
        vsync: this
    );

    _backgroundColorTween = ColorTween();
    _animation = CurvedAnimation(parent: _headerAnimationController, curve: Curves.easeIn);
    _headerCornerTween = BorderRadiusTween();
    _logoCornersTween = BorderRadiusTween();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;

    if (_isExpanded) {
      _headerAnimationController.value = 1.0;
    }

    _followCallButtonsScaleTween = Tween<double>(
      begin: 1,
      end: 1.5,
    ).animate(_headerAnimationController);
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

    final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: true);
    final int _currentSlideIndex = _activeFlyerProvider.currentSlideIndex;
    final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;
    final CountryModel _bzCountry = _activeFlyerProvider.activeFlyerBzCountry;
    final CityModel _bzCity = _activeFlyerProvider.activeFlyerBzCity;
    final bool _followIsOn = _activeFlyerProvider.followIsOn;

    const double _followCallScaleEnd = 1.5;
    final double _followCallPaddingEnd = FollowAndCallBTs.getPaddings(flyerBoxWidth: widget.flyerBoxWidth) * _followCallScaleEnd;
    final double _followCallBoxWidthEnd = FollowAndCallBTs.getBoxWidth(flyerBoxWidth: widget.flyerBoxWidth) * 1.5;
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
      ..end = canLoopList(widget.flyerModel.slides) == false ? Colorz.blackSemi230
          :
      widget.flyerModel.slides[_currentSlideIndex].midColor;

    _headerCornerTween
      ..begin = Borderers.superHeaderCorners(
        context: context,
        bzPageIsOn: false,
        flyerBoxWidth: widget.flyerBoxWidth,
      )
      ..end = Borderers.superFlyerCorners(context, widget.flyerBoxWidth);
    // ..begin = Scale.superHeaderHeight(false, widget.flyerBoxWidth)
    // ..end = Scale.superFlyerZoneHeight(context, widget.flyerBoxWidth);

    _logoCornersTween
      ..begin = Borderers.superLogoCorner(
        context: context,
        flyerBoxWidth: widget.flyerBoxWidth,
        zeroCornerIsOn: true,
      ) //widget.superFlyer.flyerShowsAuthor)
      ..end = Borderers.superLogoCorner(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth * _logoScaleRatio);

    _headerHeightTween = Tween<double>(
      begin: _headerBoxHeight,
      end: OldFlyerBox.height(context, widget.flyerBoxWidth),
    ).animate(_headerAnimationController);

    _logoSizeRatioTween = Tween<double>(
      begin: 1,
      end: _logoScaleRatio,
    ).animate(_headerAnimationController);

    _headerLeftSpacerTween = Tween<double>(
      begin: 0, //Ratioz.xxflyerHeaderMainPadding * widget.flyerBoxWidth,
      end: (widget.flyerBoxWidth * 0.2) - _followCallPaddingEnd,
    ).animate(_headerAnimationController);

    _headerRightSpacerTween = Animators.animateDouble(
      begin: 0,
      end: (widget.flyerBoxWidth * 0.2) - _followCallBoxWidthEnd - _followCallPaddingEnd,
      controller: _headerAnimationController,
    );

    _headerLabelsWidthTween = Tween<double>(
      begin: HeaderLabels.getHeaderLabelWidth(widget.flyerBoxWidth),
      end: 0,
    ).animate(_headerAnimationController);

    _logoToHeaderLabelsSpacerWidthTween = Animators.animateDouble(
      begin: 0,
      end: _followCallPaddingEnd,
      controller: _headerAnimationController,
    );

    final bool _closed = _isExpanded == false && _headerAnimationController.isDismissed == true;
    //------------------------------------------------------------o
    final double _slideHeightWithoutHeader = OldFlyerBox.height(context, widget.flyerBoxWidth) - _headerBoxHeight;
// -----------------------------------------------------------------------------
    final double labelsWidth = HeaderLabels.getHeaderLabelWidth(_headerBoxHeight);
    final double labelsHeight = _headerBoxHeight *
        (Ratioz.xxflyerHeaderMiniHeight - (2 * Ratioz.xxflyerHeaderMainPadding));
// -----------------------------------------------------------------------------
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
                    physics: _tinyMode == true || _isExpanded == false ?
                    const NeverScrollableScrollPhysics()
                        :
                    const BouncingScrollPhysics(),
                    controller: _verticalController,
                    children: <Widget>[

                      /// MINI HEADER STRIP
                      Container(
                        width: widget.flyerBoxWidth,
                        height: (_headerBoxHeight * _logoSizeRatioTween.value) + (_headerLeftSpacerTween.value),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: _headerLeftSpacerTween.value),
                        decoration: BoxDecoration(
                          color: _tinyMode == true
                              ? Colorz.white50
                              : Colorz.black80,
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
                                height:
                                _logoSizeBegin * _logoSizeRatioTween.value,
                                // color: Colorz.BloodTest,
                              ),
                            ),

                            /// LOGO
                            BzLogo(
                              width: _logoSizeBegin * _logoSizeRatioTween.value,
                              image: widget.bzModel?.logo,
                              tinyMode: OldFlyerBox.isTinyMode(context, widget.flyerBoxWidth),
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


                                    if (_tinyMode == false)
                                    SizedBox(
                                        width: labelsWidth,
                                        height: labelsHeight,
                                        // color: Colorz.Bl,
                                        child: Column(
                                          mainAxisAlignment: widget.flyerModel.showsAuthor == true ?
                                          MainAxisAlignment.end
                                              :
                                          MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[

                                            /// BUSINESS LABEL : BZ.NAME & BZ.LOCALE
                                            BzLabel(
                                              flyerBoxWidth: widget.flyerBoxWidth,
                                              bzModel: widget.bzModel,
                                              bzCity: _bzCity,
                                              bzCountry: _bzCountry,
                                              flyerShowsAuthor: widget.flyerModel.showsAuthor,
                                              headerIsExpanded: _headerIsExpanded,
                                            ),

                                            /// middle expander ,, will delete i don't like it
                                            if (widget.flyerModel.showsAuthor == false)
                                              const Expander(),

                                            /// AUTHOR LABEL : AUTHOR.IMAGE, AUTHOR.NAME, AUTHOR.TITLE, BZ.FOLLOWERS
                                            if (widget.flyerModel.showsAuthor == true)
                                              AuthorLabel(
                                                flyerBoxWidth: widget.flyerBoxWidth,
                                                bzModel: widget.bzModel,
                                                authorID: widget.flyerModel.authorID,
                                                showLabel: _headerIsExpanded,
                                                authorGalleryCount: 0, // is not needed here
                                                labelIsOn: true,
                                                onTap: null,
                                              ),

                                          ],
                                        )),

                                  ],
                                ),
                              ),
                            ),

                            /// FOLLOW AND CALL
                            Center(
                              child: Container(
                                width: FollowAndCallBTs.getBoxWidth(
                                    flyerBoxWidth: widget.flyerBoxWidth) * _followCallButtonsScaleTween.value,
                                height: _logoSizeBegin * _logoSizeRatioTween.value,
                                alignment: Alignment.topCenter,
                                // color: Colorz.BloodTest,
                                child: FollowAndCallBTs(
                                  flyerBoxWidth: widget.flyerBoxWidth * _followCallButtonsScaleTween.value,
                                  headerIsExpanded: _headerIsExpanded,
                                  followIsOn: _followIsOn,
                                  onCallTap: _onCallTap,
                                  onFollowTap: _onFollowTap,
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
                        child: BzPageHeadline(
                          flyerBoxWidth: widget.flyerBoxWidth,
                          bzPageIsOn: true,
                          bzModel: widget.bzModel,
                          country: _bzCountry,
                          city: _bzCity,
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
                              bzPageIsOn: _isExpanded,
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
      child: _closed == true ? null : Container(
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
