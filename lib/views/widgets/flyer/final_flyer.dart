import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/firestore/record_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/records/share_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/publish_time_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/h_0_flyer_screen.dart';
import 'package:bldrs/views/screens/x_0_flyer_editor_screen.dart';
import 'package:bldrs/views/screens/x_x_flyer_on_map.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/flyer/flyer_methods.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_pages.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

// enum FlyerMode {
//   tiny,
//   tinyWithID,
//
//   normal,
//   normalWithID,
//
//   newDraft,
//   draftFromFlyer,
//
//   empty,
// }

class FinalFlyer extends StatefulWidget {
  final double flyerZoneWidth;
  final FlyerModel flyerModel;
  final TinyFlyer tinyFlyer;
  final int initialSlideIndex;
  final Function onSwipeFlyer;
  final bool goesToEditor;
  final bool inEditor; // vs inView
  final BzModel bzModel;
  final String flyerID;

  const FinalFlyer({
    @required this.flyerZoneWidth,
    this.flyerModel,
    this.tinyFlyer,
    this.initialSlideIndex = 0,
    this.onSwipeFlyer,
    this.goesToEditor = false,
    this.inEditor = false,
    this.bzModel,
    this.flyerID,
    Key key
  }) :
  // assert(isDraft != null),
  // assert(child != null),
  super(key: key);


  @override
  _FinalFlyerState createState() => _FinalFlyerState();

}

