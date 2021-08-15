import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/firestore/record_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/records/share_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/f_1_flyer_editor_screen.dart';
import 'package:bldrs/views/screens/x_select_keywords_screen.dart';
import 'package:bldrs/views/screens/x_x_flyer_on_map.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/flyer/flyer_methods.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_pages.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/new_header.dart';

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
  final Key key;

  FinalFlyer({
    @required this.flyerZoneWidth,
    this.flyerModel,
    this.tinyFlyer,
    this.initialSlideIndex = 0,
    this.onSwipeFlyer,
    this.goesToEditor = false,
    this.inEditor = false,
    this.bzModel,
    this.flyerID,
    this.key,
  });
      // :
  // assert(isDraft != null),
  // assert(child != null),
  // super(key: key);


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

    if(mounted){

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
    print('dispose---> final flyer : start');
    MutableSlide.disposeMutableSlidesTextControllers(_superFlyer.mSlides);
    TextChecker.disposeControllerIfPossible(_superFlyer.infoController);
    Animators.disposeControllerIfPossible(_superFlyer.nav.verticalController);
    Animators.disposeControllerIfPossible(_superFlyer.nav.horizontalController);
    Animators.disposeControllerIfPossible(_superFlyer.nav.infoScrollController);

    // FocusScope.of(context).dispose(); // error fash5
    print('dispose---> final flyer : end');
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
  @override
  void didUpdateWidget(covariant FinalFlyer oldFlyer) {
    if(
    oldFlyer.flyerID != widget.flyerID ||
    oldFlyer.tinyFlyer != widget.tinyFlyer ||
    oldFlyer.flyerModel != widget.flyerModel ||
    oldFlyer.bzModel != widget.bzModel ||
    oldFlyer.initialSlideIndex != widget.initialSlideIndex
    ){
      setState(() {

      });

      _isInit = true;
      didChangeDependencies();
    }
    super.didUpdateWidget(oldFlyer);
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
        flyerModel: flyerModel,
        initialPage: widget.initialSlideIndex,
        onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _slideBackToSlidesPage();},
        onHeaderTap: (bool isExpanded) { _onHeaderTap(isExpanded);},
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
        bzModel: bzModel,
        flyerModel: flyerModel,
        onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _slideBackToSlidesPage();},
        onHeaderTap: (isExpanded) {_onHeaderTap(isExpanded);},
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
        onAboutTap: () async {await _onMoreInfoTap();},
        onKeywordsTap: () async {await _onAddKeywords();},
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
      bzModel: bzModel,
      onHorizontalSlideSwipe: (i) => _onHorizontalSlideSwipe(i),
      onVerticalPageSwipe: (i) => _onVerticalPageSwipe(i),
      onVerticalPageBack: () async {await _slideBackToSlidesPage();},
      onHeaderTap: (isExpanded) { _onHeaderTap(isExpanded);},
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
      onAboutTap: () async {await _onMoreInfoTap();},
      onKeywordsTap: () async {await _onAddKeywords();},
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
      info: '',
      specs: new List(),
      // times:
    );
  }
// -----------------------------------------------------o
  SuperFlyer _getSuperFlyerFromBzModel({BzModel bzModel}){
    SuperFlyer _superFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(
      onHeaderTap: _onHeaderTap,
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
        firstTimer: _superFlyer.edit.firstTimer,
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
    /// TASK : check this and delete when done
    // flyerOnTap: (tinyFlyer) async {
    //
    //
    //   dynamic _rebuild = await Navigator.push(context,
    //       new MaterialPageRoute(
    //           builder: (context) => new BzFlyerScreen(
    //             tinyFlyer: tinyFlyer,
    //             bzModel: _bzModel,
    //           )
    //       ));
    //   if (_rebuild == true){
    //     print('we should rebuild');
    //     setState(() { });
    //   } else if (_rebuild == false){
    //     print('do not rebuild');
    //   } else {
    //     print ('rebuild is null');
    //   }
    //
    // },


    print('WWWWWWWWWWWWWTTTTTTTTTTTFFFFFFFFFFF');
  }
// -----------------------------------------------------o
  void _onFlyerZoneTap(){

    print('aho');

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
  void _onHeaderTap(bool isExpanded){
    print('_onHeaderTap : bzPageIsOn was : ${_superFlyer.nav.bzPageIsOn}');
      // _superFlyer.nav.bzPageIsOn = !_superFlyer.nav.bzPageIsOn;

    if(_superFlyer.verticalIndex == 0){

      if (_superFlyer.nav.progressBarOpacity == 1){
        setState(() {
          _statelessTriggerProgressOpacity();
          // _superFlyer.nav.bzPageIsOn = isExpanded;
        });
      }
      else {
        Future.delayed(Ratioz.durationFading210, (){
          setState(() {
            _statelessTriggerProgressOpacity();
            // _superFlyer.nav.bzPageIsOn = isExpanded;
          });
        });
      }


    }

    print('_onHeaderTap : bzPageIsOn is : ${_superFlyer.nav.bzPageIsOn}');
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
    // print('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
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
          _superFlyer.nav.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
        });
      }

      /// B - when direction is going back
      else if (_direction == SwipeDirection.back){
        print('going back');
        FocusScope.of(context).previousFocus();
        setState(() {
          _superFlyer.nav.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
        });
      }

      /// B = when direction is freezing
      else {
        print('going no where');
        setState(() {
          _superFlyer.nav.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
        });
      }
    }

    /// A - if keyboard is not active
    else {
      // print('KEYBOARD IS NOT ACTIVE');
      setState(() {
        _superFlyer.nav.swipeDirection = _direction;
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
      _statelessTriggerProgressOpacity(verticalIndex: verticalIndex);
    });
    print('verticalIndex is : ${_superFlyer.verticalIndex}');

  }
