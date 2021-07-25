import 'dart:io';

import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/tiny_flyer_widget.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

/*

1 - user view random published flyer
2 - user view saved published flyer
3 - author view random published flyer
4 - author view owned published flyer
5 - author edit owned published flyer
6 - author edit owned draft flyer

A - flyer is saved flyers
B - flyer in walls
C - flyer in MyBzScreen
D - flyer in editor
E - flyer in bzGallery

 */

enum FlyerMode {
  tiny,
  tinyWithID,

  normal,
  normalWithID,

  newDraft,
  draftFromFlyer,

  empty,
}

class FinalFlyer extends StatefulWidget {
  final double flyerZoneWidth;
  final FlyerMode flyerMode;
  final FlyerModel flyerModel;
  final TinyFlyer tinyFlyer;
  final String flyerID;
  final int initialSlideIndex;
  final Function onSwipeFlyer;
  final BzModel bzModel;

  const FinalFlyer({
    @required this.flyerZoneWidth,
    this.flyerMode,
    this.flyerModel,
    this.tinyFlyer,
    this.flyerID,
    this.initialSlideIndex = 0,
    this.onSwipeFlyer,
    this.bzModel,
    Key key
  }) : super(key: key);

  @override
  _FinalFlyerState createState() => _FinalFlyerState();

}

class _FinalFlyerState extends State<FinalFlyer> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  FlyersProvider _prof;
  SuperFlyer _superFlyer;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading() async {
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _prof = Provider.of<FlyersProvider>(context, listen: false);


    super.initState();
  }
// -----------------------------------------------------------------------------
  FlyerMode _flyerMode;
  static FlyerMode concludeFlyerMode({
    BuildContext context,
    double flyerZoneWidth,
    FlyerModel flyerModel,
    TinyFlyer tinyFlyer,
    String flyerID,
  }){
    FlyerMode _flyerMode;

    bool _microMode = Scale.superFlyerMicroMode(context, flyerZoneWidth);

    /// A -
    if (flyerModel != null && flyerID != DraftFlyerModel.draftID){
        _flyerMode = FlyerMode.normal;
    }

    /// A - when flyerModel is absent but tinyFlyer is provided
    else if (tinyFlyer != null){
        _flyerMode = FlyerMode.tiny;
    }

    /// A - when flyerID is solely provided and in small size
    else if (flyerID != null && _microMode == true){
      _flyerMode = FlyerMode.tinyWithID;
    }

    /// A - when flyerID is solely provided and in small size
    else if (flyerID != null && _microMode == false){
      _flyerMode = FlyerMode.normalWithID;
    }

    /// A - when flyerModel & tinyFlyer are absent but flyerID is 'draft'
    else if (flyerModel == null && flyerID == DraftFlyerModel.draftID){
      _flyerMode = FlyerMode.newDraft;
    }

    /// A - when flyerModel & tinyFlyer are absent but flyerID is 'draft'
    else if (flyerModel != null &&flyerID == DraftFlyerModel.draftID){
      _flyerMode = FlyerMode.draftFromFlyer;
    }

    /// A - when no flyerModel not tinyFlyer provided
    else {
        _flyerMode = FlyerMode.empty;
    }

    return _flyerMode;
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        _flyerMode =
        // widget.flyerMode;
        //
        concludeFlyerMode(
          context: context,
          flyerZoneWidth: widget.flyerZoneWidth,
          flyerModel:  widget.flyerModel,
          tinyFlyer: widget.tinyFlyer,
          flyerID: widget.flyerID,
        );


        if (_flyerMode == FlyerMode.tiny){
          // no loading needed
          _superFlyer = _getSuperFlyerFromTinyFlyer(tinyFlyer: widget.tinyFlyer);
        }

        else if (_flyerMode == FlyerMode.tinyWithID){
          TinyFlyer _tinyFlyer = await _fetchOrSearchTinyFlyerByID(widget.flyerID);
          _superFlyer = _getSuperFlyerFromTinyFlyer(tinyFlyer: _tinyFlyer);
        }

        else if (_flyerMode == FlyerMode.normal){
          // no loading needed
          _superFlyer = _getSuperFlyerFromFlyer(flyerModel: widget.flyerModel);
        }

        else if (_flyerMode == FlyerMode.normalWithID){
          FlyerModel _flyer = await _fetchOrSearchFlyerByID(widget.flyerID);
          _superFlyer = _getSuperFlyerFromFlyer(flyerModel: _flyer);
        }

        else if (_flyerMode == FlyerMode.draftFromFlyer){
          // no loading needed
          _superFlyer = await _getDraftSuperFlyerFromFlyer(flyerModel: widget.flyerModel, bzModel: widget.bzModel);
        }

        else if (_flyerMode == FlyerMode.newDraft){
          // no loading needed
          _superFlyer = _getDraftSuperFlyerFromNothing(bzModel: widget.bzModel);
        }
        else if (_flyerMode == FlyerMode.empty){
          // no loading needed
          _superFlyer = SuperFlyer.createEmptySuperFlyer(context: context, flyerZoneWidth: widget.flyerZoneWidth);
        }

        else {

        }

        // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
          // bool _ankhIsOn = _prof.checkAnkh(widget.flyerID);
          // /// B - search in local saved flyers
          // if (_ankhIsOn == true){
          //   TinyFlyer _tinyFlyer = _prof.getSavedTinyFlyerByFlyerID(flyerID);
          // }
          // /// B - if not found in saved flyers
          // else {
          //   FlyerModel _flyer = await FlyerOps().readFlyerOps(context: context, flyerID: widget.flyerID);
          // }


        setState(() {

        });

      });

      _triggerLoading();
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  /// SUPER FLYER CREATORS

  Future<TinyFlyer> _fetchOrSearchTinyFlyerByID(String flyerID) async {

    TinyFlyer _tinyFlyer;

    /// A - check saved tiny flyers
    TinyFlyer _savedTinyFlyer = _prof.getSavedTinyFlyerByFlyerID(flyerID);

    /// A - if id found in saved tinyFlyers
    if (_savedTinyFlyer != null){
      setState(() {
        _tinyFlyer = _savedTinyFlyer;
      });
    }

    /// A - if not found locally, get it from database
    else {
      TinyFlyer _tinyFlyerFromDB = await FlyerOps().readTinyFlyerOps(context: context, flyerID: flyerID);

      /// B - if found on database
      if (_tinyFlyerFromDB != null){
        setState(() {
          _tinyFlyer = _tinyFlyerFromDB;
        });
      }

      /// B - if not found on database
      // do nothing and let _tinyFlyer be null
    }

    return _tinyFlyer;
  }
