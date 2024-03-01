import 'dart:io';
import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/drawing/expander.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/panel_circle_button.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/i_gt_insta_screen/src/screens/video_player_screen.dart';
import 'package:bldrs/v_videos/trim_video_screen.dart';
import 'package:bldrs/v_videos/video_ops.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class VideoEditorScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoEditorScreen({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _VideoEditorScreenState createState() => _VideoEditorScreenState();
// --------------------------------------------------------------------------
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  VideoEditorController? _videoEditorController;
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
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _videoEditorController?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  void _setVideo(File file){

    _videoEditorController = VideoEditorController.file(
      file,
      minDuration: const Duration(seconds: 1),
      maxDuration: const Duration(seconds: 10),
    );

    // await _videoEditorController?.initialize();

    _videoEditorController!
        .initialize(aspectRatio: 9 / 16)
        .then((_) => setState(() {}))
        .catchError((error) {
      // handle minumum duration bigger than video duration error
      Navigator.pop(context);
    }, test: (e) => e is VideoMinDurationError);


  }

  File? _videoFile;
  // --------------------
  Future<void> _picVideoFromGallery() async {

    final File? _file = await PicMaker.pickVideo(
        context: context,
        langCode: Localizer.getCurrentLangCode(),
        onPermissionPermanentlyDenied: BldrsPicMaker.onPermissionPermanentlyDenied,
        onError: BldrsPicMaker.onPickingError,
    );

    // final File? _file = await Filers.getFileFromUint8List(
    //     uInt8List: _output,
    //     fileName: 'test_file',
    // );

    if (_file != null){

      blog('setting the bitch');
      setState(() {
        _videoFile = _file;
      });

      _setVideo(_videoFile!);

    }

  }
  // --------------------
  Future<void> _picVideoFromCamera() async {}
  // --------------------
  Future<void> _trimVideo() async {

    setState(() {
      _isTrimming = !_isTrimming;
    });

  }
  // --------------------
  Future<void> _cropVideo() async {}
  // --------------------
  Future<void> _resizeVideo() async {}
  // --------------------
  Future<void> _compressVideo() async {}
  // --------------------
  Future<void> _muteVideo() async {}
  // --------------------
  Future<void> _goToEditor() async {

    if (_videoFile != null){
      final Uint8List? _bytes = await BldrsNav.goToNewScreen(
          screen: TrimScreen(
            file: _videoFile!,
          )
      );

      if (_bytes != null){

        // final Uint8List _bytes = await _file.readAsBytes();

        _videoFile = await Filers.getFileFromUint8List(
            uInt8List: _bytes,
            fileName: Numeric.createUniqueID().toString(),
        );

        _setVideo(_videoFile!);

      }

    }
  }
  // -----------------------------------------------------------------------------
  bool _isTrimming = false;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _panelHeight = 70;
    const double _buttonSize = _panelHeight - 5;
    const double _editorBarHeight = 70;
    final double _bodyHeight = Scale.screenHeight(context) - _panelHeight - _editorBarHeight;
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      loading: _loading,
      title: Verse.plain('Video Editor'),
      appBarRowWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.more,
          onTap: () async {

            blog('w ba3den ?');

            // VideoOps.blogVideoEditorController(
            //   controller: _videoEditorController,
            // );

            await BottomDialog.showButtonsBottomDialog(
              numberOfWidgets: 2,
                buttonHeight: 30,
                // titleVerse: Verse.plain('Stuff'),
                builder: (_, __){

                return [

                  /// UPDATE TRIM
                  BottomDialog.wideButton(
                    verse: Verse.plain('update trim'),
                    onTap: () async {

                      _videoEditorController?.updateTrim(0.5, 1);

                    },
                  ),

                  /// CROP ASPECT RATIO
                  BottomDialog.wideButton(
                    verse: Verse.plain('crop Aspect Ratio'),
                    onTap: () async {
                      _videoEditorController?.cropAspectRatio(1);
                    },
                  ),

                  /// PLAY FILE IN PLAYER
                  BottomDialog.wideButton(
                    verse: Verse.plain('Play file in player'),
                    onTap: () async {
                      final File? _file = _videoEditorController?.file;
                      await Keyboard.copyToClipboardAndNotify(copy: _file?.path);
                      await VideoPlayerScreen.playFile(file: _file);
                    },
                  ),


                ];

                },
            );

          },
        ),

      ],
      child: Column(
        children: <Widget>[

          /// VIDEO
          SizedBox(
            width: _screenWidth,
            height: _bodyHeight,
            child: FloatingList(
              width: _screenWidth,
              height: _bodyHeight,
              columnChildren: <Widget>[

                const Stratosphere(),


                // if (_videoFile != null)
                // SuperVideoPlayer(
                //   file: _videoFile,
                //   width: _screenWidth,
                // ),

                if (Mapper.boolIsTrue(_videoEditorController?.initialized) == true)
                  SizedBox(
                    height: _bodyHeight - Stratosphere.smallAppBarStratosphere - 10,
                    child: CropGridViewer.preview(
                        controller: _videoEditorController!
                    ),
                  ),

              ],
            ),
          ),

          if (_isTrimming == false)
            const Expander(),

          /// TRIM BAR
          if (_isTrimming == true && Mapper.boolIsTrue(_videoEditorController?.initialized) == true)
          Container(
            width: _screenWidth,
            height: _editorBarHeight,
            color: Colorz.bloodTest,
            child: TrimSlider(
              controller: _videoEditorController!,
              height: _editorBarHeight-20,
              horizontalMargin: 10,
              child: TrimTimeline(
                controller: _videoEditorController!,
                // padding: const EdgeInsets.only(top: 10),
              ),
            ),
          ),

          /// BOTTOM BAR
          FloatingList(
            width: _screenWidth,
            height: _panelHeight,
            boxColor: Colorz.blue20,
            scrollDirection: Axis.horizontal,
            columnChildren: <Widget>[

              /// PICK
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.video,
                verse: Verse.plain('Pick'),
                isSelected: false,
                onTap: _picVideoFromGallery,
              ),

              /// SHOOT
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.recorder,
                verse: Verse.plain('Shoot'),
                isSelected: false,
                onTap: _picVideoFromCamera,
              ),

              /// TRIM
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.cut,
                verse: Verse.plain('Trim'),
                isSelected: _isTrimming,
                onTap: _trimVideo,
              ),


              /// CROP
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.crop,
                verse: Verse.plain('Crop'),
                isSelected: false,
                onTap: () async {},
              ),

              /// RESIZE
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.resize,
                verse: Verse.plain('Resize'),
                isSelected: false,
                onTap: () async {},
              ),

              /// COMPRESS
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.compress,
                verse: Verse.plain('Compress'),
                isSelected: false,
                onTap: () async {},
              ),

              /// MUTE
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.volume_mute,
                verse: Verse.plain('Mute'),
                isSelected: false,
                onTap: () async {},
              ),

              /// PLAY
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.play_arrow,
                verse: Verse.plain('play.'),
                isSelected: false,
                onTap: _goToEditor,

              ),
            ],
          ),

        ],
      ),
    );
    // --------------------
  }

  // -----------------------------------------------------------------------------
}