class _FinalFlyerState extends State<FinalFlyer> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  FlyersProvider _prof;
  SuperFlyer _superFlyer;
  BzModel _bzModel;
  FlyerModel _originalFlyer;
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

    /// get current bzModel when this flyer goes to editor
    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _bzModel = widget.bzModel;
    // print('FINAL FINAL initialized _bzModel as : ${_bzModel.bzID} as bzName : ${_bzModel.bzName}');

    /// initialize initial superFlyer before fetching the actual superFlyer
    _superFlyer = _initializeSuperFlyer();

    super.initState();
  }
  // -----------------------------------------------------------------------------
  @override
  void dispose() {
    // TextChecker.disposeAllTextControllers(_superFlyer.headlinesControllers);
    // Animators.disposeControllerIfPossible(_superFlyer.verticalController);
    // Animators.disposeControllerIfPossible(_superFlyer.horizontalController);
    // Animators.disposeControllerIfPossible(_superFlyer.infoScrollController);
    // FocusScope.of(context).dispose();
    //     _slidingController.dispose();

    super.dispose();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        dynamic _flyerSource = FlyerMethod.selectFlyerSource(
          flyerID: widget.flyerID,
          tinyFlyer: widget.tinyFlyer,
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
        );

        FlyerMode _flyerMode = FlyerMethod.flyerModeSelector(
          context: context,
          flyerZoneWidth: widget.flyerZoneWidth,
          flyerSource: _flyerSource,
          inEditor: widget.inEditor,
        );

        // --------------------------------------------------------------------X

        SuperFlyer _builtSuperFlyer;

        if (_flyerMode == FlyerMode.tinyModeByFlyerID){
          TinyFlyer _dbTinyFlyer = await FlyerOps().readTinyFlyerOps(context: context, flyerID: widget.flyerID);
          _builtSuperFlyer = _getSuperFlyerFromTinyFlyer(tinyFlyer: _dbTinyFlyer);
        }

        else if (_flyerMode == FlyerMode.tinyModeByTinyFlyer){
          _builtSuperFlyer = _getSuperFlyerFromTinyFlyer(tinyFlyer: widget.tinyFlyer);
        }

        else if (_flyerMode == FlyerMode.tinyModeByFlyerModel){
          _builtSuperFlyer = _getSuperFlyerFromFlyer(flyerModel: widget.flyerModel);
        }

        else if (_flyerMode == FlyerMode.tinyModeByBzModel){
          _builtSuperFlyer = _getSuperFlyerFromBzModel(bzModel: widget.bzModel);
        }

        else if (_flyerMode == FlyerMode.tinyModeByNull){
          _builtSuperFlyer = SuperFlyer.createEmptySuperFlyer(flyerZoneWidth: widget.flyerZoneWidth, goesToEditor: widget.goesToEditor);
        }

        // --------------------------------------------------------------------X

        else if (_flyerMode == FlyerMode.bigModeByFlyerID){
          FlyerModel _dbFlyerModel = await FlyerOps().readFlyerOps(context: context, flyerID: widget.flyerID);
          _builtSuperFlyer = _getSuperFlyerFromFlyer(flyerModel: _dbFlyerModel);
        }

        else if (_flyerMode == FlyerMode.bigModeByTinyFlyer){
          FlyerModel _dbFlyerModel = await FlyerOps().readFlyerOps(context: context, flyerID: widget.tinyFlyer.flyerID);
          _builtSuperFlyer = _getSuperFlyerFromFlyer(flyerModel: _dbFlyerModel);
        }

        else if (_flyerMode == FlyerMode.bigModeByFlyerModel){
          _builtSuperFlyer = _getSuperFlyerFromFlyer(flyerModel: widget.flyerModel);
        }

        else if (_flyerMode == FlyerMode.bigModeByBzModel){
          _builtSuperFlyer = _getSuperFlyerFromBzModel(bzModel: widget.bzModel);
        }

        else if (_flyerMode == FlyerMode.bigModeByNull){
          _builtSuperFlyer = SuperFlyer.createEmptySuperFlyer(flyerZoneWidth: widget.flyerZoneWidth, goesToEditor: widget.goesToEditor);
        }

        // --------------------------------------------------------------------X

        else if (_flyerMode == FlyerMode.editorModeByFlyerID){
          _originalFlyer = await FlyerOps().readFlyerOps(context: context, flyerID: widget.flyerID);
          _builtSuperFlyer = await _getDraftSuperFlyerFromFlyer(bzModel: _bzModel, flyerModel: _originalFlyer);
        }

        else if (_flyerMode == FlyerMode.editorModeByTinyFlyer){
          _originalFlyer = await FlyerOps().readFlyerOps(context: context, flyerID: widget.tinyFlyer.flyerID);
          _builtSuperFlyer = await _getDraftSuperFlyerFromFlyer(bzModel: _bzModel, flyerModel: _originalFlyer);
        }

        else if (_flyerMode == FlyerMode.editorModeByFlyerModel){
          _originalFlyer = widget.flyerModel;
          _builtSuperFlyer = await _getDraftSuperFlyerFromFlyer(bzModel: _bzModel, flyerModel: widget.flyerModel);
        }

        else if (_flyerMode == FlyerMode.editorModeByBzModel){
          _builtSuperFlyer = await _getDraftSuperFlyerFromNothing(bzModel: _bzModel);
        }

        else if (_flyerMode == FlyerMode.editorModeByNull){
          _builtSuperFlyer = await _getDraftSuperFlyerFromNothing(bzModel: _bzModel);
        }

        // --------------------------------------------------------------------X


        // --------------------------------------------------------------------X


        /// X - REBUILD
        _triggerLoading(function: (){
          _superFlyer = _builtSuperFlyer;
        });

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  /// SUPER FLYER CREATORS

// -----------------------------------------------------o
  SuperFlyer _initializeSuperFlyer(){
    SuperFlyer _superFlyer;

    /// A - by flyerModel

    if (widget.flyerModel != null){
      _superFlyer = _getSuperFlyerFromFlyer(flyerModel: widget.flyerModel);
    }

    /// A - by tinyFlyer
    else if (widget.tinyFlyer != null){
        _superFlyer = _getSuperFlyerFromTinyFlyer(tinyFlyer: widget.tinyFlyer);

    }

    else if(widget.bzModel != null){
      _superFlyer = _getSuperFlyerFromBzModel(bzModel: widget.bzModel);
    }

    /// A - when only bzModel is provided (empty flyer only with header)
    else if (widget.goesToEditor == true){

      if (widget.tinyFlyer == null){
      _superFlyer = _getDraftSuperFlyerFromNothing(bzModel: _bzModel);
      }


    }

    /// A - emptiness
    else {
      _superFlyer = SuperFlyer.createEmptySuperFlyer(flyerZoneWidth: widget.flyerZoneWidth, goesToEditor: widget.goesToEditor);
    }

    return _superFlyer;
  }
// -----------------------------------------------------o
  SuperFlyer _getSuperFlyerFromTinyFlyer({TinyFlyer tinyFlyer}){
    SuperFlyer _superFlyer = SuperFlyer.createViewSuperFlyerFromTinyFlyer(
      context: context,
      flyerZoneWidth: widget.flyerZoneWidth,
      tinyFlyer: tinyFlyer,
      onHeaderTap: () async {await _openTinyFlyer();},
      onTinyFlyerTap: () async {await _openTinyFlyer();},
      onAnkhTap: () async {await _onAnkhTap();},
    );
    return _superFlyer;
  }
// -----------------------------------------------------o
  SuperFlyer _getSuperFlyerFromFlyer({FlyerModel flyerModel}){
    SuperFlyer _superFlyer;

    if (flyerModel != null){
      _superFlyer = SuperFlyer.createViewSuperFlyerFromFlyerModel(
        context: context,
        flyerZoneWidth: widget.flyerZoneWidth,
        flyerModel: flyerModel,
        initialPage: widget.initialSlideIndex,
        onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _onVerticalPageBack();},
        onHeaderTap: () async {await _onHeaderTap();},
        onSlideRightTap: _onSlideRightTap,
        onSlideLeftTap: _onSlideLeftTap,
        onSwipeFlyer: widget.onSwipeFlyer,
        onTinyFlyerTap: () async {await _openTinyFlyer();},
        onView: (slideIndex) => _onViewSlide(slideIndex),
        onAnkhTap: () async {await _onAnkhTap();} ,
        onShareTap: _onShareTap,
        onFollowTap: () async { await _onFollowTap();},
        onCallTap: () async { await _onCallTap();},
      );

    }

    /// TASK : below code is temp,,, should see what to do if flyer not found on db
    else {
      _superFlyer = SuperFlyer.createEmptySuperFlyer(flyerZoneWidth: widget.flyerZoneWidth, goesToEditor: false);
    }

    return _superFlyer;
  }
// -----------------------------------------------------o
  Future <SuperFlyer> _getDraftSuperFlyerFromFlyer({FlyerModel flyerModel, BzModel bzModel}) async {
    SuperFlyer _superFlyer;
    if(flyerModel != null && bzModel != null){
      _superFlyer = await SuperFlyer.createDraftSuperFlyerFromFlyer(
        context: context,
        flyerZoneWidth: widget.flyerZoneWidth,
        bzModel: bzModel,
        flyerModel: flyerModel,
        onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _onVerticalPageBack();},
        onHeaderTap: () async {await _onHeaderTap();},
        onSlideRightTap: _onSlideRightTap,
        onSlideLeftTap: _onSlideLeftTap,
        onSwipeFlyer: widget.onSwipeFlyer,
        onTinyFlyerTap: () async {await _openTinyFlyer();},
        onView: (i) => _onViewSlide(i),
        onAnkhTap: () async {await _onAnkhTap();} ,
        onShareTap: _onShareTap,
        onFollowTap: () async { await _onFollowTap();},
        onCallTap: () async { await _onCallTap();},
        onAddImages: () => _onAddImages(),
        onDeleteSlide: () async {await _onDeleteSlide();},
        onCropImage: () async {await _onCropImage();},
        onResetImage: () async {await _onResetImage();},
        onFitImage: _onFitImage,
        onFlyerTypeTap: () async {await _onFlyerTypeTap();},
        onZoneTap: () async {await _onChangeZone();},
        onAboutTap: () async {await _onAboutTap();},
        onKeywordsTap: () async {await _onKeywordsTap();},
        onShowAuthorTap: _onShowAuthorTap,
        onTriggerEditMode: _onTriggerEditMode,
        onPublishFlyer: () async {await _onPublishFlyer();},
        onDeleteFlyer: () async {await _onDeleteFlyer();},
        onUnPublishFlyer: () async {await _onUnpublishFlyer();},
        onRepublishFlyer: () async {await _onRepublishFlyer();},
      );

    }
    else {
      _superFlyer = SuperFlyer.createEmptySuperFlyer(flyerZoneWidth: widget.flyerZoneWidth, goesToEditor: widget.goesToEditor);
    }

    return _superFlyer;
  }
