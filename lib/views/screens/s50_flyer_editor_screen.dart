import 'dart:io';
import 'package:bldrs/controllers/drafters/flyer_sliders.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flyer_keyz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/flyer_ops.dart';
import 'package:bldrs/firestore/firebase_storage.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
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

class FlyerEditorScreen extends StatefulWidget {
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  FlyerEditorScreen({
    @required this.bzModel,
    this.firstTimer = false,
    this.flyerModel,
});

  @override
  _FlyerEditorScreenState createState() => _FlyerEditorScreenState();
}

class _FlyerEditorScreenState extends State<FlyerEditorScreen> {
  FlyersProvider _prof;
  BzModel _bz;
  FlyerModel _flyer;
  // -------------------------
  int currentSlide;
  // --------------------
  List<TextEditingController> _titleControllers;
  File _storedImage;
  File _pickedImage;
  // GeoPoint _pickedLocation;
  PageController slidingController;
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
  // ----------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
  // ----------------------------------------------------------------------
  @override
  void initState(){
    // -------------------------
    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _bz = widget.bzModel;
    _flyer = widget.firstTimer ? _createTempEmptyFlyer() : widget.flyerModel;
    // -------------------------
    _currentFlyerID = _flyer.flyerID;
    // -------------------------
    _currentFlyerType = _flyer.flyerType;

    _currentFlyerState = _flyer.flyerState;
    _currentKeywords = _flyer.keyWords;
    _currentFlyerShowsAuthor = _flyer.flyerShowsAuthor;
    _currentFlyerURL = _flyer.flyerURL; // no need for this
    // -------------------------
    _currentAuthorID = _flyer.tinyAuthor.userID;
    _currentBzID = _flyer.tinyBz.bzID;
    // -------------------------
    _currentPublishTime = _flyer.publishTime;
    _currentFlyerPosition = _flyer.flyerPosition;
    // -------------------------
    _currentSlides = _flyer.slides;
    // -------------------------
    _slidesVisibility = new List();
    slidesModes = new List();
    _titleControllers = new List();
    numberOfSlides = _currentSlides.length;
    currentSlide = 0;
    slidingController = PageController(initialPage: 0,);
    onPageChangedIsOn = true;
    super.initState();
  }
  // ----------------------------------------------------------------------
  // @override
  // void dispose() {
  //   if (textControllerHasNoValue(_nameController))_nameController.dispose();
  //   super.dispose();
  // }
  // ----------------------------------------------------------------------
  FlyerModel _createTempEmptyFlyer(){

    AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID());
    TinyUser _tinyAuthor = AuthorModel.getTinyAuthorFromAuthorModel(_author);

