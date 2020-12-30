import 'dart:io';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/flyer/slides/slides_items/single_slide.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
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
  final _titleController = TextEditingController();
  File _storedImage;
  File _pickedImage;
  LocationModel _pickedLocation;
  PageController slidingController;
  int numberOfSlides;
  List<bool> slidesVisibility;
  // ----------------------------------------------------------------------
  @override
  void initState(){
    newSlides = new List();
    slidesVisibility = new List();
    numberOfSlides = newSlides.length;
    currentSlide = 0;
    slidingController = PageController(initialPage: 0,);
    super.initState();
  }
  // ----------------------------------------------------------------------
  void emptyTheList(){
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before emptyTheList');
    setState(() {
      newSlides.clear();
      currentSlide = 0;
      numberOfSlides = 0;
    });
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after emptyTheList');
  }

  void slideToNext(int numberOfSlides, int currentSlide){
    slidingController.animateToPage(currentSlide + 1,
        duration: Ratioz.slidingDuration, curve: Curves.easeInOutCirc);
  }
  // ----------------------------------------------------------------------
  void snapToNext(int numberOfSlides, int currentSlide){
    slidingController.animateToPage(currentSlide + 1,
        duration: Duration(milliseconds: 1), curve: Curves.easeInOutCirc);
    setState(() {
      currentSlide = currentSlide -1;
    });
  }
  // ----------------------------------------------------------------------
  void slideToBack(int currentSlide){
    if (currentSlide == 0){print('can not slide back');} else {
      slidingController.animateToPage(currentSlide - 1,
          duration: Ratioz.slidingDuration,
          curve: Curves.easeInOutCirc);

    }
  }
  // ----------------------------------------------------------------------
  void snapToBack(int currentSlide){
    if (currentSlide == 0){print('can not slide back');} else {
      slidingController.animateToPage(currentSlide - 1,
          duration: Duration(milliseconds: 1),
          curve: Curves.easeInOutCirc);
    }
  }
  // ----------------------------------------------------------------------
  void slideTo(int currentSlide){
    slidingController.animateToPage(currentSlide,
        duration: Ratioz.slidingDuration, curve: Curves.easeInOutCirc);
  }

  void snapTo(int currentSlide){
    slidingController.jumpToPage(currentSlide,);
  }
  // ----------------------------------------------------------------------
  SlidingDirection slidingDecision(int numberOfSlides, int currentSlide){
    SlidingDirection decision =
    numberOfSlides == 0 ? SlidingDirection.freeze :
    numberOfSlides == 1 ? SlidingDirection.freeze :
    numberOfSlides > 1 && currentSlide + 1 == numberOfSlides ? SlidingDirection.back :
    numberOfSlides > 1 && currentSlide == 0 ? SlidingDirection.next :
    SlidingDirection.back;
    return decision;
  }
  // ----------------------------------------------------------------------
  void slidingAction(int numberOfSlides, int currentSlide) {
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before slidingAction');
    slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.next ? slideToNext(numberOfSlides, currentSlide) :
    slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.back ? slideToBack(currentSlide) :
    slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.freeze ? slideTo(currentSlide) :
    print('no sliding possible ');
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after slidingAction');
  }
  // ----------------------------------------------------------------------
  void _triggerVisibility(int currentSlide)  {
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _triggerVisibility');
      setState(() {
      slidesVisibility[currentSlide] = !slidesVisibility[currentSlide];
      });
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _triggerVisibility');
  }
  // ----------------------------------------------------------------------
  // void _delayedVisibility(int currentSlide){
  //   Future.delayed(
  //       Ratioz.fadingDuration,
  //           (){
  //         _triggerVisibility(currentSlide);
  //       });
  // }
  // ----------------------------------------------------------------------
  void _hideAndSlide (int numberOfSlides, int currentSlide)  {
    _triggerVisibility(currentSlide);
    Future.delayed(Ratioz.fadingDuration, (){
    slidingAction(numberOfSlides, currentSlide);
    });
  }
  // ----------------------------------------------------------------------
  // void _increaseProgressBar(){
  //   print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _increaseProgressBar');
  //   setState(() {
  //     numberOfSlides = numberOfSlides + 1;
  //   });
  //   print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _increaseProgressBar');
  // }
  void _decreaseProgressBar(){
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _decreaseProgressBar');
    setState(() {
    numberOfSlides > 0 ?
      numberOfSlides = numberOfSlides - 1 : print('can not decrease progressBar');
    });
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _decreaseProgressBar');
  }
  // ----------------------------------------------------------------------
  void _simpleDelete(int currentSlide){
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _simpleDelete');
    if (newSlides.isNotEmpty)
    {
      if(currentSlide == 0){newSlides.removeAt(currentSlide);currentSlide=0;}else{newSlides.removeAt(currentSlide);}
      slidesVisibility.removeAt(currentSlide);
      setState(() {
        // numberOfSlides = newSlides.length;
        // currentSlide = currentSlide == 0 ? 0 : currentSlide;
      });
    } else { print('no Slide to delete'); }
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _simpleDelete');
  }
  // ----------------------------------------------------------------------
  // void _currentSlidePlus(){
  //   print('before : $currentSlide');
  //   setState(() {
  //     currentSlide = currentSlide + 1;
  //   });
  //   print('after : $currentSlide');
  // }
  //
  void _currentSlideMinus(){
    print('before : $currentSlide');
    setState(() {
      currentSlide = currentSlide - 1;
    });
    print('after : $currentSlide');
  }
  //
  // int currentSlideAnalyzer(){
  //   return
  //   slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.next ? currentSlide - 1 :
  //   slidingDecision(numberOfSlides, currentSlide) == SlidingDirection.back ? currentSlide + 1 :
  //       currentSlide;
  // }
  // ----------------------------------------------------------------------
  void _deleteSlide (int numberOfSlides, int currentSlide) {
    if (newSlides.isNotEmpty)
    {
      _decreaseProgressBar();
      _hideAndSlide(numberOfSlides, currentSlide);
      numberOfSlides == 1 ?
      _simpleDelete(currentSlide) :
      Future.delayed(
        Ratioz.slidingAndFadingDuration,
          (){
            if(currentSlide == 0){_simpleDelete(currentSlide);snapTo(0);}
            else{_simpleDelete(currentSlide);}
      }
      );
          print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _deleteSlide ------------ last shit');
            // snapToBack(currentSlide);
    }
    else
      {print('no slide to delete');}
  }
  // ----------------------------------------------------------------------
  // ----------------------------------------------------------------------
  void _workingDeleteSlide (int currentSlide){
    int slideToDelete = currentSlide;
    newSlides.isEmpty ? print('nothing to delete') :
    setState(() {
      slidingAction(numberOfSlides, currentSlide);
      newSlides.removeAt(slideToDelete);
      numberOfSlides = newSlides.length;
      slidesVisibility[currentSlide] = true;
    });
  }
  // ----------------------------------------------------------------------
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
    print('wtf');
  }
  // ----------------------------------------------------------------------
  Future<void> _takeCameraPicture() async {
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _takeCameraPicture');
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
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    _selectImage(savedImage);
    slideTo(currentSlide);
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _takeCameraPicture');
  }
  // ----------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _takeGalleryPicture');
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
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    _selectImage(savedImage);
    slideTo(currentSlide);
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after _takeGalleryPicture');
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
      });
  }
  // ----------------------------------------------------------------------
  void slidingPages (int slideIndex){
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before slidingPages : onPageChanged --------');
    setState(() {currentSlide = slideIndex;});
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> after slidingPages : onPageChanged --------');
  }
  // ----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<CoFlyersProvider>(context);
    final coFlyer = pro.hatCoFlyerByFlyerID('f035');
    final coBz = coFlyer.coBz;
    // ----------------------------------------------------------------------
    final double flyerSizeFactor = 0.75;
    final double flyerZoneWidth = superFlyerZoneWidth(context, flyerSizeFactor);
    // ----------------------------------------------------------------------
    print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> building widget tree');
    return MainLayout(
      appBarType: AppBarType.Scrollable,
      appBarRowWidgets: <Widget>[
        zorar(()=>emptyTheList(), 'emptyTheList'),
        zorar(()=>snapToBack(currentSlide), 'snapToBack'),
        zorar(()=>snapToNext(numberOfSlides, currentSlide), 'snapToNext'),
        // zorar(()=>_currentSlideMinus(), '_currentSlideMinus'),
        // zorar(()=>_currentSlidePlus(), '_currentSlidePlus'),
        zorar(()=>_simpleDelete(currentSlide), '_simpleDelete'),
        // zorar(()=>_decreaseProgressBar(), '_decreaseProgressBar'),
        // zorar(()=>_increaseProgressBar(), '_increaseProgressBar'),
        // zorar(()=>_delayedVisibility(currentSlide), '_delayedVisibility'),
        zorar(()=>_triggerVisibility(currentSlide), '_triggerVisibility'),
        zorar(()=>_hideAndSlide(numberOfSlides, currentSlide), '_hideAndSlide'),
        zorar(()=>_deleteSlide(numberOfSlides, currentSlide), '_deleteSlide'),
        zorar(()=>slideToBack(currentSlide), 'slideToBack'),
        zorar(()=>slideToNext(numberOfSlides, currentSlide), 'slideToNext'),
        zorar(_takeCameraPicture, '_takeCameraPicture'),
        zorar(_takeGalleryPicture, '_takeGalleryPicture'),

      ],
      tappingRageh: (){
        print('slidesVisibility[currentSlide] : ${slidesVisibility[currentSlide]}');
        },
      layoutWidget: Column(
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
                      onPageChanged: slidingPages,
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
                              slideMode: SlideMode.Creation,
                              boxFit: BoxFit.fitWidth, // [fitWidth - contain - scaleDown] have the blur background
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

                  1 == 1 ? Container() :
                  Positioned(
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        DreamBox(
                          width: flyerZoneWidth * 0.15,
                          height: flyerZoneWidth * 0.15,
                          boxMargins: EdgeInsets.all(flyerZoneWidth * 0.025),
                          icon: Iconz.PhoneGallery,
                          bubble: true,
                          iconSizeFactor: 0.8,
                          boxFunction: _takeGalleryPicture,
                        ),

                        DreamBox(
                          width: flyerZoneWidth * 0.15,
                          height: flyerZoneWidth * 0.15,
                          boxMargins: EdgeInsets.all(flyerZoneWidth * 0.025),
                          icon: Iconz.Camera,
                          bubble: true,
                          iconSizeFactor: 0.8,
                          boxFunction: _takeCameraPicture,
                        ),

                      ],
                    ),
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
    );
  }
}

Widget zorar(Function function, String functionName){
  return DreamBox(
    height: 40,
    boxMargins: EdgeInsets.all(5),
    color: Colorz.WhiteAir,
    verse: functionName,
    verseScaleFactor: 0.7,
    boxFunction: function,
  );
}


// numberOfSlides == 0? numberOfSlides = 0 :
// numberOfSlides >= 1? numberOfSlides = numberOfSlides - 1 :
// numberOfSlides = numberOfSlides;
