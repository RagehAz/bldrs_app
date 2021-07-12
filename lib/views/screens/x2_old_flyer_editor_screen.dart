import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/flyer_sliders.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keys_set.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_sheet.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 's50_flyer_on_map.dart';

enum SlidingDirection{
  next,
  back,
  freeze,
}

class OldFlyerEditorScreen extends StatefulWidget {
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  OldFlyerEditorScreen({
    @required this.bzModel,
    this.firstTimer = false,
    this.flyerModel,
});

  @override
  _OldFlyerEditorScreenState createState() => _OldFlyerEditorScreenState();
}

class _OldFlyerEditorScreenState extends State<OldFlyerEditorScreen> {
  FlyersProvider _prof;
  CountryProvider _countryPro;
  BzModel _bz;
  FlyerModel _flyer;
  FlyerModel _originalFlyer;
  // -------------------------
  int _currentSlideIndex;
  // --------------------
  List<TextEditingController> _titleControllers;
  File _storedImage;
  File _pickedImage;
  // GeoPoint _pickedLocation;
  PageController _slidingController;
  int numberOfSlides;
  List<bool> _slidesVisibility;
  bool onPageChangedIsOn;
  List<SlideMode> slidesModes;
  // -------------------------
  String _currentFlyerID;
  // -------------------------
  FlyerType _currentFlyerType;
  FlyerState _currentFlyerState;
  List<dynamic> _currentKeywords;
  bool _currentFlyerShowsAuthor;
  String _currentFlyerURL; // no need for this
  Zone _currentFlyerZone;
  // -------------------------
  String _currentAuthorID;
  String _currentBzID;
  // -------------------------
  DateTime _currentPublishTime;
  GeoPoint _currentFlyerPosition;
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
  @override
  void initState(){
    // -------------------------
    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _countryPro = Provider.of<CountryProvider>(context, listen: false);
    _originalFlyer = widget.firstTimer ? null : widget.flyerModel.clone();
    _bz = widget.bzModel;
    _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel.clone();
    // -------------------------
    _currentFlyerID = _flyer.flyerID;
    // -------------------------
    _currentFlyerType = _flyer.flyerType;
    _currentFlyerState = _flyer.flyerState;
    _currentKeywords = _flyer.keyWords;
    _currentFlyerShowsAuthor = _flyer.flyerShowsAuthor;
    _currentFlyerURL = _flyer.flyerURL; // no need for this
    _currentFlyerZone = _flyer.flyerZone;
    // -------------------------
    _currentAuthorID = _flyer.tinyAuthor.userID;
    _currentBzID = _flyer.tinyBz.bzID;
    // -------------------------
    _currentPublishTime = _flyer.publishTime;
    _currentFlyerPosition = _flyer.flyerPosition;
    // -------------------------
    _currentSlides = _flyer.slides;
    // -------------------------
    _slidesVisibility = widget.firstTimer == true ? new List() : _createSlidesVisibilityList();
    slidesModes = widget.firstTimer == true ? new List() : _createSlidesModesList();
    _titleControllers = widget.firstTimer == true ? new List() : _createTitlesControllersList();
    // -------------------------
    numberOfSlides = _currentSlides.length;
    _currentSlideIndex = 0;
    _slidingController = PageController(initialPage: 0,);
    onPageChangedIsOn = true;
    super.initState();
  }
// -----------------------------------------------------------------------------
  // @override
  // void dispose() {
  //   if (textControllerHasNoValue(_nameController))_nameController.dispose();
  //   super.dispose();
  // }
// -----------------------------------------------------------------------------
  List<TextEditingController> _createTitlesControllersList(){
    List<TextEditingController> _controllers = new List();

    _originalFlyer.slides.forEach((slide) {
      TextEditingController _controller = new TextEditingController();
      _controller.text = slide.headline;
      _controllers.add(_controller);
    });

    return _controllers;
  }
// -----------------------------------------------------------------------------
  List<SlideMode> _createSlidesModesList(){
    int _listLength = _originalFlyer.slides.length;
    List<SlideMode> _slidesModesList = new List();

    for (int i = 0; i<_listLength; i++){
      _slidesModesList.add(SlideMode.Editor);
    }

    return _slidesModesList;
  }
// -----------------------------------------------------------------------------
  List<bool> _createSlidesVisibilityList(){
    int _listLength = _originalFlyer.slides.length;
    List<bool> _visibilityList = new List();

    for (int i = 0; i<_listLength; i++){
      _visibilityList.add(true);
    }

    return _visibilityList;
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
      keyWords : new List(),
      flyerShowsAuthor : true,
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
// -----------------------------------------------------------------------------
  void _triggerVisibility(int currentSlide)  {
    setState(() {
      _slidesVisibility[currentSlide] = !_slidesVisibility[currentSlide];
    });
  }
// -----------------------------------------------------------------------------
  void _decreaseProgressBar(){
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _decreaseProgressBar');
    setState(() {
      numberOfSlides > 0 ?
      numberOfSlides = numberOfSlides - 1 : print('can not decrease progressBar');
    });
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _decreaseProgressBar');
  }
// -----------------------------------------------------------------------------
  void _simpleDelete(int currentSlide){
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _simpleDelete');
    if (_currentSlides.isNotEmpty)
    {
      if(currentSlide == 0){
        _currentSlides.removeAt(currentSlide);
        // currentSlide=0;
      }else{_currentSlides.removeAt(currentSlide);}
      _slidesVisibility.removeAt(currentSlide);
      slidesModes.removeAt(currentSlide);
      _titleControllers.removeAt(currentSlide);
    } else { print('no Slide to delete'); }
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _simpleDelete');
  }
// -----------------------------------------------------------------------------
  void _currentSlideMinus(){
    if (_currentSlideIndex == 0){_currentSlideIndex = 0;}
    else {
      setState(() {
        _currentSlideIndex = _currentSlideIndex - 1;
      });
    }
  }
// -----------------------------------------------------------------------------
  void _deleteSlide (int numberOfSlides, int currentSlide) {
    if (_currentSlides.isNotEmpty)
    {
      _decreaseProgressBar();
      // onPageChangedIsOn = false;
      _triggerVisibility(currentSlide);
      Future.delayed(Ratioz.fadingDuration, (){
        slidingAction(_slidingController, numberOfSlides, currentSlide);
      });
      _currentSlideMinus();
      numberOfSlides <= 1 ?
      _simpleDelete(currentSlide) :
      Future.delayed(
          Ratioz.slidingAndFadingDuration,
              (){
            if(currentSlide == 0){_simpleDelete(currentSlide);snapTo(_slidingController, 0);}
            else{_simpleDelete(currentSlide);}
            setState(() {
              // onPageChangedIsOn = true;
              // numberOfSlides = _currentSlides.length;
            });
          }
      );
      // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _deleteSlide ------------ last shit');
    }
    else
    {print('no slide to delete');}
  }
// -----------------------------------------------------------------------------
  void _selectImage(File pickedImage){_pickedImage = pickedImage;}
// -----------------------------------------------------------------------------
  // Future<void> _takeCameraPicture() async {
  //
  //   final _imageFile = await takeCameraPicture(PicType.slideHighRes);
  //
  //   setState(() {
  //     _storedImage = File(_imageFile.path);
  //     _currentSlides.add(
  //         SlideModel(
  //           slideIndex: 0,
  //           picture: _storedImage,
  //           headline: _titleControllers[_currentSlides.length].text,
  //         ));
  //     currentSlide = _currentSlides.length - 1;
  //     numberOfSlides = _currentSlides.length;
  //     _slidesVisibility.add(true);
  //     slidesModes.add(SlideMode.Editor);
  //     _titleControllers.add(TextEditingController());
  //     onPageChangedIsOn = true;
  //   });
  //
  //   final appDir = await sysPaths.getApplicationDocumentsDirectory();
  //   final fileName = path.basename(_imageFile.path);
  //   final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
  //   _selectImage(savedImage);
  //   slideTo(_slidingController, currentSlide);
  //   // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _takeCameraPicture');
  // }
// -----------------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {

    final _imageFile = await takeGalleryPicture(PicType.slideHighRes);

    setState(() {
      _storedImage = _imageFile;
      _currentSlides.add(
          new SlideModel(
            slideIndex: _currentSlides.length,
            picture: _storedImage,
            headline: '',
            description: '',
            savesCount: 0,
            viewsCount: 0,
            sharesCount: 0,
          ));
      _currentSlideIndex = _currentSlides.length - 1;
      numberOfSlides = _currentSlides.length;
      _slidesVisibility.add(true);
      slidesModes.add(SlideMode.Editor);
      _titleControllers.add(TextEditingController());
      onPageChangedIsOn = true;
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    _selectImage(savedImage);
    slideTo(_slidingController, _currentSlideIndex);
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _takeGalleryPicture');
  }
// -----------------------------------------------------------------------------
  /// SLIDING BLOCK
  /// usage :  onPageChanged: (i) => _onPageChanged(i),
  bool _slidingNext;
  void _onPageChanged (int newIndex){
    _slidingNext = Animators.slidingNext(newIndex: newIndex, currentIndex: _currentSlideIndex,);
    setState(() {_currentSlideIndex = newIndex;})
    ;}
// -----------------------------------------------------------------------------
  // void tappingNewSlide(){
  //   setState(() {
  //     _currentSlides.add(SlideModel(
  //       slideIndex: _currentSlides.length,
  //       picture:  null,
  //       headline: '',
  //     ));
  //     currentSlide = _currentSlides.length - 1;
  //     numberOfSlides = _currentSlides.length;
  //     _slidingController.animateToPage(currentSlide, duration: Duration(milliseconds: 750), curve: Curves.easeInOutCirc);
  //     _slidesVisibility.add(true);
  //     slidesModes.add(SlideMode.Editor);
  //   });
  //   }
// -----------------------------------------------------------------------------
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
      _currentFlyerPosition = GeoPoint(lat, lng);
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _newLocationSlide() async {

    if (_currentSlides.length == 0){

      await superDialog(
          context: context,
          title: '',
        body: 'Add at least one Picture Slide First',
          boolDialog: false,
      );


    } else if (_currentFlyerPosition == null){

      setState(() {
        _currentSlides.add(
            SlideModel(
              slideIndex: _currentSlides.length,
              picture: _mapPreviewImageUrl,
              headline: _titleControllers[_currentSlides.length].text,
            ));
        _currentSlideIndex = _currentSlides.length - 1;
        numberOfSlides = _currentSlides.length;
        _slidesVisibility.add(true);
        slidesModes.add(SlideMode.Map);
        _titleControllers.add(TextEditingController());
        onPageChangedIsOn = true;
      });
      slideTo(_slidingController, _currentSlideIndex);

    } else {

    }

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
                              words: _currentKeywords,
                              selectedWords: _currentKeywords,
                              onTap: (value){
                                setSheetState(() {
                                  _currentKeywords.remove(value);
                                });
                              },
                            ),

                            WordsBubble(
                              verseSize: 1,
                              bubbles: true,
                              title: 'Space Type',
                              words: ['1', '2', '3'],
                              selectedWords: _currentKeywords,
                              onTap: (value){
                                setSheetState(() {
                                  _currentKeywords.add(value);
                                });
                              },
                            ),

                            WordsBubble(
                              verseSize: 1,
                              bubbles: true,
                              title: 'Product Use',
                              words: ['1', '2', '3'],
                              selectedWords: _currentKeywords,
                              onTap: (value){setSheetState(() {_currentKeywords.add(value);});},
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
  void _selectFlyerType(){

    double _bottomSheetHeightFactor = 0.25;

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
                            color: _currentFlyerType == FlyerType.Product ? Colorz.Yellow255 : Colorz.White20,
                            verseColor: _currentFlyerType == FlyerType.Product ? Colorz.Black230 : Colorz.White225,
                            onTap: (){
                              setSheetState(() {
                                _currentFlyerType = FlyerType.Product;
                              });
                            },
                          ),

                          DreamBox(
                            height: 60,
                            width: BottomSlider.bottomSheetClearWidth(context) / 2.2,
                            verse: 'Equipment Flyer',
                            verseMaxLines: 2,
                            verseScaleFactor: 0.7,
                            color: _currentFlyerType == FlyerType.Equipment ? Colorz.Yellow255 : Colorz.White20,
                            verseColor: _currentFlyerType == FlyerType.Equipment ? Colorz.Black230 : Colorz.White225,
                            onTap: (){
                              setSheetState(() {
                                _currentFlyerType = FlyerType.Equipment;
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
  bool _inputsAreValid(){
    /// TASK : assert that flyer.slide.lenght >= 5 slides only for default accounts, >= 15 for premium
    /// TASK : figure out flyer required fields needed for validity assertion
    return true;
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  Future<void> _createNewFlyer() async {
    /// assert that all required fields are valid
    if (_inputsAreValid() == false){
      // show something for user to know

      await superDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
        boolDialog: false,
      );

    } else {

      _triggerLoading();

      /// create slides models
      List<SlideModel> _slides = await _processNewSlides(_currentSlides, _titleControllers);

      /// create tiny author model from bz.authors
      AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID());
      TinyUser _tinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(_author);

      ///create FlyerModel
      FlyerModel _newFlyerModel = FlyerModel(
        flyerID: _currentFlyerID, // will be created in creatFlyerOps
        // -------------------------
        flyerType: _currentFlyerType,
        flyerState: _currentFlyerState,
        keyWords: _currentKeywords,
        flyerShowsAuthor: _currentFlyerShowsAuthor,
        flyerURL: _currentFlyerURL,
        flyerZone: _currentFlyerZone,
        // -------------------------
        tinyAuthor: _tinyAuthor,
        tinyBz: TinyBz(
          bzID: _currentBzID,
          bzLogo: widget.bzModel.bzLogo,
          bzName: widget.bzModel.bzName,
          bzType: widget.bzModel.bzType,
          bzZone: widget.bzModel.bzZone,
          bzTotalFollowers: widget.bzModel.bzTotalFollowers,
          bzTotalFlyers: widget.bzModel.nanoFlyers.length,
        ),
        // -------------------------
        publishTime: _currentPublishTime,
        flyerPosition: _currentFlyerPosition,
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

      /// add the result final Tinyflyer to local list and notifyListeners
      _prof.addTinyFlyerToLocalList(TinyFlyer.getTinyFlyerFromFlyerModel(_uploadedFlyerModel));

      _triggerLoading();

      await superDialog(
        context: context,
        title: 'Great !',
        body: 'Flyer has been created',
        boolDialog: false,
      );


      Nav.goBack(context);

    }
  }
// -----------------------------------------------------------------------------
  Future<void> _updateExistingFlyer() async {
    /// assert that all required fields are valid
    if (_inputsAreValid() == false){
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
      List<SlideModel> _slides = await _processNewSlides(_currentSlides, _titleControllers);

      print('B- Modifying flyer');

      ///create updated FlyerModel
      FlyerModel _updatedFlyerModel = FlyerModel(
        flyerID: _currentFlyerID,
        // -------------------------
        flyerType: _currentFlyerType,
        flyerState: _currentFlyerState,
        keyWords: _currentKeywords,
        flyerShowsAuthor: _currentFlyerShowsAuthor,
        flyerURL: _currentFlyerURL,
        flyerZone: _currentFlyerZone,
        // -------------------------
        tinyAuthor: _flyer.tinyAuthor,
        tinyBz: _flyer.tinyBz,
        // -------------------------
        publishTime: _currentPublishTime,
        flyerPosition: _currentFlyerPosition,
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
      FlyerModel _uploadedFlyerModel = await FlyerOps().updateFlyerOps(
          context: context,
          updatedFlyer: _updatedFlyerModel,
          originalFlyer: _originalFlyer,
          bzModel : _bz,
      );

      print('D- Uploading to cloud');

      /// add the result final Tinyflyer to local list and notifyListeners
      _prof.replaceTinyFlyerInLocalList(TinyFlyer.getTinyFlyerFromFlyerModel(_uploadedFlyerModel));

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
  @override
  Widget build(BuildContext context) {
    final AuthorModel _author = widget.firstTimer ?
    AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID()) :
    AuthorModel.getAuthorFromBzByAuthorID(_bz, _flyer.tinyAuthor.userID);
// -----------------------------------------------------------------------------
    final double _flyerSizeFactor = 0.8;
    final double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
// -----------------------------------------------------------------------------
    print('_pickedImage : $_pickedImage');
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> building widget tree');
// -----------------------------------------------------------------------------
    Widget _fButton({String icon, Function function}){
      return
          DreamBox(
            width: _flyerZoneWidth * 0.15,
            height: _flyerZoneWidth * 0.15,
            icon: icon,
            iconSizeFactor: 0.6,
            bubble: true,
            onTap: function,
          );
    }
// -----------------------------------------------------------------------------
    Widget _publishButton(){
      return
        DreamBox(
          height: 35,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          verse: widget.firstTimer ? 'Publish flyer' : 'update flyer',
          verseColor: Colorz.Black230,
          verseScaleFactor: 0.8,
          color: Colorz.Yellow255,
          icon: Iconz.AddFlyer,
          iconSizeFactor: 0.6,
          onTap: widget.firstTimer ? _createNewFlyer : _updateExistingFlyer,
        );
    }
// -----------------------------------------------------------------------------
    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      // appBarBackButton: true,
      sky: Sky.Black,
      pageTitle: !_loading ? 'Create a New Flyer' : 'Waiting ...',
      loading: _loading,
      tappingRageh: () async {
        _triggerLoading();

        print(_flyer.flyerID);

      },

      appBarRowWidgets: <Widget>[

        SuperVerse(
          verse: _currentFlyerZone.cipherToString(),
          size: 0,
          scaleFactor: 0.7,
        ),

        Expanded(child: Container(),),

        _publishButton(),

      ],
      layoutWidget: Stack(
        children: <Widget>[

          Column(
            // alignment: Alignment.topCenter,
            children: <Widget>[

              Stratosphere(),

              Stack(
                children: <Widget>[

                  FlyerZone(
                    flyerSizeFactor: _flyerSizeFactor,
                    tappingFlyerZone: (){},
                    stackWidgets: <Widget>[

                      // --- SLIDES
                      PageView.builder(
                        controller: _slidingController,
                        itemCount: _currentSlides.length,
                        onPageChanged: onPageChangedIsOn ? (i) => _onPageChanged(i) : zombie,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (ctx, index) =>
                            AnimatedOpacity(
                              key: ObjectKey(_currentSlides[index].picture),
                              opacity: _slidesVisibility[index] == true ? 1 : 0,
                              duration: Duration(milliseconds: 100),
                              child: SingleSlide(
                                flyerZoneWidth: _flyerZoneWidth,
                                flyerID: _flyer.flyerID,
                                picture: _currentSlides[index].picture,
                                slideMode: slidesModes[index],
                                boxFit: BoxFit.fitWidth, // [fitWidth - contain - scaleDown] have the blur background
                                titleController: _titleControllers[index],
                                textFieldOnChanged: (text){
                                  print('text is : $text');
                                },
                              ),
                            ),
                      ),

                      // --- FLYER HEADER
                      Header(
                        tinyBz: TinyBz.getTinyBzFromBzModel(_bz),
                        tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(_author),
                        flyerShowsAuthor: true,
                        followIsOn: false,
                        flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
                        bzPageIsOn: false,
                        tappingHeader: (){},
                        onFollowTap: (){},
                        onCallTap: (){},
                      ),

                      // --- PROGRESS BAR
                      ProgressBar(
                        flyerZoneWidth: _flyerZoneWidth,
                        numberOfSlides: numberOfSlides,
                        currentSlide: _currentSlideIndex,
                        slidingNext: _slidingNext,
                      ),

                    ],
                  ),

                  // --- FLYER EDITING BUTTONS
                  Positioned(
                    right: ((1-_flyerSizeFactor)/2)*Scale.superScreenWidth(context) - ((_flyerZoneWidth * 0.15/2)),
                    bottom: Scale.superScreenHeightWithoutSafeArea(context) * 0.07,
                    child: Column(
                      children: <Widget>[

                        _fButton(icon: Iconz.Info, function: _addKeywords),

                        /// --- FLYER TYPE TEMP
                        if(_bz.bzType == BzType.Manufacturer || _bz.bzType == BzType.Supplier)
                        _fButton(icon: Iconz.Flyer, function: _selectFlyerType,),

                        /// --- NEW SLIDE FROM GALLERY
                        _fButton(
                          icon: Iconz.PhoneGallery,
                          function: _takeGalleryPicture,
                        ),

                        /// PHASE 2 ISA
                        /// // --- NEW SLIDE FROM CAMERA
                        // _fButton(
                        //   icon: Iconz.Camera,
                        //   function: _takeCameraPicture,
                        // ),


                        /// --- OPEN MAP SCREEN
                        _fButton(
                          icon: Iconz.LocationPin,
                          function: _selectOnMap,
                        ),

                        /// --- DELETE SLIDE
                         _fButton(
                          icon: Iconz.XLarge,
                          function: () => _deleteSlide(numberOfSlides, _currentSlideIndex),
                        ),

                      ],
                    ),
                  ),

                ],
              ),

            ],
          ),

        ],
      ),
    );
  }
}

