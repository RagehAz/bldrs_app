import 'dart:io';
import 'package:bldrs/view_brains/controllers/flyer_sliding_controllers.dart';
import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/sizez.dart';
import 'package:bldrs/views/widgets/flyer/slides/slides_items/single_slide.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/google_map.dart';
import 'package:bldrs/xxx_LABORATORY/camera_and_location/location_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:bldrs/models/location_model.dart';
import 'package:bldrs/models/slide_model.dart';
import 'package:bldrs/providers/combined_models/coflyer_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/header/header.dart';
import 'package:bldrs/views/widgets/flyer/slides/slides_items/progress_bar.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pro_flyer/flyer_parts/flyer_zone.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

enum SlidingDirection{
  next,
  back,
  freeze,
}

class CreateFlyerScreen extends StatefulWidget {

  @override
  _CreateFlyerScreenState createState() => _CreateFlyerScreenState();
}

class _CreateFlyerScreenState extends State<CreateFlyerScreen> {
  List<SlideModel> newSlides;
  int currentSlide;
  List<TextEditingController> _titleControllers;
  File _storedImage;
  File _pickedImage;
  LocationModel _pickedLocation;
  PageController slidingController;
  int numberOfSlides;
  List<bool> slidesVisibility;
  bool onPageChangedIsOn;
  List<SlideMode> slidesModes;
  String _previewImageUrl;
  // ----------------------------------------------------------------------
  @override
  void initState(){
    newSlides = new List();
    slidesVisibility = new List();
    slidesModes = new List();
    _titleControllers = new List();
    numberOfSlides = newSlides.length;
    currentSlide = 0;
    slidingController = PageController(initialPage: 0,);
    onPageChangedIsOn = true;
    super.initState();
  }
  // ----------------------------------------------------------------------
  void _triggerVisibility(int currentSlide)  {
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _triggerVisibility');
    setState(() {
      slidesVisibility[currentSlide] = !slidesVisibility[currentSlide];
    });
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _triggerVisibility');
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
    if (newSlides.isNotEmpty)
    {
      if(currentSlide == 0){newSlides.removeAt(currentSlide);currentSlide=0;}else{newSlides.removeAt(currentSlide);}
      slidesVisibility.removeAt(currentSlide);
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
    if (newSlides.isNotEmpty)
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
              numberOfSlides = newSlides.length;
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
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _takeCameraPicture');
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null){return;}

    setState(() {
      _storedImage = File(imageFile.path);
      newSlides.add(
          SlideModel(
            flyerID: 'f${DateTime.now()}',
            slideID: 's${DateTime.now()}',
            slideIndex: 0,
            picture: _storedImage,
            headline: '',
          ));
      currentSlide = newSlides.length - 1;
      numberOfSlides = newSlides.length;
      slidesVisibility.add(true);
      slidesModes.add(SlideMode.Editor);
      _titleControllers.add(TextEditingController());
      onPageChangedIsOn = true;
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    _selectImage(savedImage);
    slideTo(slidingController, currentSlide);
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _takeCameraPicture');
  }
  // ----------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _takeGalleryPicture');
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null){return;}

    setState(() {
      _storedImage = File(imageFile.path);
      newSlides.add(
          SlideModel(
            flyerID: 'f${DateTime.now()}',
            slideID: 's${DateTime.now()}',
            slideIndex: 0,
            picture: _storedImage,
            headline: '',
          ));
      currentSlide = newSlides.length - 1;
      numberOfSlides = newSlides.length;
      slidesVisibility.add(true);
      slidesModes.add(SlideMode.Editor);
      _titleControllers.add(TextEditingController());
      onPageChangedIsOn = true;
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
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
  void tappingNewSlide(){
    setState(() {
      newSlides.add(SlideModel(
        flyerID: 'f${DateTime.now()}',
        slideID: 's${DateTime.now()}',
        slideIndex: currentSlide+1,
        picture:  null,
        headline: '',
      ));
      currentSlide = newSlides.length - 1;
      numberOfSlides = newSlides.length;
      slidingController.animateToPage(currentSlide, duration: Duration(milliseconds: 750), curve: Curves.easeInOutCirc);
      slidesVisibility.add(true);
      slidesModes.add(SlideMode.Map);
    });
    }
  // ----------------------------------------------------------------------
  Future<void>_selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
        MaterialPageRoute(
            builder: (ctx) => GoogleMapScreen(
              isSelecting: true,
            )
        )
    );
    if (selectedLocation == null){ return; }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    _newLocationSlide();
    print("${selectedLocation.latitude},${selectedLocation.longitude}");
  }
  // ----------------------------------------------------------------------
  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = getStaticMapImage(context, lat, lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }
  // ----------------------------------------------------------------------
  void _newLocationSlide(){
    setState(() {
      newSlides.add(
          SlideModel(
            flyerID: 'f${DateTime.now()}',
            slideID: 's${DateTime.now()}',
            slideIndex: 0,
            picture: _previewImageUrl,
            headline: '',
          ));
      currentSlide = newSlides.length - 1;
      numberOfSlides = newSlides.length;
      slidesVisibility.add(true);
      slidesModes.add(SlideMode.Editor);
      _titleControllers.add(TextEditingController());
      onPageChangedIsOn = true;
    });
    slideTo(slidingController, currentSlide);
  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<CoFlyersProvider>(context);
    final coFlyer = pro.hatCoFlyerByFlyerID('f035');
    final coBz = coFlyer.coBz;
    // ----------------------------------------------------------------------
    final double flyerSizeFactor = 0.73;
    final double flyerZoneWidth = superFlyerZoneWidth(context, flyerSizeFactor);
    // ----------------------------------------------------------------------
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> building widget tree');
    return MainLayout(
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[],
      layoutWidget: Stack(
        children: <Widget>[

          Column(
            // alignment: Alignment.topCenter,
            children: <Widget>[

              Stratosphere(),

              Stack(
                children: <Widget>[

                  FlyerZone(
                    flyerSizeFactor: flyerSizeFactor,
                    tappingFlyerZone: (){},
                    stackWidgets: <Widget>[

                      PageView.builder(
                        controller: slidingController,
                        itemCount: newSlides.length,
                        onPageChanged: onPageChangedIsOn ? slidingPages : zombie,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (ctx, index) =>
                            AnimatedOpacity(
                              key: ObjectKey(newSlides[index].flyerID),
                              opacity: slidesVisibility[index] == true ? 1 : 0,
                              duration: Duration(milliseconds: 100),
                              child: SingleSlide(
                                flyerZoneWidth: flyerZoneWidth,
                                // picture: Iconz.DumSlide1,
                                picFile: newSlides[index].picture,
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
                        coBz: coBz,
                        coAuthor: coBz.coAuthors[2],
                        flyerShowsAuthor: coFlyer.flyer.flyerShowsAuthor,
                        followIsOn: false,
                        flyerZoneWidth: superFlyerZoneWidth(context, flyerSizeFactor),
                        bzPageIsOn: false,
                        tappingHeader: (){},
                        tappingFollow: (){},
                        tappingUnfollow: (){},
                        tappingGallery: (){},
                      ),

                      ProgressBar(
                        flyerZoneWidth: flyerZoneWidth,
                        numberOfSlides: numberOfSlides,
                        currentSlide: currentSlide,
                      ),

                    ],
                  ),

                  Positioned(
                    right: ((1-flyerSizeFactor)/2)*superScreenWidth(context) - ((flyerZoneWidth * 0.15/2)),
                    bottom: superScreenHeightWithoutSafeArea(context) * 0.07,
                    child: Column(
                      children: <Widget>[

                        // --- NEW SLIDE FROM CAMERA
                        DreamBox(
                          width: flyerZoneWidth * 0.15,
                          height: flyerZoneWidth * 0.15,
                          icon: Iconz.PhoneGallery,
                          iconSizeFactor: 0.6,
                          bubble: true,
                          boxFunction: _takeGalleryPicture,
                        ),

                        // --- NEW SLIDE FROM GALLERY
                        DreamBox(
                          width: flyerZoneWidth * 0.15,
                          height: flyerZoneWidth * 0.15,
                          icon: Iconz.Camera,
                          iconSizeFactor: 0.65,
                          bubble: true,
                          boxFunction: _takeCameraPicture,
                        ),

                        // --- OPEN MAP SCREEN
                        DreamBox(
                          width: flyerZoneWidth * 0.15,
                          height: flyerZoneWidth * 0.15,
                          icon: Iconz.LocationPin,
                          iconSizeFactor: 0.65,
                          bubble: true,
                          boxFunction: _selectOnMap,
                        ),

                        // --- DELETE SLIDE
                        DreamBox(
                          width: flyerZoneWidth * 0.15,
                          height: flyerZoneWidth * 0.15,
                          icon: Iconz.XLarge,
                          iconSizeFactor: 0.5,
                          bubble: true,
                          boxFunction: () => _deleteSlide(numberOfSlides, currentSlide),
                        )

                      ],
                    ),
                  ),

                ],
              ),



            ],
          ),

          Positioned(
            bottom: 0,
            child: Container(
              width: superScreenWidth(context),
              height: 60,
              // color: Colorz.BloodTest,
              alignment: Alignment.center,
              child: DreamBox(
                height: 50,
                boxMargins: EdgeInsets.all(5),
                verse: 'Publish flyer',
                icon: Iconz.Flyer,
                iconSizeFactor: 0.6,
              ),
            ),
          ),


        ],
      ),
    );
  }
}

