import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/c_strips.dart';
import 'package:bldrs/b_views/j_on_boarding/p1_what_is_bldrs.dart';
import 'package:bldrs/b_views/j_on_boarding/p2_who_are_bldrs.dart';
import 'package:bldrs/b_views/j_on_boarding/p3_what_bldrs_do.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
 // D:\projects\packages\helpers\basics\lib\bldrs_theme\assets\languages
class OnBoardingScreen extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const OnBoardingScreen({
    super.key,
  });
  // -----------------------------------------------------------------------------
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
  // -----------------------------------------------------------------------------

  /// BUBBLE SIZE

  // --------------------
  static double getBubbleWidth(){
    final BuildContext context = getMainContext();
    return Scale.responsive(
        context: context,
        landscape: Scale.screenShortestSide(context) - 80,
        portrait: Scale.screenWidth(context) - 110
    );
  }
  // --------------------
  static double getBubbleHeight(){
    return Scale.screenHeight(getMainContext()) - 140;
  }
  // -----------------------------------------------------------------------------

  /// PAGES

  // --------------------
  static const int numberOfPages = 3;
  // --------------------
  static double getPagesZoneHeight(){
    final double _bubbleHeight = getBubbleHeight();
    return _bubbleHeight - buttonZoneHeight - progressBarHeight;
  }
  // --------------------
  static double getTitleBoxHeight(){
    final double pageZoneHeight = getPagesZoneHeight();
    return pageZoneHeight * 0.15;
  }
  // --------------------
  static double getSpacingsSize(){
    final double pageZoneHeight = getPagesZoneHeight();
    return pageZoneHeight * 0.03;
  }
  // --------------------
  static double getWheelDiameter(){
    final double pageZoneHeight = getPagesZoneHeight();
    return pageZoneHeight * 0.5;
  }
  // --------------------
  static double getBelowWheelTextZoneHeight(){
    final double pageZoneHeight = OnBoardingScreen.getPagesZoneHeight();
    final double _titleBoxHeight = OnBoardingScreen.getTitleBoxHeight();
    final double _topSpacingHeight = OnBoardingScreen.getSpacingsSize();
    final double _circleDiameter = OnBoardingScreen.getWheelDiameter();
    final double _middleSpacingHeight = _topSpacingHeight;
    return pageZoneHeight
        - _titleBoxHeight
        - _topSpacingHeight
        - _circleDiameter
        - _middleSpacingHeight;
  }
  // -----------------------------------------------------------------------------

  /// PROGRESS BAR

  // --------------------
  static const double progressBarHeight = 20;
  // --------------------
  static double getProgressBarWidth(){
    final double _bubbleWidth = getBubbleWidth();
    return _bubbleWidth * 0.7;
  }
  // --------------------
  static bool isAtLast({
  required ProgressBarModel? progressBarModel,
  }){

    final int _currentIndex = progressBarModel?.index ?? 0;
    return _currentIndex + 1 == numberOfPages;

  }
  // -----------------------------------------------------------------------------

  /// BUTTONS

  // --------------------
  static const double buttonZoneHeight = 60;
  // --------------------
  static double getButtonHeight(){
    return buttonZoneHeight - 20;
  }
  // -----------------------------------------------------------------------------
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  final PageController _pageController = PageController();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.initialModel(
        numberOfStrips: OnBoardingScreen.numberOfPages,
      ),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {


      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _progressBarModel.dispose();
    _pageController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  ///  SWIPING

  // --------------------
  Future<void> _onNext() async {

    final bool _isAtLast = OnBoardingScreen.isAtLast(
      progressBarModel: _progressBarModel.value,
    );

    if (_isAtLast == true){
      await _onSkip();
    }

    else {

      final int _currentIndex = _progressBarModel.value?.index ?? 0;

      ProgressBarModel.onSwipe(
        context: context,
        newIndex: _currentIndex + 1,
        progressBarModel: _progressBarModel,
        mounted: mounted,
        numberOfPages: OnBoardingScreen.numberOfPages,
      );

      await Sliders.slideToIndex(
        pageController: _pageController,
        toIndex: _currentIndex + 1,
      );

    }

  }
  // --------------------
  Future<void> _onSwipe(int index) async {

    ProgressBarModel.onSwipe(
      context: context,
      newIndex: index,
      progressBarModel: _progressBarModel,
      mounted: mounted,
    );

  }
  // --------------------
  Future<void> _onSkip() async {
    await Nav.goBack(
        context: context
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = OnBoardingScreen.getBubbleWidth();
    final double _bubbleHeight = OnBoardingScreen.getBubbleHeight();

    final double _pagesZoneHeight = OnBoardingScreen.getPagesZoneHeight();

    final double _progressBarWidth = OnBoardingScreen.getProgressBarWidth();

    final double _buttonHeight = OnBoardingScreen.getButtonHeight();

    return Material(
      color: Colorz.nothing,
      child: SizedBox(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        child: Stack(
          alignment: Alignment.center,
          children: [

            const BlurLayer(
              blurIsOn: true,
            ),

            Container(
              width: _bubbleWidth,
              height: _bubbleHeight,
              decoration: const BoxDecoration(
                color: Colorz.black200,
                borderRadius: Borderers.constantCornersAll30,
              ),
              child: Column(
                children: [

                  /// PAGES
                  SizedBox(
                    width: _bubbleWidth,
                    height: _pagesZoneHeight,
                    child: PageView(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: _onSwipe,
                      children: const [

                        /// WHAT IS BLDRS
                        AWhatIsBldrsPage(),
                        /// WHO ARE BLDRS
                        BWhoAreBldrs(),
                        /// WHAT THEY DO
                        CWhatBldrsDo(),

                      ],
                    ),
                  ),

                  /// PROGRESS BAR
                  Container(
                    width: _progressBarWidth,
                    height: OnBoardingScreen.progressBarHeight,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colorz.yellow10,
                      borderRadius: Borderers.constantCornersAll10,
                    ),
                    child: Strips(
                      flyerBoxWidth: _progressBarWidth,
                      progressBarModel: _progressBarModel,
                      margins: const EdgeInsets.only(top: 8),
                      tinyMode: false,
                      // progressBarOpacity: _progressBarOpacity,
                      // loading: false,
                    ),
                  ),

                  /// EXIT - NEXT BUTTONS
                  SizedBox(
                    width: _bubbleWidth,
                    height: OnBoardingScreen.buttonZoneHeight,
                    child: ValueListenableBuilder(
                        valueListenable: _progressBarModel,
                        builder: (_, ProgressBarModel? progressBarModel, Widget? child) {

                          final bool _isAtLast = OnBoardingScreen.isAtLast(
                            progressBarModel: progressBarModel,
                          );

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              /// EXIT
                              BldrsBox(
                                height: _buttonHeight,
                                opacity: _isAtLast == true ? 0 : 1,
                                // width: _bubbleWidth * 0.3,
                                margins: 10,
                                verse: const Verse(
                                  id: 'phid_exit',
                                  translate: true,
                                ),
                                corners: Borderers.constantCornersAll20,
                                color: Colorz.white20,
                                verseScaleFactor: 0.7,
                                onTap: _onSkip,
                              ),

                              /// NEXT
                              BldrsBox(
                                height: _buttonHeight,
                                // width: _bubbleWidth * 0.3,
                                margins: 10,
                                verse: Verse(
                                  id: _isAtLast == true ? 'phid_great_!' : 'phid_next',
                                  translate: true,
                                ),
                                corners: Borderers.constantCornersAll20,
                                color: Colorz.white20,
                                verseScaleFactor: 0.7,
                                onTap: _onNext,
                              ),

                            ],
                          );
                        }
                        ),
                  ),

                ],
              ),
            ),

            const Pyramids(
              pyramidType: PyramidType.crystalBlue,
              color: Colorz.black255,
            ),

          ],
        ),
      ),

    );

  }
}
