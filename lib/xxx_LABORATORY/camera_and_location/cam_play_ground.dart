import 'dart:io';
import 'package:exif/exif.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/timerz.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:async';
import 'package:image/image.dart' as img;

import 'package:image_picker/image_picker.dart';

class CamPlayGround extends StatefulWidget {

  CamPlayGround({Key key, this.controller}) : super(key: key); // has something to do with main screen before it

  final PageController controller;
  // final double iconHeight = 10;
  @override
  _CamPlayGroundState createState() => _CamPlayGroundState();
}

class _CamPlayGroundState extends State<CamPlayGround> {
  CameraController _controller;
  Future<void> _controllerInitializer;
  List<CameraDescription> _cameras;


// double _scale;
// ---------------------------------------------------------------------------
  @override
  void initState(){
    // getCamera().then((camera){
    //   setState(() {
    //     _controller = CameraController(camera, ResolutionPreset.max, enableAudio: false);
    //     _controllerInitializer = _controller.initialize();
    //
    //     print('controller is building : $_controller');
    //
    //   });
    // });

    getCamera();

    super.initState();

  }
// ---------------------------------------------------------------------------
  Future<void> getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    CameraDescription _cam = _cameras.first;

    _controller = CameraController(_cam, ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

  }
  // ---------------------------------------------------------------------------
  @override
  void dispose() {

    _controller?.dispose();
    super.dispose();
  }
// ---------------------------------------------------------------------------
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // App state changed before we got the chance to initialize.
  //   if (_controller == null || !_controller.value.isInitialized) {
  //     return;
  //   }
  //   if (state == AppLifecycleState.inactive) {
  //     _controller?.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     if (_controller != null) {
  //       onNewCameraSelected(controller.description);
  //     }
  //   }
  // }
// ---------------------------------------------------------------------------
  File _theImageFile;
  Future<void> _imagePickerCamera() async {
    _triggerLoading();
    final ImagePicker picker = ImagePicker();
    final PickedFile imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.rear,
    );
    final File correctedImageFile = await fixExifRotation(imageFile.path);

    setState(() {
      print('wtffffffffffffffffffffffffffffffffff');
      _theImageFile = correctedImageFile;
    });

    _triggerLoading();

  }
// ---------------------------------------------------------------------------
  Future<File> fixExifRotation(String imagePath) async {
    print('fixExifRotation STARTS');
    final originalFile = File(imagePath);
    List<int> imageBytes = await originalFile.readAsBytes();

    final originalImage = img.decodeImage(imageBytes);

    final height = originalImage.height;
    final width = originalImage.width;

    // Let's check for the image size
    if (height >= width) {
      // I'm interested in portrait photos so
      // I'll just return here
      return originalFile;
    }

    // We'll use the exif package to read exif data
    // This is map of several exif properties
    // Let's check 'Image Orientation'
    final exifData = await readExifFromBytes(imageBytes);

    img.Image fixedImage;

    if (height < width) {
      print('logger.logInfo(\'Rotating image necessary\');');
      fixedImage = img.copyRotate(originalImage, 0);
      if (exifData['Image Orientation'].printable.contains('Horizontal')) {
        fixedImage = img.copyRotate(originalImage, 90);
      } else if (exifData['Image Orientation'].printable.contains('180')) {
        fixedImage = img.copyRotate(originalImage, -90);
      } else {
        fixedImage = img.copyRotate(originalImage, 0);
      }
    }

    // Here you can select whether you'd like to save it as png
    // or jpg with some compression
    // I choose jpg with 100% quality
    final fixedFile =
    await originalFile.writeAsBytes(img.encodeJpg(fixedImage));

    print('fixExifRotation ENDS');

    return fixedFile;
  }
  Future<File> rotateAndCompressAndSaveImage(File image) async {
    int rotate = 0;
    List<int> imageBytes = await image.readAsBytes();
    Map<String, IfdTag> exifData = await readExifFromBytes(imageBytes);

    if (exifData != null &&
        exifData.isNotEmpty &&
        exifData.containsKey("Image Orientation")) {
      IfdTag orientation = exifData["Image Orientation"];
      int orientationValue = orientation.values[0];

      if (orientationValue == 3) {
        rotate = 180;
      }

      if (orientationValue == 6) {
        rotate = -90;
      }

      if (orientationValue == 8) {
        rotate = 90;
      }
    }

    List<int> result = await FlutterImageCompress.compressWithList(imageBytes,
        quality: 100, rotate: rotate);

    await image.writeAsBytes(result);


    print(image);
    return image;
  }
