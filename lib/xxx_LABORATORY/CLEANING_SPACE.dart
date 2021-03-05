import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  final PageController controller;

  CameraPage({Key key, this.controller}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _controller;
  Future<void> _controllerInitializer;

  Future<CameraDescription> getCamera() async {
    final c = await availableCameras();
    return c.first;
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double _flyerSizeFactor = 1;
    final double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: FlyerZone(
        flyerSizeFactor: _flyerSizeFactor,
        tappingFlyerZone: (){},
        stackWidgets: <Widget>[

          FutureBuilder(
            future: _controllerInitializer,
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.done)
              {return CameraPreview(_controller); }
              else
              {return Center(child: CircularProgressIndicator());}
            },
          ),

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