// -----------------------------------------------------o
  Future<void> _slideBackToSlidesPage() async {
  print('_slideBackToSlidesPage : sliding from info page to slides page aho by tap');
  await Sliders.slideToBackFrom(_superFlyer.nav.verticalController, 1);
}
// -----------------------------------------------------o
  void _statelessTriggerProgressOpacity({int verticalIndex}){

    print('triggering progress bar opacity');

    if (verticalIndex == null){

      if (_superFlyer.nav.progressBarOpacity == 1){
        _superFlyer.nav.progressBarOpacity = 0;
      }

      else {
        _superFlyer.nav.progressBarOpacity = 1;
      }

    }

    else {

      if (verticalIndex == 1){
        _superFlyer.nav.progressBarOpacity = 0;
      }

      else {
        _superFlyer.nav.progressBarOpacity = 1;
      }

    }

  }
// -----------------------------------------------------o
  Future<void> _triggerKeywordsView() async {

    print('_triggerKeywordsView : _verticalIndex : ${_superFlyer.verticalIndex}');


    /// open keywords
    if(_superFlyer.verticalIndex == 0){
      await Sliders.slideToNext(_superFlyer.nav.verticalController, 2, 0);
      // await Sliders.slideToNext(_panelController, 2, 0);
    }
    /// close keywords
    else {
      await Sliders.slideToBackFrom(_superFlyer.nav.verticalController, 1);
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
      _superFlyer.rec.ankhIsOn = !_superFlyer.rec.ankhIsOn;
    });
    print('ankh is ${_superFlyer.rec.ankhIsOn}');

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
            '- ${_superFlyer.mSlides[_i].headline} .\n'
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
    print('Following bz : followIsOn was ${_superFlyer.rec.followIsOn} & headline for slide ${_superFlyer.currentSlideIndex} is : ${_superFlyer.mSlides[_superFlyer.currentSlideIndex].headline}');

    /// start follow bz ops
    List<String> _updatedBzFollows = await RecordOps.followBzOPs(
      context: context,
      bzID: _superFlyer.bz.bzID,
      userID: superUserID(),
    );

    /// add or remove tinyBz from local followed bzz
    _prof.updatedFollowsInLocalList(_updatedBzFollows);

    /// trigger current follow value
    setState(() {
      _superFlyer.rec.followIsOn = !_superFlyer.rec.followIsOn;
    });


  }
