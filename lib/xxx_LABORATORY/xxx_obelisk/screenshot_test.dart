import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';

class ScreenShotTest extends StatefulWidget {

  @override
  _ScreenShotTestState createState() => _ScreenShotTestState();
}

class _ScreenShotTestState extends State<ScreenShotTest> {
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List _imageFile;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  Future<dynamic> ShowBottomDialogWithImage(BuildContext context, Uint8List imageFile) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    return BottomDialog.slideBottomDialog(
      context: context,
      title: 'Screenshot',
      height: _screenHeight * 0.5,
      draggable: true,
      child: Container(
        width: BottomDialog.dialogClearWidth(context),
        height: BottomDialog.dialogClearHeight(
          title: 'x',
          context: context,
          overridingDialogHeight: _screenHeight * 0.5,
        ),
        color: Colorz.Black255,
        child: imageFile != null ? Image.memory(imageFile) : Container(),
      ),
    );  }


  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    return DashBoardLayout(
      loading: _loading,
        pageTitle: 'Screenshot test',
        appBarRowWidgets: <Widget>[],
        listWidgets: <Widget>[

          Stratosphere(),

          Screenshot(
            controller: screenshotController,
            child: Container(
              width: _screenWidth * 0.8,
              height: _screenHeight * 0.4,
              color: Colorz.BloodTest,
              child: Center(
                child: SuperVerse(),
              ),
            ),
          ),

          if(_imageFile != null)
          Container(
            width: _screenWidth,
            height: 200,
            color: Colorz.White20,
            child: Center(
              child: Imagers.superImageWidget(
                _imageFile,
                fit: BoxFit.cover,
                width: _screenWidth,
                height: 200,
                scale: 1,

              ),
            ),
          ),

          DreamBox(
            width: 300,
            height: 50,
            margins: 20,
            iconSizeFactor: 0.7,
            icon: Iconz.Camera,
            verse: 'take screenshot',
            verseCentered: true,
            onTap: () async {

              screenshotController.capture(delay: Duration(milliseconds: 10))
                  .then((imageFile) async {

                setState(() {
                  _imageFile = imageFile;
                });

                await ShowBottomDialogWithImage(context, imageFile);

              }).catchError((onError) {
                print(onError);
              });
            },          ),

          DreamBox(
            width: 300,
            height: 50,
            margins: 20,
            iconSizeFactor: 0.7,
            icon: Iconz.Camera,
            verse: 'Capture invisible widget',
            verseCentered: true,
            onTap: () async {
              _imageFile = null;
              screenshotController.capture(delay: Duration(milliseconds: 10)).then(
                    (Uint8List imageFile) async {

                      setState(() {
                      _imageFile = imageFile;
                      });

                      await ShowBottomDialogWithImage(context, imageFile);


                    }
                    );
              },
          ),

        ],
    );
  }
}