// -----------------------------------------------------o
  Future<FlyerModel> _fetchOrSearchFlyerByID(String flyerID) async {
    FlyerModel _flyerModel;

    /// A - get it from database directly
    FlyerModel _flyerModelFromDB = await FlyerOps().readFlyerOps(context: context, flyerID: flyerID);

      /// B - if found on database
      if (_flyerModelFromDB != null){
        setState(() {
          _flyerModel = _flyerModelFromDB;
        });

      /// B - if not found on database
      // do nothing and let _flyerModel be null
    }

      return _flyerModel;
  }
// -----------------------------------------------------o
  SuperFlyer _getSuperFlyerFromTinyFlyer({TinyFlyer tinyFlyer}){
    SuperFlyer _superFlyer = SuperFlyer.createViewSuperFlyerFromTinyFlyer(
        context: context,
        flyerZoneWidth: widget.flyerZoneWidth,
        tinyFlyer: tinyFlyer,
        onMicroFlyerTap: _openTinyFlyer,
        onAnkhTap: _onAnkhTap,
    );
    return _superFlyer;
  }
// -----------------------------------------------------o
  SuperFlyer _getSuperFlyerFromFlyer({FlyerModel flyerModel}){
    SuperFlyer _superFlyer = SuperFlyer.createViewSuperFlyerFromFlyerModel(
        context: context,
        flyerZoneWidth: widget.flyerZoneWidth,
        flyerModel: flyerModel,
        initialPage: widget.initialSlideIndex,
        onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _onVerticalPageBack();},
        onHeaderTap: _onHeaderTap,
        onSlideRightTap: _onSlideRightTap,
        onSlideLeftTap: _onSlideLeftTap,
        onSwipeFlyer: widget.onSwipeFlyer,
        onView: (slideIndex) => _onViewSlide(slideIndex),
        onAnkhTap: _onAnkhTap,
        onShareTap: _onShareTap,
        onFollowTap: _onFollowTap,
        onCallTap: _onCallTap,
    );

    return _superFlyer;
  }