// -----------------------------------------------------o
  Future<void> _onCallTap() async {
    print('Call Bz');

    String _userID = superUserID();
    String _bzID = _superFlyer.bz.bzID;
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
  Future<void> _onTriggerEditMode() async {

    /// to  update slides headlines
    List<SlideModel> _updatedSlides = await _createSlidesModelsFromCurrentSuperFlyer();
    // List<MutableSlide> _updatedMutableSlides = MutableSlide.getDraftMutableSlidesFromSlidesModels(_updatedSlides);
    setState(() {
      _superFlyer.edit.editMode = !_superFlyer.edit.editMode;
      _superFlyer.flyerInfo = _superFlyer.infoController.text;
      // _superFlyer.mutableSlides = _updatedMutableSlides;
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

    if (mounted){

      /// TASK : figure this out ( and study shared preferences )
      // final Directory appDir = await sysPaths.getApplicationDocumentsDirectory();
      // final String fileName = path.basename(_imageFile.path);
      // final File savedImage = await _storedImage.copy('${appDir.path}/$fileName');

      FocusScope.of(context).unfocus();

      _triggerLoading();


      /// A - if max slides reached
      if(FlyerMethod.maxSlidesReached(superFlyer: _superFlyer) == true){

        int _maxLength = Standards.getMaxSlidesCount(_superFlyer.bz.accountType);
        await Dialogz.maxSlidesReached(context, _maxLength);

      }

      /// A - if can pick more gallery pictures
      else {

        /// B1 - get assets from mutable slides
        List<Asset> _assetsSources = MutableSlide.getAssetsFromMutableSlides(_superFlyer.mSlides); //Imagers.getOnlyAssetsFromDynamics(_superFlyer.assetsSources);
        /// B2 - assert that index in never null
        _superFlyer.currentSlideIndex = FlyerMethod.unNullIndexIfNull(_superFlyer.currentSlideIndex);

        /// B3 - pick images from gallery
        List<dynamic> _phoneAssets = await Imagers.getMultiImagesFromGallery(
          context: context,
          images: _assetsSources,
          mounted: mounted,
          accountType: _superFlyer.bz.accountType,
        );

        /// B4 - if did not pick new assets
        if(_phoneAssets.length == 0){
          // will do nothing
          print('no new picks');
        }

        /// B4 - if picked new assets
        else {
          print('picked new picks');

          /// C1 - declare private existing and new mutable slides
          List<MutableSlide> _tempMutableSlides = _superFlyer.mSlides;


          /// C2 - for every asset received from gallery
          for (int i = 0; i < _phoneAssets.length; i++){

            /// D1 - declare private asset
            Asset _newAsset = _phoneAssets[i];

            /// D2 - search index of _newAsset in the existing asset if possible
            int _assetIndexInAssets =  MutableSlide.getMutableSlideIndexThatContainsThisAsset(
              mSlides: _tempMutableSlides,
              assetToSearchFor: _newAsset,
            );

            bool _assetFound = _assetIndexInAssets == -1 ? false : true;

            if (_assetFound){
              // nothing shall be added to the existing mutable slides
              // _tempMutableSlides.add(_existingMutableSlides[i]);
            }

            else {
              File _newFile = await Imagers.getFileFromAsset(_newAsset);

              MutableSlide _mutableSlide = MutableSlide(
                slideIndex: i,
                opacity: 1,
                picURL: null,
                picAsset: _newAsset,
                picFile:_newFile,
                imageSize: await ImageSize.superImageSize(_newAsset),
                picFit: Imagers.concludeBoxFitForAsset(asset: _newAsset, flyerZoneWidth: widget.flyerZoneWidth),
                midColor: await Colorizer.getAverageColor(_newFile),
                headline: null,
                headlineController: new TextEditingController(),
                description: null,
                descriptionController: new TextEditingController(),
                viewsCount: 0,
                sharesCount: 0,
                savesCount: 0,
              );

              _tempMutableSlides.add(_mutableSlide);
            }

          }

          /// D - assign all new values
          setState(() {
            _superFlyer.mSlides = _tempMutableSlides;
            _superFlyer.numberOfSlides = _tempMutableSlides.length;
            _superFlyer.numberOfStrips = _superFlyer.numberOfSlides;
            _superFlyer.nav.progressBarOpacity = 1;
          });
          Tracer.traceSetState(screenName: 'FinalFlyer', varName: 'numberOfSlides', varNewValue: _superFlyer.mSlides.length);

          /// C - animate to last slide
          await Sliders.slideTo(
            controller: _superFlyer.nav.horizontalController,
            toIndex: _superFlyer.numberOfSlides - 1,
          );

        }

      }

      await _triggerLoading();

    }

  }
// -----------------------------------------------------o
  Future<void> _onDeleteSlide() async {

    /// A - if slides are empty
    if (_superFlyer.numberOfSlides == 0 || _superFlyer.edit.canDelete == false){
      print('FinalFlyer : _onDeleteSlide : Can not delete slide : ${_superFlyer.currentSlideIndex}');
    }


    /// A - if slides are not empty
    else {

      _superFlyer.edit.canDelete = false;

      /// B - if at (FIRST) slide
      if (_superFlyer.currentSlideIndex == 0){
        await _deleteFirstSlide();
      }

      /// B - if at (LAST) slide
      else if (_superFlyer.currentSlideIndex + 1 == _superFlyer.numberOfSlides){
        await _deleteMiddleOrLastSlide();
      }

      /// B - if at (Middle) slide
      else {
        await _deleteMiddleOrLastSlide();
      }

      _superFlyer.edit.canDelete = true;

    }

  }
// -----------------------------------------------------o
  Future<void> _deleteFirstSlide() async {
    print('DELETING STARTS AT (FIRST) index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides} ------------------------------------');

    /// 1 - if only one slide remaining
    if(_superFlyer.numberOfSlides == 1){

      print('_draft.visibilities : ${_superFlyer.mSlides[_superFlyer.currentSlideIndex].toString()}, _draft.numberOfSlides : $_superFlyer.numberOfSlides');

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
        _superFlyer.nav.listenToSwipe = false;
        _statelessTriggerSlideVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfStrips = _superFlyer.numberOfSlides - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await Sliders.slideToNext(_superFlyer.nav.horizontalController, _superFlyer.numberOfSlides, _superFlyer.currentSlideIndex);


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
            _superFlyer.nav.listenToSwipe = true;
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
        _superFlyer.nav.listenToSwipe = false;
        _statelessTriggerSlideVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfSlides = _decreasedNumberOfSlides;
        _superFlyer.numberOfStrips = _superFlyer.numberOfSlides;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await  Sliders.slideToNext(_superFlyer.nav.horizontalController, _superFlyer.numberOfSlides, _superFlyer.currentSlideIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfSlides <= 1){

          setState(() {
            /// Dx - delte data
            _statelessSlideDelete(_superFlyer.currentSlideIndex);
            _superFlyer.nav.listenToSwipe = true;
          });

        }

        /// D - delete when at many slides remaining
        else {

          /// E - wait for sliding to end
          await Future.delayed(Ratioz.durationFading210, () async {

            /// Dx - delete data
            _statelessSlideDelete(_superFlyer.currentSlideIndex);
            /// F - snap to index 0
            await Sliders.snapTo(_superFlyer.nav.horizontalController, 0);

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
              _superFlyer.nav.listenToSwipe = true;
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
      _superFlyer.nav.listenToSwipe = false;
      _superFlyer.currentSlideIndex = _superFlyer.currentSlideIndex - 1;
      _superFlyer.nav.swipeDirection = SwipeDirection.freeze;
      _superFlyer.numberOfStrips = _superFlyer.numberOfSlides - 1;
      _statelessTriggerSlideVisibility(_originalIndex);
    });

    // print('XXX after first rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    /// B - wait fading to start sliding
    await Future.delayed(Ratioz.durationFading210, () async {

      // print('_currentIndex before slide : $_draft.currentSlideIndex');

      /// C - slide
      await  Sliders.slideToBackFrom(_superFlyer.nav.horizontalController, _originalIndex);
      // print('_currentIndex after slide : $_draft.currentSlideIndex');

      /// E - wait for sliding to end
      await Future.delayed(Ratioz.durationFading210, () async {

        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessSlideDelete(_originalIndex);
          _superFlyer.nav.listenToSwipe = true;
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
      if(index >= 0 && _superFlyer.mSlides.length != 0){
        print('_superFlyer.mSlides[index].isVisible was ${_superFlyer.mSlides[index].opacity} for index : $index');


        if(_superFlyer.mSlides[index].opacity == 1){
          _superFlyer.mSlides[index].opacity = 0;
        }
        else {
          _superFlyer.mSlides[index].opacity = 1;
        }

        print('_superFlyer.mSlides[index].isVisible is ${_superFlyer.mSlides[index].opacity} for index : $index');
      }
      else {
        print('can not trigger visibility for index : $index');
      }
    }

  }
// -----------------------------------------------------o
  void _statelessSlideDelete(int index) {

    print('before stateless delete index was $index, _draft.numberOfSlides was : ${_superFlyer.numberOfSlides}');
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

    _superFlyer.mSlides.removeAt(index);
    // _superFlyer.screenshotsControllers.removeAt(index);
    _superFlyer.numberOfSlides = _superFlyer.mSlides.length;
    // _superFlyer.screenShots.removeAt(index);

    print('after stateless delete index is $index, _draft.numberOfSlides is : ${_superFlyer.numberOfSlides}');
  }
// -----------------------------------------------------o
  Future<void> _onCropImage() async {

    if(_superFlyer.mSlides.isNotEmpty){

      _triggerLoading();

      File croppedFile = await Imagers.cropImage(context, _superFlyer.mSlides[_superFlyer.currentSlideIndex].picFile);

      if (croppedFile != null) {
        setState(() {
          _superFlyer.mSlides[_superFlyer.currentSlideIndex].picFile = croppedFile;
        });
      }

      _triggerLoading();

    }

  }
// -----------------------------------------------------o
  Future<void> _onResetImage() async {

    if(_superFlyer.mSlides.isNotEmpty){

      if(_superFlyer.mSlides[_superFlyer.currentSlideIndex].picAsset != null){
        File _file = await Imagers.getFileFromAsset(_superFlyer.mSlides[_superFlyer.currentSlideIndex].picAsset);

        setState(() {
          _superFlyer.mSlides[_superFlyer.currentSlideIndex].picFile = _file;
        });
      }

    }

  }
// -----------------------------------------------------o
  void _onFitImage(){

    int _i = _superFlyer.currentSlideIndex;
    BoxFit _currentPicFit = _superFlyer.mSlides[_i].picFit;

    print('tapping on fit image : ${_superFlyer.mSlides.length} mSlides and _currentPicFit was : $_currentPicFit');

    if(_superFlyer.mSlides.isNotEmpty){

      if(_currentPicFit == BoxFit.fitWidth) {
        print('trying to get fit width to fit height');
        setState(() {
          _superFlyer.mSlides[_i].picFit = BoxFit.fitHeight;
        });
      }

      else if (_currentPicFit == BoxFit.fitHeight){
        print('trying to get fit height to fit width');
        setState(() {
          _superFlyer.mSlides[_i].picFit = BoxFit.fitWidth;
        });
      }

      else {
        setState(() {
          _superFlyer.mSlides[_i].picFit = BoxFit.fitHeight;
        });
      }

    }

    print('tapping on fit image : ${_superFlyer.mSlides.length} mSlides and _currentPicFit is : $_currentPicFit');

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
                        color: _superFlyer.flyerType == FlyerType.product ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _superFlyer.flyerType == FlyerType.product ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _superFlyer.flyerType = FlyerType.product;
                          });

                          setState(() {
                            _superFlyer.flyerType = FlyerType.product;
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
                        color: _superFlyer.flyerType == FlyerType.equipment ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _superFlyer.flyerType == FlyerType.equipment ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _superFlyer.flyerType = FlyerType.equipment;
                          });
                          setState(() {
                            _superFlyer.flyerType = FlyerType.equipment;
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
  Future<void> _onMoreInfoTap() async {

    double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.95);
    double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    double _dialogInnerCorners = BottomDialog.dialogClearCornerValue();

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
              corners: _dialogInnerCorners,
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
              onMaxLinesReached: null,
            ),
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------o
  Future<void> _onAddKeywords() async {

    dynamic _result = await Nav.goToNewScreen(context,
        SelectKeywordsScreen(
          selectedKeywords: _superFlyer.keywords,
          flyerType: _superFlyer.flyerType,
        )
    );

    /// when user selected some keywords
    if (_result != null){
      setState(() {
        _superFlyer.keywords = _result;
      });
    }

    /// when no keywords selected
    else {

    }

    // List<Keyword> _keywords = <Keyword>[
    //   Keyword.bldrsKeywords()[100],
    //   Keyword.bldrsKeywords()[120],
    //   Keyword.bldrsKeywords()[205],
    //   Keyword.bldrsKeywords()[403],
    //   Keyword.bldrsKeywords()[600],
    // ];
    //
    // double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.7);
    // double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    // double _dialogClearHeight = BottomDialog.dialogClearHeight(context: context, title: 'x', overridingDialogHeight: _dialogHeight);
    //
    // await BottomDialog.slideStatefulBottomDialog(
    //     context: context,
    //     draggable: true,
    //     height: _dialogHeight,
    //     title: 'Select flyer tags',
    //     builder: (context, title) {
    //       return StatefulBuilder(
    //           builder: (BuildContext context, StateSetter setDialogState) {
    //             return
    //               BottomDialog(
    //                 title: title,
    //                 height: _dialogHeight,
    //                 draggable: true,
    //                 child: Container(
    //                   width: _dialogClearWidth,
    //                   height: _dialogClearHeight,
    //                   color: Colorz.BloodTest,
    //                   child: Column(
    //                     children: <Widget>[
    //
    //                       Container(
    //                         width: _dialogClearWidth * 0.9,
    //                         height: 100,
    //                         color: Colorz.Yellow200,
    //                       ),
    //
    //                       Container(
    //                         width: _dialogClearWidth * 0.9,
    //                         height: _dialogClearHeight - 100,
    //                         color: Colorz.BlackSemi255,
    //                         child: ListView.builder(
    //                           itemCount: 3,
    //                             itemBuilder: (ctx, index){
    //                               return
    //                                 BldrsExpansionTile(
    //                                   height: _dialogClearHeight * 0.7,
    //                                   tileWidth: _dialogClearWidth * 0.9,
    //                                   key: new GlobalKey(),
    //                                   // icon: KeywordModel.getImagePath(_filterID),
    //                                   iconSizeFactor: 0.5,
    //                                   group: Group.architecturalStylesGroup,
    //                                   selectedKeywords: _superFlyer.keywords,
    //                                   onKeywordTap: (Keyword selectedKeyword){
    //                                     if (_superFlyer.keywords.contains(selectedKeyword)){
    //                                       setDialogState(() {
    //                                         print('a77a');
    //                                         _superFlyer.keywords.remove(selectedKeyword);
    //                                       });
    //                                     }
    //                                     else {
    //                                       setDialogState(() {
    //                                         _superFlyer.keywords.add(selectedKeyword);
    //                                       });
    //                                     }
    //                                     },
    //                                   onGroupTap: (String groupID){
    //                                     },
    //                                 );
    //                             }
    //                             ),
    //                       ),
    //                     ],
    //                 ),
    //               ),
    //
    //
    //
    //               );
    //           }
    //       );
    //     }
    // );
  }
// -----------------------------------------------------o
  Future<void>_selectOnMap() async {

    if (_superFlyer.mSlides.length == 0){

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
  void _updateTinyFlyerInLocalBzTinyFlyers(TinyFlyer modifiedTinyFlyer){
    // _prof.update(modifiedTinyFlyer);
    print(' should update tiny flyer in current bz tiny flyers shof enta ezay');
  }

  void _onReorderSlides(){
    /// check this package
    // https://pub.dev/packages/reorderables
  }
// -----------------------------------------------------------------------------

  /// CREATION METHODS

// -----------------------------------------------------o
  Future<bool> _inputsValidator() async {
    bool _inputsAreValid;

    /// when no pictures picked
    if (_superFlyer.mSlides == null || _superFlyer.mSlides.length == 0){
      await superDialog(
        context: context,
        boolDialog: false,
        // title: 'No '
        body: 'First, select some pictures',
      );
      _inputsAreValid = false;
    }

    /// when less than 3 pictures selected
    else if (_superFlyer.mSlides.length < 3){
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

    return _inputsAreValid;
  }
// -----------------------------------------------------o
  Future<void> _onPublishFlyer() async {
    print('publishing flyer');

    _triggerLoading();

    await _slideBackToSlidesPage();

    FlyerModel _uploadedFlyer;

    /// A - when creating new flyer
    if (_superFlyer.edit.firstTimer == true){
      print('first timer');

      _uploadedFlyer = await _createNewFlyer();
    }

    /// A - when creating updated flyer
    else {
      print('updating the flyer not first timer');

      _uploadedFlyer = await _updateExistingFlyer(_originalFlyer);
    }

    // /// B - update local tiny flyer
    // if(_uploadedFlyer != null){

    // /// B1 - when first time creating the flyer
    // if(_superFlyer.firstTimer == true){
    //   /// add the result final TinyFlyer to local list and notifyListeners
    //   _prof.addTinyFlyerToLocalList(_uploadedTinyFlyer);
    // }
    //
    // /// B1 - when updating existing flyer
    // else {
    //   _prof.replaceTinyFlyerInLocalList(_uploadedTinyFlyer);
    // }

    // }

    // /// B - if uploaded flyer is null
    // else {
    //   print('_uploaded flyer is null,, very weird');
    // }

    _triggerLoading();

    await superDialog(
      context: context,
      title: 'Great !',
      body: _superFlyer.edit.firstTimer == true ? 'Flyer has been created' : 'Flyer has been updated',
      boolDialog: false,
    );

    TinyFlyer _uploadedTinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(_uploadedFlyer);
    Nav.goBack(context, argument: _uploadedTinyFlyer);

  }
// -----------------------------------------------------o
// -----------------------------------------------------o
//   Future<List<SlideModel>> combineSlidesStuffInSlidesModels({
//     List<String> picturesURLs,
//     List<SlideModel> currentSlides,
//     List<TextEditingController> titlesControllers,
//     List<TextEditingController> descriptionsControllers,
//   }) async {
//     List<SlideModel> _slides = new List();
//
//     for (var slide in currentSlides){
//
//       int i = slide.slideIndex;
//
//       SlideModel _newSlide = SlideModel(
//         slideIndex: currentSlides[i].slideIndex,
//         picture: picturesURLs[i],
//         headline: titlesControllers[i].text,
//         description: descriptionsControllers[i].text,
//         savesCount: _superFlyer.firstTimer ? 0 : _superFlyer.mutableSlides[i].savesCount,
//         sharesCount: _superFlyer.firstTimer ? 0 : _superFlyer.mutableSlides[i].sharesCount,
//         viewsCount: _superFlyer.firstTimer ? 0 : _superFlyer.mutableSlides[i].viewsCount,
//         imageSize: currentSlides[i].imageSize,
//         boxFit: currentSlides[i].boxFit,
//       );
//
//       _slides.add(_newSlide);
//
//     }
//
//     print('slides are $_slides');
//
//     return _slides;
//   }
// -----------------------------------------------------o
  Future<List<SlideModel>> _createSlidesModelsFromCurrentSuperFlyer() async {
    List<SlideModel> _slides = new List();

    // for (int i = 0; i<_superFlyer.mutableSlides.length; i++){
    //
    //   SlideModel _newSlide = SlideModel(
    //     slideIndex: i,
    //     picURL: _superFlyer.mutableSlides[i].picURL,
    //     headline: _superFlyer.headlinesControllers[i].text,
    //     description: _superFlyer.descriptionsControllers[i].text,
    //     savesCount: _superFlyer.mutableSlides[i].savesCount,
    //     sharesCount: _superFlyer.mutableSlides[i].sharesCount,
    //     viewsCount: _superFlyer.mutableSlides[i].viewsCount,
    //     imageSize: _superFlyer.mutableSlides[i].imageSize,
    //     picFit: _superFlyer.mutableSlides[i].picFit,
    //     midColor: _superFlyer.mutableSlides[i].midColor,
    //   );
    //
    //   _slides.add(_newSlide);
    //
    // }

    return _slides;
  }
// -----------------------------------------------------o
  Future<List<SlideModel>> _createSlidesFromCurrentSuperFlyer() async {
    List<SlideModel> _slides = new List();

    for (int i = 0; i<_superFlyer.mSlides.length; i++){


      SlideModel _newSlide = SlideModel(
        slideIndex: i,
        pic: _superFlyer.mSlides[i].picFile,
        headline: _superFlyer.mSlides[i].headlineController.text,
        description: _superFlyer.mSlides[i].descriptionController.text,
        savesCount: _superFlyer.mSlides[i].savesCount,
        sharesCount: _superFlyer.mSlides[i].sharesCount,
        viewsCount: _superFlyer.mSlides[i].viewsCount,
        imageSize: _superFlyer.mSlides[i].imageSize,
        picFit: _superFlyer.mSlides[i].picFit,
        midColor: _superFlyer.mSlides[i].midColor,
      );

      _slides.add(_newSlide);

    }

    return _slides;
  }
// -----------------------------------------------------o
//   Future<List<SlideModel>> _createUpdatesSlides() async {
//     List<SlideModel> _slides = new List();
//
//     for (int i = 0; i<_superFlyer.assetsFiles.length; i++){
//
//       ImageSize _imageSize = await Imagers.superImageSize(_superFlyer.assetsFiles[i]);
//
//       SlideModel _newSlide = SlideModel(
//         slideIndex: i,
//         picURL: _superFlyer.assetsFiles[i],
//         headline: _superFlyer.headlinesControllers[i].text,
//         description: _superFlyer.descriptionsControllers[i].text,
//         savesCount: _superFlyer.mutableSlides[i].savesCount,
//         sharesCount: _superFlyer.mutableSlides[i].sharesCount,
//         viewsCount: _superFlyer.mutableSlides[i].viewsCount,
//         picFit: _superFlyer.mutableSlides[i].picFit,
//         imageSize: _imageSize,
//         midColor:  _superFlyer.mutableSlides[i].midColor,
//       );
//
//       _slides.add(_newSlide);
//
//     }
//
//     return _slides;
//   }
// -----------------------------------------------------o
  Future<FlyerModel> _createNewFlyer() async {
    FlyerModel _uploadedFlyerModel;


    /// assert that all required fields are valid
    bool _inputsAreValid = await _inputsValidator();

    if (_inputsAreValid == false){
      // dialogs already pushed in inputsValidator

    } else {


      /// create slides models
      List<SlideModel> _slides = await _createSlidesFromCurrentSuperFlyer();

      /// create tiny author model from bz.authors
      BzModel _bz = _superFlyer.bz;
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
        flyerURL: _superFlyer.flyerURL,
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
        info: _superFlyer.infoController.text,
        specs: _superFlyer.specs,
        times: <PublishTime>[PublishTime(timeStamp: DateTime.now(), state: FlyerState.Published)],
      );

      /// start create flyer ops
      _uploadedFlyerModel = await FlyerOps()
          .createFlyerOps(context, _newFlyerModel, _bz);
    }

    return _uploadedFlyerModel;
  }
// -----------------------------------------------------o
  Future<FlyerModel> _updateExistingFlyer(FlyerModel originalFlyer) async {
    FlyerModel _uploadedFlyerModel;

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

      print('A- Managing slides');

      /// create slides models
      List<SlideModel> _updatedSlides = await _createSlidesFromCurrentSuperFlyer();

      print('B- Modifying flyer');

      ///create updated FlyerModel
      FlyerModel _tempUpdatedFlyerModel = FlyerModel(
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
        specs: _superFlyer.specs,
        // times: _superFlyer.times,
        // specs: _draft.specs,
      );

      print('C- Uploading to cloud');

      /// start create flyer ops
      _uploadedFlyerModel = await FlyerOps().updateFlyerOps(
        context: context,
        updatedFlyer: _tempUpdatedFlyerModel,
        originalFlyer: originalFlyer,
        bzModel : _superFlyer.bz,
      );

      print('D- Uploading to cloud');


      await superDialog(
        context: context,
        title: 'Great !',
        body: 'Flyer has been updated',
        boolDialog: false,
      );

    }

    return _uploadedFlyerModel;
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
  void _slideFlyerOptions(BuildContext context, FlyerModel flyerModel){

    // BottomDialog.slideButtonsBottomDialog(
    //   context: context,
    //   // height: (50+10+50+10+50+30).toDouble(),
    //   draggable: true,
    //   buttonHeight: 50,
    //   buttons: <Widget>[
    //
    //     // --- UNPUBLISH FLYER
    //     DreamBox(
    //       height: 50,
    //       width: BottomDialog.dialogClearWidth(context),
    //       icon: Iconz.XSmall,
    //       iconSizeFactor: 0.5,
    //       iconColor: Colorz.Red255,
    //       verse: 'Unpublish Flyer',
    //       verseScaleFactor: 1.2,
    //       verseColor: Colorz.Red255,
    //       // verseWeight: VerseWeight.thin,
    //       onTap: () => _unpublishFlyerOnTap(context),
    //
    //     ),
    //
    //     // --- DELETE FLYER
    //     DreamBox(
    //       height: 50,
    //       width: BottomDialog.dialogClearWidth(context),
    //       icon: Iconz.FlyerScale,
    //       iconSizeFactor: 0.5,
    //       verse: 'Delete Flyer',
    //       verseScaleFactor: 1.2,
    //       verseColor: Colorz.White255,
    //       onTap: () async {
    //         Nav.goBack(context);
    //
    //         /// Task : this should be bool dialog instead
    //         bool _dialogResult = await superDialog(
    //           context: context,
    //           title: '',
    //           body: 'Are you sure you want to Delete this flyer and never get it back?',
    //           boolDialog: true,
    //         );
    //
    //         print(_dialogResult);
    //
    //         /// start delete flyer ops
    //         await FlyerOps().deleteFlyerOps(
    //           context: context,
    //           bzModel: bzModel,
    //           flyerModel : flyerModel,
    //         );
    //
    //         /// remove tinyFlyer from Local list
    //         FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
    //         _prof.removeTinyFlyerFromLocalList(tinyFlyer.flyerID);
    //
    //         /// re-route back
    //         Nav.goBack(context, argument: true);
    //       },
    //     ),
    //
    //     // --- EDIT FLYER
    //     DreamBox(
    //       height: 50,
    //       width: BottomDialog.dialogClearWidth(context),
    //       icon: Iconz.Gears,
    //       iconSizeFactor: 0.5,
    //       verse: 'Edit Flyer',
    //       verseScaleFactor: 1.2,
    //       verseColor: Colorz.White255,
    //       onTap: (){
    //
    //         Nav.goToNewScreen(context,
    //             OldFlyerEditorScreen(
    //                 bzModel: bzModel,
    //                 firstTimer: false,
    //                 flyerModel: flyerModel
    //             ));
    //
    //       },
    //     ),
    //
    //   ],
    //
    // );

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

    Tracer.traceWidgetBuild(number: 1, widgetName: 'FinalFlyer', varName: 'flyerID', varValue: _superFlyer.flyerID, tracerIsOn: false);
    // Tracer.traceWidgetBuild(number: 2, widgetName: 'FinalFlyer', varName: 'numberOfSlides', varValue: _superFlyer.numberOfSlides);
    // Tracer.traceWidgetBuild(number: 3, widgetName: 'FinalFlyer', varName: 'midColor', varValue: Colorizer.cipherColor(_superFlyer.mSlides[0].midColor));
    return
        FlyerZoneBox(
          flyerZoneWidth: widget.flyerZoneWidth,
          superFlyer: _superFlyer,
          onFlyerZoneTap: _onFlyerZoneTap,
          onFlyerZoneLongPress: _onFlyerZoneLongPress,
          editorBzModel: _bzModel,
          editorMode: widget.inEditor,
          stackWidgets: <Widget>[

            if (_superFlyerHasID == true)
              FlyerPages(
                superFlyer: _superFlyer,
                flyerZoneWidth: widget.flyerZoneWidth,
              ),

            if (_superFlyerHasID == true)
              NewHeader(
                superFlyer: _superFlyer,
                flyerZoneWidth: widget.flyerZoneWidth,
              ),

            if (_tinyMode == false)
              ProgressBar(
                superFlyer: _superFlyer,
                flyerZoneWidth: widget.flyerZoneWidth,
                loading: _loading,
              ),

          ],
        );

  }
}
