import 'dart:async';

import 'package:bldrs/b_views/a_starters/a_logo_screen/x_logo_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:filers/filers.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:widget_fader/widget_fader.dart';

class AnimatedLogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AnimatedLogoScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<AnimatedLogoScreen> createState() => _AnimatedLogoScreenState();
  /// --------------------------------------------------------------------------
  static const double trackLength = 8775; // milli seconds
  /// --------------------------------------------------------------------------
  static double getBeatRatio(double milliSecond) {
    return milliSecond / trackLength;
  }
  // --------------------
  static Map<String, dynamic> createBeat({
    @required double start, // in milliseconds
    @required double duration, // in milliseconds
    @required String text,
    Color color = Colorz.white255,
  }) {
    return {
      'first': getBeatRatio(start),
      'second': getBeatRatio(start + duration),
      'verse': text,
      'color': color,
    };
  }
  /// --------------------------------------------------------------------------
}

class _AnimatedLogoScreenState extends State<AnimatedLogoScreen> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _linesMap;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _linesMap = <Map<String, dynamic>>[
      AnimatedLogoScreen.createBeat(
          start: 1900,
          duration: 200,
          text: xPhrase(context, 'phid_search'),
          color: Colorz.white200),
      // 1
      AnimatedLogoScreen.createBeat(
          start: 2800,
          duration: 200,
          text: xPhrase(context, 'phid_connect'),
          color: Colorz.white200),
      // 5
      AnimatedLogoScreen.createBeat(
          start: 2700, duration: 200, text: xPhrase(context, 'phid_ask'), color: Colorz.white200),
      // 4
      AnimatedLogoScreen.createBeat(
          start: 2350,
          duration: 450,
          text: xPhrase(context, 'phid_answer'),
          color: Colorz.white200),
      // 3
      AnimatedLogoScreen.createBeat(
          start: 2000, duration: 450, text: xPhrase(context, 'phid_grow'), color: Colorz.white200),
      // 2
      AnimatedLogoScreen.createBeat(
          start: 4700, duration: 300, text: xPhrase(context, 'phid_on'), color: Colorz.white200),
      // 6
      AnimatedLogoScreen.createBeat(
          start: 5550,
          duration: 1000,
          text: xPhrase(context, 'phid_bldrsFullName'),
          color: Colorz.yellow255),
      // 10
      AnimatedLogoScreen.createBeat(
          start: 4800, duration: 300, text: '- ${xPhrase(context, 'phid_designers')}'),
      // 7
      AnimatedLogoScreen.createBeat(
          start: 5150, duration: 300, text: '- ${xPhrase(context, 'phid_contractors')}'),
      // 8
      AnimatedLogoScreen.createBeat(
          start: 5450, duration: 300, text: '- ${xPhrase(context, 'phid_artisans')}'),
      // 9
    ];

    _initializeAnimationControllers();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading(setTo: true).then((_) async {
        Keyboard.closeKeyboard(context);

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
            goToRoute: Routing.home,
          );

        });

        await _triggerLoading(setTo: false);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    // _sloganAniController.dispose();
    _sloganCurvedAnimation.dispose();
    _logoAniController.dispose();
    _logoCurvedAnimation.dispose();

    if (Mapper.checkCanLoopList(_linesControllers) == true) {
      for (final CurvedAnimation cont in _linesControllers) {
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
  void _initializeAnimationControllers() {
    /// LOGO CONTROLLERS
    _logoAniController =
        AnimationController(duration: const Duration(milliseconds: 8500), vsync: this);

    _logoCurvedAnimation = CurvedAnimation(
      parent: _logoAniController,
      curve: Interval(
        AnimatedLogoScreen.getBeatRatio(600),
        AnimatedLogoScreen.getBeatRatio(1800),
        curve: Curves.easeInOutExpo,
      ),
    );

    _sloganCurvedAnimation = CurvedAnimation(
      parent: _logoAniController,
      curve: Interval(
        AnimatedLogoScreen.getBeatRatio(3200),
        AnimatedLogoScreen.getBeatRatio(4500),
        curve: Curves.easeInOutExpo,
      ),
    );

    _linesControllers = _initializedLinesAnimations();
  }
  // --------------------
  List<CurvedAnimation> _initializedLinesAnimations() {
    final List<CurvedAnimation> _animations = <CurvedAnimation>[];
    for (final Map<String, dynamic> map in _linesMap) {
      final CurvedAnimation _curvedAni = CurvedAnimation(
        parent: _logoAniController,
        curve: Interval(
          map['first'],
          map['second'],
          curve: Curves.easeInOutExpo,
        ),
      );
      _animations.add(_curvedAni);
    }

    return _animations;
  }
  // -----------------------------------------------------------------------------

  /// ANIMATION SEQUENCES

  // --------------------
  Future<void> _startAnimationSequence() async {
    // _isPlaying.value  = true;
    // _restartControllers();
    unawaited(BldrsSounder.playIntro());
    await _animateLogoLine();
    // _isPlaying.value  = false;
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
    _logoAniController.value  = 0;
  }
  final ValueNotifier<bool> _isPlaying = ValueNotifier(false);
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------------------
    const double _logoWidth = 200;
    const double _logoHeight = 50;
    const double _logoBox = _logoWidth * 3;
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    final double _leftOffset = _screenWidth - Ratioz.pyramidsWidth - (_logoBox * 0.5) + 30;
    // -----------------------------------------------------------------------------
    return MainLayout(
      pyramidsAreOn: true,
      pyramidType: PyramidType.yellow,
      appBarType: AppBarType.non,
      // onBack: () async {
      //
      //   await Nav.replaceScreen(
      //       context: context,
      //       screen: const AnimatedLogoScreen(),
      //   );
      //
      // },
      canGoBack: false,
      child: Stack(
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
                    child: WebsafeSvg.asset(
                      Iconz.bldrsNameSingleLine,
                      fit: BoxFit.fitHeight,
                      // package: Iconz.bldrsTheme,
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
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.only(right: _val * 300),
                              child: const SuperVerse(
                                verse: Verse(
                                  id: 'phid_bldrsTagLine',
                                  translate: true,
                                  casing: Casing.upperCase,
                                ),
                                shadow: true,
                                scaleFactor: 1.8,
                                margin: EdgeInsets.only(bottom: 10),
                                // italic: true,
                              ),
                            ),
                          );
                        }),

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
            margin: Scale.superInsets(
              context: context,
              appIsLTR: UiProvider.checkAppIsLeftToRight(context),
              top: _screenWidth * 0.07,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                ...List.generate(_linesControllers.length, (index) {
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
          // Container(
          //   width: Scale.screenWidth(context),
          //   height: Scale.screenHeight(context),
          //   // color: Colorz.bloodTest,
          //   alignment: Alignment.topRight,
          //   child: Column(
          //     children: [
          //
          //       /// REPLAY
          //       DreamBox(
          //         width: 50,
          //         height: 50,
          //         icon: Iconz.play,
          //         iconSizeFactor: 0.6,
          //         onTap: () async {
          //
          //           await _startAnimationSequence();
          //
          //         },
          //       ),
          //
          //       /// CHANGE LANG
          //       DreamBox(
          //         width: 50,
          //         height: 50,
          //         icon: Iconz.language,
          //         iconSizeFactor: 0.6,
          //         onTap: () async {
          //           WaitDialog.showUnawaitedWaitDialog(context: context);
          //
          //           final PhraseProvider _phraseProvider =
          //               Provider.of<PhraseProvider>(context, listen: false);
          //
          //           String langCode = PhraseProvider.proGetCurrentLangCode(
          //             context: context,
          //             listen: false,
          //           );
          //
          //           langCode = langCode == 'en' ? 'ar' : 'en';
          //
          //           await Localizer.changeAppLanguage(context, langCode);
          //
          //           await _phraseProvider.fetchSetCurrentLangAndAllPhrases(
          //             context: context,
          //             setLangCode: langCode,
          //           );
          //
          //           await WaitDialog.closeWaitDialog(context);
          //
          //           await Nav.replaceScreen(
          //             context: context,
          //             screen: const AnimatedLogoScreen(),
          //           );
          //         },
          //       ),
          //
          //     ],
          //   ),
          // ),

        ],
      ),
    );
    // -----------------------------------------------------------------------------
  }
  // -----------------------------------------------------------------------------
}

/// PLAN : NEED TO PUT THESE STATEMENTS FOR BZZ
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
    final double _screenWidth = Scale.screenWidth(context);
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
                left: -_screenWidth,
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
        width: 220,
        height: 35,
        child: SuperVerse(
          verse: Verse(
            id: verse,
            casing: Casing.upperCase,
            translate: false,
          ),
          textDirection: TextDirection.ltr,
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
