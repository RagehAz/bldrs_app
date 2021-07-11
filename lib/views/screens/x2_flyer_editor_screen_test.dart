import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/zoomable_widget.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/views/screens/x3_slide_full_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class FlyerEditorScreenTest extends StatefulWidget {

  @override
  _FlyerEditorScreenTestState createState() => _FlyerEditorScreenTestState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _FlyerEditorScreenTestState extends State<FlyerEditorScreenTest> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  AppState state;
  File _imageFile;
  BoxFit _botFit;
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
  void initState() {
    // _imageFile = File('');
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _pickImage() async {
    PicType picType = PicType.slideHighRes;

     // _imageFile = await takeGalleryPicture(PicType.slideHighRes);
     final _picker = ImagePicker();

     final _file = await _picker.getImage(
         source: ImageSource.gallery,
         imageQuality: concludeImageQuality(picType),
         // maxWidth: concludeImageMaxWidth(picType),
         maxHeight: Scale.superScreenHeight(context),
     );

     // if (_imageFile != null) {
      setState(() {
        _imageFile = File(_file.path);
        state = AppState.picked;
      });
    // }

  }
// -----------------------------------------------------------------------------
  Future<void> _cropImage() async {

    double _flyerWidthRatio = 1;
    double _flyerHeightRatio = Ratioz.xxflyerZoneHeight; // 1.74

    // flyer ratio would be (1 x 1.74)

    List<CropAspectRatioPreset> _androidRatios = <CropAspectRatioPreset>[
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
    ];

    List<CropAspectRatioPreset> _notAndroidRatios = <CropAspectRatioPreset>[
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9
    ];

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: Ratioz.xxflyerZoneHeight),
        aspectRatioPresets: Platform.isAndroid ? _androidRatios : _notAndroidRatios,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop flyer Aspect Ratio 1 : ${Ratioz.xxflyerZoneHeight}',
            toolbarColor: Colorz.Yellow,
            toolbarWidgetColor: Colorz.DarkBlue,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Crop flyer Aspect Ratio 1 : ${Ratioz.xxflyerZoneHeight}',
          doneButtonTitle: 'Done babe',

        ));
    if (croppedFile != null) {
      _imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }
// -----------------------------------------------------------------------------
  void _clearImage() {
    _imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
// -----------------------------------------------------------------------------
  void _setBoxFitTo(BoxFit fit){
    setState(() {
      _botFit = fit;
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    Widget _button({String icon, String verse, @required Function onTap}){

      double _size = 35;
      double _width = verse == null ? _size : null;

      return
        DreamBox(
          height: _size,
          width: _width,
          verse: verse,
          verseWeight: VerseWeight.thin,
          verseScaleFactor: 0.8,
          icon: icon,
          iconSizeFactor: 0.6,
          margins: 5,
          onTap: onTap,
        );
    }

    double _flyerSizeFactor = 0.65;
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerZoneWidth);

    return MainLayout(
      pageTitle: 'Image cropper test',
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      loading: _loading,
      appBarRowWidgets: <Widget>[

      ],
      layoutWidget: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[

              Stratosphere(),

              FlyerZone(
                tappingFlyerZone: (){},
                flyerSizeFactor: _flyerSizeFactor,
                onLongPress: (){},
                stackWidgets: <Widget>[

                  ZoomableWidget(
                    child: Container(
                      width: _flyerZoneWidth,
                      height: _flyerZoneHeight,
                      color: Colorz.Nothing,
                      child:
                      _imageFile == null ?
                      DreamBox(
                        width: _flyerZoneWidth,
                        height: _flyerZoneHeight,
                        verse: 'Nothing',
                        verseScaleFactor: 0.7,
                        bubble: false,
                        color: Colorz.BabyBluePlastic,
                      )
                          :
                      Container(
                        child: superImageWidget(
                          _imageFile,
                          width: 300,
                          height: 300,
                          fit: _botFit,
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              /// imagePreview

              Container(
                child: Column(
                  children: <Widget>[

                    /// editors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        _button(
                          icon: Iconz.Gallery,
                          onTap: () async {await _pickImage();},
                        ),

                        _button(
                          icon: Iconz.BxDesignsOff,
                          onTap: () async {await _cropImage();},
                        ),

                        _button(
                          icon: Iconz.XLarge,
                          onTap: () async {await _clearImage();},
                        ),

                        _button(
                          icon: Iconz.ArrowRight,
                          onTap: () async {await Nav.goToNewScreen(context, SlideFullScreen(image: _imageFile,));},
                        ),

                      ],
                    ),

                    /// box fit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        _button(
                          verse: 'Contain',
                          onTap: () => _setBoxFitTo(BoxFit.contain),
                        ),

                        _button(
                          verse: 'Cover',
                          onTap: () => _setBoxFitTo(BoxFit.cover),
                        ),

                        _button(
                          verse: 'fill',
                          onTap: () => _setBoxFitTo(BoxFit.fill),
                        ),

                        _button(
                          verse: 'fit height',
                          onTap: () => _setBoxFitTo(BoxFit.fitHeight),
                        ),

                        _button(
                          verse: 'fit width',
                          onTap: () => _setBoxFitTo(BoxFit.fitWidth),
                        ),

                        _button(
                          verse: 'none',
                          onTap: () => _setBoxFitTo(BoxFit.none),
                        ),

                        _button(
                          verse: 'Scale down',
                          onTap: () => _setBoxFitTo(BoxFit.scaleDown),
                        ),

                      ],
                ),


                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}