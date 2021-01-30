import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
double scale;

Future<CameraDescription> getCamera() async {
  final c = await availableCameras();
  return c.first;
}

@override
void initState(){
  super.initState();
  getCamera().then((camera){
    setState(() {
      _controller = CameraController(camera, ResolutionPreset.ultraHigh, enableAudio: false);
      _controllerInitializer = _controller.initialize();

    print('controller is building : $_controller');

    });
  });
}

@override
void dispose() {
    // TODO: implement dispose
  _controller.dispose();
    super.dispose();
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
      tappingRageh: (){print('_controller = $_controller');},
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