// -----------------------------------------------------o
  Future <SuperFlyer> _getDraftSuperFlyerFromFlyer({FlyerModel flyerModel, BzModel bzModel}) async {
    SuperFlyer _superFlyer = await SuperFlyer.createDraftSuperFlyerFromFlyer(
        context: context,
        flyerZoneWidth: widget.flyerZoneWidth,
        bzModel: bzModel,
        flyerModel: flyerModel,
        onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _onVerticalPageBack();},
        onHeaderTap: _onHeaderTap,
        onSlideRightTap: _onSlideRightTap,
        onSlideLeftTap: _onSlideLeftTap,
        onSwipeFlyer: widget.onSwipeFlyer,
        onView: (i) => _onViewSlide(i),
        onAnkhTap: _onAnkhTap,
        onShareTap: _onShareTap,
        onFollowTap: _onFollowTap,
        onCallTap: _onCallTap,
        onAddImages: () => _onAddImages(flyerZoneWidth: widget.flyerZoneWidth),
        onDeleteSlide: () async {await _onDeleteSlide();},
        onCropImage: () async {await _onCropImage();},
        onResetImage: () async {await _onResetImage();},
        onFitImage: _onFitImage,
        onFlyerTypeTap: () async {await _onFlyerTypeTap();},
        onZoneTap: () async {await _onChangeZone();},
        onAboutTap: () async {await _onAboutTap();},
        onKeywordsTap: () async {await _onKeywordsTap();}
    );

    return _superFlyer;
  }
// -----------------------------------------------------------------------------
  SuperFlyer _getDraftSuperFlyerFromNothing({BzModel bzModel}){
    SuperFlyer _superFlyer = SuperFlyer.createDraftSuperFlyerFromNothing(
        context: context,
        flyerZoneWidth: widget.flyerZoneWidth,
        bzModel: bzModel,
        onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _onVerticalPageBack();},
        onHeaderTap: _onHeaderTap,
        onSlideRightTap: _onSlideRightTap,
        onSlideLeftTap: _onSlideLeftTap,
        onSwipeFlyer: widget.onSwipeFlyer,
        onView: (i) => _onViewSlide(i),
        onAnkhTap: _onAnkhTap,
        onShareTap: _onShareTap,
        onFollowTap: _onFollowTap,
        onCallTap: _onCallTap,
        onAddImages: () => _onAddImages(flyerZoneWidth: widget.flyerZoneWidth),
        onDeleteSlide: () async {await _onDeleteSlide();},
        onCropImage: () async {await _onCropImage();},
        onResetImage: () async {await _onResetImage();},
        onFitImage: _onFitImage,
        onFlyerTypeTap: () async {await _onFlyerTypeTap();},
        onZoneTap: () async {await _onChangeZone();},
        onAboutTap: () async {await _onAboutTap();},
        onKeywordsTap: () async {await _onKeywordsTap();}
    );

    return _superFlyer;
  }
// -----------------------------------------------------------------------------
  ///   NAVIGATION METHODS

  void _openTinyFlyer(){
    print('opening tiny flyer');
  }
// -----------------------------------------------------o
  void _tappingFlyerZone(){
    print('Final flyer zone tapped');
  }
// -----------------------------------------------------o
  void _onFlyerZoneLongPress(){
    print('Final flyer zone long pressed');
  }
// -----------------------------------------------------o
  void _onHeaderTap(){
    print('tapping header');
  }
