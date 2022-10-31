import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/a_models/x_utilities/keyboard_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/d_user_search_screen/search_users_screen.dart';
import 'package:bldrs/b_views/j_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_controller.dart';
import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_counter_builder.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_screen/keyboard_screen.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/ui_manager/bldrs_icons_screen.dart';
import 'package:bldrs/x_dashboard/ldb_manager/ldb_viewer_screen.dart';
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
  final StopWatchController stopWatchController = StopWatchController();
  // --------------------
  final double _aspectRatio = 1;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    stopWatchController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  File _file;
  Uint8List uInt;
  img.Image imgImage;
  ui.Image uiImage;
  String _ldbBase64;
  // --------------------
  Dimensions _imageSize;
  bool isLoading;
  // --------------------
  Future<void> setImage(FileModel fileModel) async {

    stopWatchController.stop();

    if (fileModel != null){

      _loading.value = true;
      stopWatchController.start();


      final Uint8List _uInt = await Floaters.getUint8ListFromFile(fileModel.file);
      final ui.Image _uiImage = await Floaters.getUiImageFromUint8List(_uInt);
      final img.Image _imgImage = await Floaters.getImgImageFromUint8List(_uInt);
      final Dimensions _size = await Dimensions.superDimensions(fileModel.file);
      await LDBOps.insertMap(
        docName: 'tempPicDoc',
        input: {
          'id': 'ldbBase64',
          'data' : await Floaters.getBase64FromFileOrURL(fileModel.file),
        },
      );

      String _base64FromLDB;
      final List<Map<String, dynamic>> _mapBase64 = await LDBOps.readMaps(
          ids: ['ldbBase64'],
          docName: 'tempPicDoc',
      );
      if (Mapper.checkCanLoopList(_mapBase64) == true){
        _base64FromLDB = _mapBase64.first['data'];
      }

      setState(() {
        _file = fileModel.file;
        uInt = _uInt;
        uiImage = _uiImage;
        imgImage = _imgImage;
        _ldbBase64 = _base64FromLDB;

        _imageSize = _size;
      });

      _loading.value = false;
      stopWatchController.pause();

    }


  }
  // --------------------
  void _clearImage(){
    setState(() {
      _file = null;
      uInt = null;
      uiImage = null;
      imgImage = null;
      _ldbBase64 = null;

      _imageSize = null;
      isLoading = false;
    });
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _buttonWidth = PageBubble.clearWidth(context);

    final List<Map<String, dynamic>> _maps = [
      {'pic' : _file,       'text' : 'FILE : $_file'},
      {'pic' : uInt,        'text' : 'uInt8List : ${Numeric.formatNumToCounterCaliber(context, uInt?.length)} nums'},
      {'pic' : imgImage,    'text' : 'imgImage : ${imgImage?.toString()}'},
      {'pic' : uiImage,     'text' : 'uiImage : ${uiImage?.toString()}'},
      {'pic' : _ldbBase64,  'text' : 'ldbBase64 : $_ldbBase64'},
    ];

    return MainLayout(
      loading: _loading,
      appBarType: AppBarType.scrollable,
      appBarRowWidgets: <Widget>[

        /// GALLERY PICK
        AppBarButton(
          icon: Iconz.phoneGallery,
          onTap: () async {

            final FileModel _pickedFileModel = await Imagers.pickAndCropSingleImage(
                context: context,
                cropAfterPick: false,
                aspectRatio: _aspectRatio,
            );

            await setImage(_pickedFileModel);

          },
        ),

        /// CAMERA PICK
        AppBarButton(
          icon: Iconz.camera,
          onTap: () async {

            final FileModel _pickedFileModel = await Imagers.shootAndCropCameraImage(
              context: context,
              cropAfterPick: false,
              aspectRatio: _aspectRatio,
            );

            await setImage(_pickedFileModel);

          },
        ),

        /// URL
        AppBarButton(
          icon: Iconz.comWebsite,
          onTap: () async {

            final UserModel _user = await SearchUsersScreen.selectUser(context);

            if (_user != null){

              await _triggerLoading(setTo: true);

              final FileModel _pickedFileModel = await FileModel.createModelByUrl(
                url: _user.pic,
                fileName: _user.id,
              );

              await setImage(_pickedFileModel);

            }

          },
        ),

        /// ASSET
        AppBarButton(
          icon: Iconz.dvDonaldDuck,
          onTap: () async {

            final String _icon = await BldrsIconsScreen.selectIcon(context);

            blog('icon is : $_icon');

            if (_icon != null){

              await _triggerLoading(setTo: true);

              final File _file = await Filers.getFileFromLocalRasterAsset(
                localAsset: _icon,
              );

              if (_file != null){
                final FileModel _pickedFileModel = FileModel.createModelByNewFile(_file);
                await setImage(_pickedFileModel);
              }

              await _triggerLoading(setTo: false);

            }

          },
        ),

        /// SEPARATOR
        const DotSeparator(boxWidth: 20,),

        /// CROP IMAGE
        AppBarButton(
          icon: Iconz.crop,
          onTap: () async {

            final FileModel _pickedFileModel = await Imagers.cropImage(
              context: context,
              pickedFile: FileModel.createModelByNewFile(_file),
              aspectRatio: _aspectRatio,
              // resizeToWidth: null,
            );

            await setImage(_pickedFileModel);

          },
        ),

        /// RESIZE
        AppBarButton(
          icon: Iconz.resize,
          onTap: () async {

            final String _result = await Nav.goToNewScreen(
                context: context,
                screen: KeyboardScreen(
                  screenTitleVerse: const Verse(
                    text: 'Crop Image',
                    translate: false,
                  ),
                  keyboardModel: KeyboardModel.standardModel().copyWith(
                    textInputType: TextInputType.number,
                    titleVerse: const Verse(
                      text: 'Add new width',
                      translate: false,
                    ),
                    hintVerse: Verse(
                      text: 'width was ${uiImage?.width}',
                      translate: false,
                    ),
                  ),
                ),
            );

            if (TextCheck.isEmpty(_result) == false){

              final double _value = Numeric.transformStringToDouble(_result);

              final File _pickedFile = await Filers.resizeImage(
                  file: _file,
                  finalWidth: _value,
              );

              await setImage(FileModel.createModelByNewFile(_pickedFile));

            }

          },
        ),

        /// CLEAR
        AppBarButton(
          icon: Iconz.xLarge,
          onTap: _clearImage,
        ),

        /// SEPARATOR
        const DotSeparator(boxWidth: 20,),

        /// LDB
        AppBarButton(
          icon: Iconz.form,
          onTap: () async {

            await Nav.goToNewScreen(
                context: context,
                screen: const LDBViewerScreen(
                  ldbDocName:'tempPicDoc',
                ),
            );

          },
        ),

        /// SEPARATOR
        const DotSeparator(boxWidth: 20,),

        /// UPLOAD TO STORAGE AND GET URL
        AppBarButton(
          icon: Iconz.arrowUp,
          isDeactivated: true,
          onTap: () async {

           await  _triggerLoading(setTo: true);

            // final String url = await Storage.createStoragePicAndGetURL(
            //     context: context,
            //     docName: 'admin',
            //     fileName: NoteModel.bldrsFCMIconFireStorageFileName,
            //     ownersIDs: [AuthFireOps.superUserID()],
            //     inputFile: await Filers.getFileFromBase64(_ldbBase64),
            // );

            // await Dialogs.showSuccessDialog(
            //     context: context,
            //     firstLine: const Verse(
            //       text: 'Image uploaded successfully',
            //       translate: false,
            //     ),
            //   secondLine: Verse.plain(url),
            // );
            //
            // await Keyboard.copyToClipboard(context: context, copy: url);

           await  _triggerLoading(setTo: false);

          },
        ),

        /// SEPARATOR
        const DotSeparator(boxWidth: 20,),

        /// CLEAR CACHE
        AppBarButton(
          icon: Iconz.power,
          onTap: () async {

            // await  _triggerLoading(setTo: true);

            imageCache.clear();
            blog('imageCache.clear() : DONE');
            imageCache.clearLiveImages();
            blog('imageCache.clearLiveImages() : DONE');
            PaintingBinding.instance.imageCache.clear();
            blog('iPaintingBinding.instance.imageCache.clear() : DONE');

            setState(() {});
            // await  _triggerLoading(setTo: false);

          },
        ),

      ],
      layoutWidget: ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool isLoading, Widget child){

          if (isLoading == true){
            return const LoadingFullScreenLayer();
          }

          else {
            return Stack(
              children: <Widget>[

                SizedBox(
                  child: SingleChildScrollView(
                    padding: Stratosphere.stratosphereSandwich,
                    physics: const BouncingScrollPhysics(),
                    child:Column(
                        children: <Widget>[

                          StopWatchCounterBuilder(
                            controller: stopWatchController,
                            builder: (String displayTime){

                              return DataStrip(
                                dataKey: 'Loading duration',
                                dataValue: displayTime,
                                tooTipVerse: Verse.plain(
                                    'this includes all functions transforming to'
                                        ' (file, uInt, imgImage, uiImage, ldbBase64)'
                                ),
                              );

                            },
                          ),

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

                          /// FILE NAME
                          DataStrip(
                            dataKey: 'Name',
                            dataValue: Filers.getFileNameFromFile(
                              file: _file,
                              withExtension: true,
                            ),
                            tooTipVerse: Verse.plain(
                                'this splits ( file.path ) property of ( File ) '
                                'variable and gets the last part after last ( / ) '
                                'in path string'
                            ),
                          ),

                          /// EXTENSION
                          DataStrip(
                            dataKey: 'Ext.',
                            dataValue: _file?.path == null ? '' : TextMod.removeTextBeforeLastSpecialCharacter(extension(_file?.path), '.'),
                            tooTipVerse: Verse.plain(
                                'this splits ( file.path ) property of ( File ) '
                                'and get the last part after the last ( . )'
                            ),
                          ),

                          /// FILE PATH
                          DataStrip(
                            dataKey: 'Path',
                            dataValue: _file?.path,
                            tooTipVerse: Verse.plain(
                                'This is the ( file.path ) of ( File ) variable'
                            ),
                          ),

                          /// FILE SIZE (Byte)
                          DataStrip(
                            dataKey: 'Size (b)',
                            dataValue: '${Numeric.formatNumToSeparatedKilos(number: _file?.lengthSync())} Bytes',
                            color: Colorz.blue80,
                            tooTipVerse: Verse.plain(
                                'This is : ( file.lengthSync() )'
                            ),
                          ),

                          /// FILE SIZE (KB)
                          DataStrip(
                            dataKey: 'Size (Kb)',
                            dataValue: '${Filers.getFileSizeWithUnit(
                              file: _file,
                              unit: FileSizeUnit.kiloByte,
                            )} KiloByte',
                            color: Colorz.blue80,
                            tooTipVerse: Verse.plain(
                                'This is : ( file.lengthSync() / 1024 )'
                            ),
                          ),

                          /// FILE SIZE (MB)
                          DataStrip(
                            dataKey: 'Size (Mb)',
                            dataValue: '${Filers.getFileSizeInMb(_file)} MegaBytes',
                            color: Colorz.blue80,
                            tooTipVerse: Verse.plain(
                                'This is : [ file.lengthSync() / (1024 * 1024) ]'
                            ),
                          ),

                          /// FILE SIZE
                          DataStrip(
                            dataKey: 'Width x Height',
                            dataValue: '[ w ${uiImage?.width} px ] . [ h ${uiImage?.height} px ]',
                            color: Colorz.black150,
                            tooTipVerse: Verse.plain(
                                'This is : ( uiImage.width * uiImage.height )'
                            ),

                          ),

                          /// SUPER SIZE
                          FutureBuilder(
                              future: Dimensions.superDimensions(_file),
                              builder: (_, AsyncSnapshot<Dimensions> snapshot){

                                final Dimensions imageSize = snapshot.data;

                                return DataStrip(
                                  dataKey: 'SUPER SIZE',
                                  dataValue: '[ w ${imageSize?.width} px ] . [ h ${imageSize?.height} px ]',
                                  color: Colorz.black150,
                                  tooTipVerse: Verse.plain(
                                      'This is : ( Dimensions.superDimensions( dynamic ) .'
                                  ),

                                );

                              }
                          ),

                          /// ASPECT RATIO
                          DataStrip(
                            dataKey: 'Aspect Ratio',
                            dataValue: '${_imageSize?.getAspectRatio()}',
                            color: Colorz.black150,
                            tooTipVerse: Verse.plain(
                                'This is : ( width / height ) .'
                            ),
                          ),

                          /// IMAGES GRID
                          if (_file != null)
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(20),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: _imageSize?.getAspectRatio() ?? 1,
                                // mainAxisExtent: PageBubble.width(context),
                              ),
                              itemCount: _maps.length,
                              itemBuilder: (_, int index){

                                final Map<String, dynamic> _map = _maps[index];

                                return ImageTile(
                                    pic: _map['pic'],
                                    text: _map['text'],
                                    tileWidth: (PageBubble.width(context) - 20) / 3,
                                    imageSize: _imageSize
                                );

                              },
                            ),

                          /// SEPARATOR
                          const SeparatorLine(),

                          /// CACHE
                          SuperVerse(
                              verse: Verse.plain('Cache'),
                          ),

                          /// CURRENT SIZE
                          DataStrip(
                            dataKey: 'current Size',
                            dataValue: '${imageCache.currentSize} ',
                            color: Colorz.yellow20,
                          ),

                          /// CURRENT SIZE BYTES
                          DataStrip(
                            dataKey: 'current Size Bytes',
                            dataValue: '${imageCache.currentSizeBytes} Bytes',
                            color: Colorz.yellow20,
                          ),

                          /// LIVE IMAGE COUNT
                          DataStrip(
                            dataKey: 'liveImageCount',
                            dataValue: '${imageCache.liveImageCount} ',
                            color: Colorz.yellow20,
                          ),

                          /// PENDING IMAGE COUNT
                          DataStrip(
                            dataKey: 'pendingImageCount',
                            dataValue: '${imageCache.pendingImageCount} ',
                            color: Colorz.yellow20,
                          ),

                          const Horizon(),

                        ]
                    ),


                  ),
                ),

                if (uiImage != null)
                CornerWidgetMaximizer(
                  minWidth: 70,
                  maxWidth: uiImage?.width?.toDouble(),
                  childWidth: uiImage?.width?.toDouble(),

                  child: SuperImage(
                    width: uiImage?.width?.toDouble(),
                    height: uiImage?.height?.toDouble(),
                    pic: _file,
                    loading: isLoading,
                  ),
                  // child: SizedBox(
                  //   width: uiImage?.width?.toDouble(),
                  //   height: uiImage?.height?.toDouble(),
                  //   child: ZoomablePicture(
                  //     isOn: true,
                  //     isFullScreen: true,
                  //     autoShrink: false,
                  //     child: SuperFilteredImage(
                  //         filterModel: ImageFilterModel.bldrsImageFilters[2],
                  //         imageFile: _file,
                  //         width: uiImage?.width?.toDouble(),
                  //         height: uiImage?.height?.toDouble(),
                  //     ),
                  //   ),
                  // ),
                ),

              ],
            );
          }

        },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class ImageTile extends StatelessWidget {

  const ImageTile({
    @required this.pic,
    @required this.tileWidth,
    @required this.imageSize,
    @required this.text,
    Key key
  }) : super(key: key);

  final dynamic pic;
  final double tileWidth;
  final Dimensions imageSize;
  final String text;

  @override
  Widget build(BuildContext context) {

    if (pic == null){
      return const SizedBox();
    }

    else {

      final double _picHeight = Dimensions.getHeightByAspectRatio(
        width: tileWidth,
        aspectRatio: imageSize.getAspectRatio(),
      );

      return GestureDetector(
        onTap: () => Nav.goToNewScreen(context: context, screen: SlideFullScreen(image: pic, imageSize: imageSize)),
        child: SizedBox(
          width: tileWidth,
          height: _picHeight,
          child: Stack(
            children: <Widget>[

              SuperImage(
                width: tileWidth,
                height: _picHeight,
                pic: pic,
              ),

              SuperVerse(
                width: tileWidth - 10,
                verse: Verse.plain(text),
                margin: 5,
                labelColor: Colorz.black200,
                maxLines: 3,
                size: 1,
              ),

            ],
          ),
        ),
      );

    }
  }

}