// ---------------------------------------------------------------------------
  bool _loading = false;
  void _triggerLoading(){
    setState(() {
      _loading = !_loading;
    });

    if(_loading == true){
      print('loading ----------------------------------');
    } else {
    print('loading complete xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    }

  }
// ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // final _pro = Provider.of<FlyersProvider>(context);
    // final _flyer = _pro.getFlyerByFlyerID('f035');
    // final bz = flyer.bz;

    // final double screenWidth = superScreenWidth(context);
    final double _flyerSizeFactor = 1;
    final double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);

    // final double deviceRatio = superDeviceRatio(context);
    // double controllerRatio = _controller.value.aspectRatio;
    // double fuckingRatio = controllerRatio / deviceRatio;
    // double scale =  controllerRatio < deviceRatio ? 1/fuckingRatio : fuckingRatio ;

    // double fuckingScale = _controller.value.aspectRatio
    //     <
    //     superDeviceRatio(context) ?
    // (1/_controller.value.aspectRatio) / superDeviceRatio(context) :
    // ((_controller.value.aspectRatio) / superDeviceRatio(context)) ;


    return MainLayout(
      // tappingRageh: (){print('_controller = $_controller');},
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: FlyerZone(
        flyerSizeFactor: _flyerSizeFactor,
        tappingFlyerZone: (){},
        stackWidgets: <Widget>[

          // // -- first test
          // FutureBuilder(
          //   future: _controllerInitializer,
          //   builder: (context, snapshot){
          //     if (snapshot.connectionState == ConnectionState.done)
          //     {return CameraPreview(_controller); }
          //     else
          //     {return Center(child: Loading(loading: true,));}
          //   },
          // ),


          // Header(
          //     bz: bz,
          //     author: bz.authors[2],
          //     flyerShowsAuthor: flyer.flyerShowsAuthor,
          //     followIsOn: false,
          //     _flyerZoneWidth: super_FlyerZoneWidth(context, _flyerSizeFactor),
          //     bzPageIsOn: false,
          //     tappingHeader: (){},
          //     tappingFollow: (){},
          //     tappingUnfollow: (){},
          // ),

          Positioned(
            bottom: 0,
            child: DreamBox(
              width: _flyerZoneWidth * 0.2,
              height: _flyerZoneWidth * 0.2,
              boxMargins: EdgeInsets.only(bottom: _flyerZoneWidth * 0.025),
              icon: Iconz.CameraButton,
              bubble: false,
              boxFunction: _imagePickerCamera,
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: DreamBox(
              width: _flyerZoneWidth * 0.15,
              height: _flyerZoneWidth * 0.15,
              boxMargins: EdgeInsets.only(bottom: _flyerZoneWidth * 0.05, left: _flyerZoneWidth * 0.05),
              icon: Iconz.PhoneGallery,
              bubble: false,
              boxFunction: (){
                print('aho');
              },
            ),
          ),

          Center(
            child: DreamBox(
              height: 200,
              width: 200,
              iconFile: _theImageFile,
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 60,
                height: 60,
                child: Loading(size: 60,loading: _loading,)
            ),
          ),

        ],
      ),
    );
  }
}

Widget cameraWidget(BuildContext context, CameraController controller, Future<dynamic> controllerInitializer){
  final double deviceRatio = superDeviceRatio(context);
  final double controllerRatio = controller.value.aspectRatio;
  double scale =  controllerRatio / deviceRatio ;
  if (controllerRatio < deviceRatio){scale = 1/scale;}
  return Transform.scale(
    scale: scale,
    child: Center(
      child: AspectRatio(
        aspectRatio: controllerRatio,
        child: FutureBuilder(
          future: controllerInitializer,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done)
            {return CameraPreview(controller); }
            else
            {return Center(child: CircularProgressIndicator());}
          },
        ),
      ),
    ),
  );
}