// -----------------------------------------------------------------------------

  /// SLIDING METHODS

  void _onHorizontalSlideSwipe (int newIndex){
    print('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
    SwipeDirection _direction = Animators.getSwipeDirection(newIndex: newIndex, oldIndex: _superFlyer.currentSlideIndex,);


    /// A - if Keyboard is active
    if (Keyboarders.keyboardIsOn(context) == true){
      print('KEYBOARD IS ACTIVE');

      /// B - when direction is going next
      if (_direction == SwipeDirection.next){
        FocusScope.of(context).nextFocus();
        setState(() {
          _superFlyer.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }

      /// B - when direction is going back
      else if (_direction == SwipeDirection.back){
        FocusScope.of(context).previousFocus();
        setState(() {
          _superFlyer.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }

      /// B = when direction is freezing
      else {
        setState(() {
          _superFlyer.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }
    }

    /// A - if keyboard is not active
    else {
      print('KEYBOARD IS NOT ACTIVE');
      setState(() {
        _superFlyer.swipeDirection = _direction;
        _superFlyer.currentSlideIndex = newIndex;
      });

    }

  }
// -----------------------------------------------------o
  void _onSlideRightTap(){
    print('_onSlideRightTap');
  }
// -----------------------------------------------------o
  void _onSlideLeftTap(){
    print('_onSlideLeftTap');
  }
// -----------------------------------------------------o
  void _onVerticalPageSwipe(int verticalIndex){
    print('verticalIndex was : ${_superFlyer.verticalIndex}');
    setState(() {
      _superFlyer.verticalIndex = verticalIndex;
      _statelessTriggerProgressOpacity();
    });
    print('verticalIndex is : ${_superFlyer.verticalIndex}');

  }
// -----------------------------------------------------o
  Future<void> _onVerticalPageBack () async {
  print('shit');
  await Sliders.slideToBackFrom(_superFlyer.verticalController, 1);
}
// -----------------------------------------------------o
  void _statelessTriggerProgressOpacity(){
    if (_superFlyer.progressBarOpacity == 1){
      _superFlyer.progressBarOpacity = 0;
    } else {
      _superFlyer.progressBarOpacity = 1;
    }
  }
// -----------------------------------------------------------------------------

  /// RECORD METHODS

  void _onViewSlide(int slideIndex){
    print('viewing slide : ${slideIndex} : from flyer : ${_superFlyer.flyerID}');
  }
// -----------------------------------------------------o
  void _onAnkhTap(){
    print('tapping Ankh');
  }
// -----------------------------------------------------o
  void _onShareTap(){
    print('Sharing flyer');
  }
// -----------------------------------------------------o
  void _onFollowTap(){
    print('Sharing flyer');
  }
// -----------------------------------------------------o
  void _onCallTap(){
    print('Sharing flyer');
  }
// -----------------------------------------------------------------------------

  /// EDITOR METHOD

// -----------------------------------------------------------------------------
  Future<void> _onAddImages({@required double flyerZoneWidth}) async {

    FocusScope.of(context).unfocus();

    _triggerLoading();

    List<Asset> _assetsSources = _superFlyer.assetsSources;
    int _maxLength = Standards.getMaxSlidesCount(widget.bzModel.accountType);

    /// A - if max images reached
    if(_maxLength <= _assetsSources.length ){

      await Dialogz.maxSlidesReached(context, _maxLength);

    }

    /// A - if still picking images
    else {

      _superFlyer.currentSlideIndex = _superFlyer.currentSlideIndex == null ? 0 : _superFlyer.currentSlideIndex;

      List<Asset> _outputAssets;

      if(mounted){
        _outputAssets = await Imagers.getMultiImagesFromGallery(
          context: context,
          images: _assetsSources,
          mounted: mounted,
          accountType: _superFlyer.accountType,
        );

        /// B - if did not pick new assets
        if(_outputAssets.length == 0){
          // will do nothing
          print('no new picks');
        }

        /// B - if picked new assets
        else {

          List<File> _assetsFiles = await Imagers.getFilesFromAssets(_outputAssets);
          List<BoxFit> _fits = Imagers.concludeBoxesFits(assets: _assetsSources, flyerZoneWidth: flyerZoneWidth);


          List<BoxFit> _newFits = new List();
          List<File> _newFiles = new List();
          List<TextEditingController> _newControllers = new List();
          List<bool> _newVisibilities = new List();

          /// C - for every asset received from gallery
          for (Asset newAsset in _outputAssets){

            /// C 1 - get index of newAsset in the existing asset if possible
            int _assetIndexInExistingAssets = _superFlyer.assetsSources.indexWhere(
                  (existingAsset) => existingAsset.identifier == newAsset.identifier,);

            /// C 2 - if this is NEW ASSET
            // no match found between new assets and existing assets
            if(_assetIndexInExistingAssets == -1){
              /// fit
              _newFits.add(Imagers.concludeBoxFit(asset: newAsset, flyerZoneWidth: flyerZoneWidth));
              /// file
              File _newFile = await Imagers.getFileFromAsset(newAsset);
              _newFiles.add(_newFile);
              /// controller
              _newControllers.add(new TextEditingController());
              /// visibilities
              _newVisibilities.add(true);
            }

            /// C 3 - if this is EXISTING ASSET
            // found the index of the unchanged asset
            else {
              /// fit
              _newFits.add(_superFlyer.boxesFits[_assetIndexInExistingAssets]);
              /// file
              _newFiles.add(_superFlyer.assetsFiles[_assetIndexInExistingAssets]);
              /// controller
              _newControllers.add(_superFlyer.headlinesControllers[_assetIndexInExistingAssets]);
              /// visibilities
              _newVisibilities.add(_superFlyer.slidesVisibilities[_assetIndexInExistingAssets]);
            }

          }

          /// D - assign all new values
          setState(() {
            _superFlyer.assetsSources = _outputAssets;
            _superFlyer.assetsSources = _outputAssets;

            _superFlyer.boxesFits = _newFits;
            _superFlyer.boxesFits = _newFits;

            _superFlyer.assetsFiles = _newFiles;
            _superFlyer.assetsFiles = _newFiles;

            _superFlyer.headlinesControllers = _newControllers;

            _superFlyer.slidesVisibilities = _newVisibilities;

            _superFlyer.numberOfSlides = _superFlyer.assetsSources.length;
            _superFlyer.numberOfStrips = _superFlyer.numberOfSlides;

            _superFlyer.progressBarOpacity = 1;
          });

          /// E - animate to first page
          await _superFlyer.horizontalController.animateToPage(
              _outputAssets.length - 1,
              duration: Ratioz.duration1000ms, curve: Curves.easeInOut
          );

        }

      }

    }

    _triggerLoading();

  }
// -----------------------------------------------------o
  Future<void> _onDeleteSlide() async {

    /// A - if slides are empty
    if (_superFlyer.numberOfSlides == 0){
      print('nothing can be done');
    }

    /// A - if slides are not empty
    else {

      /// B - if at (FIRST) slide
      if (_superFlyer.currentSlideIndex == 0){
        await _deleteFirstSlide();
      }

      /// B - if at (LAST) slide
      else if (_superFlyer.currentSlideIndex + 1 == _superFlyer.numberOfSlides){
        _deleteMiddleOrLastSlide();
      }

      /// B - if at (Middle) slide
      else {
        _deleteMiddleOrLastSlide();
      }

    }

  }
// -----------------------------------------------------o
  Future<void> _deleteFirstSlide() async {
    print('DELETING STARTS AT (FIRST) index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides} ------------------------------------');

    /// 1 - if only one slide remaining
    if(_superFlyer.numberOfSlides == 1){

      print('_draft.visibilities : ${_superFlyer.slidesVisibilities.toString()}, _draft.numberOfSlides : $_superFlyer.numberOfSlides');

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerSlideVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfStrips = 0;
        _statelessTriggerProgressOpacity();
      });

      /// B - wait fading to start deleting + update index to null
      await Future.delayed(Ratioz.durationFading210, () async {

        /// Dx - delete data
        setState(() {
          _statelessSlideDelete(_superFlyer.currentSlideIndex);
          _superFlyer.currentSlideIndex = null;
        });

      });

    }

    /// 2 - if two slides remaining
    else if(_superFlyer.numberOfSlides == 2){

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _superFlyer.listenToSwipe = false;
        _statelessTriggerSlideVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfStrips = _superFlyer.numberOfSlides - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await Sliders.slideToNext(_superFlyer.horizontalController, _superFlyer.numberOfSlides, _superFlyer.currentSlideIndex);


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
            _statelessSlideDelete(_superFlyer.currentSlideIndex);
            _superFlyer.currentSlideIndex = 0;
            // _draft.numberOfSlides = 1;
            _superFlyer.listenToSwipe = true;
          });

        });


      });
    }

    /// 2 - if more than two slides
    else {

      int _originalNumberOfSlides = _superFlyer.numberOfSlides;
      int _decreasedNumberOfSlides =  _superFlyer.numberOfSlides - 1;
      // int _originalIndex = 0;
      // int _decreasedIndex = 0;

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _superFlyer.listenToSwipe = false;
        _statelessTriggerSlideVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfSlides = _decreasedNumberOfSlides;
        _superFlyer.numberOfStrips = _superFlyer.numberOfSlides;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await  Sliders.slideToNext(_superFlyer.horizontalController, _superFlyer.numberOfSlides, _superFlyer.currentSlideIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfSlides <= 1){

          setState(() {
            /// Dx - delte data
            _statelessSlideDelete(_superFlyer.currentSlideIndex);
            _superFlyer.listenToSwipe = true;
          });

        }

        /// D - delete when at many slides remaining
        else {

          /// E - wait for sliding to end
          await Future.delayed(Ratioz.durationFading210, () async {

            /// Dx - delete data
            _statelessSlideDelete(_superFlyer.currentSlideIndex);
            /// F - snap to index 0
            await Sliders.snapTo(_superFlyer.horizontalController, 0);

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
              _superFlyer.listenToSwipe = true;
            });

          });

        }

      });

    }

    print('DELETING ENDS AT (FIRST) : index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides} ------------------------------------');
  }