// -----------------------------------------------------o
  SuperFlyer _getDraftSuperFlyerFromNothing({BzModel bzModel}){
    SuperFlyer _superFlyer = SuperFlyer.createDraftSuperFlyerFromNothing(
      context: context,
      flyerZoneWidth: widget.flyerZoneWidth,
      bzModel: bzModel,
      onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
      onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
      onVerticalPageBack: () async {await _onVerticalPageBack();},
      onHeaderTap: () async {await _onHeaderTap();},
      onSlideRightTap: _onSlideRightTap,
      onSlideLeftTap: _onSlideLeftTap,
      onSwipeFlyer: widget.onSwipeFlyer,
      onTinyFlyerTap: () async {await _openTinyFlyer();},
      onView: (i) => _onViewSlide(i),
      onAnkhTap: () async {await _onAnkhTap();} ,
      onShareTap: _onShareTap,
      onFollowTap: () async { await _onFollowTap();},
      onCallTap: () async { await _onCallTap();},
      onAddImages: () => _onAddImages(),
      onDeleteSlide: () async {await _onDeleteSlide();},
      onCropImage: () async {await _onCropImage();},
      onResetImage: () async {await _onResetImage();},
      onFitImage: _onFitImage,
      onFlyerTypeTap: () async {await _onFlyerTypeTap();},
      onZoneTap: () async {await _onChangeZone();},
      onAboutTap: () async {await _onAboutTap();},
      onKeywordsTap: () async {await _onKeywordsTap();},
      onShowAuthorTap: _onShowAuthorTap,
      onTriggerEditMode: _onTriggerEditMode,
      onPublishFlyer: () async {await _onPublishFlyer();},
      onDeleteFlyer: () async {await _onDeleteFlyer();},
      onUnPublishFlyer: () async {await _onUnpublishFlyer();},
      onRepublishFlyer: () async {await _onRepublishFlyer();},
    );

    return _superFlyer;
  }
// -----------------------------------------------------o
  FlyerModel _createTempEmptyFlyer(){

    AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bzModel, superUserID());
    TinyUser _tinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(_author);

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    return new FlyerModel(
      flyerID : SuperFlyer.draftID, // no need
      // -------------------------
      flyerType : FlyerTypeClass.concludeFlyerType(_bzModel.bzType),
      flyerState : FlyerState.Draft,
      keywords : _superFlyer?.keywords,
      flyerShowsAuthor : true,
      flyerURL : '...',
      flyerZone: _countryPro.currentZone,
      // -------------------------
      tinyAuthor : _tinyAuthor,
      tinyBz : TinyBz.getTinyBzFromBzModel(_bzModel),
      // -------------------------
      publishTime : DateTime.now(),
      flyerPosition : null,
      // -------------------------
      ankhIsOn : false,
      // -------------------------
      slides : new List(),
      // -------------------------
      flyerIsBanned: false,
      deletionTime: null,
    );
  }
// -----------------------------------------------------o
  SuperFlyer _getSuperFlyerFromBzModel({BzModel bzModel}){
    SuperFlyer _superFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(
      onHeaderTap: _onHeaderTap,
      flyerZoneWidth: widget.flyerZoneWidth,
      bzModel: bzModel,
    );

    return _superFlyer;
  }
// -----------------------------------------------------------------------------

  ///   NAVIGATION METHODS

  Future <void> _openTinyFlyer() async {

    TinyFlyer _tinyFlyer = TinyFlyer.getTinyFlyerFromSuperFlyer(_superFlyer);
    print('opening tiny flyer : ${_tinyFlyer.flyerID} while THE FUCKING widget.goesToEditor IS : ${widget.goesToEditor}');

    /// opening editor
    if (widget.goesToEditor == true){
      await _goToFlyerEditor(
        context: context,
        firstTimer: _superFlyer.firstTimer,
      );
    }

    /// opening flyer to view
    else {

      await Nav.openFlyer(
          context: context,
          tinyFlyer: _tinyFlyer,
      );

    }


    // await Navigator.push(context,
    // MaterialPageRoute(builder: (context) => FlyerScreen(
    //   tinyFlyer: _tinyFlyer,
    // )
    // )
    // );

    print('WWWWWWWWWWWWWTTTTTTTTTTTFFFFFFFFFFF');
  }
// -----------------------------------------------------o
  void _onFlyerZoneTap(){

    bool _tinyMode = Scale.superFlyerTinyMode(context, widget.flyerZoneWidth);

    print('Final flyer zone tapped : ${_superFlyer.flyerID} : micro mode is $_tinyMode');

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    if (_tinyMode == true){

      print('tapping tiny flyer aho');
      _openTinyFlyer();

    }

  }
// -----------------------------------------------------o
  void _onFlyerZoneLongPress(){
    print('Final flyer zone long pressed');
  }
