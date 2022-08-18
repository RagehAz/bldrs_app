import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/b_views/z_components/app_bar/app_bar_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class ImagesTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ImagesTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ImagesTestScreenState createState() => _ImagesTestScreenState();
/// --------------------------------------------------------------------------
}

class _ImagesTestScreenState extends State<ImagesTestScreen> {
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// XXXX
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  File _file;
  Uint8List uInt;
  img.Image imgImage;
  ui.Image uiImage;
  bool isLoading;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      loading: _loading,
      appBarWidgets: [

        /// GET IMAGE FROM GALLERY
        AppBarButton(
          icon: Iconz.phoneGallery,
          verse: 'take',
          onTap: () async {

            final File _pickedFile = await Imagers.pickAndCropSingleImage(
                context: context,
                cropAfterPick: false,
                isFlyerRatio: false,
            );

            if (_pickedFile != null){

              _loading.value = true;

              final Uint8List _uInt = await Floaters.getUint8ListFromFile(_pickedFile);
              final ui.Image _uiImage = await Floaters.getUiImageFromUint8List(_uInt);
              final img.Image _imgImage = await Floaters.getImgImageFromUint8List(_uInt);

              setState(() {
                _file = _pickedFile;
                uInt = _uInt;
                uiImage = _uiImage;
                imgImage = _imgImage;
              });

              _loading.value = false;

            }

          },
        ),

        /// CROP IMAGE
        AppBarButton(
          icon: _file,
          verse: 'crop',
          onTap: () async {

            final File _pickedFile = await Imagers.cropImage(
              context: context,
              pickedFile: _file,
              isFlyerRatio: false,
            );

            if (_pickedFile != null){

              _loading.value = true;

              final Uint8List _uInt = await Floaters.getUint8ListFromFile(_pickedFile);
              final ui.Image _uiImage = await Floaters.getUiImageFromUint8List(_uInt);
              final img.Image _imgImage = await Floaters.getImgImageFromUint8List(_uInt);

              setState(() {
                _file = _pickedFile;
                uInt = _uInt;
                uiImage = _uiImage;
                imgImage = _imgImage;
              });

              _loading.value = false;

            }

          },
        ),

        /// RESIZE
        AppBarButton(
          icon: Iconz.arrowDown,
          verse: 'resize',
          onTap: () async {

            final File _pickedFile = await Imagers.resizeImage(
                file: _file,
                finalWidth: 10,
                aspectRatio: 1
            );

            if (_pickedFile != null){

              _loading.value = true;

              final Uint8List _uInt = await Floaters.getUint8ListFromFile(_pickedFile);
              final ui.Image _uiImage = await Floaters.getUiImageFromUint8List(_uInt);
              final img.Image _imgImage = await Floaters.getImgImageFromUint8List(_uInt);

              setState(() {
                _file = _pickedFile;
                uInt = _uInt;
                uiImage = _uiImage;
                imgImage = _imgImage;
              });

              _loading.value = false;

            }

          },
        ),

      ],
      listWidgets: <Widget>[

        ValueListenableBuilder(
            valueListenable: _loading,
            builder: (_, bool isLoading, Widget child){

              if (isLoading == true){
                return const LoadingFullScreenLayer();
              }

              else {

                return Column(
                  children: <Widget>[

                    /// TAMAM : FILE
                    WideButton(
                      verse: 'FILE : $_file',
                      icon: _file,
                      iconSizeFactor: 1,
                      verseScaleFactor: 0.6,
                      // onTap: () async {
                      //
                      //   blog('fuck this');
                      //
                      // },
                    ),

                    /// TAMAM : uInt8List
                    WideButton(
                      verse: 'uInt8List : ${Numeric.formatNumToCounterCaliber(context, uInt?.length)} nums',
                      icon: uInt,
                      iconSizeFactor: 1,
                      verseScaleFactor: 0.6,
                      // onTap: () async {
                      //
                      //   // final Uint8List _uInt = await Floaters.getUint8ListFromFile(_file);
                      //   //
                      //   // setState(() {
                      //   //   uInt = _uInt;
                      //   // });
                      //
                      // },
                    ),

                    /// TAMAM : uiImage
                    WideButton(
                      verse: 'uiImage : ${uiImage?.toString()}',
                      icon: uiImage,
                      iconSizeFactor: 1,
                      verseScaleFactor: 0.6,
                      // onTap: () async {
                      //
                      //   // final ui.Image _uiImage = await Floaters.getUiImageFromUint8List(uInt);
                      //   //
                      //   // setState(() {
                      //   //   uiImage = _uiImage;
                      //   // });
                      //   //
                      //   // blog('fuck this');
                      //
                      // },
                    ),

                    /// imgImage
                    WideButton(
                      verse: 'imgImage : ${imgImage?.toString()}',
                      icon: imgImage,
                      iconSizeFactor: 1,
                      verseScaleFactor: 0.6,
                      // onTap: () async {
                      //
                      //   // blog('${imgImage.channels.name}');
                      //
                      //   // final img.Image _imgImage = await Floaters.getImgImageFromUint(uInt);
                      //   //
                      //   // setState(() {
                      //   //   imgImage = _imgImage;
                      //   // });
                      //
                      // },
                    ),

                  ]
                );

              }

            },
        ),

      ],
    );

  }

}