    return new FlyerModel(
    flyerID : '...',
    // -------------------------
    flyerType : FlyerModel.concludeFlyerType(_bz.bzType),
    flyerState : FlyerState.Draft,
    keyWords : new List(),
    flyerShowsAuthor : true,
    flyerURL : '...',
    // -------------------------
    tinyAuthor : _tinyAuthor,
    tinyBz : TinyBz(bzID: _bz.bzID, bzLogo: _bz.bzLogo, bzName: _bz.bzName, bzType: _bz.bzType, bzZone: Zone.getZoneFromBzModel(_bz), bzTotalFollowers: _bz.bzTotalFollowers, bzTotalFlyers: _bz.bzFlyers.length),
    // -------------------------
    publishTime : DateTime.now(),
    flyerPosition : null,
    // -------------------------
    ankhIsOn : false,
    // -------------------------
    slides : new List(),
    );
  }
  // ----------------------------------------------------------------------
  void _triggerVisibility(int currentSlide)  {
    setState(() {
      _slidesVisibility[currentSlide] = !_slidesVisibility[currentSlide];
    });
  }
  // ----------------------------------------------------------------------
  void _decreaseProgressBar(){
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _decreaseProgressBar');
    setState(() {
      numberOfSlides > 0 ?
      numberOfSlides = numberOfSlides - 1 : print('can not decrease progressBar');
    });
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _decreaseProgressBar');
  }
  // ----------------------------------------------------------------------
  void _simpleDelete(int currentSlide){
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _simpleDelete');
    if (_currentSlides.isNotEmpty)
    {
      if(currentSlide == 0){_currentSlides.removeAt(currentSlide);currentSlide=0;}else{_currentSlides.removeAt(currentSlide);}
      _slidesVisibility.removeAt(currentSlide);
      slidesModes.removeAt(currentSlide);
      _titleControllers.removeAt(currentSlide);
    } else { print('no Slide to delete'); }
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _simpleDelete');
  }
  // ----------------------------------------------------------------------
  void _currentSlideMinus(){
    if (currentSlide == 0){currentSlide = 0;}
    else {
      setState(() {
        currentSlide = currentSlide - 1;
      });
    }
  }
  // ----------------------------------------------------------------------
  void _deleteSlide (int numberOfSlides, int currentSlide) {
    if (_currentSlides.isNotEmpty)
    {
      _decreaseProgressBar();
      onPageChangedIsOn = false;
      _triggerVisibility(currentSlide);
      Future.delayed(Ratioz.fadingDuration, (){
        slidingAction(slidingController, numberOfSlides, currentSlide);
      });
      _currentSlideMinus();
      numberOfSlides <= 1 ?
      _simpleDelete(currentSlide) :
      Future.delayed(
          Ratioz.slidingAndFadingDuration,
              (){
            if(currentSlide == 0){_simpleDelete(currentSlide);snapTo(slidingController, 0);}
            else{_simpleDelete(currentSlide);}
            setState(() {
              onPageChangedIsOn = true;
              numberOfSlides = _currentSlides.length;
            });
          }
      );
      // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _deleteSlide ------------ last shit');
    }
    else
    {print('no slide to delete');}
  }
  // ----------------------------------------------------------------------
  void _selectImage(File pickedImage){_pickedImage = pickedImage;}
  // ----------------------------------------------------------------------
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
  //   slideTo(slidingController, currentSlide);
  //   // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _takeCameraPicture');
  // }
  // ----------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {

    final _imageFile = await takeGalleryPicture(PicType.slideHighRes);

    setState(() {
      _storedImage = File(_imageFile?.path);
      _currentSlides.add(
          SlideModel(
            slideIndex: _currentSlides.length,
            picture: _storedImage,
            headline: '',
          ));
      currentSlide = _currentSlides.length - 1;
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
    slideTo(slidingController, currentSlide);
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _takeGalleryPicture');
  }
  // ----------------------------------------------------------------------
  void slidingPages (int slideIndex){setState(() {currentSlide = slideIndex;});}
  // ----------------------------------------------------------------------
  // void tappingNewSlide(){
  //   setState(() {
  //     _currentSlides.add(SlideModel(
  //       slideIndex: _currentSlides.length,
  //       picture:  null,
  //       headline: '',
  //     ));
  //     currentSlide = _currentSlides.length - 1;
  //     numberOfSlides = _currentSlides.length;
  //     slidingController.animateToPage(currentSlide, duration: Duration(milliseconds: 750), curve: Curves.easeInOutCirc);
  //     _slidesVisibility.add(true);
  //     slidesModes.add(SlideMode.Editor);
  //   });
  //   }
  // ----------------------------------------------------------------------
  Future<void>_selectOnMap() async {

    if (_currentSlides.length == 0){
      superDialog(context, 'Map Slide Can not be The First Slide', '');
    } else {
      final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
          MaterialPageRoute(
              builder: (ctx) =>
                  GoogleMapScreen(
                    isSelecting: true,
                    flyerZoneWidth: superFlyerZoneWidth(context, 0.8),
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
  // ----------------------------------------------------------------------
  void _showMapPreview(double lat, double lng) {
    final staticMapImageUrl = getStaticMapImage(context, lat, lng);
    setState(() {
      _mapPreviewImageUrl = staticMapImageUrl;
      _currentFlyerPosition = GeoPoint(lat, lng);
    });
  }
  // ----------------------------------------------------------------------
  void _newLocationSlide(){

    if (_currentSlides.length == 0){
      superDialog(context, 'Add at least one Picture Slide First', '');
    } else if (_currentFlyerPosition == null){

      setState(() {
        _currentSlides.add(
            SlideModel(
              slideIndex: _currentSlides.length,
              picture: _mapPreviewImageUrl,
              headline: _titleControllers[_currentSlides.length].text,
            ));
        currentSlide = _currentSlides.length - 1;
        numberOfSlides = _currentSlides.length;
        _slidesVisibility.add(true);
        slidesModes.add(SlideMode.Map);
        _titleControllers.add(TextEditingController());
        onPageChangedIsOn = true;
      });
      slideTo(slidingController, currentSlide);

    } else {

    }

  }
  // ----------------------------------------------------------------------
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
  // ----------------------------------------------------------------------
  Future<void> _publishFlyer() async {

    /// TASK : assert that flyer.slide.lenght >= 5 slides only for default accounts, >= 15 for premium

    print('Starting to publish');

    if(numberOfSlides == 0) {
      superDialog(context, 'You have to add some slides first', '');
    } else if (_currentKeywords.length == 0) {
      _addKeywords();
    } else if (_currentFlyerType == null){
      superDialog(context, 'You have to choose flyer type', '');
    } else {

      _triggerLoading();

      await tryAndCatch(
        context: context,
        functions: () async {
          /// 1 - save a flyer document on firestore to get its auto generated
          /// flyerID if creating a new flyer
          if(widget.firstTimer){
            // _currentFlyerID = await FlyerCRUD().createFlyerOps();
          }
          /// 2 - create slides to store on firebase, and save each pic file to
          /// firebase storage and get its url to save to firestore
          List<String> _picturesURLs = await savePicturesToFireStorageAndGetListOfURL(context, _currentSlides, _currentFlyerID);
          List<SlideModel> _slides = await processSlides(_picturesURLs, _currentSlides, _titleControllers);

          /// create tiny author model from bz.authors
          AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID());
          TinyUser _tinyAuthor = AuthorModel.getTinyAuthorFromAuthorModel(_author);

          /// 3 - create FlyerModel
          FlyerModel _newFlyerModel = FlyerModel(
              flyerID: _currentFlyerID,
              // -------------------------
              flyerType: _currentFlyerType,
              flyerState: _currentFlyerState,
              keyWords: _currentKeywords,
              flyerShowsAuthor: _currentFlyerShowsAuthor,
              flyerURL: _currentFlyerURL,
              // -------------------------
              tinyAuthor: _tinyAuthor,
              tinyBz: TinyBz(
                bzID: _currentBzID,
                bzLogo: widget.bzModel.bzLogo,
                bzName: widget.bzModel.bzName,
                bzType: widget.bzModel.bzType,
                bzZone: Zone.getZoneFromBzModel(widget.bzModel),
                bzTotalFollowers: widget.bzModel.bzTotalFollowers,
                bzTotalFlyers: widget.bzModel.bzFlyers.length,
              ),
              // -------------------------
              publishTime: _currentPublishTime,
              flyerPosition: _currentFlyerPosition,
              // -------------------------
              ankhIsOn: false, // shouldn't be saved here but will leave this now
              // -------------------------
              slides: _slides,
          );
          /// 4- update flyer doc on firestore
          await FlyerCRUD().updateFlyerDoc(_newFlyerModel);

          /// 6- save flyer to local flyers List
          _prof.addFlyerModelToLocalList(_newFlyerModel);

          superDialog(context, 'Flyer Published', '');
          _triggerLoading();
          print('flyer publishing ended');

        },
      );

    }

  }
  // ----------------------------------------------------------------------
  void _addKeywords(){

      double _bottomSheetHeightFactor = 0.7;

      slideStatefulBottomSheet(
        context: context,
        height: superScreenHeight(context) * _bottomSheetHeightFactor,
        draggable: true,
        builder: (context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setSheetState){
                return BldrsBottomSheet(
                  height: superScreenHeight(context) * _bottomSheetHeightFactor,
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
                        width: bottomSheetClearWidth(context),
                        height: bottomSheetClearHeight(context, _bottomSheetHeightFactor) - superVerseRealHeight(context, 3, 1, null),
                        child: ListView(
                          // key: UniqueKey(),

                          children: <Widget>[

                            SizedBox(
                              height: Ratioz.ddAppBarPadding,
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
                              words: Keywordz.spaceType,
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
                              words: Keywordz.productUse,
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
  // ----------------------------------------------------------------------
  void _selectFlyerType(){

    double _bottomSheetHeightFactor = 0.25;

    slideStatefulBottomSheet(
      context: context,
      height: superScreenHeight(context) * _bottomSheetHeightFactor,
      draggable: true,
      builder: (context){
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSheetState){


              return BldrsBottomSheet(
                height: superScreenHeight(context) * _bottomSheetHeightFactor,
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
                      width: bottomSheetClearWidth(context),
                      height: bottomSheetClearHeight(context, _bottomSheetHeightFactor) - superVerseRealHeight(context, 3, 1, null),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          DreamBox(
                            height: 60,
                            width: bottomSheetClearWidth(context) / 2.2,
                            verse: 'Product Flyer',
                            verseMaxLines: 2,
                            verseScaleFactor: 0.7,
                            color: _currentFlyerType == FlyerType.Product ? Colorz.Yellow : Colorz.WhiteGlass,
                            verseColor: _currentFlyerType == FlyerType.Product ? Colorz.BlackBlack : Colorz.White,
                            boxFunction: (){
                              setSheetState(() {
                                _currentFlyerType = FlyerType.Product;
                              });
                            },
                          ),

                          DreamBox(
                            height: 60,
                            width: bottomSheetClearWidth(context) / 2.2,
                            verse: 'Equipment Flyer',
                            verseMaxLines: 2,
                            verseScaleFactor: 0.7,
                            color: _currentFlyerType == FlyerType.Equipment ? Colorz.Yellow : Colorz.WhiteGlass,
                            verseColor: _currentFlyerType == FlyerType.Equipment ? Colorz.BlackBlack : Colorz.White,
                            boxFunction: (){
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
  // ----------------------------------------------------------------------
  bool _inputsAreValid(){
    // TASK : figure out flyer required fields needed for validity assertion
    return true;
  }
  // ----------------------------------------------------------------------
  Future<List<SlideModel>> _processNewSlides(List<SlideModel> currentSlides, List<TextEditingController> titleControllers) async {
    List<SlideModel> _slides = new List();

    for (var slide in currentSlides){

      int i = slide.slideIndex;

      SlideModel _newSlide = SlideModel(
        slideIndex: currentSlides[i].slideIndex,
        picture: currentSlides[i].picture,
        headline: titleControllers[i].text,
        description: null,
        savesCount: 0,
        sharesCount: 0,
        viewsCount: 0,
      );

      _slides.add(_newSlide);

    }

    return _slides;
  }
  // ----------------------------------------------------------------------
  Future<void> _createNewFlyer() async {
    /// assert that all required fields are valid
    if (_inputsAreValid() == false){
      // show something for user to know
      await superDialog(context, 'Please add all required fields', 'incomplete');
    } else {

      _triggerLoading();

      /// create slides models
      List<SlideModel> _slides = await _processNewSlides(_currentSlides, _titleControllers);

      /// create tiny author model from bz.authors
      AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID());
      TinyUser _tinyAuthor = AuthorModel.getTinyAuthorFromAuthorModel(_author);

      ///create FlyerModel
      FlyerModel _newFlyerModel = FlyerModel(
        flyerID: _currentFlyerID, // will be created in creatFlyerOps
        // -------------------------
        flyerType: _currentFlyerType,
        flyerState: _currentFlyerState,
        keyWords: _currentKeywords,
        flyerShowsAuthor: _currentFlyerShowsAuthor,
        flyerURL: _currentFlyerURL,
        // -------------------------
        tinyAuthor: _tinyAuthor,
        tinyBz: TinyBz(
          bzID: _currentBzID,
          bzLogo: widget.bzModel.bzLogo,
          bzName: widget.bzModel.bzName,
          bzType: widget.bzModel.bzType,
          bzZone: Zone.getZoneFromBzModel(widget.bzModel),
          bzTotalFollowers: widget.bzModel.bzTotalFollowers,
          bzTotalFlyers: widget.bzModel.bzFlyers.length,
        ),
        // -------------------------
        publishTime: _currentPublishTime,
        flyerPosition: _currentFlyerPosition,
        // -------------------------
        ankhIsOn: false, // shouldn't be saved here but will leave this now
        // -------------------------
        slides: _slides,
      );

      /// start create flyer ops
      FlyerModel _uploadedFlyerModel = await FlyerCRUD().createFlyerOps(context, _newFlyerModel, widget.bzModel);

      /// add the result final Tinyflyer to local list and notifyListeners
      /// TASK : should be TinyFlyer not Flyer
      _prof.addTinyFlyerToLocalList(TinyFlyer.getTinyFlyerFromFlyerModel(_uploadedFlyerModel));

      _triggerLoading();

      Nav.goBack(context);

    }
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final AuthorModel _author = widget.firstTimer ?
    AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID()) :
    AuthorModel.getAuthorFromBzByAuthorID(_bz, _flyer.tinyAuthor.userID);
    // ----------------------------------------------------------------------
    final double _flyerSizeFactor = 0.8;
    final double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);
    // ----------------------------------------------------------------------
    print('_pickedImage : $_pickedImage');
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> building widget tree');
    // ----------------------------------------------------------------------
    Widget _fButton({String icon, Function function}){
      return
          DreamBox(
            width: _flyerZoneWidth * 0.15,
            height: _flyerZoneWidth * 0.15,
            icon: icon,
            iconSizeFactor: 0.6,
            bubble: true,
            boxFunction: function,
          );
    }
    // ----------------------------------------------------------------------
    Widget _publishButton(){
      return
        DreamBox(
          height: 35,
          boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarPadding),
          verse: widget.firstTimer ? 'Publish flyer' : 'update flyer',
          verseColor: Colorz.BlackBlack,
          verseScaleFactor: 0.8,
          color: Colorz.Yellow,
          icon: Iconz.AddFlyer,
          iconSizeFactor: 0.6,
          boxFunction: widget.firstTimer ? _createNewFlyer : (){print('should update flyer');},
        );
    }
    // ----------------------------------------------------------------------
    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      appBarBackButton: true,
      sky: Sky.Black,
      pageTitle: !_loading ? 'Create a New Flyer' : 'Waiting ...',
      loading: _loading,
      tappingRageh: (){
        _triggerLoading();
      },
      appBarRowWidgets: <Widget>[

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

                      PageView.builder(
                        controller: slidingController,
                        itemCount: _currentSlides.length,
                        onPageChanged: onPageChangedIsOn ? slidingPages : zombie,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (ctx, index) =>
                            AnimatedOpacity(
                              key: ObjectKey(_currentSlides[index].picture),
                              opacity: _slidesVisibility[index] == true ? 1 : 0,
                              duration: Duration(milliseconds: 100),
                              child: SingleSlide(
                                flyerZoneWidth: _flyerZoneWidth,
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

                      Header(
                        tinyBz: TinyBz.getTinyBzFromBzModel(_bz),
                        tinyAuthor: AuthorModel.getTinyAuthorFromAuthorModel(_author),
                        flyerShowsAuthor: true,
                        followIsOn: false,
                        flyerZoneWidth: superFlyerZoneWidth(context, _flyerSizeFactor),
                        bzPageIsOn: false,
                        tappingHeader: (){},
                        tappingFollow: (){},
                      ),

                      ProgressBar(
                        flyerZoneWidth: _flyerZoneWidth,
                        numberOfSlides: numberOfSlides,
                        currentSlide: currentSlide,
                      ),

                    ],
                  ),

                  Positioned(
                    right: ((1-_flyerSizeFactor)/2)*superScreenWidth(context) - ((_flyerZoneWidth * 0.15/2)),
                    bottom: superScreenHeightWithoutSafeArea(context) * 0.07,
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
                          function: () => _deleteSlide(numberOfSlides, currentSlide),
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