// -----------------------------------------------------o
  void _onHeaderTap(){
    print('_onHeaderTap : bzPageIsOn was : ${_superFlyer.bzPageIsOn}');
    setState(() {
      _superFlyer.bzPageIsOn = !_superFlyer.bzPageIsOn;
      _statelessTriggerProgressOpacity();
    });
    print('_onHeaderTap : bzPageIsOn is : ${_superFlyer.bzPageIsOn}');
  }
// -----------------------------------------------------o
  Future<void> _goToFlyerEditor({BuildContext context, bool firstTimer}) async {

    print('going to flyer editor for flyerID ${_superFlyer.flyerID} as firstTimer is ${firstTimer}');

    await Future.delayed(Ratioz.durationFading200, () async {

      // FlyerModel _flyer = firstTimer == true ? null : widget.flyerModel;

      dynamic _result = await Nav.goToNewScreen(context,
          new FlyerEditorScreen(
            firstTimer: firstTimer,
            bzModel: _bzModel,
            tinyFlyer: firstTimer == true ? null : widget.tinyFlyer,
          )
      );

      if (_result.runtimeType == TinyFlyer){
        print('_goToFlyerEditor : adding published flyer model to bzPage screen gallery');
        _updateTinyFlyerInLocalBzTinyFlyers(_result);
      }
      else {
        print('_goToFlyerEditor : did not publish the new draft flyer');
      }

    });
  }
