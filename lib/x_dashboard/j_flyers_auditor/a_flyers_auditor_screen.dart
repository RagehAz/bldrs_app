import 'dart:async';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/x_dashboard/j_flyers_auditor/x_flyer_auditor_controller.dart';
import 'package:flutter/material.dart';

class FlyersAuditor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyersAuditor({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _FlyersAuditorState createState() => _FlyersAuditorState();
  /// --------------------------------------------------------------------------
}

class _FlyersAuditorState extends State<FlyersAuditor> {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<List<FlyerModel>> _flyers = ValueNotifier(<FlyerModel>[]);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await readMoreUnVerifiedFlyers(
          context: context,
          flyers: _flyers,
          loading: _loading,
        );

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _scrollController.dispose();
    _loading.dispose();
    _flyers.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /*
  bool _canDelete = true;
  int _numberOfStrips;
  Future<void> _onRemoveFlyerFromStack(FlyerModel flyerModel) async {
    /// A - if flyers are empty
    if (_flyers.isEmpty || _canDelete == false) {
      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Can not delete',
        body: 'I do not know why bsara7a',
      );
    }

    /// A - if slides are not empty
    else {
      _canDelete = false;

      /// B - if at (FIRST) slide
      if (_currentPageIndex == 0) {
        await _deleteFirstPage();
      }

      /// B - if at (LAST) slide
      else if (_currentPageIndex + 1 == _flyers.length) {
        await _deleteMiddleOrLastSlide();
      }

      /// B - if at (Middle) slide
      else {
        await _deleteMiddleOrLastSlide();
      }

      _canDelete = true;
    }
  }
// -----------------------------------------------------o
  Future<void> _deleteFirstPage() async {
    blog(
        'DELETING STARTS AT (FIRST) index : $_currentPageIndex, numberOfSlides : ${_flyers.length} ------------------------------------');

    /// 1 - if only one slide remaining
    if (_flyers.length == 1) {
      // blog('_draft.visibilities : ${_superFlyer.mSlides[_currentPageIndex].toString()}, _draft.numberOfSlides : $_flyers.length');

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerPageVisibility(_currentPageIndex);
        _numberOfStrips = 0;
        _statelessTriggerProgressOpacity();
      });

      /// B - wait fading to start deleting + update index to null
      await Future<void>.delayed(Ratioz.durationFading210, () async {
        /// Dx - delete data
        setState(() {
          _statelessFlyerRemove(_currentPageIndex);
          _currentPageIndex = null;
        });
      });
    }

    /// 2 - if two slides remaining
    else if (_flyers.length == 2) {
      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerPageVisibility(_currentPageIndex);
        _numberOfStrips = _flyers.length - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future<void>.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await Sliders.slideToNext(
            pageController: _pageController,
            numberOfSlides: _flyers.length,
            currentSlide: _currentPageIndex,
        );

        /// D - delete when one slide remaining
        /// E - wait for sliding to end
        await Future<void>.delayed(Ratioz.durationFading210, () async {
          // /// F - snap to index 0
          // await Sliders.snapTo(_pageController, 0);
          //
          // blog('now i can swipe again');
          //
          // /// G - trigger progress bar listener (onPageChangedIsOn)
          setState(() {
            /// Dx - delete data
            _statelessFlyerRemove(_currentPageIndex);
            _currentPageIndex = 0;
            // _draft.numberOfSlides = 1;
          });
        });
      });
    }

    /// 2 - if more than two slides
    else {
      final int _originalNumberOfPages = _flyers.length;
      final int _decreasedNumberOfPages = _flyers.length - 1;
      // int _originalIndex = 0;
      // int _decreasedIndex = 0;

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerPageVisibility(_currentPageIndex);
        // _flyers.length = _decreasedNumberOfPages;
        _numberOfStrips = _decreasedNumberOfPages;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future<void>.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await Sliders.slideToNext(
            pageController: _pageController,
            numberOfSlides: _flyers.length,
            currentSlide: _currentPageIndex,
        );

        /// D - delete when one slide remaining
        if (_originalNumberOfPages <= 1) {
          setState(() {
            /// Dx - delte data
            _statelessFlyerRemove(_currentPageIndex);
          });
        }

        /// D - delete when at many slides remaining
        else {
          /// E - wait for sliding to end
          await Future<void>.delayed(Ratioz.durationFading210, () async {
            /// Dx - delete data
            _statelessFlyerRemove(_currentPageIndex);

            /// F - snap to index 0
            Sliders.snapTo(
                pageController: _pageController,
                currentSlide: 0,
            );
            // await null;

            blog('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {});
          });
        }
      });
    }

    // blog('DELETING ENDS AT (FIRST) : index : ${_currentPageIndex}, numberOfSlides : ${_flyers.length} ------------------------------------');
  }
// -----------------------------------------------------o
  Future<void> _deleteMiddleOrLastSlide() async {
    blog('XXXXX ----- DELETING STARTS AT (MIDDLE) index : $_currentPageIndex, numberOfSlides : ${_flyers.length}');

    final int _originalIndex = _currentPageIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      _currentPageIndex = _currentPageIndex - 1;
      _lastSwipeDirection = Sliders.SwipeDirection.freeze;
      _numberOfStrips = _flyers.length - 1;
      _statelessTriggerPageVisibility(_originalIndex);
    });

    // blog('XXX after first rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    /// B - wait fading to start sliding
    await Future<void>.delayed(Ratioz.durationFading210, () async {
      // blog('_currentIndex before slide : $_draft.currentSlideIndex');

      /// C - slide
      await Sliders.slideToBackFrom(
          pageController: _pageController,
          currentSlide: _originalIndex,
      );
      // blog('_currentIndex after slide : $_draft.currentSlideIndex');

      /// E - wait for sliding to end
      await Future<void>.delayed(Ratioz.durationFading210, () async {
        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessFlyerRemove(_originalIndex);
        });

        // blog('XXX after second rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');
      });

      // blog('XXX after third LAST rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');
    });

    blog('XXXXX -------  DELETING ENDS AT (MIDDLE) : index : $_currentPageIndex, numberOfSlides : ${_flyers.length}');
  }
// -----------------------------------------------------o
  void _statelessTriggerPageVisibility(int index) {
    if (index != null) {
      if (index >= 0 && _flyers.isNotEmpty) {
        blog(
            '_superFlyer.mSlides[index].isVisible was ${_pagesOpacities[0]} for index : $index');

        if (_pagesOpacities[0] == 1) {
          _pagesOpacities[0] = 0;
        } else {
          _pagesOpacities[0] = 1;
        }

        blog(
            '_superFlyer.mSlides[index].isVisible is ${_pagesOpacities[0]} for index : $index');
      } else {
        blog('can not trigger visibility for index : $index');
      }
    }
  }
// -----------------------------------------------------o
  void _statelessTriggerProgressOpacity({int verticalIndex}) {
    blog('triggering progress bar opacity');

    if (verticalIndex == null) {
      if (_progressBarOpacity == 1) {
        _progressBarOpacity = 0;
      } else {
        _progressBarOpacity = 1;
      }
    } else {
      if (verticalIndex == 1) {
        _progressBarOpacity = 0;
      } else {
        _progressBarOpacity = 1;
      }
    }
  }
// -----------------------------------------------------o
  void _statelessFlyerRemove(int index) {
    blog(
        'before stateless delete index was $index, _draft.numberOfSlides was : ${_flyers.length}');
    // if(ObjectChecker.listCanBeUsed(_superFlyer.assetsFiles) == true){_superFlyer.assetsFiles.removeAt(index);}
    // if(ObjectChecker.listCanBeUsed(_superFlyer.assetsFiles) == true){_superFlyer.mutableSlides.removeAt(index);}

    // if(_superFlyer.edit.firstTimer == false){
    //   int _assetIndex = MutableSlide.getAssetTrueIndexFromMutableSlides(mutableSlides: _superFlyer.mutableSlides, slideIndex: index);
    //   if(_assetIndex != null){
    //     _superFlyer.assetsSources.removeAt(_assetIndex);
    //   }
    // }
    // else {
    //   _superFlyer.assetsSources.removeAt(index);
    // }

    _flyers.removeAt(index);
    // _superFlyer.screenshotsControllers.removeAt(index);
    _flyers.length = _flyers.length;
    // _superFlyer.screenShots.removeAt(index);

    blog(
        'after stateless delete index is $index, _draft.numberOfSlides is : ${_flyers.length}');
  }
// -----------------------------------------------------o
  List<double> _createPagesOpacities(int numberOfPages) {
    final List<double> _opacities = <double>[];

    for (int i = 1; i <= numberOfPages; i++) {
      _opacities.add(1);
    }

    return _opacities;
  }
// -----------------------------------------------------o
  void _onPageChange(int newIndex) {
    // blog('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
    final Sliders.SwipeDirection _direction = Animators.getSwipeDirection(
      newIndex: newIndex,
      oldIndex: _currentPageIndex,
    );

    // /// A - if Keyboard is active
    // if (Keyboarders.keyboardIsOn(context) == true){
    //   blog('KEYBOARD IS ACTIVE');
    //
    //   /// B - when direction is going next
    //   if (_direction == SwipeDirection.next){
    //     blog('going next');
    //     FocusScope.of(context).nextFocus();
    //     setState(() {
    //       _superFlyer.nav.swipeDirection = _direction;
    //       _superFlyer.currentSlideIndex = newIndex;
    //     });
    //   }
    //
    //   /// B - when direction is going back
    //   else if (_direction == SwipeDirection.back){
    //     blog('going back');
    //     FocusScope.of(context).previousFocus();
    //     setState(() {
    //       _superFlyer.nav.swipeDirection = _direction;
    //       _superFlyer.currentSlideIndex = newIndex;
    //     });
    //   }
    //
    //   /// B = when direction is freezing
    //   else {
    //     blog('going no where');
    //     setState(() {
    //       _superFlyer.nav.swipeDirection = _direction;
    //       _superFlyer.currentSlideIndex = newIndex;
    //     });
    //   }
    // }

    // /// A - if keyboard is not active
    // else {
    // blog('KEYBOARD IS NOT ACTIVE');
    setState(() {
      _lastSwipeDirection = _direction;
      _currentPageIndex = newIndex;
      _currentFlyer = _flyers[newIndex];
    });

    // }
  }
// -----------------------------------------------------o
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    return MainLayout(
      pageTitleVerse: Verse.plain('Flyers Auditor'),
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      loading: _loading,
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain('load more'),
          onTap: () => readMoreUnVerifiedFlyers(
            context: context,
            flyers: _flyers,
            loading: _loading,
          ),
        ),

      ],
      layoutWidget: Stack(
        children: <Widget>[

          /// FLYERS
          ValueListenableBuilder(
              valueListenable: _flyers,
              builder: (_, List<FlyerModel> flyers, Widget child){

                if (Mapper.checkCanLoopList(flyers) == true){
                  return FlyersGrid(
                    flyers: flyers,
                    gridWidth: _screenWidth,
                    gridHeight: _screenHeight,
                    scrollController: _scrollController,
                    // numberOfColumns: 2,
                    onFlyerOptionsTap: (FlyerModel flyer) => onFlyerOptionsTap(
                      context: context,
                      flyerModel: flyer,
                      flyers: _flyers,
                    ),
                    heroPath: 'flyerAuditorScreenGrid',
                  );
                }

                else {
                  return const Center(
                    child: SuperVerse(
                      verse: Verse(
                        text: 'No Flyers Left',
                        translate: false,
                      ),
                      weight: VerseWeight.black,
                      italic: true,
                      size: 4,
                    ),
                  );
                }

              }
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
