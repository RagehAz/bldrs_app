import 'dart:io';
import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/ambassadors/services/firebase_storage.dart';
import 'package:bldrs/ambassadors/services/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/controllers/flyer_sliding_controllers.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
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
  List<String> _currentKeywords;
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
    _currentAuthorID = _flyer.authorID;
    _currentBzID = _flyer.bzID;
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
    return new FlyerModel(
    flyerID : '...',
    // -------------------------
    flyerType : concludeFlyerType(_bz.bzType),
    flyerState : FlyerState.Draft,
    keyWords : new List(),
    flyerShowsAuthor : true,
    flyerURL : '...',
    // -------------------------
    authorID : superUserID(),
    bzID : _bz.bzID,
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
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }
  // ----------------------------------------------------------------------
  Future<void> _takeCameraPicture() async {

    final _imageFile = await takeCameraPicture(PicType.slideHighRes);

    setState(() {
      _storedImage = File(_imageFile.path);
      _currentSlides.add(
          SlideModel(
            slideIndex: 0,
            picture: _storedImage,
            headline: _titleControllers[_currentSlides.length].text,
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
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _takeCameraPicture');
  }
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
  void slidingPages (int slideIndex){
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before slidingPages : onPageChanged --------');
    setState(() {
      currentSlide = slideIndex;
    });
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after slidingPages : onPageChanged --------');
  }
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
  Future<void> _publishFlyer() async {
    print('Starting to publish');

    if(numberOfSlides == 0) {
      superDialog(context, 'You have to add some slides first', '');
    } else if (_currentKeywords.length == 0){
      superDialog(context, 'Add Flyer HashTags', 'Add Hashtags');
    } else {

      _triggerLoading();

      await tryAndCatch(
        context: context,
        functions: () async {
          /// 1 - save a flyer document on firestore to get its auto generated
          /// flyerID if creating a new flyer
            final CollectionReference _flyersCollection = FirebaseFirestore.instance.collection(FireStoreCollection.flyers);
            DocumentReference _flyerDocRef = _flyersCollection.doc();
          if(widget.firstTimer){
            await _flyerDocRef.set({});
            _currentFlyerID = _flyerDocRef.id;
          }
          /// 2 - create slides to store on firebase, and save each pic file to
          /// firebase storage and get its url to save to firestore
          List<SlideModel> _slides = new List();
          _currentSlides.forEach((sl) async {

            String _picURL = await savePicOnFirebaseStorageAndGetURL(
                context: context,
                inputFile: sl.picture,
                fileName: '${_currentFlyerID}_${sl.slideIndex}'
              );
            _slides.add(
                SlideModel(
                  slideIndex: sl.slideIndex,
                  picture: _picURL,
                  headline: _titleControllers[sl.slideIndex].text,
                  description: '',
                  callsCount: widget.firstTimer ? 0 : _flyer.slides[sl.slideIndex].callsCount,
                  savesCount: widget.firstTimer ? 0 : _flyer.slides[sl.slideIndex].savesCount,
                  sharesCount: widget.firstTimer ? 0 : _flyer.slides[sl.slideIndex].sharesCount,
                  viewsCount: widget.firstTimer ? 0 : _flyer.slides[sl.slideIndex].viewsCount,
            ));
          });
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
              authorID: _currentAuthorID,
              bzID: _currentBzID,
              // -------------------------
              publishTime: _currentPublishTime,
              flyerPosition: _currentFlyerPosition,
              // -------------------------
              ankhIsOn: false, // shouldn't be saved here but will leave this now
              // -------------------------
              slides: _slides,
          );
          /// 4- save flyer to firestore
          // await _flyersCollection.doc(_currentFlyerID).update(_newFlyerModel.toMap());

        }
      );

      _triggerLoading();

    }

  }
  // ----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);
    // final user = Provider.of<UserModel>(context);
    // final BzModel _bz = _prof.getBzByBzID(widget.bzModel.bzID);
    final AuthorModel _author = widget.firstTimer ?
    getAuthorFromBzByAuthorID(_bz, superUserID()) :
    getAuthorFromBzByAuthorID(_bz, _flyer.authorID);
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
    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      appBarBackButton: true,
      sky: Sky.Black,
      pageTitle: 'Create a New Flyer',
      tappingRageh: (){
        _currentSlides.forEach((slide) {
          // print('i: ${slide.slideIndex} || flyerID : (${slide.flyerID}), slideID : (${slide.slideID}), headline : (${slide.headline}), picture : (${slide.picture})');
        });
      },
      appBarRowWidgets: <Widget>[

        Expanded(child: Container(),),

        DreamBox(
          height: 35,
          boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarPadding),
          verse: 'Publish flyer',
          verseColor: Colorz.BlackBlack,
          verseScaleFactor: 0.8,
          color: Colorz.Yellow,
          icon: Iconz.AddFlyer,
          iconSizeFactor: 0.6,
          boxFunction: _publishFlyer,
      ),

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
                                // picture: Iconz.DumSlide1,
                                picFile: _currentSlides[index].picture,
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
                        bz: _bz,
                        author: _author,
                        flyerShowsAuthor: true,
                        followIsOn: false,
                        flyerZoneWidth: superFlyerZoneWidth(context, _flyerSizeFactor),
                        bzPageIsOn: false,
                        tappingHeader: (){},
                        tappingFollow: (){},
                        tappingUnfollow: (){},
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

                        /// --- FLYER TYPE TEMP
                        if(_bz.bzType == BzType.Manufacturer || _bz.bzType == BzType.Supplier)
                        _fButton(icon: Iconz.Flyer, function: (){
                          superDialog(context, 'choose flyer type', 'later');
                        }),

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

