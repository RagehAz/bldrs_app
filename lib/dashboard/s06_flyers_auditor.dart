import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FlyersAuditor extends StatefulWidget {
  @override
  _FlyersAuditorState createState() => _FlyersAuditorState();
}

class _FlyersAuditorState extends State<FlyersAuditor> {
  PageController _pageController;
  List<FlyerModel> _flyers = [];
  FlyerModel _currentFlyer;
  int _currentPageIndex;
  SwipeDirection _lastSwipeDirection;
  List<double> _pagesOpacities = [];
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
  QueryDocumentSnapshot _lastSnapshot;
  Future<void> _readMoreFlyers() async {

    List<dynamic> _maps = await Fire.readCollectionDocs(
      collectionName:  FireCollection.flyers,
      orderBy: 'flyerID',
      limit: 5,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,
    );

    List<FlyerModel> _fetchedModels = FlyerModel.decipherFlyersMaps(_maps);

    _fetchedModels[1].printFlyer();

    setState(() {
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
  void _onSwipeFlyer(SwipeDirection direction, int pageIndex){

    _lastSwipeDirection = direction;

    if (direction == SwipeDirection.next){
      Sliders.slideToNext(_pageController, _flyers.length, pageIndex);
    } else if (direction == SwipeDirection.back){
      Sliders.slideToBackFrom(_pageController, pageIndex);
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onTamam() async {
    print('currentFlyer : ${_currentFlyer.slides.length} slides');

    if (_currentFlyer.flyerState != FlyerState.Verified){

      await Fire.updateDocField(
        context: context,
        collName: FireCollection.flyers,
        docName: _currentFlyer.flyerID,
        field: 'flyerState',
        input: FlyerModel.cipherFlyerState(FlyerState.Verified),
      );

      await _onRemoveFlyerFromStack(_currentFlyer);

      await NavDialog.showNavDialog(
        context: context,
        color: Colorz.Green255,
        firstLine: 'Done',
        secondLine: 'flyer ${_currentFlyer.flyerID} got verified',
        isBig: true,
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
  Future<void> _onTa3ala() async {

  }
// -----------------------------------------------------------------------------
  bool _canDelete = false;
  int _numberOfStrips;
  bool _listenToSwipe = true;
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
      await Future.delayed(Ratioz.durationFading210, () async {

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
        _listenToSwipe = false;
        _statelessTriggerPageVisibility(_currentPageIndex);
        _numberOfStrips = _flyers.length - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await Sliders.slideToNext(_pageController, _flyers.length, _currentPageIndex);


        /// D - delete when one slide remaining
        /// E - wait for sliding to end
        await Future.delayed(Ratioz.durationFading210, () async {


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
            _listenToSwipe = true;
          });

        });


      });
    }

    /// 2 - if more than two slides
    else {

      int _originalNumberOfPages = _flyers.length;
      int _decreasedNumberOfPages =  _flyers.length - 1;
      // int _originalIndex = 0;
      // int _decreasedIndex = 0;

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _listenToSwipe = false;
        _statelessTriggerPageVisibility(_currentPageIndex);
        // _flyers.length = _decreasedNumberOfPages;
        _numberOfStrips = _decreasedNumberOfPages;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await  Sliders.slideToNext(_pageController, _flyers.length, _currentPageIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfPages <= 1){

          setState(() {
            /// Dx - delte data
            _statelessFlyerRemove(_currentPageIndex);
            _listenToSwipe = true;
          });

        }

        /// D - delete when at many slides remaining
        else {

          /// E - wait for sliding to end
          await Future.delayed(Ratioz.durationFading210, () async {

            /// Dx - delete data
            _statelessFlyerRemove(_currentPageIndex);
            /// F - snap to index 0
            await Sliders.snapTo(_pageController, 0);

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
              _listenToSwipe = true;
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

    int _originalIndex = _currentPageIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      _listenToSwipe = false;
      _currentPageIndex = _currentPageIndex - 1;
      _lastSwipeDirection = SwipeDirection.freeze;
      _numberOfStrips = _flyers.length - 1;
      _statelessTriggerPageVisibility(_originalIndex);
    });

    // print('XXX after first rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    /// B - wait fading to start sliding
    await Future.delayed(Ratioz.durationFading210, () async {

      // print('_currentIndex before slide : $_draft.currentSlideIndex');

      /// C - slide
      await  Sliders.slideToBackFrom(_pageController, _originalIndex);
      // print('_currentIndex after slide : $_draft.currentSlideIndex');

      /// E - wait for sliding to end
      await Future.delayed(Ratioz.durationFading210, () async {

        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessFlyerRemove(_originalIndex);
          _listenToSwipe = true;
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
    List<double> _opacities = [];

    for (int i = 1; i <= numberOfPages; i++){
      _opacities.add(1.0);
    }

    return _opacities;
  }
// -----------------------------------------------------o
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _clearScreenHeight = DashBoardLayout.clearScreenHeight(context);
    const double _footerZoneHeight = 70;
    const double _progressBarHeight = 20;
    double _bodyZoneHeight = _clearScreenHeight - _footerZoneHeight - _progressBarHeight;
    double _flyerSizeFactor = 0.7;

    return DashBoardLayout(
      pageTitle: 'Flyers Auditor',
      loading: false,
      listWidgets: <Widget>[

        Container(
          width: _screenWidth,
          height: _clearScreenHeight,
          child: Column(

            children: <Widget>[

              Container(
                width: _screenWidth,
                height: _progressBarHeight,
                child: ProgressBar(
                  index: _currentPageIndex,
                  numberOfSlides: _flyers.length,
                  numberOfStrips: _numberOfStrips,
                  opacity: _progressBarOpacity,
                  swipeDirection: _lastSwipeDirection,
                  loading: _loading,
                  flyerZoneWidth: _screenWidth,

                ),
              ),

              /// FLYERS
              Container(
                width: _screenWidth,
                height: _bodyZoneHeight,
                // color: Colorz.Yellow50,
                child:

                _flyers != null && _flyers.isNotEmpty == true ?

                PageView.builder(
                  scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _flyers.length,
                    controller: _pageController,
                    allowImplicitScrolling: true,
                    onPageChanged: (int i){
                    print('slide to page index : $i');
                    _currentFlyer = _flyers[i];
                    _currentPageIndex = i;
                    },
                    pageSnapping: true,
                    // scrollBehavior: ScrollBehavior().,
                    itemBuilder: (ctx, index){

                      return

                        AnimatedOpacity(
                          opacity: _pagesOpacities[index],
                          duration: Ratioz.durationFading200,
                          child: FinalFlyer(
                            flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
                            flyerModel: _flyers[index],
                            goesToEditor: false,
                            onSwipeFlyer: (SwipeDirection direction) => _onSwipeFlyer(direction, index),
                          ),
                        );

                    }
                )

                    :

                Container()

                ,
              ),

              /// BUTTONS
              Container(
                width: _screenWidth,
                height: _footerZoneHeight,
                // color: Colorz.Blue125,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    AuditorButton(
                        verse: 'Ta3ala',
                        color: Colorz.Red255,
                        icon: Iconz.XSmall,
                        onTap: _onTa3ala,
                    ),

                    AuditorButton(
                      verse: 'Tamam',
                      color: Colorz.Green255,
                      icon: Iconz.Check,
                      onTap: _onTamam,
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
});

  @override
  Widget build(BuildContext context) {

    const int _numberOfItems = 2;
    double _buttonWidth = Scale.getUniformRowItemWidth(context, _numberOfItems);

    return DreamBox(
      height: 60,
      width: _buttonWidth,
      verse: verse,
      verseScaleFactor: 1.3,
      icon: icon,
      iconColor: Colorz.White230,
      iconSizeFactor: 0.5,
      onTap: onTap,
      color: color,
    );
  }
}
