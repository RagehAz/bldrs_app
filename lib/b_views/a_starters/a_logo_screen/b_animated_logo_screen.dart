import 'dart:async';

import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/animators/widgets/widget_waiter.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/texting/customs/leading_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_initialization_protocols/a_initializer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_sounder.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AnimatedLogoScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AnimatedLogoScreen({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  State<AnimatedLogoScreen> createState() => _AnimatedLogoScreenState();
  /// --------------------------------------------------------------------------
  static const int trackLength = 8500; // milli seconds
  /// --------------------------------------------------------------------------
  static double getBeatRatio(double milliSecond) {
    return milliSecond / trackLength;
  }
  // --------------------
  static Map<String, dynamic> createBeat({
    required double start, // in milliseconds
    required double duration, // in milliseconds
    required String? text,
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
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  List<Map<String, dynamic>>? _linesMap;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _createLinesMap();

    _initializeAnimationControllers();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await Keyboard.closeKeyboard();

        bool _loadApp = false;

        await Future.delayed(const Duration(milliseconds: 100), () async {

          await Future.wait(<Future<void>>[

            Future.delayed(const Duration(milliseconds: AnimatedLogoScreen.trackLength),() async {
              await _triggerLoading(setTo: true);
            }),

            Initializer.logoScreenInitialize(
              context: context,
              mounted: mounted,
            ).then((bool loadApp){
              _loadApp = loadApp;
            }),

            _startAnimationSequence(),

          ]);

          if (_loadApp == true){
            await Initializer.routeAfterLoaded(
                context: context,
                mounted: mounted
            );
          }

          else {
            await BldrsNav. pushLogoRouteAndRemoveAllBelow(animatedLogoScreen: false);
          }

        });

      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
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
  late AnimationController _logoAniController;
  late CurvedAnimation _logoCurvedAnimation;
  late CurvedAnimation _sloganCurvedAnimation;
  late List<CurvedAnimation> _linesControllers;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  void _createLinesMap(){
    _linesMap = <Map<String, dynamic>>[
      AnimatedLogoScreen.createBeat(
          start: 1900,
          duration: 200,
          text: getWord('phid_search'),
          color: Colorz.white200
      ),
      // 1
      AnimatedLogoScreen.createBeat(
          start: 2800,
          duration: 200,
          text: getWord('phid_connect'),
          color: Colorz.white200),
      // 5
      AnimatedLogoScreen.createBeat(
          start: 2700,
          duration: 200,
          text: getWord('phid_ask'),
          color: Colorz.white200,
      ),
      // 4
      AnimatedLogoScreen.createBeat(
          start: 2350,
          duration: 450,
          text: getWord('phid_answer'),
          color: Colorz.white200),
      // 3
      AnimatedLogoScreen.createBeat(
          start: 2000, duration: 450, text: getWord('phid_grow'), color: Colorz.white200),
      // 2
      AnimatedLogoScreen.createBeat(
          start: 4700, duration: 300, text: getWord('phid_on'), color: Colorz.white200),
      // 6
      AnimatedLogoScreen.createBeat(
          start: 5550,
          duration: 1000,
          text: getWord('phid_bldrsFullName'),
          color: Colorz.yellow255),
      // 10
      AnimatedLogoScreen.createBeat(
          start: 4800, duration: 300, text: '- ${getWord('phid_realEstate')}'),
      // 7
      AnimatedLogoScreen.createBeat(
          start: 5150, duration: 300, text: '- ${getWord('phid_construction')}'),
      // 8
      AnimatedLogoScreen.createBeat(
          start: 5450, duration: 300, text: '- ${getWord('phid_supplies')}'),
      // 9
    ];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeAnimationControllers() {
    /// LOGO CONTROLLERS
    _logoAniController = AnimationController(
        duration: const Duration(milliseconds: AnimatedLogoScreen.trackLength),
        vsync: this
    );

    _logoCurvedAnimation = CurvedAnimation(
      parent: _logoAniController,
      curve: Interval(
        AnimatedLogoScreen.getBeatRatio(600),
        AnimatedLogoScreen.getBeatRatio(1800),
        curve: Curves.easeInOutExpo,
      ),
      // reverseCurve: Curves.easeOut,
    );

    _sloganCurvedAnimation = CurvedAnimation(
      parent: _logoAniController,
      curve: Interval(
        AnimatedLogoScreen.getBeatRatio(3200),
        AnimatedLogoScreen.getBeatRatio(4500),
        curve: Curves.easeInOutExpo,
      ),
      // reverseCurve: Curves.easeOut,
    );

    _linesControllers = _initializedLinesAnimations();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<CurvedAnimation> _initializedLinesAnimations() {
    final List<CurvedAnimation> _animations = <CurvedAnimation>[];

    if (Mapper.checkCanLoopList(_linesMap) == true){

      for (final Map<String, dynamic> map in _linesMap!) {
      final CurvedAnimation _curvedAni = CurvedAnimation(
        parent: _logoAniController,
        curve: Interval(
          map['first'],
          map['second'],
          curve: Curves.easeInOutExpo,
        ),
        // reverseCurve: Curves.easeOut,
      );
      _animations.add(_curvedAni);
    }

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
    await _logoAniController.reverse(from: 1);
  }
  // -----------------------------------------------------------------------------

  /// RESTARTING ( FOR_DEV_ONLY )

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
    // --------------------
    DynamicRouter.blogGo('AnimatedLogoScreen');
    // --------------------
    const double _logoWidth = 200;
    const double _logoHeight = 50;
    const double _logoBox = _logoWidth * 3;
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    final double _leftOffset = _screenWidth - Ratioz.pyramidsWidth - (_logoBox * 0.5) + 30;
    // -----------------------------------------------------------------------------
    return MainLayout(
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalYellow,
      appBarType: AppBarType.non,
      loading: _loading,
      skyType: SkyType.blackStars,
      canGoBack: false,
      /// FOR_DEV_ONLY
      // pyramidButtons: [
      //
      //   if (UsersProvider.userIsRage7() == true)
      //   PyramidFloatingButton(
      //     icon: Iconz.bz,
      //     onTap: () async {
      //     await BldrsNav.goToLogoScreenAndRemoveAllBelow(animatedLogoScreen: false);
      //     },
      //   ),
      //
      // ],
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// FADING SPLASH LOGO
          const WidgetFader(
            fadeType: FadeType.fadeOut,
            curve: Curves.easeOutQuint,
            duration: Duration(milliseconds: 400),
            child: LogoSlogan(),
          ),

          /// SLIDING LOGO
          Positioned(
            bottom: 20,
            left: _leftOffset,
            child: Transform.rotate(
              angle: Numeric.degreeToRadian(-45)!,
              alignment: Alignment.bottomCenter,
              child: Transform.scale(
                scale: 2,
                alignment: Alignment.bottomCenter,
                child: AnimatedBuilder(
                  animation: _logoCurvedAnimation,
                  builder: (BuildContext context, Widget? child) {
                    
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
                      width: _logoWidth,
                      height: _logoHeight,
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
              angle: Numeric.degreeToRadian(-45)!,
              alignment: Alignment.bottomCenter,
              child: Transform.scale(
                scale: 2,
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    AnimatedBuilder(
                        animation: _sloganCurvedAnimation,
                        builder: (BuildContext context, Widget? child) {
                          
                          final double _val = _tween.evaluate(_sloganCurvedAnimation);

                          return Opacity(
                            opacity: _val > 1 ? 1 : _val,
                            child: Container(
                              width: 700,
                              height: 50,
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.only(right: _val * 300),
                              child: const BldrsText(
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
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
              top: _screenWidth * 0.07,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                /// LINES
                if (Mapper.checkCanLoopList(_linesMap) == true)
                ...List.generate(_linesControllers.length, (index) {
                  return AnimatedLine(
                    curvedAnimation: _linesControllers[index],
                    tween: _tween,
                    verse: _linesMap![index]['verse'],
                    verseColor: _linesMap![index]['color'],
                  );
                }),

              ],
            ),
          ),

          /// LOADING
          Positioned(
            bottom: Ratioz.pyramidsHeight,
            right: 10,
            child: WidgetWaiter(
              waitDuration: const Duration(milliseconds: AnimatedLogoScreen.trackLength),
              child: LoadingVerse(
                builder: (Verse? verse){

                  final Verse _loadingVerse = getVerse('phid_loading')!;
                  final Verse _loading = verse ?? _loadingVerse;

                  return BldrsBox(
                    height: 20,
                    verse: _loading.copyWith(casing: Casing.upperCase),
                    verseScaleFactor: 0.9,
                    color: Colorz.yellow20,
                    verseWeight: VerseWeight.black,
                    bubble: false,
                    verseItalic: true,
                  );

                  },
              ),
            ),
          ),

          // /// RESTART
          // const SomethingWrongRestartButton(
          //   waitSeconds: Standards.loadingScreenTimeOut,
          // ),

          /// FOR_DEV_ONLY
          // Container(
          //   width: Scale.screenWidth(context),
          //   height: Scale.screenHeight(context),
          //   // color: Colorz.bloodTest,
          //   alignment: Alignment.topRight,
          //   child: Column(
          //     children: [
          //
          //       /// REPLAY
          //       BldrsBox(
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
          //       BldrsBox(
          //         width: 50,
          //         height: 50,
          //         icon: Iconz.language,
          //         iconSizeFactor: 0.6,
          //         onTap: () async {
          //           WaitDialog.showUnawaitedWaitDialog();
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
          //             setLangCode: langCode,
          //           );
          //
          //           await WaitDialog.closeWaitDialog();
          //
          //           await Nav.replaceScreen(
          //             context: context,
          //             screen: const AnimatedLogoScreen(),
          //           );
          //         },
          //       ),
          //
          //       /// GO BACK
          //       BldrsBox(
          //         width: 50,
          //         height: 50,
          //         icon: Iconz.arrowWhiteLeft,
          //         iconSizeFactor: 0.6,
          //         onTap: () => BldrsNav.goToLogoScreenAndRemoveAllBelow(animatedLogoScreen: false),
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

class AnimatedLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AnimatedLine({
    required this.curvedAnimation,
    required this.tween,
    required this.verse,
    required this.verseColor,
    super.key
  });
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
      builder: (BuildContext context, Widget? child) {
        
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
        child: BldrsText(
          verse: Verse(
            id: verse,
            casing: Casing.upperCase,
            translate: false,
          ),
          // textDirection: TextDirection.ltr,
          size: 3,
          weight: VerseWeight.black,
          italic: true,
          shadow: true,
          textDirection: TextDirection.ltr,
          centered: false,
          color: verseColor,
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
