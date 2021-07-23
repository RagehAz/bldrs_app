import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
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
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/xx_flyer_on_map.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/publish_button.dart';
import 'package:bldrs/views/widgets/buttons/slides_counter.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/flyer/editor/editorPanel.dart';
import 'package:bldrs/views/widgets/flyer/parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/editor_footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/info_slide.dart';
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
  DraftFlyerModel _draft;
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
  void _onPageChanged (int newIndex){
    print('flyer onPageChanged oldIndex: ${_draft.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_draft.numberOfSlides}');
    SwipeDirection _direction = Animators.getSwipeDirection(newIndex: newIndex, oldIndex: _draft.currentSlideIndex,);


    /// A - if Keyboard is active
    if (Keyboarders.keyboardIsOn(context) == true){
      print('KEYBOARD IS ACTIVE');

      /// B - when direction is going next
      if (_direction == SwipeDirection.next){
        FocusScope.of(context).nextFocus();
        setState(() {
          _draft.swipeDirection = _direction;
          _draft.currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }

      /// B - when direction is going back
      else if (_direction == SwipeDirection.back){
        FocusScope.of(context).previousFocus();
        setState(() {
          _draft.swipeDirection = _direction;
          _draft.currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }

      /// B = when direction is freezing
      else {
        setState(() {
          _draft.swipeDirection = _direction;
          _draft.currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }
    }

    /// A - if keyboard is not active
    else {
      print('KEYBOARD IS NOT ACTIVE');
      setState(() {
        _draft.swipeDirection = _direction;
        _draft.currentSlideIndex = newIndex;
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
    _draft = DraftFlyerModel.createNewDraftFlyer(context: context ,bzModel: _bz);
    _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    TextChecker.disposeAllTextControllers(_draft.headlinesControllers);
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

    List<Asset> _assetsSources = _draft.assetsSources;
    int _maxLength = Standards.getMaxSlidesCount(widget.bzModel.accountType);

    /// A - if max images reached
    if(_maxLength <= _assetsSources.length ){

      await Dialogz.maxSlidesReached(context, _maxLength);

    }

    /// A - if still picking images
    else {

      _draft.currentSlideIndex = _draft.currentSlideIndex == null ? 0 : _draft.currentSlideIndex;

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
            int _assetIndexInExistingAssets = _draft.assetsSources.indexWhere(
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
              _newFits.add(_draft.boxesFits[_assetIndexInExistingAssets]);
              /// file
              _newFiles.add(_draft.assetsFiles[_assetIndexInExistingAssets]);
              /// controller
              _newControllers.add(_draft.headlinesControllers[_assetIndexInExistingAssets]);
              /// visibilities
              _newVisibilities.add(_draft.visibilities[_assetIndexInExistingAssets]);
            }

          }

          /// D - assign all new values
          setState(() {
            _draft.assetsSources = _outputAssets;
            _draft.assetsSources = _outputAssets;

            _draft.boxesFits = _newFits;
            _draft.boxesFits = _newFits;

            _draft.assetsFiles = _newFiles;
            _draft.assetsFiles = _newFiles;

            _draft.headlinesControllers = _newControllers;

            _draft.visibilities = _newVisibilities;

            _draft.numberOfSlides = _draft.assetsSources.length;
            _draft.numberOfStrips = _draft.numberOfSlides;

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
    if (_draft.numberOfSlides == 0){
      print('nothing can be done');
    }

    /// A - if slides are not empty
    else {

      /// B - if at (FIRST) slide
      if (_draft.currentSlideIndex == 0){
        await _deleteFirstSlide();
      }

      /// B - if at (LAST) slide
      else if (_draft.currentSlideIndex + 1 == _draft.numberOfSlides){
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
    print('DELETING STARTS AT (FIRST) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides ------------------------------------');

    /// 1 - if only one slide remaining
    if(_draft.numberOfSlides == 1){

      print('_draft.visibilities : ${_draft.visibilities.toString()}, _draft.numberOfSlides : $_draft.numberOfSlides');

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerVisibility(_draft.currentSlideIndex);
        _draft.numberOfStrips = 0;
        _triggerProgressOpacity();
      });

      /// B - wait fading to start deleting + update index to null
      await Future.delayed(_fadingDurationX, () async {

        /// Dx - delete data
        setState(() {
          _statelessDelete(_draft.currentSlideIndex);
          _draft.currentSlideIndex = null;
        });

      });

    }

    /// 2 - if two slides remaining
    else if(_draft.numberOfSlides == 2){

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _draft.listenToSwipe = false;
        _statelessTriggerVisibility(_draft.currentSlideIndex);
        _draft.numberOfStrips = _draft.numberOfSlides - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(_fadingDurationX, () async {

        /// C - slide
        await Sliders.slideToNext(_horizontalController, _draft.numberOfSlides, _draft.currentSlideIndex);


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
            _statelessDelete(_draft.currentSlideIndex);
            _draft.currentSlideIndex = 0;
            // _draft.numberOfSlides = 1;
            _draft.listenToSwipe = true;
          });

        });


      });
    }

    /// 2 - if more than two slides
    else {

      int _originalNumberOfSlides = _draft.numberOfSlides;
      int _decreasedNumberOfSlides =  _draft.numberOfSlides - 1;
      // int _originalIndex = 0;
      // int _decreasedIndex = 0;

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _draft.listenToSwipe = false;
        _statelessTriggerVisibility(_draft.currentSlideIndex);
        _draft.numberOfSlides = _decreasedNumberOfSlides;
        _draft.numberOfStrips = _draft.numberOfSlides;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(_fadingDurationX, () async {

        /// C - slide
        await  Sliders.slideToNext(_horizontalController, _draft.numberOfSlides, _draft.currentSlideIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfSlides <= 1){

          setState(() {
            /// Dx - delte data
            _statelessDelete(_draft.currentSlideIndex);
            _draft.listenToSwipe = true;
          });

        }

        /// D - delete when at many slides remaining
        else {

          /// E - wait for sliding to end
          await Future.delayed(_fadingDurationX, () async {

            /// Dx - delete data
            _statelessDelete(_draft.currentSlideIndex);
            /// F - snap to index 0
            await Sliders.snapTo(_horizontalController, 0);

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
              _draft.listenToSwipe = true;
            });

          });

        }

      });

    }

    print('DELETING ENDS AT (FIRST) : index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides ------------------------------------');
  }
// ------------------------------------------------o
  Future<void> _deleteMiddleOrLastSlide() async {
    print('XXXXX ----- DELETING STARTS AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    int _originalIndex = _draft.currentSlideIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      _draft.listenToSwipe = false;
      _draft.currentSlideIndex = _draft.currentSlideIndex - 1;
      _draft.swipeDirection = SwipeDirection.freeze;
      _draft.numberOfStrips = _draft.numberOfSlides - 1;
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
          _draft.listenToSwipe = true;
        });

        // print('XXX after second rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

      });

      // print('XXX after third LAST rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    });

    print('XXXXX -------  DELETING ENDS AT (MIDDLE) : index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');
  }
// ------------------------------------------------o
  void _statelessTriggerVisibility(int index) {

    if (index != null){
      if(index >= 0 && _draft.visibilities.length != 0){
        print('_draft.visibilities[index] was ${_draft.visibilities[index]} for index : $index');
        _draft.visibilities[index] = !_draft.visibilities[index];
        print('_draft.visibilities[index] is ${_draft.visibilities[index]} for index : $index');
      }
      else {
        print('can not trigger visibility for index : $index');
      }
    }

  }
// ------------------------------------------------o
  void _statelessDelete(int index){
    print('before stateless delete index was $index, _draft.numberOfSlides was : $_draft.numberOfSlides');
    _draft.assetsFiles.removeAt(index);
    _draft.assetsSources.removeAt(index);
    _draft.visibilities.removeAt(index);
    _draft.headlinesControllers.removeAt(index);
    _draft.boxesFits.removeAt(index);
    _draft.numberOfSlides = _draft.assetsSources.length;
    print('after stateless delete index is $index, _draft.numberOfSlides is : $_draft.numberOfSlides');
  }
/// ----------------------------------------------------------------------------
  Future<void>_selectOnMap() async {

    if (_draft.slides.length == 0){

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
      _draft.mapImageURL = staticMapImageUrl;
      _draft.position = GeoPoint(lat, lng);
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
                            keywords: _draft.keywords,
                            selectedWords: _draft.keywords,
                            onTap: (value){
                              setDialogState(() {
                                _draft.keywords.remove(value);
                              });
                            },
                          ),

                          KeywordsBubble(
                            verseSize: 1,
                            bubbles: true,
                            title: 'Space Type',
                            keywords: _keywords,
                            selectedWords: _draft.keywords,
                            onTap: (value){
                              setDialogState(() {
                                _draft.keywords.add(value);
                              });
                            },
                          ),

                          KeywordsBubble(
                            verseSize: 1,
                            bubbles: true,
                            title: 'Product Use',
                            keywords: _keywords,
                            selectedWords: _draft.keywords,
                            onTap: (value){setDialogState(() {_draft.keywords.add(value);});},
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
                        color: _draft.flyerType == FlyerType.Product ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _draft.flyerType == FlyerType.Product ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _draft.flyerType = FlyerType.Product;
                          });
                        },
                      ),

                      DreamBox(
                        height: 60,
                        width: BottomDialog.dialogClearWidth(context) / 2.2,
                        verse: 'Equipment Flyer',
                        verseMaxLines: 2,
                        verseScaleFactor: 0.7,
                        color: _draft.flyerType == FlyerType.Equipment ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _draft.flyerType == FlyerType.Equipment ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _draft.flyerType = FlyerType.Equipment;
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
    if (_draft.assetsFiles == null || _draft.assetsFiles.length == 0){
      await superDialog(
        context: context,
        boolDialog: false,
        // title: 'No '
        body: 'First, select some pictures',
      );
      _inputsAreValid = false;
    }

    /// when less than 3 pictures selected
    else if (_draft.assetsFiles.length < 3){
      await superDialog(
        context: context,
        boolDialog: false,
        // title: 'No '
        body: 'At least 3 pictures are required to publish this flyer',
      );
      _inputsAreValid = false;
    }

    /// when no keywords selected
    else if (_draft.keywords.length == 0){
      /// TASK : add these keywords condition in flyer publish validator
      // await
      _inputsAreValid = true;
    }

    /// when flyerType is not defined
    else if (_draft.flyerType == null){
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

    for (int i = 0; i<_draft.assetsFiles.length; i++){

      SlideModel _newSlide = SlideModel(
        slideIndex: i,
        picture: _draft.assetsFiles[i],
        headline: _draft.headlinesControllers[i].text,
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
        flyerID: _draft.flyerID, // will be created in createFlyerOps
        // -------------------------
        flyerType: _draft.flyerType,
        flyerState: _draft.flyerState,
        keyWords: _draft.keywords,
        flyerShowsAuthor: _draft.showAuthor,
        flyerURL: null,
        flyerZone: _draft.flyerZone,
        // -------------------------
        tinyAuthor: _tinyAuthor,
        tinyBz: _tinyBz,
        // -------------------------
        publishTime: null, // will be overriden in createFlyerOps
        flyerPosition: _draft.position,
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
        flyerID: _draft.flyerID,
        // -------------------------
        flyerType: _draft.flyerType,
        flyerState: _draft.flyerState,
        keyWords: _draft.keywords,
        flyerShowsAuthor: _draft.showAuthor,
        flyerURL: null,
        flyerZone: _draft.flyerZone,
        // -------------------------
        tinyAuthor: _flyer.tinyAuthor,
        tinyBz: _flyer.tinyBz,
        // -------------------------
        publishTime: _flyer.publishTime,
        flyerPosition: _draft.position,
        // -------------------------
        ankhIsOn: false, // shouldn't be saved here but will leave this now
        // -------------------------
        slides: _slides,
        // -------------------------
        flyerIsBanned: _flyer.flyerIsBanned,
        deletionTime: _flyer.deletionTime,
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
      keyWords : _draft.keywords,
      flyerShowsAuthor : _draft.showAuthor,
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

    if(_draft.assetsFiles.isNotEmpty){

      if(fit == BoxFit.fitWidth) {
        setState(() {
          _draft.boxesFits[_draft.currentSlideIndex] = BoxFit.fitHeight;
        });
      }

      else {
        setState(() {
          _draft.boxesFits[_draft.currentSlideIndex] = BoxFit.fitWidth;
        });
      }

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onResetImage() async {

    if(_draft.assetsFiles.isNotEmpty){

      File _file = await Imagers.getFileFromAsset(_draft.assetsSources[_draft.currentSlideIndex]);

      setState(() {
        _draft.assetsFiles[_draft.currentSlideIndex] = _file;
      });

    }

  }
// -----------------------------------------------------------------------------
  void _onAuthorTap(){
    setState(() {
      _draft.showAuthor = !_draft.showAuthor;
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _onCropImage() async {

    if(_draft.assetsFiles.isNotEmpty){

      _triggerLoading();

      File croppedFile = await Imagers.cropImage(context, _draft.assetsFiles[_draft.currentSlideIndex]);

      if (croppedFile != null) {
        setState(() {
          _draft.assetsFiles[_draft.currentSlideIndex] = croppedFile;
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
                        color: _draft.flyerType == FlyerType.Product ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _draft.flyerType == FlyerType.Product ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _draft.flyerType = FlyerType.Product;
                          });

                          setState(() {
                            _draft.flyerType = FlyerType.Product;
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
                        color: _draft.flyerType == FlyerType.Equipment ? Colorz.Yellow255 : Colorz.White20,
                        verseColor: _draft.flyerType == FlyerType.Equipment ? Colorz.Black230 : Colorz.White255,
                        onTap: (){
                          setDialogState(() {
                            _draft.flyerType = FlyerType.Equipment;
                          });
                          setState(() {
                            _draft.flyerType = FlyerType.Equipment;
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
    List<Map<String,String>> _cities = _countryPro.getCitiesNamesMapsByIso3(context, _draft.flyerZone.countryID);
    List<Map<String,String>> _districts = _countryPro.getDistrictsNameMapsByCityID(context, _draft.flyerZone.cityID);

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

          String _lastCountryID = _draft.flyerZone.countryID;

          setState(() {
            _draft.flyerZone.countryID = countryID;
            _cities = _countryPro.getCitiesNamesMapsByIso3(context, _draft.flyerZone.countryID);
            _openNextDialog = true;
          });

          /// if changed country, reset city & district
          if (_lastCountryID != countryID){
            setState(() {
            _draft.flyerZone.cityID = null;
            _draft.flyerZone.districtID = null;
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
        title: '${_countryPro.getCountryNameInCurrentLanguageByIso3(context, _draft.flyerZone.countryID)} Cities',
        child: BottomDialogButtons(
          listOfMaps: _cities,
          mapValueIs: MapValueIs.String,
          alignment: Alignment.center,
          provider: _countryPro,
          sheetType: BottomSheetType.Province,
          buttonTap: (cityID) async {

            String _lastCity = _draft.flyerZone.cityID;

            setState(() {
              _draft.flyerZone.cityID = cityID;
              _districts = _countryPro.getDistrictsNameMapsByCityID(context, cityID);
              _openNextDialog = true;
            });

            /// if city changed, reset district
            if (_lastCity != cityID){
              setState(() {
                _draft.flyerZone.districtID = null;
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
        title: '${_countryPro.getCityNameWithCurrentLanguageIfPossible(context, _draft.flyerZone.cityID)} Districts',
        child: BottomDialogButtons(
          listOfMaps: _districts,
          mapValueIs: MapValueIs.String,
          alignment: Alignment.center,
          provider: _countryPro,
          sheetType: BottomSheetType.District,
          buttonTap: (districtID) async {
            setState(() {
              _draft.flyerZone.districtID = districtID;
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
              textController: _draft.infoController,
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
      _draft.editMode = !_draft.editMode;
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    // print('draft picture screen');

    double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    // double _panelWidth = _buttonSize + (Ratioz.appBarMargin * 2);
    // double _flyerZoneWidth = _screenWidth - _panelWidth - Ratioz.appBarMargin;
    // double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerZoneWidth);
    // double _flyerSizeFactor = Scale.superFlyerSizeFactorByWidth(context, _flyerZoneWidth);

    double _flyerZoneHeight = Scale.superScreenHeightWithoutSafeArea(context) - Ratioz.appBarSmallHeight - (Ratioz.appBarMargin * 3);
    double _flyerSizeFactor = Scale.superFlyerSizeFactorByHeight(context, _flyerZoneHeight);
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    double _panelWidth = _screenWidth - _flyerZoneWidth - (Ratioz.appBarMargin * 3);

    double _panelHeight = _flyerZoneHeight;
    double _buttonSize = _panelWidth - (Ratioz.appBarPadding);
    double _panelButtonSize = _buttonSize * 0.8;


    AuthorModel _author = widget.firstTimer ?
    AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID()) :
    AuthorModel.getAuthorFromBzByAuthorID(_bz, _flyer.tinyAuthor.userID);


    // ImageSize _originalAssetSize = _assets.length == 0 || _assets == null ? null : ImageSize(
    //   width: _assets[_draft.currentSlideIndex].originalWidth,
    //   height: _assets[_draft.currentSlideIndex].originalHeight,
    // );

// ------------------------------
    BoxFit _currentPicFit = _draft.boxesFits.length == 0 ? null : _draft.boxesFits[_draft.currentSlideIndex];


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
          Container(
            width: _screenWidth,
            height: _panelHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// PANEL
                EditorPanel(
                  flyerZoneWidth: _flyerZoneWidth,
                  panelWidth: _panelWidth,
                  boxFit: _currentPicFit,
                  showAuthor: _draft.showAuthor,
                  onAuthorTap: _onAuthorTap,
                  onTriggerEditMode: _triggerEditMode,
                  zone: _draft.flyerZone,
                  flyerType: _draft.flyerType,
                  onFlyerTypeTap: () async {await _onChangeFlyerType();},
                  onZoneTap: () async {await _onChangeZone();},
                  onAboutTap: () async {await _onAboutTap();},
                  onKeywordsTap: () async {await _onKeywordsTap();},
                  draft: _draft,
                ),

                /// FLYER
                FlyerZone(
                  flyerSizeFactor: _flyerSizeFactor,
                  tappingFlyerZone: (){},
                  onLongPress: (){},
                  stackWidgets: <Widget>[

                    /// SLIDES
                    PageView(
                      pageSnapping: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),//_verticalIndex == 0 ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
                      allowImplicitScrolling: true,
                      onPageChanged: _draft.listenToSwipe ? (i) => _onVerticalIndexChanged(i) : (i) => Sliders.zombie(i),
                      controller: _verticalController,
                      children: <Widget>[

                        /// PAGES & ANKH
                        Stack(
                          children: <Widget>[

                            /// SLIDES
                            if(_draft.currentSlideIndex != null)
                              PageView(
                                pageSnapping: true,
                                controller: _horizontalController,
                                physics: const BouncingScrollPhysics(),
                                allowImplicitScrolling: false,
                                clipBehavior: Clip.antiAlias,
                                restorationId: '${_draft.key.value}',
                                onPageChanged: _draft.listenToSwipe ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[

                                  ...List.generate(_draft.numberOfSlides, (i){

                                    // print('========= BUILDING PROGRESS BAR FOR ||| index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

                                    BoxFit _currentPicFit = _draft.boxesFits.length == 0 ? null : _draft.boxesFits[_draft.currentSlideIndex];

                                    ImageSize _originalAssetSize =
                                    _draft.numberOfSlides == 0 ? null :
                                    _draft.assetsSources.length == 0 ? null :
                                    ImageSize(
                                      width: _draft.assetsSources[_draft.currentSlideIndex].originalWidth,
                                      height: _draft.assetsSources[_draft.currentSlideIndex].originalHeight,
                                    );


                                    return
                                      _draft.numberOfSlides == 0 ? Container() :
                                      AnimatedOpacity(
                                        key: ObjectKey(_draft.key.value + i),
                                        opacity: _draft.visibilities[i] == true ? 1 : 0,
                                        duration: _fadingDuration,
                                        child: Stack(
                                          children: <Widget>[

                                            SingleSlide(
                                              key: ObjectKey(_draft.key.value + i),
                                              flyerZoneWidth: _flyerZoneWidth,
                                              flyerID: null, //_flyer.flyerID,
                                              picture: _draft.assetsFiles[i],//_currentSlides[index].picture,
                                              slideMode: _draft.editMode ? SlideMode.Editor : SlideMode.View,//slidesModes[index],
                                              boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                                              titleController: _draft.headlinesControllers[i],
                                              title: _draft.headlinesControllers[i].text,
                                              imageSize: _originalAssetSize,
                                              textFieldOnChanged: (text){
                                                print('text is : $text');
                                              },
                                              onTap: (){},
                                            ),

                                            if (_draft.editMode == false)
                                              FlyerFooter(
                                                flyerZoneWidth: _flyerZoneWidth,
                                                saves: 0,
                                                shares: 0,
                                                views: 0,
                                                onShareTap: null,
                                                onCountersTap: _triggerKeywordsView,
                                              ),

                                          ],
                                        ),
                                      );

                                  }),

                                ],
                              ),

                            /// ANKH
                            if(_draft.currentSlideIndex != null && _draft.numberOfSlides != 0 && _draft.editMode == false)
                              AnkhButton(
                                bzPageIsOn: false,
                                flyerZoneWidth: _flyerZoneWidth,
                                slidingIsOn: true,
                                ankhIsOn: false,
                                tappingAnkh: (){},
                              ),

                            /// EDITOR FOOTER
                            if (_draft.editMode == true)
                              EditorFooter(
                                flyerZoneWidth: _flyerZoneWidth,
                                currentPicFit: _currentPicFit,
                                onAddImages: () async {await _getMultiGalleryImages(flyerZoneWidth: _flyerZoneWidth);},
                                onDeleteSlide: _deleteSlide,
                                onCropImage: () async {_onCropImage();},
                                onResetImage: _onResetImage,
                                onFitImage: () async {await _onFitImage(_currentPicFit);},
                                numberOdSlides: _draft.numberOfSlides,
                              ),

                          ],
                        ),

                        /// INFO SLIDE
                        NotificationListener(
                          onNotification: (ScrollUpdateNotification details){

                            double _offset = details.metrics.pixels;

                            double _bounceLimit = _flyerZoneHeight * 0.15 * (-1);

                            bool _canPageUp = _offset < _bounceLimit;

                            bool _goingDown = Scrollers.isGoingDown(_infoScrollController);

                            if(_goingDown && _canPageUp){
                              Sliders.slideToBackFrom(_verticalController, 1, curve: Curves.easeOut);
                            }

                            return true;
                          },
                          child: ListView(
                            key: PageStorageKey<String>('${Numberers.createUniqueIntFrom(existingValues: [1, 2])}'),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: false,
                            controller: _infoScrollController,
                            children: <Widget>[

                              InfoSlide(
                                flyerZoneWidth: _flyerZoneWidth,
                                draft: _draft,
                                onVerticalBack: () async {
                                  await Sliders.slideToBackFrom(_verticalController, 1);
                                  // _onVerticalIndexChanged(0);
                                },
                                onFlyerTypeTap: () async {await _onChangeFlyerType();},
                                onZoneTap: () async {await _onChangeZone();},
                                onAboutTap: () async {await _onAboutTap();},
                                onKeywordsTap: () async {await _onKeywordsTap();},
                              ),

                            ],
                          ),
                        ),



                      ],
                    ),

                    /// FLYER HEADER
                    AbsorbPointer(
                      absorbing: true,
                      child: Header(
                        tinyBz: TinyBz.getTinyBzFromBzModel(_bz),
                        tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(_author),
                        flyerShowsAuthor: _draft.showAuthor,
                        followIsOn: false,
                        flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
                        bzPageIsOn: false,
                        tappingHeader: (){},
                        onFollowTap: (){},
                        onCallTap: (){
                          print('call');
                        },
                      ),
                    ),

                    /// PROGRESS BAR
                    if(_draft.numberOfStrips != 0 && _draft.currentSlideIndex != null)
                      AnimatedOpacity(
                        duration: _slidingDuration,
                        opacity: _progressOpacity,
                        child: ProgressBar(
                          flyerZoneWidth: _flyerZoneWidth,
                          numberOfStrips: _draft.numberOfStrips,
                          slideIndex: _draft.currentSlideIndex,
                          swipeDirection: _draft.swipeDirection,
                        ),
                      ),


                  ],
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