// -----------------------------------------------------------------------------

  /// SLIDING METHODS

  void _onHorizontalSlideSwipe (int newIndex){
    print('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
    SwipeDirection _direction = Animators.getSwipeDirection(newIndex: newIndex, oldIndex: _superFlyer.currentSlideIndex,);

    // if(_superFlyer.editMode == false){
    //   FocusScope.of(context).dispose();
    // }

    /// A - if Keyboard is active
    if (Keyboarders.keyboardIsOn(context) == true){
      print('KEYBOARD IS ACTIVE');

      /// B - when direction is going next
      if (_direction == SwipeDirection.next){
        print('going next');
        FocusScope.of(context).nextFocus();
        setState(() {
          _superFlyer.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
          _superFlyer.currentPicFit = _superFlyer.boxesFits[newIndex];
        });
      }

      /// B - when direction is going back
      else if (_direction == SwipeDirection.back){
        print('going back');
        FocusScope.of(context).previousFocus();
        setState(() {
          _superFlyer.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
          _superFlyer.currentPicFit = _superFlyer.boxesFits[newIndex];
        });
      }

      /// B = when direction is freezing
      else {
        print('going no where');
        setState(() {
          _superFlyer.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
          _superFlyer.currentPicFit = _superFlyer.boxesFits[newIndex];
        });
      }
    }

    /// A - if keyboard is not active
    else {
      print('KEYBOARD IS NOT ACTIVE');
      setState(() {
        _superFlyer.swipeDirection = _direction;
        _superFlyer.currentSlideIndex = newIndex;
        _superFlyer.currentPicFit = _superFlyer.boxesFits[newIndex];
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

    print('triggering progress bar opacity');

    if (_superFlyer.progressBarOpacity == 1){
      _superFlyer.progressBarOpacity = 0;
    } else {
      _superFlyer.progressBarOpacity = 1;
    }
  }
// -----------------------------------------------------o
  Future<void> _triggerKeywordsView() async {

    print('_triggerKeywordsView : _verticalIndex : ${_superFlyer.verticalIndex}');


    /// open keywords
    if(_superFlyer.verticalIndex == 0){
      await Sliders.slideToNext(_superFlyer.verticalController, 2, 0);
      // await Sliders.slideToNext(_panelController, 2, 0);
    }
    /// close keywords
    else {
      await Sliders.slideToBackFrom(_superFlyer.verticalController, 1);
      // await Sliders.slideToBackFrom(_panelController, 1);
    }

    setState(() {
      _statelessTriggerProgressOpacity();
    });

  }
// -----------------------------------------------------o
  Future<void> _onSwipeFlyer() async {
    /// TASK : do some magic
  }
// -----------------------------------------------------------------------------

  /// RECORD METHODS

  void _onViewSlide(int slideIndex){
    print('viewing slide : ${slideIndex} : from flyer : ${_superFlyer.flyerID}');
  }
// -----------------------------------------------------o
  Future<void> _onAnkhTap() async {
    print('tapping Ankh');

    /// start save flyer ops
    await RecordOps.saveFlyerOps(
        context: context,
        userID: superUserID(),
        flyerID: _superFlyer.flyerID,
        slideIndex: _superFlyer.currentSlideIndex,
    );

    TinyFlyer _tinyFlyer = TinyFlyer.getTinyFlyerFromSuperFlyer(_superFlyer);

    /// add or remove tiny flyer in local saved flyersList
    _prof.addOrDeleteTinyFlyerInLocalSavedTinyFlyers(_tinyFlyer);

    setState(() {
      _superFlyer.ankhIsOn = !_superFlyer.ankhIsOn;
    });
    print('ankh is ${_superFlyer.ankhIsOn}');

  }
// -----------------------------------------------------o
  Future<void> _onShareTap() async {
    print('Sharing flyer');

    int _i = _superFlyer.currentSlideIndex;

    /// TASK : adjust link url and description
    LinkModel _theFlyerLink = LinkModel(
        url: _superFlyer.flyerURL,
        description: '${_superFlyer.flyerType} flyer .\n'
            '- slide number ${_superFlyer.currentSlideIndex} .\n'
            '- ${_superFlyer.slides[_i].headline} .\n'
    );

    // don't await this method
    RecordOps.shareFlyerOPs(
        context: context,
        flyerID: _superFlyer.flyerID,
        userID: superUserID(),
        slideIndex: _superFlyer.currentSlideIndex,
      );

      await ShareModel.shareFlyer(context, _theFlyerLink);
  }
// -----------------------------------------------------o
  Future <void> _onFollowTap() async {
    print('Following bz : followIsOn was ${_superFlyer.followIsOn} & headline for slide ${_superFlyer.currentSlideIndex} is : ${_superFlyer.slides[_superFlyer.currentSlideIndex].headline}');

    /// start follow bz ops
    List<String> _updatedBzFollows = await RecordOps.followBzOPs(
      context: context,
      bzID: _superFlyer.bzID,
      userID: superUserID(),
    );

    /// add or remove tinyBz from local followed bzz
    _prof.updatedFollowsInLocalList(_updatedBzFollows);

    /// trigger current follow value
    setState(() {
      _superFlyer.followIsOn = !_superFlyer.followIsOn;
    });


  }
// -----------------------------------------------------o
  Future<void> _onCallTap() async {
    print('Call Bz');

    String _userID = superUserID();
    String _bzID = _superFlyer.bzID;
    String _contact = _superFlyer.flyerTinyAuthor.email;

    /// alert user there is no contact to call
    if (_contact == null){print('no contact here');}

    /// or launch call and start call bz ops
    else {

      /// launch call
      launchCall('tel: $_contact');

      /// start call bz ops
      await RecordOps.callBzOPs(
        context: context,
        bzID: _bzID,
        userID: _userID,
        slideIndex: _superFlyer.currentSlideIndex,
      );

    }

  }
// -----------------------------------------------------------------------------

  /// EDITOR METHOD

// -----------------------------------------------------o
  void _onTriggerEditMode(){
    setState(() {
      _superFlyer.editMode = !_superFlyer.editMode;
    });
  }
// -----------------------------------------------------o
  void _onShowAuthorTap(){

    print('triggering showing author : as _superFlyer is : ${_superFlyer.flyerID} \n and superFlyer.flyerShowsAuthor is : ${_superFlyer.flyerShowsAuthor}');

    setState(() {
      _superFlyer.flyerShowsAuthor = !_superFlyer.flyerShowsAuthor;
    });
  }
// -----------------------------------------------------o
  Future<void> _onAddImages() async {

    FocusScope.of(context).unfocus();

    _triggerLoading();

    List<Asset> _assetsSources = _superFlyer.assetsSources;
    int _maxLength = Standards.getMaxSlidesCount(_superFlyer.accountType);

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
          List<BoxFit> _fits = Imagers.concludeBoxesFits(assets: _assetsSources, flyerZoneWidth: widget.flyerZoneWidth);


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
              _newFits.add(Imagers.concludeBoxFit(asset: newAsset, flyerZoneWidth: widget.flyerZoneWidth));
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
            _superFlyer.currentPicFit = _superFlyer.boxesFits[_superFlyer.currentSlideIndex];
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
    if(ObjectChecker.listCanBeUsed(_superFlyer.assetsFiles) == true){_superFlyer.assetsFiles.removeAt(index);}
    if(ObjectChecker.listCanBeUsed(_superFlyer.assetsFiles) == true){_superFlyer.slides.removeAt(index);}
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
  void _onFitImage(){

    print('tapping on fit image : ${_superFlyer.assetsFiles.length} assets and currentPicFit was : ${_superFlyer.currentPicFit}');

    if(_superFlyer.assetsFiles.isNotEmpty){

      int index = _superFlyer.currentSlideIndex;

      if(_superFlyer.currentPicFit == BoxFit.fitWidth) {
        print('trying to get fit width to fit height');
        setState(() {
          _superFlyer.currentPicFit = BoxFit.fitHeight;
          _superFlyer.boxesFits[index] = _superFlyer.currentPicFit;
        });
      }

      else if (_superFlyer.currentPicFit == BoxFit.fitHeight){
        print('trying to get fit height to fit width');
        setState(() {
          _superFlyer.currentPicFit = BoxFit.fitWidth;
          _superFlyer.boxesFits[index] = _superFlyer.currentPicFit;
        });
      }

      else {
        setState(() {
          _superFlyer.currentPicFit = BoxFit.fitHeight;
          _superFlyer.boxesFits[index] = _superFlyer.currentPicFit;
        });
      }

    }

    print('tapping on fit image : ${_superFlyer.assetsFiles.length} assets and currentPicFit is : ${_superFlyer.currentPicFit}');

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
// -----------------------------------------------------o
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
// -----------------------------------------------------o
  void _addKeywords(){


    List<Keyword> _keywords = <Keyword>[
      Keyword.bldrsKeywords()[100],
      Keyword.bldrsKeywords()[120],
      Keyword.bldrsKeywords()[205],
      Keyword.bldrsKeywords()[403],
      Keyword.bldrsKeywords()[600],
    ];

    double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.7);

    BottomDialog.slideStatefulBottomDialog(
      context: context,
      height: _dialogHeight,
      draggable: true,
      builder: (context, title){
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState){
              return BottomDialog(
                height: _dialogHeight,
                draggable: true,
                title: title,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SuperVerse(
                      verse: 'Add Keywords to the flyer',
                      size: 3,
                      weight: VerseWeight.thin,
                      italic: true,
                    ),

                    Container(
                      width: BottomDialog.dialogClearWidth(context),
                      height: BottomDialog.dialogClearHeight(title: 'x', context: context, overridingDialogHeight: _dialogHeight),
                      child: ListView(
                        // key: UniqueKey(),

                        children: <Widget>[

                          SizedBox(
                            height: Ratioz.appBarPadding,
                          ),

                          KeywordsBubble(
                            verseSize: 1,
                            bubbles: false,
                            title: 'Selected keywords',
                            keywords: _superFlyer.keywords,
                            selectedWords: _superFlyer.keywords,
                            onTap: (value){
                              setDialogState(() {
                                _superFlyer.keywords.remove(value);
                              });
                            },
                          ),

                          KeywordsBubble(
                            verseSize: 1,
                            bubbles: true,
                            title: 'Space Type',
                            keywords: _keywords,
                            selectedWords: _superFlyer.keywords,
                            onTap: (value){
                              setDialogState(() {
                                _superFlyer.keywords.add(value);
                              });
                            },
                          ),

                          KeywordsBubble(
                            verseSize: 1,
                            bubbles: true,
                            title: 'Product Use',
                            keywords: _keywords,
                            selectedWords: _superFlyer.keywords,
                            onTap: (value){setDialogState(() {_superFlyer.keywords.add(value);});},
                          ),

                          // Container(
                          //   width: dialogClearWidth(context)(context),
                          //   height: 800,
                          //   color: Colorz.BloodTest,
                          // ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        );
      },
    );
  }
// -----------------------------------------------------o
  Future<void>_selectOnMap() async {

    if (_superFlyer.slides.length == 0){

      await superDialog(
        context: context,
        title: '',
        body: 'Map Slide Can not be The First Slide',
        boolDialog: false,
      );

    } else {
      final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
          MaterialPageRoute(
              builder: (ctx) =>
                  GoogleMapScreen(
                    isSelecting: true,
                    flyerZoneWidth: Scale.superFlyerZoneWidth(context, 0.8),
                  )
          )
      );
      if (selectedLocation == null) {
        return;
      }
      _showMapPreview(selectedLocation.latitude, selectedLocation.longitude);
      _newLocationSlide();
      print("${selectedLocation.latitude},${selectedLocation.longitude}");
    }
  }
// -----------------------------------------------------o
  void _showMapPreview(double lat, double lng) {
    final staticMapImageUrl = getStaticMapImage(context, lat, lng);
    setState(() {
      // _mapImageURL = staticMapImageUrl;
      // _superFlyer.position = GeoPoint(lat, lng);
    });

    /// TASK : when adding map slide,, should add empty values in _draft.assetsFiles & _assets ... etc
  }
// -----------------------------------------------------o
  Future<void> _newLocationSlide() async {

    /// TASK : REVISION REQUIRED
    // if (_currentSlides.length == 0){
    //
    //   await superDialog(
    //     context: context,
    //     title: '',
    //     body: 'Add at least one Picture Slide First',
    //     boolDialog: false,
    //   );
    //
    //
    // } else if (_currentFlyerPosition == null){
    //
    //   setState(() {
    //     _currentSlides.add(
    //         SlideModel(
    //           slideIndex: _currentSlides.length,
    //           picture: _draft.mapImageURL,
    //           headline: _titleControllers[_currentSlides.length].text,
    //         ));
    //     _draft.currentSlideIndex = _currentSlides.length - 1;
    //     _draft.numberOfSlides = _currentSlides.length;
    //     _draft.visibilities.add(true);
    //     // slidesModes.add(SlideMode.Map);
    //     _titleControllers.add(TextEditingController());
    //     onPageChangedIsOn = true;
    //   });
    //   Sliders.slideTo(_pageController, _draft.currentSlideIndex);
    //
    // } else {
    //
    // }

  }
// -----------------------------------------------------o
  Future<void> _onPublishFlyer() async {
    print('publishing flyer');

    if (_superFlyer.firstTimer == true){
      print('first timer');
      await _createNewFlyer();
    }

    else {
      print('updating the flyer not first timer');
      await _updateExistingFlyer(_originalFlyer);
    }

  }
// -----------------------------------------------------------------------------
  void _updateTinyFlyerInLocalBzTinyFlyers(TinyFlyer modifiedTinyFlyer){
    // _prof.update(modifiedTinyFlyer);
    print(' should update tiny flyer in current bz tiny flyers shof enta ezay');
  }


  /// CREATION METHODS

// -----------------------------------------------------o
  Future<List<SlideModel>> processSlides(
      List<String> picturesURLs,
      List<SlideModel> currentSlides,
      List<TextEditingController> titleControllers
      ) async {
    List<SlideModel> _slides = new List();

    for (var slide in currentSlides){

      int i = slide.slideIndex;

      SlideModel _newSlide = SlideModel(
        slideIndex: currentSlides[i].slideIndex,
        picture: picturesURLs[i],
        headline: titleControllers[i].text,
        description: '',
        savesCount: _superFlyer.firstTimer ? 0 : _superFlyer.slides[i].savesCount,
        sharesCount: _superFlyer.firstTimer ? 0 : _superFlyer.slides[i].sharesCount,
        viewsCount: _superFlyer.firstTimer ? 0 : _superFlyer.slides[i].viewsCount,
      );

      _slides.add(_newSlide);

    }

    print('slides are $_slides');

    return _slides;
  }
// -----------------------------------------------------o
  Future<List<SlideModel>> _processNewSlides(List<SlideModel> currentSlides, List<TextEditingController> titleControllers) async {
    List<SlideModel> _slides = new List();

    for (int i = 0; i<currentSlides.length; i++){

      SlideModel _newSlide = SlideModel(
        slideIndex: i,
        picture: currentSlides[i].picture,
        headline: titleControllers[i].text,
        description: currentSlides[i].description,
        savesCount: currentSlides[i].savesCount,
        sharesCount: currentSlides[i].sharesCount,
        viewsCount: currentSlides[i].viewsCount,
      );

      _slides.add(_newSlide);

    }

    return _slides;
  }
// -----------------------------------------------------o
  Future<bool> _inputsValidator() async {
    bool _inputsAreValid;

    /// when no pictures picked
    if (_superFlyer.assetsFiles == null || _superFlyer.assetsFiles.length == 0){
      await superDialog(
        context: context,
        boolDialog: false,
        // title: 'No '
        body: 'First, select some pictures',
      );
      _inputsAreValid = false;
    }

    /// when less than 3 pictures selected
    else if (_superFlyer.assetsFiles.length < 3){
      await superDialog(
        context: context,
        boolDialog: false,
        // title: 'No '
        body: 'At least 3 pictures are required to publish this flyer',
      );
      _inputsAreValid = false;
    }

    /// when no keywords selected
    else if (_superFlyer.keywords.length == 0){
      /// TASK : add these keywords condition in flyer publish validator
      // await
      _inputsAreValid = true;
    }

    /// when flyerType is not defined
    else if (_superFlyer.flyerType == null){
      await _onFlyerTypeTap();
      _inputsAreValid = false;
    }

    /// when everything is okey
    else {
      _inputsAreValid = true;
    }

    await superDialog(
      context: context,
      boolDialog: false,
      title: 'Done ',
      body: 'Validator End here, Delete me',
    );


    return _inputsAreValid;
  }
// -----------------------------------------------------o
  Future<List<SlideModel>> _createNewSlides() async {
    List<SlideModel> _slides = new List();

    for (int i = 0; i<_superFlyer.assetsFiles.length; i++){

      SlideModel _newSlide = SlideModel(
        slideIndex: i,
        picture: _superFlyer.assetsFiles[i],
        headline: _superFlyer.headlinesControllers[i].text,
        description: _superFlyer.descriptionsControllers[i].text,
        savesCount: 0,
        sharesCount: 0,
        viewsCount: 0,
        boxFit: _superFlyer.boxesFits[i],
      );

      _slides.add(_newSlide);

    }

    return _slides;
  }
// -----------------------------------------------------o
  Future<List<SlideModel>> _updateExistingSlides() async {
    List<SlideModel> _slides = new List();

    for (int i = 0; i<_superFlyer.assetsFiles.length; i++){

      SlideModel _newSlide = SlideModel(
        slideIndex: i,
        picture: _superFlyer.assetsFiles[i],
        headline: _superFlyer.headlinesControllers[i].text,
        description: _superFlyer.descriptionsControllers[i].text,
        savesCount: _superFlyer.slides[i].savesCount,
        sharesCount: _superFlyer.slides[i].sharesCount,
        viewsCount: _superFlyer.slides[i].viewsCount,
        boxFit: _superFlyer.boxesFits[i],
      );

      _slides.add(_newSlide);

    }

    return _slides;
  }
// -----------------------------------------------------o
  Future<void> _createNewFlyer() async {
    /// assert that all required fields are valid

    bool _inputsAreValid = await _inputsValidator();

    if (_inputsAreValid == false){
      // dialogs already pushed in inputsValidator

    } else {

      _triggerLoading();

      /// create slides models
      List<SlideModel> _slides = await _createNewSlides();

      /// create tiny author model from bz.authors
      BzModel _bz = BzModel.getBzModelFromSuperFlyer(_superFlyer);
      AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID());
      TinyUser _tinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(_author);
      TinyBz _tinyBz = TinyBz.getTinyBzFromBzModel(_bz);

      ///create FlyerModel
      FlyerModel _newFlyerModel = FlyerModel(
        flyerID: _superFlyer.flyerID, // will be created in createFlyerOps
        // -------------------------
        flyerType: _superFlyer.flyerType,
        flyerState: _superFlyer.flyerState,
        keywords: _superFlyer.keywords,
        flyerShowsAuthor: _superFlyer.flyerShowsAuthor,
        flyerURL: null,
        flyerZone: _superFlyer.flyerZone,
        // -------------------------
        tinyAuthor: _tinyAuthor,
        tinyBz: _tinyBz,
        // -------------------------
        publishTime: null, // will be overriden in createFlyerOps
        flyerPosition: _superFlyer.position,
        // -------------------------
        ankhIsOn: false, // shouldn't be saved here but will leave this now
        // -------------------------
        slides: _slides,
        // -------------------------
        flyerIsBanned: false,
        deletionTime: null,
      );

      /// start create flyer ops
      FlyerModel _uploadedFlyerModel = await FlyerOps()
          .createFlyerOps(context, _newFlyerModel, _bz);

      TinyFlyer _uploadedTinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(_uploadedFlyerModel);
      /// add the result final TinyFlyer to local list and notifyListeners
      _prof.addTinyFlyerToLocalList(_uploadedTinyFlyer);

      _triggerLoading();

      await superDialog(
        context: context,
        title: 'Great !',
        body: 'Flyer has been created',
        boolDialog: false,
      );


      Nav.goBack(context, argument: _uploadedTinyFlyer);

    }
  }
// -----------------------------------------------------o
  Future<void> _updateExistingFlyer(FlyerModel originalFlyer) async {
    /// assert that all required fields are valid
    if (_inputsValidator() == false){
      // show something for user to know

      await superDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
        boolDialog: false,
      );


    } else {

      _triggerLoading();

      print('A- Managing slides');

      /// create slides models
      List<SlideModel> _updatedSlides = await _updateExistingSlides();

      print('B- Modifying flyer');

      ///create updated FlyerModel
      FlyerModel _updatedFlyerModel = FlyerModel(
        flyerID: _superFlyer.flyerID,
        // -------------------------
        flyerType: _superFlyer.flyerType,
        flyerState: _superFlyer.flyerState,
        keywords: _superFlyer.keywords,
        flyerShowsAuthor: _superFlyer.flyerShowsAuthor,
        flyerURL: _superFlyer.flyerURL,
        flyerZone: _superFlyer.flyerZone,
        // -------------------------
        tinyAuthor: _superFlyer.flyerTinyAuthor,
        tinyBz: TinyBz.getTinyBzFromSuperFlyer(_superFlyer),
        // -------------------------
        publishTime: PublishTime.getPublishTimeFromTimes(times: _superFlyer.flyerTimes, state: FlyerState.Published),
        flyerPosition: _superFlyer.position,
        // -------------------------
        ankhIsOn: false, // shouldn't be saved here but will leave this now
        // -------------------------
        slides: _updatedSlides,
        // -------------------------
        flyerIsBanned: PublishTime.flyerIsBanned(_superFlyer.flyerTimes),
        deletionTime: PublishTime.getPublishTimeFromTimes(times: _superFlyer.flyerTimes, state: FlyerState.Deleted),
        info: _superFlyer.infoController.text,
        // specs: _draft.specs,
      );

      print('C- Uploading to cloud');

      /// start create flyer ops
      FlyerModel _publishedFlyerModel = await FlyerOps().updateFlyerOps(
        context: context,
        updatedFlyer: _updatedFlyerModel,
        originalFlyer: originalFlyer,
        bzModel : BzModel.getBzModelFromSuperFlyer(_superFlyer),
      );

      print('D- Uploading to cloud');

      // /// add the result final Tinyflyer to local list and notifyListeners
      // _prof.replaceTinyFlyerInLocalList(TinyFlyer.getTinyFlyerFromFlyerModel(_publishedFlyerModel));

      print('E- added to local list');

      _triggerLoading();

      await superDialog(
        context: context,
        title: 'Great !',
        body: 'Flyer has been updated',
        boolDialog: false,
      );

      Nav.goBack(context);
    }

  }
// -----------------------------------------------------o
  Future<void> _onDeleteFlyer() async {
    // Nav.goBack(context);
    _triggerLoading();

    /// Task : this should be bool dialog instead
    bool _dialogResult = await superDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Delete this flyer and never get it back?',
      boolDialog: true,
    );

    print(_dialogResult);

    if (_dialogResult == true){

      /// start delete flyer ops
      await FlyerOps().deleteFlyerOps(
        context: context,
        bzModel: _bzModel,
        flyerModel : _originalFlyer,
      );

      /// remove tinyFlyer from Local list
      // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
      // _prof.removeTinyFlyerFromLocalList(tinyFlyer.flyerID);

      _triggerLoading();

      /// re-route back
      Nav.goBack(context, argument: true);

    }

    else {
      _triggerLoading();
    }

  }
// -----------------------------------------------------o
  Future<void> _onUnpublishFlyer() async {

    // Nav.goBack(context);

    /// Task : this should be bool dialog instead
    bool _dialogResult = await superDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to unpublish this flyer ?',
      boolDialog: true,
    );

    /// if user stop
    if (_dialogResult == false) {

      print('cancelled unpublishing flyer');

    }

    /// if user continue
    else {

      /// start delete flyer ops
      await FlyerOps().deactivateFlyerOps(
        context: context,
        bzModel: _bzModel,
        flyerID : _superFlyer.flyerID,
      );

      /// remove tinyFlyer from Local list
      // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
      // _prof.removeTinyFlyerFromLocalList(tinyFlyer.flyerID);


    }

    // /// re-route back
    // Nav.goBack(context, argument: true);

  }
// -----------------------------------------------------o
  Future<void> _onRepublishFlyer() async {
    print('this is here to republish the flyer');
  }
// -----------------------------------------------------o
  //   // List<TextEditingController> _createHeadlinesForExistingFlyer(){
//   //   List<TextEditingController> _controllers = new List();
//   //
//   //   _flyer.slides.forEach((slide) {
//   //     TextEditingController _controller = new TextEditingController();
//   //     _controller.text = slide.headline;
//   //     _controllers.add(_controller);
//   //   });
//   //
//   //   return _controllers;
//   // }
// // -----------------------------------------------------------------------------
// //   List<bool> _createSlidesVisibilityList(){
// //     int _listLength = widget.draftFlyer.assetsFiles.length;
// //     List<bool> _visibilityList = new List();
// //
// //     for (int i = 0; i<_listLength; i++){
// //       _visibilityList.add(true);
// //     }
// //
// //     return _visibilityList;
// //   }
//
// }


  @override
  Widget build(BuildContext context) {
    super.build(context);

    bool _tinyMode = Scale.superFlyerTinyMode(context, widget.flyerZoneWidth);

    bool _superFlyerHasID = _superFlyer?.flyerID == null ? false : true;

    bool _flyerHasMoreThanOnePage = FlyerMethod.flyerHasMoreThanOneSlide(_superFlyer);

    // BzModel _editorBzModel =
    // _superFlyer == null ? null :
    // _superFlyer.isDraft == true ? BzModel.getBzModelFromSuperFlyer(_superFlyer) :
    // null;

    // print('widget.goesToFlyer is : ${widget.goesToEditor} for ${_superFlyer.flyerID}');

    print('----------> building final flyer flyerID : ${_superFlyer.flyerID},'
        ' numberOfSlides : ${_superFlyer.numberOfSlides},'
        ' editMode : ${_superFlyer.editMode}');

    return

    // Container();

        FlyerZoneBox(
          flyerZoneWidth: widget.flyerZoneWidth,
          superFlyer: _superFlyer,
          onFlyerZoneTap: _onFlyerZoneTap,
          onFlyerZoneLongPress: _onFlyerZoneLongPress,
          editorBzModel: _bzModel,
          editorMode: widget.inEditor,
          stackWidgets: <Widget>[

            if (_superFlyerHasID)
              FlyerPages(superFlyer: _superFlyer,),

            if (_superFlyerHasID)
              FlyerHeader(superFlyer: _superFlyer,),

            if ((!_tinyMode))
              ProgressBar(
                superFlyer: _superFlyer,
                flyerZoneWidth: widget.flyerZoneWidth,
                loading: _loading,
              ),

          ],
        );

  }
}
