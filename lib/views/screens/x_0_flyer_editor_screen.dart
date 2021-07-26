import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/sliders.dart' show SwipeDirection, Sliders;
import 'package:bldrs/controllers/drafters/imagers.dart' ;
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/x_x_flyer_on_map.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/publish_button.dart';
import 'package:bldrs/views/widgets/buttons/slides_counter.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/flyer/editor/editorPanel.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_pages.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';

class FlyerEditorScreen extends StatefulWidget {
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  FlyerEditorScreen({
    @required this.bzModel,
    @required this.firstTimer,
    this.flyerModel,
  });

  @override
  _FlyerEditorScreenState createState() => _FlyerEditorScreenState();
}

class _FlyerEditorScreenState extends State<FlyerEditorScreen> with AutomaticKeepAliveClientMixin{
  /// to keep out of screen objects alive when using [with AutomaticKeepAliveClientMixin]
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  PageController _horizontalController;
  PageController _verticalController;
  ScrollController _infoScrollController;
// -----------------------------------------------------------------------------
  FlyersProvider _prof;
  CountryProvider _countryPro;
  BzModel _bz;
  FlyerModel _flyer;
  SuperFlyer _superFlyer;
  String _mapImageURL;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  /// SLIDING BLOCK
  void _onHorizontalSwipe (int newIndex){
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
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _horizontalController = PageController(initialPage: 0, viewportFraction: 1, keepPage: true);
    _verticalController = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    _infoScrollController = ScrollController(keepScrollOffset: true,);


    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _countryPro = Provider.of<CountryProvider>(context, listen: false);
    _bz = widget.bzModel;

    /// by defining _flyer and its conditions,, we can use _flyer anywhere
    // _superFlyer = widget.firstTimer ? SuperFlyer;
    _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    TextChecker.disposeAllTextControllers(_superFlyer.headlinesControllers);
    _verticalController.dispose();
    _horizontalController.dispose();
    _infoScrollController.dispose();
    super.dispose();
  }
// ---------------------------------------------------o
  Duration _fadingDuration = Ratioz.durationFading200;
  Duration _fadingDurationX = Ratioz.durationFading210;
  Duration _slidingDuration = Ratioz.durationSliding400;
  Duration _slidingDurationX = Ratioz.durationSliding410;
  double _progressOpacity = 1;
// ---------------------------------------------------o
  void _triggerProgressOpacity(){
    if (_progressOpacity == 1){
      _progressOpacity = 0;
    } else {
      _progressOpacity = 1;
    }
  }
// -----------------------------------------------------------------------------
  Future<void> _getMultiGalleryImages({double flyerZoneWidth}) async {

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
          accountType: _bz.accountType,
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

            _progressOpacity = 1;
          });

          /// E - animate to first page
          await _horizontalController.animateToPage(
              _outputAssets.length - 1,
              duration: Ratioz.duration1000ms, curve: Curves.easeInOut
          );

        }

      }

    }

    _triggerLoading();

  }
