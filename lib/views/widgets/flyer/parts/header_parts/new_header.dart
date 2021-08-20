import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:flutter/material.dart';

class NewHeader extends StatefulWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;
  final bool initiallyExpanded;


  const NewHeader({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
    this.initiallyExpanded = false,
  });

  @override
  _NewHeaderState createState() => _NewHeaderState();
}

class _NewHeaderState extends State<NewHeader> with SingleTickerProviderStateMixin  {
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

    _verticalController = ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
    _controller = new AnimationController(duration: Ratioz.durationFading200, vsync: this);


    _backgroundColorTween = new ColorTween();
    _animation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _headerCornerTween = new BorderRadiusTween();
    _logoCornersTween = new BorderRadiusTween();
    _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) {_controller.value = 1.0;}


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

        if (_isExpanded){
          _controller.forward();
        }

        else {

          _controller.reverse().then<void>((dynamic value) async {

            await _verticalController.animateTo(0, duration: Ratioz.durationSliding410, curve: Curves.easeOut);

            setState(() {
              // Rebuild without widget.children.
            });
          });
        }

        PageStorage.of(context)?.writeState(context, _isExpanded);
        // widget.superFlyer.nav.bzPageIsOn = !widget.superFlyer.nav.bzPageIsOn;

      });

      widget.superFlyer.nav.onHeaderTap(_isExpanded);

      // if (widget.onHeaderTap != null) {
      //   widget.onHeaderTap(_isExpanded);
      // }

    }
  }
// -----------------------------------------------------------------------------
  void _statelessFadeMaxHeader(){
    print('_maxHeaderOpacity = $_maxHeaderOpacity');

    Future.delayed(Ratioz.durationFading200, (){
      if (_maxHeaderOpacity == 1){
        _maxHeaderOpacity = 0;
      }
      else {
        _maxHeaderOpacity = 1;
      }
    });

  }
