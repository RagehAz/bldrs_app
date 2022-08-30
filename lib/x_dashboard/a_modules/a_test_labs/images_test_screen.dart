import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/app_bar/app_bar_button.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';

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
      onBldrsTap: (){
        setState(() {
          _file = null;
          uInt = null;
          uiImage = null;
          imgImage = null;

        });
      },
      appBarWidgets: [

        /// GET IMAGE FROM GALLERY
        AppBarButton(
          icon: Iconz.phoneGallery,
          verse: '##Take',
          onTap: () async {

            final FileModel _pickedFileModel = await Imagers.pickAndCropSingleImage(
                context: context,
                cropAfterPick: false,
                isFlyerRatio: false,
            );

            if (_pickedFileModel != null){

              _loading.value = true;

              final Uint8List _uInt = await Floaters.getUint8ListFromFile(_pickedFileModel.file);
              final ui.Image _uiImage = await Floaters.getUiImageFromUint8List(_uInt);
              final img.Image _imgImage = await Floaters.getImgImageFromUint8List(_uInt);

              setState(() {
                _file = _pickedFileModel.file;
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
          verse: '##Crop',
          onTap: () async {

            final FileModel _pickedFileModel = await Imagers.cropImage(
              context: context,
              pickedFile: FileModel.createModelByNewFile(_file),
              isFlyerRatio: false,
              // resizeToWidth: null,
            );

            if (_pickedFileModel != null){

              _loading.value = true;

              final Uint8List _uInt = await Floaters.getUint8ListFromFile(_pickedFileModel.file);
              final ui.Image _uiImage = await Floaters.getUiImageFromUint8List(_uInt);
              final img.Image _imgImage = await Floaters.getImgImageFromUint8List(_uInt);

              setState(() {
                _file = _pickedFileModel.file;
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
          verse: '##resize',
          onTap: () async {

            final File _pickedFile = await Filers.resizeImage(
                file: _file,
                finalWidth: 1080,
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

                blog('kos omkla');

                return Column(
                  children: <Widget>[

                    /// META DATA
                    // WideButton(
                    //   verse:  'get Meta data',
                    //   onTap: () async {
                    //
                    //     /// TO CHANGE META DATA OF SPECIFIC FILE
                    //     // // bSHZNhydCNqQFvEVK8Rc
                    //     //
                    //     // final FullMetadata _meta = await Storage.getMetadataByFileName(
                    //     //     context: context,
                    //     //     storageDocName: StorageDoc.logos,
                    //     //     fileName: 'bSHZNhydCNqQFvEVK8Rc',
                    //     // );
                    //     //
                    //     // Map<String, String> _maw = _meta.customMetadata;
                    //     // _maw['extension'] = 'png';
                    //     //
                    //     // final SettableMetadata metaData = SettableMetadata(
                    //     //   customMetadata: _maw,
                    //     // );
                    //     //
                    //     // final Reference _ref = Storage.getRef(
                    //     //   context: context,
                    //     //   storageDocName: StorageDoc.logos,
                    //     //   fileName: 'bSHZNhydCNqQFvEVK8Rc',
                    //     // );
                    //     //
                    //     // await _ref.updateMetadata(metaData);
                    //
                    //   },
                    // ),

                    const SeparatorLine(),

                    /// TAMAM : FILE
                    WideButton(
                      translate: false,
                      verse:  'FILE : $_file',
                      icon: _file,
                      iconSizeFactor: 1,
                      verseScaleFactor: 0.6,

                    ),

                    /// TAMAM : uInt8List
                    WideButton(
                      translate: false,
                      verse:  'uInt8List : ${Numeric.formatNumToCounterCaliber(context, uInt?.length)} nums',
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
                      translate: false,
                      verse:  'uiImage : ${uiImage?.toString()}',
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
                      //   // blog('getUiImageFromUint8List image test screen');
                      //
                      // },
                    ),

                    /// imgImage
                    WideButton(
                      translate: false,
                      verse:  'imgImage : ${imgImage?.toString()}',
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

                    const SeparatorLine(),

                    /// FILE NAME
                    DataStrip(
                        dataKey: 'Name',
                        dataValue: Filers.getFileNameFromFile(
                          file: _file,
                          withExtension: true,
                        ),
                    ),

                    /// FILE PATH
                    DataStrip(
                      dataKey: 'Path',
                      dataValue: _file?.path,
                    ),

                    /// FILE SIZE (Byte)
                    DataStrip(
                      dataKey: 'Size (b)',
                      dataValue: _file?.lengthSync(),
                    ),

                    /// FILE SIZE (MB)
                    DataStrip(
                      dataKey: 'Size (Mb)',
                      dataValue: Filers.getFileSize(_file),
                    ),

                    /// FILE SIZE
                    DataStrip(
                      dataKey: 'Width x Height',
                      dataValue: '[ w ${uiImage?.width} px ] . [ h ${uiImage?.height} px ]',
                    ),

                    /// SUPER SIZE
                    FutureBuilder(
                        future: ImageSize.superImageSize(_file),
                        builder: (_, AsyncSnapshot<ImageSize> snapshot){

                          final ImageSize imageSize = snapshot.data;

                          return DataStrip(
                            dataKey: 'SUPER SIZE',
                            dataValue: '[ w ${imageSize?.width} px ] . [ h ${imageSize?.height} px ]',
                          );

                        }
                    ),

                    /// EXTENSION
                    DataStrip(
                      dataKey: 'Ext.',
                      dataValue: _file?.path == null ? '' : TextMod.removeTextBeforeLastSpecialCharacter(extension(_file?.path), '.'),
                    ),

                  ]
                );

              }

            },
        ),

        const Horizon(),

      ],
    );

  }

}