// -----------------------------------------------------------------------------
  Future<void> _deleteSlide() async {

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
// ------------------------------------------------o
  Future<void> _deleteFirstSlide() async {
    print('DELETING STARTS AT (FIRST) index : $_superFlyer.currentSlideIndex, numberOfSlides : $_superFlyer.numberOfSlides ------------------------------------');

    /// 1 - if only one slide remaining
    if(_superFlyer.numberOfSlides == 1){

      print('_draft.visibilities : ${_superFlyer.slidesVisibilities.toString()}, _draft.numberOfSlides : $_superFlyer.numberOfSlides');

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfStrips = 0;
        _triggerProgressOpacity();
      });

      /// B - wait fading to start deleting + update index to null
      await Future.delayed(_fadingDurationX, () async {

        /// Dx - delete data
        setState(() {
          _statelessDelete(_superFlyer.currentSlideIndex);
          _superFlyer.currentSlideIndex = null;
        });

      });

    }

    /// 2 - if two slides remaining
    else if(_superFlyer.numberOfSlides == 2){

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _superFlyer.listenToSwipe = false;
        _statelessTriggerVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfStrips = _superFlyer.numberOfSlides - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(_fadingDurationX, () async {

        /// C - slide
        await Sliders.slideToNext(_horizontalController, _superFlyer.numberOfSlides, _superFlyer.currentSlideIndex);


        /// D - delete when one slide remaining
        /// E - wait for sliding to end
        await Future.delayed(_fadingDurationX, () async {


          // /// F - snap to index 0
          // await Sliders.snapTo(_pageController, 0);
          //
          // print('now i can swipe again');
          //
          // /// G - trigger progress bar listener (onPageChangedIsOn)
          setState(() {
            /// Dx - delete data
            _statelessDelete(_superFlyer.currentSlideIndex);
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
        _statelessTriggerVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfSlides = _decreasedNumberOfSlides;
        _superFlyer.numberOfStrips = _superFlyer.numberOfSlides;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(_fadingDurationX, () async {

        /// C - slide
        await  Sliders.slideToNext(_horizontalController, _superFlyer.numberOfSlides, _superFlyer.currentSlideIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfSlides <= 1){

          setState(() {
            /// Dx - delte data
            _statelessDelete(_superFlyer.currentSlideIndex);
            _superFlyer.listenToSwipe = true;
          });

        }

        /// D - delete when at many slides remaining
        else {

          /// E - wait for sliding to end
          await Future.delayed(_fadingDurationX, () async {

            /// Dx - delete data
            _statelessDelete(_superFlyer.currentSlideIndex);
            /// F - snap to index 0
            await Sliders.snapTo(_horizontalController, 0);

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
              _superFlyer.listenToSwipe = true;
            });

          });

        }

      });

    }

    print('DELETING ENDS AT (FIRST) : index : $_superFlyer.currentSlideIndex, numberOfSlides : $_superFlyer.numberOfSlides ------------------------------------');
  }
// ------------------------------------------------o
  Future<void> _deleteMiddleOrLastSlide() async {
    print('XXXXX ----- DELETING STARTS AT (MIDDLE) index : $_superFlyer.currentSlideIndex, numberOfSlides : $_superFlyer.numberOfSlides');

    int _originalIndex = _superFlyer.currentSlideIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      _superFlyer.listenToSwipe = false;
      _superFlyer.currentSlideIndex = _superFlyer.currentSlideIndex - 1;
      _superFlyer.swipeDirection = SwipeDirection.freeze;
      _superFlyer.numberOfStrips = _superFlyer.numberOfSlides - 1;
      _statelessTriggerVisibility(_originalIndex);
    });

    // print('XXX after first rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    /// B - wait fading to start sliding
    await Future.delayed(_fadingDurationX, () async {

      // print('_currentIndex before slide : $_draft.currentSlideIndex');

      /// C - slide
      await  Sliders.slideToBackFrom(_horizontalController, _originalIndex);
      // print('_currentIndex after slide : $_draft.currentSlideIndex');

      /// E - wait for sliding to end
      await Future.delayed(_fadingDurationX, () async {

        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessDelete(_originalIndex);
          _superFlyer.listenToSwipe = true;
        });

        // print('XXX after second rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

      });

      // print('XXX after third LAST rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    });

    print('XXXXX -------  DELETING ENDS AT (MIDDLE) : index : $_superFlyer.currentSlideIndex, numberOfSlides : $_superFlyer.numberOfSlides');
  }
// ------------------------------------------------o
  void _statelessTriggerVisibility(int index) {

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
// ------------------------------------------------o
  void _statelessDelete(int index){
    print('before stateless delete index was $index, _draft.numberOfSlides was : $_superFlyer.numberOfSlides');
    _superFlyer.assetsFiles.removeAt(index);
    _superFlyer.assetsSources.removeAt(index);
    _superFlyer.slidesVisibilities.removeAt(index);
    _superFlyer.headlinesControllers.removeAt(index);
    _superFlyer.boxesFits.removeAt(index);
    _superFlyer.numberOfSlides = _superFlyer.assetsSources.length;
    print('after stateless delete index is $index, _draft.numberOfSlides is : $_superFlyer.numberOfSlides');
  }
/// ----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  void _showMapPreview(double lat, double lng) {
    final staticMapImageUrl = getStaticMapImage(context, lat, lng);
    setState(() {
      _mapImageURL = staticMapImageUrl;
      _superFlyer.position = GeoPoint(lat, lng);
    });

    /// TASK : when adding map slide,, should add empty values in _draft.assetsFiles & _assets ... etc
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  Future<List<SlideModel>> processSlides(List<String> picturesURLs, List<SlideModel> currentSlides, List<TextEditingController> titleControllers) async {
    List<SlideModel> _slides = new List();

    for (var slide in currentSlides){

      int i = slide.slideIndex;

      SlideModel _newSlide = SlideModel(
        slideIndex: currentSlides[i].slideIndex,
        picture: picturesURLs[i],
        headline: titleControllers[i].text,
        description: '',
        savesCount: widget.firstTimer ? 0 : _flyer.slides[i].savesCount,
        sharesCount: widget.firstTimer ? 0 : _flyer.slides[i].sharesCount,
        viewsCount: widget.firstTimer ? 0 : _flyer.slides[i].viewsCount,
      );

      _slides.add(_newSlide);

    }

    print('slides are $_slides');

    return _slides;
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  Future<void> _selectFlyerType() async {

    double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.25);

    await BottomDialog.slideStatefulBottomDialog(
      context: context,
      height: _dialogHeight,
      draggable: true,
      builder: (context, title){
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState){

              return BottomDialog(
                height: _dialogHeight,
                title: 'Choose Flyer Type',
                draggable: true,
                child: Container(
                  width: BottomDialog.dialogClearWidth(context),
                  height: BottomDialog.dialogClearHeight(title: 'x', context: context, overridingDialogHeight: _dialogHeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      DreamBox(
                        height: 60,
                        width: BottomDialog.dialogClearWidth(context) / 2.2,
                        verse: 'Product Flyer',
                        verseMaxLines: 2,
                        verseScaleFactor: 0.7,
                        color: _superFlyer.flyerType == FlyerType.Product ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _superFlyer.flyerType == FlyerType.Product ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _superFlyer.flyerType = FlyerType.Product;
                          });
                        },
                      ),

                      DreamBox(
                        height: 60,
                        width: BottomDialog.dialogClearWidth(context) / 2.2,
                        verse: 'Equipment Flyer',
                        verseMaxLines: 2,
                        verseScaleFactor: 0.7,
                        color: _superFlyer.flyerType == FlyerType.Equipment ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _superFlyer.flyerType == FlyerType.Equipment ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
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
// -----------------------------------------------------------------------------
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
      await _selectFlyerType();
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
// -----------------------------------------------------------------------------
  Future<List<SlideModel>> _createNewSlidesFromAssetsAndTitles() async {
    List<SlideModel> _slides = new List();

    for (int i = 0; i<_superFlyer.assetsFiles.length; i++){

      SlideModel _newSlide = SlideModel(
        slideIndex: i,
        picture: _superFlyer.assetsFiles[i],
        headline: _superFlyer.headlinesControllers[i].text,
        description: null,
        savesCount: 0,
        sharesCount: 0,
        viewsCount: 0,
      );

      _slides.add(_newSlide);

    }

    return _slides;
  }
// -----------------------------------------------------------------------------
  Future<void> _createNewFlyer() async {
    /// assert that all required fields are valid

    bool _inputsAreValid = await _inputsValidator();

    if (_inputsAreValid == false){
      // dialogs already pushed in inputsValidator

    } else {

      _triggerLoading();

      /// create slides models
      List<SlideModel> _slides = await _createNewSlidesFromAssetsAndTitles();

      /// create tiny author model from bz.authors
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
      FlyerModel _uploadedFlyerModel = await FlyerOps().createFlyerOps(context, _newFlyerModel, widget.bzModel);

      /// add the result final TinyFlyer to local list and notifyListeners
      _prof.addTinyFlyerToLocalList(TinyFlyer.getTinyFlyerFromFlyerModel(_uploadedFlyerModel));

      _triggerLoading();

      await superDialog(
        context: context,
        title: 'Great !',
        body: 'Flyer has been created',
        boolDialog: false,
      );


      Nav.goBack(context, argument: 'published');

    }
  }
// -----------------------------------------------------------------------------
  Future<void> _updateExistingFlyer() async {
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
      List<SlideModel> _slides = await _createNewSlidesFromAssetsAndTitles();

      print('B- Modifying flyer');

      ///create updated FlyerModel
      FlyerModel _updatedFlyerModel = FlyerModel(
        flyerID: _superFlyer.flyerID,
        // -------------------------
        flyerType: _superFlyer.flyerType,
        flyerState: _superFlyer.flyerState,
        keywords: _superFlyer.keywords,
        flyerShowsAuthor: _superFlyer.flyerShowsAuthor,
        flyerURL: null,
        flyerZone: _superFlyer.flyerZone,
        // -------------------------
        tinyAuthor: _flyer.tinyAuthor,
        tinyBz: _flyer.tinyBz,
        // -------------------------
        publishTime: _flyer.publishTime,
        flyerPosition: _superFlyer.position,
        // -------------------------
        ankhIsOn: false, // shouldn't be saved here but will leave this now
        // -------------------------
        slides: _slides,
        // -------------------------
        flyerIsBanned: _flyer.flyerIsBanned,
        deletionTime: _flyer.deletionTime,
        info: _superFlyer.infoController.text,
        // specs: _draft.specs,
      );

      print('C- Uploading to cloud');

      /// start create flyer ops
      FlyerModel _publishedFlyerModel = await FlyerOps().updateFlyerOps(
        context: context,
        updatedFlyer: _updatedFlyerModel,
        originalFlyer: _flyer,
        bzModel : _bz,
      );

      print('D- Uploading to cloud');

      /// add the result final Tinyflyer to local list and notifyListeners
      _prof.replaceTinyFlyerInLocalList(TinyFlyer.getTinyFlyerFromFlyerModel(_publishedFlyerModel));

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
// -----------------------------------------------------------------------------
  FlyerModel _createTempEmptyFlyer(){

    AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID());
    TinyUser _tinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(_author);

    return new FlyerModel(
      flyerID : '...',
      // -------------------------
      flyerType : FlyerTypeClass.concludeFlyerType(_bz.bzType),
      flyerState : FlyerState.Draft,
      keywords : _superFlyer?.keywords,
      flyerShowsAuthor : _superFlyer?.flyerShowsAuthor,
      flyerURL : '...',
      flyerZone: _countryPro.currentZone,
      // -------------------------
      tinyAuthor : _tinyAuthor,
      tinyBz : TinyBz.getTinyBzFromBzModel(_bz),
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
/// ----------------------------------------------------------------------------
  int _verticalIndex = 0;
  void _onVerticalIndexChanged(int verticalIndex){
    print('verticalIndex was : $_verticalIndex');
    setState(() {
      _verticalIndex = verticalIndex;
      _triggerProgressOpacity();
    });
    print('verticalIndex is : $_verticalIndex');

  }
// -----------------------------------------------------------------------------
  Future<void> _triggerKeywordsView() async {

    print('_triggerKeywordsView : _verticalIndex : $_verticalIndex');


    /// open keywords
    if(_verticalIndex == 0){
      await Sliders.slideToNext(_verticalController, 2, 0);
      // await Sliders.slideToNext(_panelController, 2, 0);
    }
    /// close keywords
    else {
      await Sliders.slideToBackFrom(_verticalController, 1);
      // await Sliders.slideToBackFrom(_panelController, 1);
    }

    setState(() {
      _triggerProgressOpacity();
    });

  }
/// ----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  Future<void> _onResetImage() async {

    if(_superFlyer.assetsFiles.isNotEmpty){

      File _file = await Imagers.getFileFromAsset(_superFlyer.assetsSources[_superFlyer.currentSlideIndex]);

      setState(() {
        _superFlyer.assetsFiles[_superFlyer.currentSlideIndex] = _file;
      });

    }

  }
// -----------------------------------------------------------------------------
  void _onAuthorTap(){
    setState(() {
      _superFlyer.flyerShowsAuthor = !_superFlyer.flyerShowsAuthor;
    });
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  Future<void> _onChangeFlyerType() async {

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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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
  void _triggerEditMode(){
    setState(() {
      _superFlyer.editMode = !_superFlyer.editMode;
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    double _screenWidth = Scale.superScreenWidth(context);
    double _flyerZoneHeight = Scale.superScreenHeightWithoutSafeArea(context) - Ratioz.appBarSmallHeight - (Ratioz.appBarMargin * 3);
    double _flyerSizeFactor = Scale.superFlyerSizeFactorByHeight(context, _flyerZoneHeight);
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    double _panelWidth = _screenWidth - _flyerZoneWidth - (Ratioz.appBarMargin * 3);
    AuthorModel _author = widget.firstTimer ?
    AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID()) :
    AuthorModel.getAuthorFromBzByAuthorID(_bz, _flyer.tinyAuthor.userID);
    // BoxFit _currentPicFit = _superFlyer?.boxesFits?.length == 0 ? null : _superFlyer?.boxesFits[_superFlyer?.currentSlideIndex];

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        SlidesCounter(),

        Expander(),

        PublishButton(
          firstTimer: widget.firstTimer,
          loading: _loading,
          onTap: widget.firstTimer ? _createNewFlyer : _updateExistingFlyer,
        ),

      ],

      layoutWidget: Column(
        // physics: NeverScrollableScrollPhysics(),
        children: <Widget>[

          Stratosphere(),

          /// FLYER & PANEL ZONES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// PANEL
              EditorPanel(
                superFlyer: _superFlyer,
                panelWidth: _panelWidth,
                bzModel: _bz,
                flyerZoneWidth: _flyerZoneWidth,
              ),

              /// FLYER

              FinalFlyer(
                flyerZoneWidth: _flyerZoneWidth,
                flyerModel: _flyer,
                tinyFlyer: null,
                isDraft: true,
                initialSlideIndex: 0,

              ),

              // FlyerZone(
              //   flyerSizeFactor: _flyerSizeFactor,
              //   tappingFlyerZone: (){},
              //   onLongPress: (){},
              //   stackWidgets: <Widget>[
              //
              //     /// FLYER PAGES
              //     // FlyerPages(
              //     //   superFlyer: ,
              //       // flyerZoneWidth: _flyerZoneWidth,
              //       // horizontalController: _horizontalController,
              //       // draft: _draft,
              //       // onHorizontalSwipe: (i) => _onHorizontalSwipe(i),
              //       // onVerticalSwipe: _triggerKeywordsView,
              //       // bzPageIsOn: false,
              //       // listenToSwipe: true,
              //       // ankhIsOn: false,
              //       // tappingAnkh: (){},
              //       // currentPicFit: _currentPicFit,
              //       // onAddImages: () async {await _getMultiGalleryImages(flyerZoneWidth: _flyerZoneWidth);},
              //       // onDeleteSlide: _deleteSlide,
              //       // onCropImage: () async {_onCropImage();},
              //       // onResetImage: _onResetImage,
              //       // onFitImage: () async {await _onFitImage(_currentPicFit);},
              //       // onVerticalBack: () async {
              //       //   print('shit');
              //       //   await Sliders.slideToBackFrom(_verticalController, 1);
              //       //   // _onVerticalIndexChanged(0);
              //       // },
              //       // onFlyerTypeTap: () async {await _onChangeFlyerType();},
              //       // onZoneTap: () async {await _onChangeZone();},
              //       // onAboutTap: () async {await _onAboutTap();},
              //       // onKeywordsTap: () async {await _onKeywordsTap();},
              //       // verticalController: _verticalController,
              //       // infoScrollController: _infoScrollController,
              //       // onVerticalIndexChanged:  (i) => _onVerticalIndexChanged(i),
              //     // ),
              //
              //     /// FLYER HEADER
              //     // FlyerHeader(
              //     //   superFlyer: null,
              //       // tinyBz: TinyBz.getTinyBzFromBzModel(_bz),
              //       // tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(_author),
              //       // flyerShowsAuthor: _draft.showAuthor,
              //       // followIsOn: false,
              //       // flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
              //       // bzPageIsOn: false,
              //       // tappingHeader: (){},
              //       // onFollowTap: (){},
              //       // onCallTap: (){
              //       //   print('call');
              //       // },
              //     // ),
              //
              //     /// PROGRESS BAR
              //     // if(_draft.numberOfStrips != 0 && _draft.currentSlideIndex != null)
              //     //   ProgressBar(
              //     //
              //     //     duration: _slidingDuration,
              //     //     opacity: _progressOpacity,
              //     //     flyerZoneWidth: _flyerZoneWidth,
              //     //     draft: _draft,
              //     //   ),
              //
              //   ],
              // ),

            ],
          ),

        ],
      ),
    );
  }
}
