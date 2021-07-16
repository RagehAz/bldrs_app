import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
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
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/xx_flyer_on_map.dart';
import 'package:bldrs/views/screens/x2_old_flyer_editor_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/panel_button.dart';
import 'package:bldrs/views/widgets/buttons/publish_button.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_sheet.dart';
import 'package:bldrs/views/widgets/flyer/parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/screens/x1_publisher_screen.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';

class FlyerEditorScreen extends StatefulWidget {
  final DraftFlyerModel draftFlyerModel;
  final String firstTitle;
  final int index;
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;
  final double flyerZoneWidth;
  final Function onDeleteImage;
  final List<TextEditingController> headlinesControllers;

  FlyerEditorScreen({
    @required this.draftFlyerModel,
    @required this.firstTitle,
    @required this.index,
    @required this.bzModel,
    @required this.firstTimer,
    this.flyerModel,
    @required this.flyerZoneWidth,
    @required this.onDeleteImage,
    @required this.headlinesControllers,
  });

  @override
  _FlyerEditorScreenState createState() => _FlyerEditorScreenState();
}

class _FlyerEditorScreenState extends State<FlyerEditorScreen> with AutomaticKeepAliveClientMixin{
  /// to keep out of screen objects alive when using [with AutomaticKeepAliveClientMixin]
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  PageController _pageController;
  PageController _keywordsScrollController;
  double _buttonSize = 50;
  List<bool> _slidesVisibility;
  List<TextEditingController> _headlinesControllers;
// -----------------------------------------------------------------------------
  FlyersProvider _prof;
  CountryProvider _countryPro;
  BzModel _bz;
  FlyerModel _flyer;
// -----------------------------------------------------------------------------
  List<Asset> _assets;
  List<File> _assetsAsFiles;
  List<BoxFit> _picsFits;
// ---------------------------------------------------------------------------
  String _currentFlyerID;
  // -------------------------
  FlyerType _flyerType;
  FlyerState _flyerState;
  List<Keyword> _keywords = new List();
  bool _showAuthor = true;
  String _flyerURL; // no need for this
  Zone _flyerZone;
  // -------------------------
  String _currentAuthorID;
  String _currentBzID;
  // -------------------------
  DateTime _publishTime;
  GeoPoint _flyerPosition;
  String _mapPreviewImageUrl;
  // -------------------------
  bool _ankhIsOn = false; // shouldn't be saved here but will leave this now
  // -------------------------
  List<SlideModel> _currentSlides;
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
  // usage :  onPageChanged: (i) => _onPageChanged(i),
  SwipeDirection _swipeDirection = SwipeDirection.next;
  int _currentSlideIndex; /// in init : _currentSlideIndex = widget.index;
  int _numberOfSlides; /// in init : numberOfSlides = _assets.length;
  bool onPageChangedIsOn = true; /// onPageChanged: onPageChangedIsOn ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
  int _numberOfStrips ;
  void _onPageChanged (int newIndex){
    print('flyer onPageChanged oldIndex: $_currentSlideIndex, newIndex: $newIndex, _numberOfSlides: $_numberOfSlides');
    SwipeDirection _direction = Animators.getSwipeDirection(newIndex: newIndex, oldIndex: _currentSlideIndex,);


    /// A - if Keyboard is active
    if (Keyboarders.keyboardIsOn(context) == true){
      print('KEYBOARD IS ACTIVE');

      /// B - when direction is going next
      if (_direction == SwipeDirection.next){
        FocusScope.of(context).nextFocus();
        setState(() {
          _swipeDirection = _direction;
          _currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }

      /// B - when direction is going back
      else if (_direction == SwipeDirection.back){
        FocusScope.of(context).previousFocus();
        setState(() {
          _swipeDirection = _direction;
          _currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }

      /// B = when direction is freezing
      else {
        setState(() {
          _swipeDirection = _direction;
          _currentSlideIndex = newIndex;
          // _autoFocus = true;
        });
      }
    }

    /// A - if keyboard is not active
    else {
      print('KEYBOARD IS NOT ACTIVE');
      setState(() {
        _swipeDirection = _direction;
        _currentSlideIndex = newIndex;
      });

    }

    }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index, viewportFraction: 1, keepPage: true);
    _keywordsScrollController = PageController(initialPage: 0, keepPage: true);

    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _countryPro = Provider.of<CountryProvider>(context, listen: false);
    _bz = widget.bzModel;

    /// by defining _flyer and its conditions,, we can use _flyer anywhere
    _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();
    _flyerZone = _flyer.flyerZone;

    _assets = widget.draftFlyerModel.assetsSources;
    _currentSlideIndex = widget.index;
    _numberOfSlides = _assets.length;
    _numberOfStrips = _numberOfSlides;

    _assetsAsFiles = widget.draftFlyerModel.assetsFiles;
    _picsFits = widget.draftFlyerModel.boxesFits;
    _slidesVisibility = _createSlidesVisibilityList(); //widget.firstTimer == true ? new List() : _createSlidesVisibilityList();
    _headlinesControllers = widget.firstTimer ? widget.headlinesControllers : _createHeadlinesForExistingFlyer();

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    TextChecker.disposeAllTextControllers(_headlinesControllers);

    super.dispose();
  }
// -----------------------------------------------------------------------------
  List<TextEditingController> _createHeadlinesForNewFlyer(){

    List<TextEditingController> _controllers = TextChecker.createTextControllersAndOverrideOneString(
      length: _assetsAsFiles.length,
      indexToOverride: 0,
      overridingString: widget.firstTitle,
    );

    return _controllers;
  }
// -----------------------------------------------------------------------------
  List<TextEditingController> _createHeadlinesForExistingFlyer(){
    List<TextEditingController> _controllers = new List();

    _flyer.slides.forEach((slide) {
      TextEditingController _controller = new TextEditingController();
      _controller.text = slide.headline;
      _controllers.add(_controller);
    });

    return _controllers;
  }
// -----------------------------------------------------------------------------
  List<bool> _createSlidesVisibilityList(){
    int _listLength = widget.draftFlyerModel.assetsFiles.length;
    List<bool> _visibilityList = new List();

    for (int i = 0; i<_listLength; i++){
      _visibilityList.add(true);
    }

    return _visibilityList;
  }
// ---------------------------------------------------o
  Duration _fadingDuration = Ratioz.durationFading200;
  Duration _fadingDurationX = Ratioz.durationFading210;
  Duration _slidingDuration = Ratioz.durationSliding400;
  Duration _slidingDurationX = Ratioz.durationSliding410;
// ---------------------------------------------------o
  Future<void> _getMultiImages({BzAccountType accountType}) async {

    _triggerLoading();

    List<Asset> _oldAssets = _assets;

    /// A - if flyer reached max slides
    if(Standards.getMaxSlidesCount(accountType) <= _oldAssets.length ){
      await superDialog(
        context: context,
        title: 'Obbaaaa',
        body: 'Ta3alaaaaaaa ba2aaa ya 7abibi',
      );
    }

    /// A - if still picking images
    else {

      _currentSlideIndex = _currentSlideIndex == null ? 0 : _currentSlideIndex;

      List<Asset> _newAssets;

      if(mounted){
        _newAssets = await Imagers.getMultiImagesFromGallery(
          context: context,
          images: _oldAssets,
          mounted: mounted,
          accountType: accountType,
        );

        /// B - if did not pick new assets
        if(_newAssets.length == 0){
          // will do nothing
          print('no new picks');
        }

        /// B - if picked new assets
        else {

          // for (Asset asset in _newAssets){
          //   File _file = await Imagers.getFileFromCropperAsset(asset);
          //   _assetsAsFiles.add(_file);
          //   _fits.add(Imagers.concludeBoxFit(asset));
          // }

          List<BoxFit> _newFits = new List();
          List<File> _newFiles = new List();
          List<TextEditingController> _newControllers = new List();
          List<Matrix4> _newMatrixes = new List();
          List<bool> _newVisibilities = new List();

          for (Asset newAsset in _newAssets){
            int _assetIndexInExistingAssets = _assets.indexWhere((existingAsset) => existingAsset.identifier == newAsset.identifier,);

            /// if no match found between new assets and existing assets
            // this asset is new
            if(_assetIndexInExistingAssets == -1){
              /// fit
              _newFits.add(Imagers.concludeBoxFit(asset: newAsset, flyerZoneWidth: widget.flyerZoneWidth));
              /// file
              File _newFile = await Imagers.getFileFromAsset(newAsset);
              _newFiles.add(_newFile);
              /// controller
              _newControllers.add(new TextEditingController());
              /// matrixes
              _newMatrixes.add(new Matrix4.identity());
              /// visibilities
              _newVisibilities.add(true);
            }

            /// found the index of the unchanged asset
            // this asset is old
            else {
              /// fit
              _newFits.add(_picsFits[_assetIndexInExistingAssets]);
              /// file
              _newFiles.add(_assetsAsFiles[_assetIndexInExistingAssets]);
              /// controller
              _newControllers.add(_headlinesControllers[_assetIndexInExistingAssets]);
              /// visibilities
              _newVisibilities.add(_slidesVisibility[_assetIndexInExistingAssets]);
            }

          }

          setState(() {
            widget.draftFlyerModel.assetsSources = _newAssets;
            _assets = _newAssets;

            widget.draftFlyerModel.boxesFits = _newFits;
            _picsFits = _newFits;

            widget.draftFlyerModel.assetsFiles = _newFiles;
            _assetsAsFiles = _newFiles;

            _headlinesControllers = _newControllers;

            _slidesVisibility = _newVisibilities;

            _numberOfSlides = _assets.length;
            _numberOfStrips = _numberOfSlides;
          });

          await _pageController.animateToPage(
              _newAssets.length - 1,
              duration: Ratioz.duration1000ms, curve: Curves.easeInOut
          );

          // print(_assets.toString());
          // print(_picsFits.toString());
          // print(_assetsAsFiles.toString());
          // print(_titleControllers.toString());
          // print(_matrixes.toString());
          // print(_slidesVisibility.toString());
        }

      }

    }

    _triggerLoading();

  }
// -----------------------------------------------------------------------------
  List<Widget> _buildSlides(){
    // print('========= BUILDING PROGRESS BAR FOR ||| index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

    BoxFit _currentPicFit = _picsFits.length == 0 ? null : _picsFits[_currentSlideIndex];

    ImageSize _originalAssetSize =
    _numberOfSlides == 0 ? null :
    _assets.length == 0 ? null :
    ImageSize(
      width: _assets[_currentSlideIndex].originalWidth,
      height: _assets[_currentSlideIndex].originalHeight,
    );

    return
        <Widget>[
          ...List.generate(_numberOfSlides, (i){

            return
            _numberOfSlides == 0 ? Container() :
              AnimatedOpacity(
                key: ObjectKey(widget.draftFlyerModel.key.value + i),
                opacity: _slidesVisibility[i] == true ? 1 : 0,
                duration: _fadingDuration,
                child: Stack(
                  children: <Widget>[

                    SingleSlide(
                      key: ObjectKey(widget.draftFlyerModel.key.value + i),
                      flyerZoneWidth: widget.flyerZoneWidth,
                      flyerID: null, //_flyer.flyerID,
                      picture: _assetsAsFiles[i],//_currentSlides[index].picture,
                      slideMode: SlideMode.Editor,//slidesModes[index],
                      boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
                      titleController: _headlinesControllers[i],
                      imageSize: _originalAssetSize,
                      textFieldOnChanged: (text){
                        print('text is : $text');
                      },
                    ),

                    FlyerFooter(
                      flyerZoneWidth: widget.flyerZoneWidth,
                      saves: 0,
                      shares: 0,
                      views: 0,
                      tappingShare: null,
                    ),

                  ],
                ),
              );

          }),
        ];
  }
// -----------------------------------------------------------------------------
  Future<void> _deleteSlide() async {

    /// A - if slides are empty
    if (_numberOfSlides == 0){
      print('nothing can be done');
    }

    /// A - if slides are not empty
    else {

      /// B - if at (FIRST) slide
      if (_currentSlideIndex == 0){
        await _deleteFirstSlide();
      }

      /// B - if at (LAST) slide
      else if (_currentSlideIndex + 1 == _numberOfSlides){
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
    print('DELETING STARTS AT (FIRST) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides ------------------------------------');

    /// 1 - if only one slide remaining
    if(_numberOfSlides == 1){

      print('_slidesVisibility : ${_slidesVisibility.toString()}, _numberOfSlides : $_numberOfSlides');

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerVisibility(_currentSlideIndex);
        _numberOfStrips = 0;
      });

      /// B - wait fading to start deleting + update index to null
      await Future.delayed(_fadingDurationX, () async {

        /// Dx - delete data
        setState(() {
          _statelessDelete(_currentSlideIndex);
          _currentSlideIndex = null;
        });

      });

    }

    /// 2 - if two slides remaining
    else if(_numberOfSlides == 2){

      /// A - decrease progress bar and trigger visibility
      setState(() {
        onPageChangedIsOn = false;
        _statelessTriggerVisibility(_currentSlideIndex);
        _numberOfStrips = _numberOfSlides - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(_fadingDurationX, () async {

        /// C - slide
        await Sliders.slideToNext(_pageController, _numberOfSlides, _currentSlideIndex);


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
            _statelessDelete(_currentSlideIndex);
            _currentSlideIndex = 0;
            // _numberOfSlides = 1;
            onPageChangedIsOn = true;
          });

        });


      });
    }

    /// 2 - if more than two slides
    else {

      int _originalNumberOfSlides = _numberOfSlides;
      int _decreasedNumberOfSlides =  _numberOfSlides - 1;
      // int _originalIndex = 0;
      // int _decreasedIndex = 0;

      /// A - decrease progress bar and trigger visibility
      setState(() {
        onPageChangedIsOn = false;
        _statelessTriggerVisibility(_currentSlideIndex);
        _numberOfSlides = _decreasedNumberOfSlides;
        _numberOfStrips = _numberOfSlides;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future.delayed(_fadingDurationX, () async {

        /// C - slide
        await  Sliders.slideToNext(_pageController, _numberOfSlides, _currentSlideIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfSlides <= 1){

          setState(() {
            /// Dx - delte data
            _statelessDelete(_currentSlideIndex);
            onPageChangedIsOn = true;
          });

        }

        /// D - delete when at many slides remaining
        else {

          /// E - wait for sliding to end
          await Future.delayed(_fadingDurationX, () async {

            /// Dx - delete data
            _statelessDelete(_currentSlideIndex);
            /// F - snap to index 0
            await Sliders.snapTo(_pageController, 0);

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
              onPageChangedIsOn = true;
            });

          });

        }

      });

    }

    print('DELETING ENDS AT (FIRST) : index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides ------------------------------------');
  }
// ------------------------------------------------o
  Future<void> _deleteMiddleOrLastSlide() async {
    print('XXXXX ----- DELETING STARTS AT (MIDDLE) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

    int _originalIndex = _currentSlideIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      onPageChangedIsOn = false;
      _currentSlideIndex = _currentSlideIndex - 1;
      _swipeDirection = SwipeDirection.freeze;
      _numberOfStrips = _numberOfSlides - 1;
      _statelessTriggerVisibility(_originalIndex);
    });

