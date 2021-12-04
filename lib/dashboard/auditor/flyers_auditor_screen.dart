import 'package:bldrs/controllers/drafters/animators.dart' as Animators;
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/fire/methods/firestore.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/progress_bar_parts/strips.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlyersAuditor extends StatefulWidget {
  const FlyersAuditor({Key key}) : super(key: key);

  @override
  _FlyersAuditorState createState() => _FlyersAuditorState();
}

class _FlyersAuditorState extends State<FlyersAuditor> {
  PageController _pageController;
  List<FlyerModel> _flyers = <FlyerModel>[];
  FlyerModel _currentFlyer;
  int _currentPageIndex;
  SwipeDirection _lastSwipeDirection;
  List<double> _pagesOpacities = <double>[];
  double _progressBarOpacity = 1;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(function: (){}).then((_) async {
        /// ---------------------------------------------------------0

        _readMoreFlyers();

        /// ---------------------------------------------------------0
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  QueryDocumentSnapshot<Object> _lastSnapshot;
  Future<void> _readMoreFlyers() async {

    if (_loading == false){
      setState(() {
        _loading = true;
      });
    }

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      collName:  FireColl.flyers,
      orderBy: 'id',
      limit: 5,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,
    );

    final List<FlyerModel> _fetchedModels = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

    _fetchedModels[1].printFlyer();

    setState(() {
      _loading = false;
      _lastSnapshot = _maps[_maps.length - 1]['docSnapshot'];
      _flyers.addAll(_fetchedModels);
      _currentPageIndex = 0;
      _currentFlyer = _flyers[0];
      _numberOfStrips = _flyers.length;
      _lastSwipeDirection = SwipeDirection.next;
      _pagesOpacities = _createPagesOpacities(_numberOfStrips);
    });


  }
// -----------------------------------------------------------------------------
  Future<void> _onSwipeFlyer(SwipeDirection direction, int pageIndex) async {

    _lastSwipeDirection = direction;

    if (direction == SwipeDirection.next){

      if (pageIndex + 1 != _flyers.length){
        await Sliders.slideToNext(_pageController, _flyers.length, pageIndex);
      }

    } else if (direction == SwipeDirection.back){

      if (pageIndex != 0){
        await Sliders.slideToBackFrom(_pageController, pageIndex);
      }

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onVerify() async {
    print('currentFlyer : ${_currentFlyer.slides.length} slides');

    if (_currentFlyer.flyerState != FlyerState.verified){

      await Fire.updateDocField(
        context: context,
        collName: FireColl.flyers,
        docName: _currentFlyer.id,
        field: 'flyerState',
        input: FlyerModel.cipherFlyerState(FlyerState.verified),
      );

      await _onRemoveFlyerFromStack(_currentFlyer);

      TopDialog.showTopDialog(
          context: context,
          verse: 'Done',
          secondLine: 'flyer ${_currentFlyer.id} got verified',
          color: Colorz.green255,
          onTap: (){
            print('a77aaa ');
          }
      );

    }

    else {

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'A77a',
        body: 'This flyer is already verified, check the next one. please',
        boolDialog: false,
      );

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onAudit() async {

  }
// -----------------------------------------------------------------------------
  bool _canDelete = true;
  int _numberOfStrips;
  Future<void> _onRemoveFlyerFromStack(FlyerModel flyerModel) async {

    /// A - if flyers are empty
    if (_flyers.length == 0 || _canDelete == false){

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
      if (_currentPageIndex == 0){
        await _deleteFirstPage();
      }

      /// B - if at (LAST) slide
      else if (_currentPageIndex + 1 == _flyers.length){
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
    print('DELETING STARTS AT (FIRST) index : ${_currentPageIndex}, numberOfSlides : ${_flyers.length} ------------------------------------');

    /// 1 - if only one slide remaining
    if(_flyers.length == 1){

      // print('_draft.visibilities : ${_superFlyer.mSlides[_currentPageIndex].toString()}, _draft.numberOfSlides : $_flyers.length');

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
    else if(_flyers.length == 2){

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerPageVisibility(_currentPageIndex);
        _numberOfStrips = _flyers.length - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future<void>.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await Sliders.slideToNext(_pageController, _flyers.length, _currentPageIndex);


        /// D - delete when one slide remaining
        /// E - wait for sliding to end
        await Future<void>.delayed(Ratioz.durationFading210, () async {


          // /// F - snap to index 0
          // await Sliders.snapTo(_pageController, 0);
          //
          // print('now i can swipe again');
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
      final int _decreasedNumberOfPages =  _flyers.length - 1;
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
        await  Sliders.slideToNext(_pageController, _flyers.length, _currentPageIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfPages <= 1){

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
            await Sliders.snapTo(_pageController, 0);

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
            });

          });

        }

      });

    }

    // print('DELETING ENDS AT (FIRST) : index : ${_currentPageIndex}, numberOfSlides : ${_flyers.length} ------------------------------------');
  }
// -----------------------------------------------------o
  Future<void> _deleteMiddleOrLastSlide() async {
    print('XXXXX ----- DELETING STARTS AT (MIDDLE) index : ${_currentPageIndex}, numberOfSlides : ${_flyers.length}');

    final int _originalIndex = _currentPageIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      _currentPageIndex = _currentPageIndex - 1;
      _lastSwipeDirection = SwipeDirection.freeze;
      _numberOfStrips = _flyers.length - 1;
      _statelessTriggerPageVisibility(_originalIndex);
    });

    // print('XXX after first rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    /// B - wait fading to start sliding
    await Future<void>.delayed(Ratioz.durationFading210, () async {

      // print('_currentIndex before slide : $_draft.currentSlideIndex');

      /// C - slide
      await  Sliders.slideToBackFrom(_pageController, _originalIndex);
      // print('_currentIndex after slide : $_draft.currentSlideIndex');

      /// E - wait for sliding to end
      await Future<void>.delayed(Ratioz.durationFading210, () async {

        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessFlyerRemove(_originalIndex);
        });

        // print('XXX after second rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

      });

      // print('XXX after third LAST rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    });

    print('XXXXX -------  DELETING ENDS AT (MIDDLE) : index : ${_currentPageIndex}, numberOfSlides : ${_flyers.length}');
  }
// -----------------------------------------------------o
  void _statelessTriggerPageVisibility(int index) {

    if (index != null){
      if(index >= 0 && _flyers.length != 0){
        print('_superFlyer.mSlides[index].isVisible was ${_pagesOpacities[0]} for index : $index');


        if(_pagesOpacities[0] == 1){
          _pagesOpacities[0] = 0;
        }
        else {
          _pagesOpacities[0] = 1;
        }

        print('_superFlyer.mSlides[index].isVisible is ${_pagesOpacities[0]} for index : $index');
      }
      else {
        print('can not trigger visibility for index : $index');
      }
    }

  }
// -----------------------------------------------------o
  void _statelessTriggerProgressOpacity({int verticalIndex}){

    print('triggering progress bar opacity');

    if (verticalIndex == null){

      if (_progressBarOpacity == 1){
        _progressBarOpacity = 0;
      }

      else {
        _progressBarOpacity = 1;
      }

    }

    else {

      if (verticalIndex == 1){
        _progressBarOpacity = 0;
      }

      else {
        _progressBarOpacity = 1;
      }

    }

  }
// -----------------------------------------------------o
  void _statelessFlyerRemove(int index) {

    print('before stateless delete index was $index, _draft.numberOfSlides was : ${_flyers.length}');
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

    print('after stateless delete index is $index, _draft.numberOfSlides is : ${_flyers.length}');
  }
// -----------------------------------------------------o
  List<double> _createPagesOpacities(int numberOfPages){
    final List<double> _opacities = <double>[];

    for (int i = 1; i <= numberOfPages; i++){
      _opacities.add(1.0);
    }

    return _opacities;
  }
// -----------------------------------------------------o
  void _onPageChange (int newIndex){
    // print('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
    final SwipeDirection _direction = Animators.getSwipeDirection(newIndex: newIndex, oldIndex: _currentPageIndex,);

    // /// A - if Keyboard is active
    // if (Keyboarders.keyboardIsOn(context) == true){
    //   print('KEYBOARD IS ACTIVE');
    //
    //   /// B - when direction is going next
    //   if (_direction == SwipeDirection.next){
    //     print('going next');
    //     FocusScope.of(context).nextFocus();
    //     setState(() {
    //       _superFlyer.nav.swipeDirection = _direction;
    //       _superFlyer.currentSlideIndex = newIndex;
    //     });
    //   }
    //
    //   /// B - when direction is going back
    //   else if (_direction == SwipeDirection.back){
    //     print('going back');
    //     FocusScope.of(context).previousFocus();
    //     setState(() {
    //       _superFlyer.nav.swipeDirection = _direction;
    //       _superFlyer.currentSlideIndex = newIndex;
    //     });
    //   }
    //
    //   /// B = when direction is freezing
    //   else {
    //     print('going no where');
    //     setState(() {
    //       _superFlyer.nav.swipeDirection = _direction;
    //       _superFlyer.currentSlideIndex = newIndex;
    //     });
    //   }
    // }

    // /// A - if keyboard is not active
    // else {
      // print('KEYBOARD IS NOT ACTIVE');
      setState(() {
        _lastSwipeDirection = _direction;
        _currentPageIndex = newIndex;
        _currentFlyer = _flyers[newIndex];
      });

    // }


  }
// -----------------------------------------------------o
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _clearScreenHeight = DashBoardLayout.clearScreenHeight(context);
    const double _footerZoneHeight = 70;
    final double _progressBarHeight = Strips.boxHeight(_screenWidth);
    final double _bodyZoneHeight = _clearScreenHeight - _footerZoneHeight - _progressBarHeight;
    const double _flyerSizeFactor = 0.7;

    return DashBoardLayout(
      pageTitle: 'Flyers Auditor',
      loading: false,
      onBldrsTap: (){

        print('aho');

      },
      listWidgets: <Widget>[

        FloatingLayout(
          child: Column(

            children: <Widget>[

              /// PROGRESS BAR
              Container(
                width: _screenWidth,
                height: _progressBarHeight,
                // color: Colorz.BloodTest,
                // alignment: Alignment.center,
                child: ProgressBar(
                  index: _currentPageIndex,
                  numberOfSlides: _flyers.length,
                  numberOfStrips: _numberOfStrips,
                  opacity: _progressBarOpacity,
                  swipeDirection: _lastSwipeDirection,
                  loading: _loading,
                  flyerBoxWidth: _screenWidth,
                  margins: EdgeInsets.zero,

                ),
              ),

              /// FLYERS
              Container(
                width: _screenWidth,
                height: _bodyZoneHeight,
                alignment: Alignment.center,
                child:

                Mapper.canLoopList(_flyers) == true ?

                PageView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _flyers.length,
                    controller: _pageController,
                    allowImplicitScrolling: true,
                    onPageChanged: (int i) => _onPageChange(i),
                    pageSnapping: true,
                    // scrollBehavior: ScrollBehavior().,
                    itemBuilder: (BuildContext ctx, int index){
                      return
                        AnimatedOpacity(
                          opacity: _pagesOpacities[index],
                          duration: Ratioz.durationFading200,
                          child: FinalFlyer(
                            flyerBoxWidth: FlyerBox.width(context, _flyerSizeFactor),
                            flyerModel: _flyers[index],
                            goesToEditor: false,
                            onSwipeFlyer: (SwipeDirection direction) => _onSwipeFlyer(direction, index),
                          ),
                        );
                    }
                    )
                    :
                Container(),
              ),

              /// BUTTONS
              Container(
                width: _screenWidth,
                height: _footerZoneHeight,
                color: Colorz.white10,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    /// AUDIT
                    AuditorButton(
                        verse: 'Audit',
                        color: Colorz.red255,
                        icon: Iconz.XSmall,
                        onTap: _onAudit,
                    ),

                    /// VERIFY
                    AuditorButton(
                      verse: 'Verify',
                      color: Colorz.green255,
                      icon: Iconz.Check,
                      onTap: _onVerify,
                    ),
                  ],
                ),
              ),

            ],

          ),
        ),

      ],
    );
  }

}

class AuditorButton extends StatelessWidget {
  final String verse;
  final Color color;
  final String icon;
  final Function onTap;

  const AuditorButton({
    @required this.verse,
    @required this.onTap,
    @required this.color,
    @required this.icon,
    Key key,
}) : super(key: key);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<String>('verse', verse));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<String>('icon', icon));
    properties.add(DiagnosticsProperty<Function>('onTap', onTap));
  }

  @override
  Widget build(BuildContext context) {

    const int _numberOfItems = 2;
    final double _buttonWidth = Scale.getUniformRowItemWidth(context, _numberOfItems);

    return DreamBox(
      height: 50,
      width: _buttonWidth,
      verse: verse,
      verseScaleFactor: 1.3,
      icon: icon,
      iconColor: Colorz.white230,
      iconSizeFactor: 0.5,
      onTap: onTap,
      color: color,
    );
  }
}