// -----------------------------------------------------o
  Future<void> _deleteMiddleOrLastSlide() async {
    print('XXXXX ----- DELETING STARTS AT (MIDDLE) index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides}');

    int _originalIndex = _superFlyer.currentSlideIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      _superFlyer.listenToSwipe = false;
      _superFlyer.currentSlideIndex = _superFlyer.currentSlideIndex - 1;
      _superFlyer.swipeDirection = SwipeDirection.freeze;
      _superFlyer.numberOfStrips = _superFlyer.numberOfSlides - 1;
      _statelessTriggerSlideVisibility(_originalIndex);
    });

    // print('XXX after first rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    /// B - wait fading to start sliding
    await Future.delayed(Ratioz.durationFading210, () async {

      // print('_currentIndex before slide : $_draft.currentSlideIndex');

      /// C - slide
      await  Sliders.slideToBackFrom(_superFlyer.horizontalController, _originalIndex);
      // print('_currentIndex after slide : $_draft.currentSlideIndex');

      /// E - wait for sliding to end
      await Future.delayed(Ratioz.durationFading210, () async {

        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessSlideDelete(_originalIndex);
          _superFlyer.listenToSwipe = true;
        });

        // print('XXX after second rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

      });

      // print('XXX after third LAST rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    });

    print('XXXXX -------  DELETING ENDS AT (MIDDLE) : index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides}');
  }
