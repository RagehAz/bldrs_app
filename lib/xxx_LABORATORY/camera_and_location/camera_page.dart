import 'dart:io';

import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:exif/exif.dart';

// class CameraMainPageView extends StatelessWidget{
//   final controller = PageController(initialPage: 1);
//   @override
//   Widget build(BuildContext context){
//     return PageView(
//       controller: controller,
//       children: <Widget>[
//         CameraPage(),
//         ObeliskScreen(
//           controller: this.controller,
//         ),
//       ],
//     );
//   }
// }

class CameraPage extends StatefulWidget {

  CameraPage({Key key, this.controller}) : super(key: key); // has something to do with main screen before it

  final PageController controller;
  // final double iconHeight = 10;
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
CameraController _controller;
Future<void> _controllerInitializer;
// double _scale;

Future<CameraDescription> getCamera() async {
  final _cam = await availableCameras();
  return _cam.first;
}

@override
void initState(){
  super.initState();
  getCamera().then((camera){
    setState(() {
      _controller = CameraController(camera, ResolutionPreset.medium, enableAudio: false);
      _controllerInitializer = _controller.initialize();

    print('controller is building : $_controller');

    });
  });
}
bool _loading;

void _triggerLoading(){
  print('loading------------------');
  setState(() {
    _loading = !_loading;
  });
  print('loading complete --------');

}

@override
void dispose() {

  _controller.dispose();
    super.dispose();
  }

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
  final File correctedImageFile = await rotateAndCompressAndSaveImage(File(imageFile.path));

  setState(() {
    _theImageFile = correctedImageFile;
  });

    _triggerLoading();

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

    return image;
  }


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
          FutureBuilder(
            future: _controllerInitializer,
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.done)
              {return CameraPreview(_controller); }
              else
              {return Center(child: CircularProgressIndicator());}
            },
          ),


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
            child: Loading(loading: true,),
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