    // print('XXX after first rebuild AT (MIDDLE) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

    /// B - wait fading to start sliding
    await Future.delayed(_fadingDurationX, () async {

      // print('_currentIndex before slide : $_currentSlideIndex');

      /// C - slide
      await  Sliders.slideToBackFrom(_pageController, _originalIndex);
      // print('_currentIndex after slide : $_currentSlideIndex');

      /// E - wait for sliding to end
      await Future.delayed(_fadingDurationX, () async {

        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessDelete(_originalIndex);
          onPageChangedIsOn = true;
        });

        // print('XXX after second rebuild AT (MIDDLE) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

      });

      // print('XXX after third LAST rebuild AT (MIDDLE) index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');

    });

    print('XXXXX -------  DELETING ENDS AT (MIDDLE) : index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides');
  }
// ------------------------------------------------o
  void _statelessTriggerVisibility(int index) {

    if (index != null){
      if(index >= 0 && _slidesVisibility.length != 0){
        print('_slidesVisibility[index] was ${_slidesVisibility[index]} for index : $index');
        _slidesVisibility[index] = !_slidesVisibility[index];
        print('_slidesVisibility[index] is ${_slidesVisibility[index]} for index : $index');
      }
      else {
        print('can not trigger visibility for index : $index');
      }
    }

  }