// -----------------------------------------------------o
  void _statelessTriggerSlideVisibility(int index) {

    if (index != null){
      if(index >= 0 && _superFlyer.slidesVisibilities.length != 0){
        print('_draft.visibilities[index] was ${_superFlyer.slidesVisibilities[index]} for index : $index');
        _superFlyer.slidesVisibilities[index] = !_superFlyer.slidesVisibilities[index];
        print('_draft.visibilities[index] is ${_superFlyer.slidesVisibilities[index]} for index : $index');
      }
      else {
        print('can not trigger visibility for index : $index');
      }
    }

  }
// -----------------------------------------------------o
  void _statelessSlideDelete(int index){
    print('before stateless delete index was $index, _draft.numberOfSlides was : ${_superFlyer.numberOfSlides}');
    _superFlyer.assetsFiles.removeAt(index);
    _superFlyer.assetsSources.removeAt(index);
    _superFlyer.slidesVisibilities.removeAt(index);
    _superFlyer.headlinesControllers.removeAt(index);
    _superFlyer.boxesFits.removeAt(index);
    _superFlyer.numberOfSlides = _superFlyer.assetsSources.length;
    print('after stateless delete index is $index, _draft.numberOfSlides is : ${_superFlyer.numberOfSlides}');
  }
// -----------------------------------------------------o
  Future<void> _onCropImage() async {

    if(_superFlyer.assetsFiles.isNotEmpty){

      _triggerLoading();

      File croppedFile = await Imagers.cropImage(context, _superFlyer.assetsFiles[_superFlyer.currentSlideIndex]);

      if (croppedFile != null) {
        setState(() {
          _superFlyer.assetsFiles[_superFlyer.currentSlideIndex] = croppedFile;
        });
      }

      _triggerLoading();

    }

  }
// -----------------------------------------------------o
  Future<void> _onResetImage() async {

    if(_superFlyer.assetsFiles.isNotEmpty){

      File _file = await Imagers.getFileFromAsset(_superFlyer.assetsSources[_superFlyer.currentSlideIndex]);

      setState(() {
        _superFlyer.assetsFiles[_superFlyer.currentSlideIndex] = _file;
      });

    }

  }
// -----------------------------------------------------o
  void _onFitImage(BoxFit fit){

    if(_superFlyer.assetsFiles.isNotEmpty){

      if(fit == BoxFit.fitWidth) {
        setState(() {
          _superFlyer.boxesFits[_superFlyer.currentSlideIndex] = BoxFit.fitHeight;
        });
      }

      else {
        setState(() {
          _superFlyer.boxesFits[_superFlyer.currentSlideIndex] = BoxFit.fitWidth;
        });
      }

    }

  }
