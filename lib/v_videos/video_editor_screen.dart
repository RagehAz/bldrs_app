import 'dart:io';
import 'dart:typed_data';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:basics/mediator/super_video_player/a_super_video_player.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/panel_circle_button.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_pic_maker.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/v_videos/the_screen.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

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
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  File? _videoFile;
  // --------------------
  Future<void> _picVideoFromGallery() async {

    final Uint8List? _output = await PicMaker.pickVideo(
        context: context,
        langCode: Localizer.getCurrentLangCode(),
        onPermissionPermanentlyDenied: BldrsPicMaker.onPermissionPermanentlyDenied,
        onError: BldrsPicMaker.onPickingError,
    );

    final File? _file = await Filers.getFileFromUint8List(
        uInt8List: _output,
        fileName: 'test_file',
    );

    if (_file != null){


      setState(() {
        _videoFile = _file;
      });

    }

  }
  // --------------------
  Future<void> _picVideoFromCamera() async {}
  // --------------------
  Future<void> _trimVideo() async {}
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
      await BldrsNav.goToNewScreen(
          screen: TheVideoEditorScreen(
            file: _videoFile!,
          )
      );

    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _panelHeight = 70;
    const double _buttonSize = _panelHeight - 5;
    final double _bodyHeight = Scale.screenHeight(context) - _panelHeight;
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


            await BottomDialog.showBottomDialog(
                height: 100,
                child: Container(
                  width: BottomDialog.clearWidth(),
                  height: BottomDialog.clearHeight(context: context),
                  color: Colorz.bloodTest,
                ),
            );

          },
        ),

      ],
      child: Column(
        children: <Widget>[

          SizedBox(
            width: _screenWidth,
            height: _bodyHeight,
            child: FloatingList(
              width: _screenWidth,
              height: _bodyHeight,
              columnChildren: <Widget>[

                const Stratosphere(),

                SuperVideoPlayer(
                  file: _videoFile,
                  width: _screenWidth,
                ),

              ],
            ),
          ),

          FloatingList(
            width: _screenWidth,
            height: _panelHeight,
            boxColor: Colorz.blue20,
            scrollDirection: Axis.horizontal,
            columnChildren: <Widget>[

              /// PICK
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.phoneGallery,
                verse: Verse.plain('Pick'),
                isSelected: false,
                onTap: _picVideoFromGallery,
              ),

              /// PICK
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.camera,
                verse: Verse.plain('Shoot'),
                isSelected: false,
                onTap: _picVideoFromCamera,
              ),

              /// TRIM
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.cut,
                verse: Verse.plain('Trim'),
                isSelected: false,
                onTap: () async {},
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