// -----------------------------------------------------------------------------
  Animation<double> animateDouble({double begin, double end, AnimationController controller}){
    return
      Tween<double>(
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

    double _followCallScaleEnd = 1.5;
    double _followCallPaddingEnd = FollowAndCallBTs.getPaddings(flyerZoneWidth: widget.flyerZoneWidth) * _followCallScaleEnd;
    double _followCallBoxWidthEnd = (FollowAndCallBTs.getBoxWidth(flyerZoneWidth: widget.flyerZoneWidth) * 1.5);
    double _logoSizeBegin = Scale.superLogoWidth(false, widget.flyerZoneWidth);
    double _logoSizeEnd = widget.flyerZoneWidth * 0.6;
    double _logoScaleRatio = _logoSizeEnd / _logoSizeBegin;

    bool _tinyMode = Scale.superFlyerTinyMode(context, widget.flyerZoneWidth);

    //--------------------------------o
    _backgroundColorTween
      ..begin = _tinyMode == true ? Colorz.Nothing :  Colorz.BlackSemi230
      ..end = widget.superFlyer.mSlides == null || widget.superFlyer.mSlides.length == 0 ?
      Colorz.BlackSemi230 : widget.superFlyer.mSlides[widget.superFlyer.currentSlideIndex].midColor;

    _headerCornerTween
      ..begin = Borderers.superHeaderCorners(context, false, widget.flyerZoneWidth)
      ..end = Borderers.superFlyerCorners(context, widget.flyerZoneWidth);
    // ..begin = Scale.superHeaderHeight(false, widget.flyerZoneWidth)
    // ..end = Scale.superFlyerZoneHeight(context, widget.flyerZoneWidth);

    _logoCornersTween
      ..begin = Borderers.superLogoCorner(context: context, flyerZoneWidth: widget.flyerZoneWidth, zeroCornerIsOn: true,)//widget.superFlyer.flyerShowsAuthor)
      ..end = Borderers.superLogoCorner(context: context, flyerZoneWidth: widget.flyerZoneWidth * _logoScaleRatio, zeroCornerIsOn: false);

    _headerHeightTween = Tween<double>(
      begin: Scale.superHeaderHeight(false, widget.flyerZoneWidth),
      end: Scale.superFlyerZoneHeight(context, widget.flyerZoneWidth),
    ).animate(_controller);

    _logoSizeRatioTween = Tween<double>(
      begin: 1,
      end: _logoScaleRatio,
    ).animate(_controller);

    _headerLeftSpacerTween = Tween<double>(
      begin: 0,//Ratioz.xxflyerHeaderMainPadding * widget.flyerZoneWidth,
      end: (widget.flyerZoneWidth * 0.2) - _followCallPaddingEnd,
    ).animate(_controller);

    _headerRightSpacerTween = animateDouble(
      begin: 0,
      end: (widget.flyerZoneWidth * 0.2) - _followCallBoxWidthEnd - _followCallPaddingEnd,
      controller: _controller,
    );

    _headerLabelsWidthTween = Tween<double>(
      begin: HeaderLabels.getHeaderLabelWidth(widget.flyerZoneWidth),
      end: 0,
    ).animate(_controller);

    _logoToHeaderLabelsSpacerWidthTween = animateDouble(
      begin: 0,
      end: _followCallPaddingEnd,
      controller: _controller,
    );

    final bool _closed = _isExpanded == false && _controller.isDismissed == true;
    //------------------------------------------------------------o
    final _slideHeightWithoutHeader = Scale.superFlyerZoneHeight(context, widget.flyerZoneWidth) - Scale.superHeaderHeight(false, widget.flyerZoneWidth);



    return AnimatedBuilder(
      animation: _controller.view,
      builder: (ctx, child){

        final Color _headerColor = _backgroundColorTween.evaluate(_animation);
        final BorderRadius _headerBorders = _headerCornerTween.evaluate(_animation);
        final BorderRadius _logoBorders = _logoCornersTween.evaluate(_animation);

        return

          GestureDetector(
            onTap: _tinyMode == true ? null : toggle,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: widget.flyerZoneWidth,
                height: _headerHeightTween.value,
                // margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: _headerColor,
                  borderRadius: _headerBorders,
                ),
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: _headerBorders,
                  child: new GoHomeOnMaxBounce(
                    // onNavigate: collapse,
                    child: ListView(
                      shrinkWrap: false,
                      physics: _tinyMode == true || _isExpanded == false ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      controller: _verticalController,
                      children: <Widget>[

                        /// MINI HEADER STRIP
                        Container(
                          width: widget.flyerZoneWidth,
                          height: (Scale.superHeaderHeight(false, widget.flyerZoneWidth) * _logoSizeRatioTween.value) + (_headerLeftSpacerTween.value),
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: _headerLeftSpacerTween.value),
                          decoration: BoxDecoration(
                            color: _tinyMode == true ? Colorz.White50 :  Colorz.Black80,
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
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              /// HEADER LEFT SPACER
                              Center(
                                child: Container(
                                  width: _headerLeftSpacerTween.value,
                                  height: _logoSizeBegin * _logoSizeRatioTween.value,
                                  // color: Colorz.BloodTest,
                                ),
                              ),

                              /// LOGO
                              BzLogo(
                                width: _logoSizeBegin * _logoSizeRatioTween.value,
                                image: widget.superFlyer.bz.bzLogo,
                                tinyMode: Scale.superFlyerTinyMode(context, widget.flyerZoneWidth),
                                corners: _logoBorders,
                                bzPageIsOn: widget.superFlyer.nav.bzPageIsOn,
                                zeroCornerIsOn: widget.superFlyer.flyerShowsAuthor,
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
                                child: Container(
                                  width: _logoToHeaderLabelsSpacerWidthTween.value,
                                  height: _logoSizeBegin * _logoSizeRatioTween.value,
                                ),
                              ),

                              /// HEADER LABELS
                              Center(
                                child: Container(
                                  width: _headerLabelsWidthTween.value,
                                  height: _logoSizeBegin * _logoSizeRatioTween.value,
                                  child: ListView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      HeaderLabels(
                                        superFlyer: widget.superFlyer,
                                        flyerZoneWidth: widget.flyerZoneWidth * _logoSizeRatioTween.value,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// FOLLOW AND CALL
                              Center(
                                child: Container(
                                  width: FollowAndCallBTs.getBoxWidth(flyerZoneWidth: widget.flyerZoneWidth) * _followCallButtonsScaleTween.value,
                                  height: _logoSizeBegin * _logoSizeRatioTween.value,
                                  alignment: Alignment.topCenter,
                                  // color: Colorz.BloodTest,
                                  child: FollowAndCallBTs(
                                    flyerZoneWidth: widget.flyerZoneWidth * _followCallButtonsScaleTween.value,
                                    superFlyer: widget.superFlyer,
                                  ),
                                ),
                              ),

                              /// HEADER RIGHT SPACER
                              Center(
                                child: Container(
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
                          color: Colorz.Black80,
                          child: BzPageHeadline(
                            flyerZoneWidth: widget.flyerZoneWidth,
                            bzPageIsOn: true,
                            tinyBz: SuperFlyer.getTinyBzFromSuperFlyer(widget.superFlyer),
                          ),
                        ),

                        if (_isExpanded == true)
                          AnimatedOpacity(
                            duration: Ratioz.durationSliding400,
                            curve: Curves.easeIn,
                            opacity: _maxHeaderOpacity,
                            child: Container(
                              width: widget.flyerZoneWidth,
                              // height: 400,
                              // color: Colorz.Yellow200,
                              child: MaxHeader(
                                superFlyer: widget.superFlyer,
                                flyerZoneWidth: widget.flyerZoneWidth,
                                bzPageIsOn: _isExpanded,
                                tinyBz: SuperFlyer.getTinyBzFromSuperFlyer(widget.superFlyer),
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
                //     //     flyerZoneWidth: widget.flyerZoneWidth,
                //     //   ),
                //     // ),
                //     //
                //     // /// EXPANDABLE ZONE
                //     // ClipRRect(
                //     //   borderRadius: Borderers.superBorderOnly(
                //     //     context: context,
                //     //     enTopLeft: 0,
                //     //     enTopRight: 0,
                //     //     enBottomLeft: Ratioz.xxflyerBottomCorners * widget.flyerZoneWidth,
                //     //     enBottomRight: Ratioz.xxflyerBottomCorners * widget.flyerZoneWidth,
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
        width: widget.flyerZoneWidth,
        height: _slideHeightWithoutHeader,
        decoration: BoxDecoration(
          color: Colorz.BloodTest,
          borderRadius: Borderers.superBorderOnly(
            context: context,
            enTopLeft: 0,
            enTopRight: 0,
            enBottomLeft: Ratioz.xxflyerBottomCorners * widget.flyerZoneWidth,
            enBottomRight: Ratioz.xxflyerBottomCorners * widget.flyerZoneWidth,
          ),
        ),
      )
      ,
    );
  }
}
