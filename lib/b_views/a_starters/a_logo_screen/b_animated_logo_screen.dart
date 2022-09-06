import 'dart:async';

import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/x_logo_screen_controllers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AnimatedLogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AnimatedLogoScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<AnimatedLogoScreen> createState() => _AnimatedLogoScreenState();
  /// --------------------------------------------------------------------------
}

class _AnimatedLogoScreenState extends State<AnimatedLogoScreen> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'AnimatedLogoScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _linesMap;
  // --------------------
  static const double _trackLength = 8775; // milli seconds
  // --------------------
  double _toRatio(double milliSecond){
    return milliSecond / _trackLength;
  }
  // --------------------
  Map<String, dynamic> _beat({
    @required double start, // in milliseconds
    @required double duration,// in milliseconds
    @required String verse,
    Color color = Colorz.white255,
  }){
    return {
      'first' : _toRatio(start),
      'second' : _toRatio(start + duration),
      'verse': verse,
      'color' : color,
    };
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();


    _linesMap = <Map<String, dynamic>>[
      _beat(start: 1900, duration: 200,   verse: '##Search'),  // 1
      _beat(start: 2800, duration: 200,   verse: '##Connect'), // 5
      _beat(start: 2700, duration: 200,   verse: '##Ask'), // 4
      _beat(start: 2350, duration: 450,   verse: '##Answer'), // 3
      _beat(start: 2000, duration: 450,   verse: '##Grow'), // 2

      _beat(start: 4700,  duration: 300,  verse: '##on'), // 6
      _beat(start: 5550,  duration: 1000, verse: '##Bldrs.net', color: Colorz.yellow255), // 10
      _beat(start: 4800,  duration: 300,  verse: '## - Designers'), // 7
      _beat(start: 5150,  duration: 300,  verse: '## - Contractors'), // 8
      _beat(start: 5450,  duration: 300,  verse: '## - Artisans'), // 9
    ];

    _initializeAnimationControllers();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {

        await Future.delayed(const Duration(milliseconds: 500), () async {

          await Future.wait(<Future<void>>[

            initializeLogoScreen(
              context: context,
              mounted: mounted,
            ),

            _startAnimationSequence(),

          ]);

          await Nav.pushNamedAndRemoveAllBelow(
            context: context,
            goToRoute: Routez.home,
          );

        });


        // await _triggerLoading();
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {

    _loading.dispose();
    // _sloganAniController.dispose();
    _sloganCurvedAnimation.dispose();
    _logoAniController.dispose();
    _logoCurvedAnimation.dispose();

    if (Mapper.checkCanLoopList(_linesControllers) == true){
      for (final CurvedAnimation cont in _linesControllers){
        cont.dispose();
      }
    }

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  final Tween<double> _tween = Tween<double>(begin: 0, end: 1);
  AnimationController _logoAniController;
  CurvedAnimation _logoCurvedAnimation;
  CurvedAnimation _sloganCurvedAnimation;
  List<CurvedAnimation> _linesControllers;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  void _initializeAnimationControllers(){

    /// LOGO CONTROLLERS
    _logoAniController = AnimationController(
        duration: const Duration(milliseconds: 8500),
        vsync: this
    );

    _logoCurvedAnimation = CurvedAnimation(
      parent: _logoAniController,
      curve:  Interval(_toRatio(600), _toRatio(1800), curve: Curves.easeInOutExpo,),

    );

    _sloganCurvedAnimation = CurvedAnimation(
      parent: _logoAniController,
      curve: Interval(_toRatio(3200), _toRatio(4500), curve: Curves.easeInOutExpo,),
    );

    _linesControllers = _initializedLinesAnimations();
  }
  // --------------------
  List<CurvedAnimation> _initializedLinesAnimations(){

    final List<CurvedAnimation> _animations = <CurvedAnimation>[];
    for (final Map<String, dynamic> map in _linesMap){
      final CurvedAnimation _curvedAni = CurvedAnimation(
        parent: _logoAniController,
        curve: Interval(map['first'], map['second'], curve: Curves.easeInOutExpo,),
      );
      _animations.add(_curvedAni);
    }

    return _animations;
  }
  // -----------------------------------------------------------------------------

  /// ANIMATION SEQUENCES

  // --------------------
  Future<void> _startAnimationSequence() async {
    // _isPlaying.value = true;
    // _restartControllers();
    unawaited(Sounder.playIntro());
    await _animateLogoLine();
    // _isPlaying.value = false;
  }
  // --------------------
  Future<void> _animateLogoLine() async {
    await _logoAniController.forward(from: 0);
  }
  // -----------------------------------------------------------------------------

  /// RESTARTING ( FOR TESTING ONLY)

  // --------------------
  /*
  void _restartControllers(){
    _logoAniController.value = 0;
  }
  final ValueNotifier<bool> _isPlaying = ValueNotifier(false);
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // /// for dev
    // _initializeAnimationControllers();

    const double _logoWidth = 200;
    const double _logoHeight = 50;
    const double _logoBox = _logoWidth * 3;
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    final double _leftOffset = _screenWidth - Ratioz.pyramidsWidth - (_logoBox * 0.5) + 30;

    return MainLayout(
      pyramidsAreOn: true,
      pyramidType: PyramidType.yellow,
      appBarType: AppBarType.non,
      // loading: ValueNotifier(true),
      onBack: (){
        Nav.closeApp(context);
      },
      layoutWidget: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// FADING SPLASH LOGO
          const WidgetFader(
            fadeType: FadeType.fadeOut,
            curve: Curves.easeOutQuint,
            duration: Duration(milliseconds: 400),
            child: LogoSlogan(
              sizeFactor: 0.75,
            ),
          ),

          /// SLIDING LOGO
          Positioned(
            bottom: 20,
            left: _leftOffset,
            child: Transform.rotate(
              angle: Numeric.degreeToRadian(-45),
              alignment: Alignment.bottomCenter,
              child: Transform.scale(
                scale: 2,
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  animation: _logoCurvedAnimation,
                  builder: (BuildContext context, Widget child) {

                    final double _val = _tween.evaluate(_logoCurvedAnimation);

                    return Opacity(
                      opacity: _val > 1 ? 1 : _val,
                      child: Container(
                        width: _logoBox,
                        height: _logoHeight,
                        padding: EdgeInsets.only(right: _val * _logoWidth * 0.71),
                        alignment: Alignment.centerRight,
                        child: child,
                      ),
                    );

                  },
                  child: SizedBox(
                    width: _logoWidth,
                    height: _logoHeight,
                    child: WebsafeSvg.asset(Iconz.bldrsNameSingleLine,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// SLIDING SLOGAN
          Positioned(
            bottom: 20,
            left: _leftOffset,
            child: Transform.rotate(
              angle: Numeric.degreeToRadian(-45),
              alignment: Alignment.bottomCenter,
              child: Transform.scale(
                scale: 2,
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    AnimatedBuilder(
                        animation: _sloganCurvedAnimation,
                        builder: (BuildContext context, Widget child) {

                          final double _val = _tween.evaluate(_sloganCurvedAnimation);

                          return Opacity(
                            opacity: _val > 1 ? 1 : _val,
                            child: Container(
                              width: 700,
                              height: 50,
                              // color: Colorz.bloodTest,
                              alignment: Alignment.bottomRight,
                              padding: EdgeInsets.only(right: _val * 300),
                              child: SuperVerse(
                                verse: "THE BUILDER'S NETWORK",
                                shadow: true,
                                scaleFactor: 1.8,
                                margin: Scale.superInsets(context: context, bottom: 10),
                                // italic: true,
                              ),
                            ),
                          );

                        }
                    ),

                    const SizedBox(
                      width: _logoBox,
                      height: _logoHeight,
                    ),

                  ],
                ),
              ),
            ),
          ),

          /// LINES
          Container(
            width: _screenWidth,
            height: _screenHeight,
            alignment: Alignment.centerLeft,
            margin: Scale.superInsets(context: context, top: _screenWidth * 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                ...List.generate(_linesControllers.length, (index){
                  return AnimatedLine(
                    curvedAnimation: _linesControllers[index],
                    tween: _tween,
                    verse: _linesMap[index]['verse'],
                    verseColor: _linesMap[index]['color'],
                  );
                })

              ],

            ),
          ),

          /// FOR DEV ONLY
          // /// PLAY BUTTON
          // Container(
          //   width: superScreenWidth(context),
          //   height: superScreenHeight(context),
          //   // color: Colorz.bloodTest,
          //   alignment: Alignment.topRight,
          //   child: ValueListenableBuilder(
          //       valueListenable: _isPlaying,
          //       builder: (_, bool isPlaying, Widget child) {
          //
          //         return DreamBox(
          //           width: 50,
          //           height: 50,
          //           icon: isPlaying ? Iconz.stop : Iconz.play,
          //           iconSizeFactor: 0.6,
          //           onTap: isPlaying ?
          //               /// when playing
          //               (){
          //             _isPlaying.value = false;
          //             _restartControllers();
          //             _logoAniController.stop();
          //           }
          //           :
          //               /// when paused
          //               () async {
          //
          //                 await _startAnimationSequence();
          //             },
          //         );
          //
          //       }
          //       ),
          // ),

        ],
      ),
    );
  }
  // -----------------------------------------------------------------------------
}

/// TASK : NEED TO PUT THESE STATEMENTS FOR BZZ
///  - NO SUBSCRIPTION FEES
///  - NO SALES COMMISSION
///  - SHARE YOUR WORK AND YOUR SOCIAL MEDIA LINKS
///  - BLDRS COMMUNITY IS REFERRAL COMMUNITY
///  - NO VIOLATIONS ALLOWED
///  ...

class AnimatedLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AnimatedLine({
    @required this.curvedAnimation,
    @required this.tween,
    @required this.verse,
    @required this.verseColor,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CurvedAnimation curvedAnimation;
  final Tween<double> tween;
  final String verse;
  final Color verseColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // --------------------
    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (BuildContext context, Widget child) {

        final double _val = tween.evaluate(curvedAnimation);

        return SizedBox(
          width: _screenWidth,
          height: 35,
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[

              Positioned(
                left: - _screenWidth,
                top: 0,
                child: Opacity(
                  opacity: _val > 1 ? 1 : _val,
                  child: Container(
                    width: _screenWidth * 2,
                    height: 35,
                    // color: Colorz.bloodTest,
                    padding: EdgeInsets.only(left: _val * _screenWidth * 1.1),
                    alignment: Alignment.centerLeft,
                    child: child,
                  ),
                ),
              ),

            ],
          ),
        );

      },
      child: SizedBox(
        width: 200,
        height: 35,
        child: SuperVerse(
          verse: verse.toUpperCase(),
          size: 3,
          weight: VerseWeight.black,
          italic: true,
          shadow: true,
          centered: false,
          color: verseColor,
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