// -----------------------------------------------------o
  Future<void> _onFlyerTypeTap() async {

    double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.25);

    BottomDialog.slideStatefulBottomDialog(
      context: context,
      height: _dialogHeight,
      draggable: true,
      title: 'Select Flyer Type',
      builder: (context, title){
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState){


              return BottomDialog(
                height: _dialogHeight,
                title: title,
                draggable: true,
                child: Container(
                  width: BottomDialog.dialogClearWidth(context),
                  height: BottomDialog.dialogClearHeight(context: context, overridingDialogHeight: _dialogHeight, title: 'x'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      DreamBox(
                        height: 60,
                        width: BottomDialog.dialogClearWidth(context) / 2.2,
                        verse: 'Product Flyer',
                        // icon: Iconz.BxProductsOff,
                        // iconColor: _draft.flyerType == FlyerType.Product ? Colorz.Black255 : Colorz.White255,
                        // iconSizeFactor: 0.5,
                        verseMaxLines: 2,
                        verseScaleFactor: 0.7,
                        color: _superFlyer.flyerType == FlyerType.Product ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _superFlyer.flyerType == FlyerType.Product ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _superFlyer.flyerType = FlyerType.Product;
                          });

                          setState(() {
                            _superFlyer.flyerType = FlyerType.Product;
                          });

                        },
                      ),

                      DreamBox(
                        height: 60,
                        width: BottomDialog.dialogClearWidth(context) / 2.2,
                        verse: 'Equipment Flyer',
                        // icon: Iconz.BxEquipmentOff,
                        // iconColor: _draft.flyerType == FlyerType.Product ? Colorz.Black255 : Colorz.White255,
                        // iconSizeFactor: 0.5,
                        verseMaxLines: 2,
                        verseScaleFactor: 0.7,
                        color: _superFlyer.flyerType == FlyerType.Equipment ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _superFlyer.flyerType == FlyerType.Equipment ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _superFlyer.flyerType = FlyerType.Equipment;
                          });
                          setState(() {
                            _superFlyer.flyerType = FlyerType.Equipment;
                          });
                        },
                      ),

                    ],
                  ),
                ),
              );
            }
        );
      },
    );
  }
// -----------------------------------------------------o
  Future<void> _onChangeZone() async {

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    List<Map<String,String>> _flags = _countryPro.getAvailableCountries(context);
    List<Map<String,String>> _cities = _countryPro.getCitiesNamesMapsByIso3(context, _superFlyer.flyerZone.countryID);
    List<Map<String,String>> _districts = _countryPro.getDistrictsNameMapsByCityID(context, _superFlyer.flyerZone.cityID);

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    bool _openNextDialog = false;

    /// COUNTRY DIALOG
    await BottomDialog.slideBottomDialog(
      context: context,
      draggable: true,
      height: null,
      title: 'Publish this flyer targeting a specific city',
      child: BottomDialogButtons(
        listOfMaps: _flags,
        mapValueIs: MapValueIs.flag,
        alignment: Alignment.center,
        provider: _countryPro,
        sheetType: BottomSheetType.BottomSheet,
        buttonTap: (countryID) async {

          String _lastCountryID = _superFlyer.flyerZone.countryID;

          setState(() {
            _superFlyer.flyerZone.countryID = countryID;
            _cities = _countryPro.getCitiesNamesMapsByIso3(context, _superFlyer.flyerZone.countryID);
            _openNextDialog = true;
          });

          /// if changed country, reset city & district
          if (_lastCountryID != countryID){
            setState(() {
              _superFlyer.flyerZone.cityID = null;
              _superFlyer.flyerZone.districtID = null;
            });
          }

          await Nav.goBack(context);

        },
      ),
    );

    /// CITY DIALOG
    if(_openNextDialog == true) {
      _openNextDialog = false;
      await BottomDialog.slideBottomDialog(
        context: context,
        draggable: true,
        height: null,
        title: '${_countryPro.getCountryNameInCurrentLanguageByIso3(context, _superFlyer.flyerZone.countryID)} Cities',
        child: BottomDialogButtons(
          listOfMaps: _cities,
          mapValueIs: MapValueIs.String,
          alignment: Alignment.center,
          provider: _countryPro,
          sheetType: BottomSheetType.Province,
          buttonTap: (cityID) async {

            String _lastCity = _superFlyer.flyerZone.cityID;

            setState(() {
              _superFlyer.flyerZone.cityID = cityID;
              _districts = _countryPro.getDistrictsNameMapsByCityID(context, cityID);
              _openNextDialog = true;
            });

            /// if city changed, reset district
            if (_lastCity != cityID){
              setState(() {
                _superFlyer.flyerZone.districtID = null;
              });
            }

            await Nav.goBack(context);
          },
        ),
      );
    }

    /// DISTRICT DIALOG
    if(_openNextDialog == true) {
      await BottomDialog.slideBottomDialog(
        context: context,
        draggable: true,
        height: null,
        title: '${_countryPro.getCityNameWithCurrentLanguageIfPossible(context, _superFlyer.flyerZone.cityID)} Districts',
        child: BottomDialogButtons(
          listOfMaps: _districts,
          mapValueIs: MapValueIs.String,
          alignment: Alignment.center,
          provider: _countryPro,
          sheetType: BottomSheetType.District,
          buttonTap: (districtID) async {
            setState(() {
              _superFlyer.flyerZone.districtID = districtID;
            });

            await Nav.goBack(context);
          },
        ),
      );
    }

  }