// ------------------------------------------------o
  void _statelessDelete(int index){
    print('before stateless delete index was $index, _numberOfSlides was : $_numberOfSlides');
    _assetsAsFiles.removeAt(index);
    _assets.removeAt(index);
    _slidesVisibility.removeAt(index);
    _headlinesControllers.removeAt(index);
    _picsFits.removeAt(index);
    _numberOfSlides = _assets.length;
    print('after stateless delete index is $index, _numberOfSlides is : $_numberOfSlides');
  }
// -----------------------------------------------------------------------------
  Future<void> _cropImage(File file) async {

    _triggerLoading();

    File croppedFile = await Imagers.cropImage(context, file);

    if (croppedFile != null) {
      setState(() {
        _assetsAsFiles[_currentSlideIndex] = croppedFile;
      });
    }

    _triggerLoading();
  }
/// ----------------------------------------------------------------------------
  Future<void>_selectOnMap() async {

    if (_currentSlides.length == 0){

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
      _mapPreviewImageUrl = staticMapImageUrl;
      _flyerPosition = GeoPoint(lat, lng);
    });

    /// TASK : when adding map slide,, should add empty values in _assetsAsFiles & _assets ... etc
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
    //           picture: _mapPreviewImageUrl,
    //           headline: _titleControllers[_currentSlides.length].text,
    //         ));
    //     _currentSlideIndex = _currentSlides.length - 1;
    //     _numberOfSlides = _currentSlides.length;
    //     _slidesVisibility.add(true);
    //     // slidesModes.add(SlideMode.Map);
    //     _titleControllers.add(TextEditingController());
    //     onPageChangedIsOn = true;
    //   });
    //   Sliders.slideTo(_pageController, _currentSlideIndex);
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

    double _bottomSheetHeightFactor = 0.7;

    BottomSlider.slideStatefulBottomSheet(
      context: context,
      height: Scale.superScreenHeight(context) * _bottomSheetHeightFactor,
      draggable: true,
      builder: (context){
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSheetState){
              return BldrsBottomSheet(
                height: Scale.superScreenHeight(context) * _bottomSheetHeightFactor,
                draggable: true,
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
                      width: BottomSlider.bottomSheetClearWidth(context),
                      height: BottomSlider.bottomSheetClearHeight(context, _bottomSheetHeightFactor) - superVerseRealHeight(context, 3, 1, null),
                      child: ListView(
                        // key: UniqueKey(),

                        children: <Widget>[

                          SizedBox(
                            height: Ratioz.appBarPadding,
                          ),

                          WordsBubble(
                            verseSize: 1,
                            bubbles: false,
                            title: 'Selected keywords',
                            words: _keywords,
                            selectedWords: _keywords,
                            onTap: (value){
                              setSheetState(() {
                                _keywords.remove(value);
                              });
                            },
                          ),

                          WordsBubble(
                            verseSize: 1,
                            bubbles: true,
                            title: 'Space Type',
                            words: ['1', '2', '3'],
                            selectedWords: _keywords,
                            onTap: (value){
                              setSheetState(() {
                                _keywords.add(value);
                              });
                            },
                          ),

                          WordsBubble(
                            verseSize: 1,
                            bubbles: true,
                            title: 'Product Use',
                            words: ['1', '2', '3'],
                            selectedWords: _keywords,
                            onTap: (value){setSheetState(() {_keywords.add(value);});},
                          ),

                          // Container(
                          //   width: bottomSheetClearWidth(context),
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

    double _bottomSheetHeightFactor = 0.25;

    await BottomSlider.slideStatefulBottomSheet(
      context: context,
      height: Scale.superScreenHeight(context) * _bottomSheetHeightFactor,
      draggable: true,
      builder: (context){
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSheetState){


              return BldrsBottomSheet(
                height: Scale.superScreenHeight(context) * _bottomSheetHeightFactor,
                draggable: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SuperVerse(
                      verse: 'Choose Flyer Type',
                      size: 3,
                      weight: VerseWeight.thin,
                      italic: true,
                    ),

                    Container(
                      width: BottomSlider.bottomSheetClearWidth(context),
                      height: BottomSlider.bottomSheetClearHeight(context, _bottomSheetHeightFactor) - superVerseRealHeight(context, 3, 1, null),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          DreamBox(
                            height: 60,
                            width: BottomSlider.bottomSheetClearWidth(context) / 2.2,
                            verse: 'Product Flyer',
                            verseMaxLines: 2,
                            verseScaleFactor: 0.7,
                            color: _flyerType == FlyerType.Product ? Colorz.Yellow255 : Colorz.White20,
                            verseColor: _flyerType == FlyerType.Product ? Colorz.Black230 : Colorz.White255,
                            onTap: (){
                              setSheetState(() {
                                _flyerType = FlyerType.Product;
                              });
                            },
                          ),

                          DreamBox(
                            height: 60,
                            width: BottomSlider.bottomSheetClearWidth(context) / 2.2,
                            verse: 'Equipment Flyer',
                            verseMaxLines: 2,
                            verseScaleFactor: 0.7,
                            color: _flyerType == FlyerType.Equipment ? Colorz.Yellow255 : Colorz.White20,
                            verseColor: _flyerType == FlyerType.Equipment ? Colorz.Black230 : Colorz.White255,
                            onTap: (){
                              setSheetState(() {
                                _flyerType = FlyerType.Equipment;
                              });
                            },
                          ),

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
  Future<bool> _inputsValidator() async {
    bool _inputsAreValid;

    /// when no pictures picked
    if (_assetsAsFiles == null || _assetsAsFiles.length == 0){
      await superDialog(
        context: context,
        boolDialog: false,
        // title: 'No '
        body: 'First, select some pictures',
      );
      _inputsAreValid = false;
    }

    /// when less than 3 pictures selected
    else if (_assetsAsFiles.length < 3){
      await superDialog(
        context: context,
        boolDialog: false,
        // title: 'No '
        body: 'At least 3 pictures are required to publish this flyer',
      );
      _inputsAreValid = false;
    }

    /// when no keywords selected
    else if (_keywords.length == 0){
      /// TASK : add these keywords condition in flyer publish validator
      // await
      _inputsAreValid = true;
    }

    /// when flyerType is not defined
    else if (_flyerType == null){
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

    for (int i = 0; i<_assetsAsFiles.length; i++){

      SlideModel _newSlide = SlideModel(
        slideIndex: i,
        picture: _assetsAsFiles[i],
        headline: _headlinesControllers[i].text,
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
        flyerID: _currentFlyerID, // will be created in createFlyerOps
        // -------------------------
        flyerType: _flyerType,
        flyerState: _flyerState,
        keyWords: _keywords,
        flyerShowsAuthor: _showAuthor,
        flyerURL: _flyerURL,
        flyerZone: _flyerZone,
        // -------------------------
        tinyAuthor: _tinyAuthor,
        tinyBz: _tinyBz,
        // -------------------------
        publishTime: null, // will be overriden in createFlyerOps
        flyerPosition: _flyerPosition,
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
        flyerID: _currentFlyerID,
        // -------------------------
        flyerType: _flyerType,
        flyerState: _flyerState,
        keyWords: _keywords,
        flyerShowsAuthor: _showAuthor,
        flyerURL: _flyerURL,
        flyerZone: _flyerZone,
        // -------------------------
        tinyAuthor: _flyer.tinyAuthor,
        tinyBz: _flyer.tinyBz,
        // -------------------------
        publishTime: _flyer.publishTime,
        flyerPosition: _flyerPosition,
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
      keyWords : _keywords,
      flyerShowsAuthor : _showAuthor,
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
    setState(() {
      _verticalIndex = verticalIndex;
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _triggerKeywordsView() async {

    // setState(() {
    //   _keywordsScrollController = PageController(initialPage: 0, keepPage: true);
    //   _verticalIndex = 0;
    // });

    /// open keywords
    if(_verticalIndex == 0){
      await Sliders.slideTo(_keywordsScrollController, 1);
    }
    /// close keywords
    else {
      await Sliders.slideTo(_keywordsScrollController, 0);
    }

  }
/// ----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);

    // print('draft picture screen');

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    double _panelWidth = _buttonSize + (Ratioz.appBarMargin * 2);

    double _flyerZoneWidth = _screenWidth - _panelWidth - Ratioz.appBarMargin;
    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerZoneWidth);
    double _flyerSizeFactor = Scale.superFlyerSizeFactorByWidth(context, _flyerZoneWidth);

    double _panelHeight = _flyerZoneHeight;

    AuthorModel _author = widget.firstTimer ?
    AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID()) :
    AuthorModel.getAuthorFromBzByAuthorID(_bz, _flyer.tinyAuthor.userID);

    BoxFit _currentPicFit = _picsFits.length == 0 ? null : _picsFits[_currentSlideIndex];

    // ImageSize _originalAssetSize = _assets.length == 0 || _assets == null ? null : ImageSize(
    //   width: _assets[_currentSlideIndex].originalWidth,
    //   height: _assets[_currentSlideIndex].originalHeight,
    // );

// ------------------------------

    double _panelButtonSize = _buttonSize * 0.8;

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        DreamBox(
          height: Ratioz.appBarButtonSize,
          // width: Ratioz.appBarButtonSize * 1.3,
          verse: '122 slides',
          verseItalic: true,
          verseMaxLines: 2,
          verseScaleFactor: 0.5,
          secondLine: 'available',
          secondLineScaleFactor: 0.9,
          verseCentered: false,
          bubble: false,
          color: Colorz.White20,
          onTap: () async {

            await superDialog(
              context: context,
              boolDialog: true,
              title: 'No Slides left',
              body: 'You don\'t have any more slides to add\nWould you wish to get more slides ?',
            );

            },
        ),

        Expanded(child: Container(),),

        PublishButton(
          firstTimer: widget.firstTimer,
          loading: _loading,
          onTap: widget.firstTimer ? _createNewFlyer : _updateExistingFlyer,
        ),

      ],

      layoutWidget:
      ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[

          Stratosphere(),

          /// FLYER & PANEL ZONES
          Container(
            width: _screenWidth,
            height: _panelHeight,
            child: Row(
              children: <Widget>[

                /// PANEL
                Container(
                  width: _panelWidth,
                  height: _panelHeight,
                  alignment: Alignment.center,
                  child: Container(
                    width: _panelWidth - Ratioz.appBarMargin,
                    height: _panelHeight,
                    // padding: EdgeInsets.all(Ratioz.appBarPadding),
                    decoration: BoxDecoration(
                      // borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
                      // color: Colorz.Red125,//Colorz.White10,
                    ),
                    child: ClipRRect(
                      borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
                      child: Column(
                        // shrinkWrap: true,

                        children: <Widget>[

                          /// SHOW AUTHOR
                          DreamBox(
                            height: Ratioz.xxflyerLogoWidth * _flyerZoneWidth,
                            margins: EdgeInsets.symmetric(vertical: (Ratioz.xxflyerHeaderMiniHeight - Ratioz.xxflyerLogoWidth) * _flyerZoneWidth / 2),
                            width: _buttonSize,
                            color: _showAuthor == true ? Colorz.White80 : Colorz.White80,
                            icon: _author.authorPic,
                            underLine: _showAuthor == true ? 'Author Shown' : 'Author Hidden',
                            underLineShadowIsOn: false,
                            underLineColor: _showAuthor == true ? Colorz.White255 : Colorz.White80,
                            corners: Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * _flyerZoneWidth),
                            blackAndWhite: _showAuthor == true ? false : true,
                            bubble: _showAuthor == true ? true : false,
                            onTap: (){
                              setState(() {
                                _showAuthor = !_showAuthor;
                              });
                            },
                          ),

                          /// SPACER
                          Expanded(
                            child: Container(),
                          ),

                          /// ADD IMAGE
                          PanelButton(
                            size: _panelButtonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.Plus,
                            iconSizeFactor: 0.5,
                            verse: 'Add',
                            onTap: () async {
                              print('adding Image');
                              await _getMultiImages(accountType: BzAccountType.Super);
                            },
                          ),

                          /// DELETE IMAGE
                          PanelButton(
                            size: _panelButtonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.XSmall,
                            iconSizeFactor: 0.5,
                            verse: 'Delete',
                            onTap: () async {
                              // widget.onDeleteImage(_currentSlideIndex);

                              await _deleteSlide(
                                // numberOfSlides: _numberOfSlides,
                                // currentSlide: _currentSlideIndex,
                              );

                            },
                          ),

                          PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

                          /// CROP IMAGE
                          PanelButton(
                            size: _panelButtonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.BxDesignsOff,
                            iconSizeFactor: 0.5,
                            verse: 'Crop',
                            onTap: () async {

                              if (_assetsAsFiles.length != 0){
                                await _cropImage(_assetsAsFiles[_currentSlideIndex]);
                              }

                              },
                          ),

                          /// RELOAD
                          PanelButton(
                            size: _panelButtonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            icon:  Iconz.Clock,
                            iconSizeFactor: 0.5,
                            verse: 'Reset',
                            onTap: () async {

                              File _file = await Imagers.getFileFromAsset(_assets[_currentSlideIndex]);
                              setState(() {
                                _assetsAsFiles[_currentSlideIndex] = _file;
                              });

                            },
                          ),

                          PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

                          /// CHANGE SLIDE BOX FIT
                          PanelButton(
                            size: _panelButtonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            verse: 'Fit',
                            icon: _currentPicFit == BoxFit.fitWidth ? Iconz.ArrowRight : _currentPicFit == BoxFit.fitHeight ? Iconz.ArrowUp : Iconz.DashBoard,
                            iconSizeFactor: 0.35,
                            isAuthorButton: false,
                            onTap: (){

                              if(_currentPicFit == BoxFit.fitWidth) {
                                setState(() {
                                  _picsFits[_currentSlideIndex] = BoxFit.fitHeight;
                                });
                              }

                              else {
                                setState(() {
                                  _picsFits[_currentSlideIndex] = BoxFit.fitWidth;
                                });
                              }

                              // else {
                              //   setState(() {
                              //     _picsFits[_currentSlideIndex] = BoxFit.fitWidth;
                              //   });
                              // }

                              // print('fit is : ${_picsFits[currentSlide]}');

                            },
                          ),

                          PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

                          /// TRIGGER KEYWORDS
                          PanelButton(
                            size: _panelButtonSize,
                            flyerZoneWidth: _flyerZoneWidth,
                            verse: 'Tags',
                            icon: Iconz.DvBlackHole,
                            iconSizeFactor: 1,
                            isAuthorButton: false,
                            onTap: _triggerKeywordsView,
                          ),

                          /// BOTTOM SPACING
                          // SizedBox(
                          //   //Ratioz.xxflyerBottomCorners * _flyerZoneWidth - Ratioz.appBarPadding,
                          //   height: Scale.superFlyerFooterHeight(_flyerZoneWidth),
                          // ),

                        ],
                      ),
                    ),
                  ),
                ),

                /// FLYER
                Container(
                  width: _flyerZoneWidth,
                  height: _flyerZoneHeight,
                  decoration: BoxDecoration(
                    color: Colorz.White10,
                    borderRadius: Borderers.superFlyerCorners(context, _flyerZoneWidth),
                  ),
                  child: ClipRRect(
                    borderRadius: Borderers.superFlyerCorners(context, _flyerZoneWidth),
                    child: Stack(
                      children: <Widget>[

                        PageView(
                          pageSnapping: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          allowImplicitScrolling: true,
                          onPageChanged: (i) => _onVerticalIndexChanged(i),
                          controller: _keywordsScrollController,
                          children: <Widget>[

                            /// PAGES & ANKH
                            Stack(
                              children: <Widget>[

                                /// SLIDES
                                if(_currentSlideIndex != null)
                                  PageView(
                                    pageSnapping: true,
                                    controller: _pageController,
                                    physics: BouncingScrollPhysics(),
                                    allowImplicitScrolling: false,
                                    clipBehavior: Clip.antiAlias,
                                    restorationId: '${widget.draftFlyerModel.key.value}',
                                    onPageChanged: onPageChangedIsOn ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      ..._buildSlides(),
                                    ],
                                  ),

                                /// ANKH
                                if(_currentSlideIndex != null)
                                  AnkhButton(
                                    microMode: false,
                                    bzPageIsOn: false,
                                    flyerZoneWidth: _flyerZoneWidth,
                                    slidingIsOn: true,
                                    ankhIsOn: false,
                                    tappingAnkh: (){
                                      Nav.goToNewScreen(context,
                                          OldFlyerEditorScreen(
                                            bzModel: widget.bzModel,
                                            firstTimer: true,
                                            flyerModel: null,
                                          )
                                      );
                                    },
                                  ),

                              ],
                            ),

                            /// KEYWORDS
                            Container(
                              width: _flyerZoneWidth,
                              height: _flyerZoneHeight * 0.5,
                              color: Colorz.BloodTest,
                            ),

                          ],
                        ),


                        /// FLYER HEADER
                        AbsorbPointer(
                          absorbing: true,
                          child: Header(
                            tinyBz: TinyBz.getTinyBzFromBzModel(_bz),
                            tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(_author),
                            flyerShowsAuthor: _showAuthor,
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
                        if(_numberOfStrips != 0 && _currentSlideIndex != null)
                          ProgressBar(
                            flyerZoneWidth: _flyerZoneWidth,
                            numberOfStrips: _numberOfStrips,
                            slideIndex: _currentSlideIndex,
                            swipeDirection: _swipeDirection,
                          ),


                      ],


                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