// -----------------------------------------------------o
  Future<void> _onAboutTap() async {

    double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.95);
    double _dialogClearWidth = BottomDialog.dialogClearWidth(context);

    await BottomDialog.slideBottomDialog(
      context: context,
      draggable: true,
      height: _dialogHeight,
      title: 'Add more info to your flyer',
      child: Column(
        children: <Widget>[

          /// TEXTFIELD
          Container(
            width: _dialogClearWidth,
            child: SuperTextField(
              // autofocus: autoFocus,
              // onChanged: textFieldOnChanged,
              width: _dialogClearWidth,
              hintText: '...',
              fieldColor: Colorz.White20,
              // margin: EdgeInsets.only(top: (_dialogClearWidth * 0.3), left: 5, right: 5),
              maxLines: 10,
              minLines: 5,
              maxLength: 500,
              designMode: false,
              counterIsOn: true,
              inputSize: 2,
              centered: false,
              textController: _superFlyer.infoController,
              inputWeight: VerseWeight.thin,
              inputShadow: false,
              fieldIsFormField: false,

              onSubmitted: (val){
                print('val is : $val');
              },
              keyboardTextInputType: TextInputType.multiline,
              keyboardTextInputAction: TextInputAction.newline,
            ),
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
  Future<void> _onKeywordsTap() async {
    double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.5);
    double _dialogClearWidth = BottomDialog.dialogClearWidth(context);

    await BottomDialog.slideStatefulBottomDialog(
        context: context,
        draggable: true,
        height: _dialogHeight,
        title: 'Select flyer tags',
        builder: (context, title) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setDialogState) {
                return
                  BottomDialog(
                    title: title,
                    height: _dialogHeight,
                    draggable: true,
                    child: Container(
                      width: _dialogClearWidth,
                      height: 100,
                      // color: Colorz.BloodTest,
                    ),
                  );
              }
          );
        }
    );
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    super.build(context);

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
    bool _ankhIsOn = _prof.checkAnkh(widget.flyerID);

    return

      _flyerMode == FlyerMode.tiny || _flyerMode == FlyerMode.tinyWithID ?
      TinyFlyerWidget(
        superFlyer: _superFlyer,
        // flyerSizeFactor: Scale.superFlyerSizeFactorByWidth(context, widget.flyerZoneWidth),
        // tinyFlyer: widget.tinyFlyer,
        // onTap: _tappingFlyerZone,
      )

          :

      _flyerMode == FlyerMode.normal ?
      NormalFlyerWidget(
        superFlyer: _superFlyer,
        // flyerSizeFactor: Scale.superFlyerSizeFactorByWidth(context, widget.flyerZoneWidth),
        // flyer: widget.flyerModel,
        // onSwipeFlyer: widget.onSwipeFlyer,
      )

          :

      _flyerMode == FlyerMode.normalWithID ?
      NormalFlyerWidget(
        superFlyer: _superFlyer,

        // flyerSizeFactor: Scale.superFlyerSizeFactorByWidth(context, widget.flyerZoneWidth),
        // flyer: _flyerModel,
        // onSwipeFlyer: widget.onSwipeFlyer,
      )

      //     :
      //
      // _flyerMode == FlyerMode.draft ?
      //     Container()
          :

      FlyerZone(
       flyerSizeFactor: Scale.superFlyerSizeFactorByWidth(context, widget.flyerZoneWidth),
        tappingFlyerZone: _tappingFlyerZone,
        onLongPress: _onFlyerZoneLongPress,
        stackWidgets: <Widget>[



        ],
      );
  }
}
