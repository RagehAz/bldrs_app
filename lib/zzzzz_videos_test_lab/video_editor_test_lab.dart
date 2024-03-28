import 'dart:io';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/components/drawing/expander.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:basics/mediator/video_maker/video_maker.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/panel_circle_button.dart';
import 'package:bldrs/b_screens/h_media_screens/bldrs_video_editor_screen/src/components/panels/super_timeline/super_time_line.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_media_maker.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/g_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/i_gt_insta_screen/src/screens/video_player_screen.dart';
import 'package:basics/mediator/video_maker/video_ops.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/notes/x_components/red_dot_badge.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/zzzzz_videos_test_lab/video_dialog.dart';
import 'package:ffmpeg_kit_flutter/statistics.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class VideoEditorTestLab extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoEditorTestLab({
    this.video,
    super.key
  });
  // --------------------
  final MediaModel? video;
  // --------------------
  @override
  _VideoEditorTestLabState createState() => _VideoEditorTestLabState();
// --------------------------------------------------------------------------
}

class _VideoEditorTestLabState extends State<VideoEditorTestLab> {
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
  final ScrollController _timeLineScrollController = ScrollController();
  final ValueNotifier<double> _timelineMsPixelLength = ValueNotifier(TimelineScale.initialMsPixelLength);
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

        if (widget.video != null){

          final File? _file = await Filer.createFromMediaModel(
            mediaModel: widget.video,
          );

          await _setVideo(_file);

        }

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
    _timeLineScrollController.dispose();
    _timelineMsPixelLength.dispose();
    super.dispose();
  }
  // --------------------
  String? _activeButton;
  // --------------------
  static const String _trimButton = 'trim';
  static const String _cropButton = 'crop';
  static const String _coverButton = 'cover';
  static const String _view = 'view';
  // --------------------
  void _setActiveButton(String? button){

    if (_activeButton == button){
      if (_activeButton != null){
        setState(() {
          _activeButton = null;
        });
      }
    }

    else {
      setState(() {
        _activeButton = button;
      });
    }

  }
  // -----------------------------------------------------------------------------
  Future<void> _setVideo(File? file) async {

    final String? _oldButton = _activeButton;

    setState(() {
      _activeButton = null;
    });

    _videoEditorController = await VideoOps.initializeVideoEditorController(
      file: file,
      onError: (String error) async {
        await Dialogs.errorDialog(
          titleVerse: Verse.plain(error),
        );
        // await Nav.goBack(context: context);
      },

    );

    setState(() {
      _activeButton = _oldButton;
    });

  }
  // --------------------
  Future<void> _picVideoFromGallery() async {

    final MediaModel? _video = await VideoMaker.pickVideo(
      context: context,
      langCode: Localizer.getCurrentLangCode(),
      onPermissionPermanentlyDenied: BldrsMediaMaker.onPermissionPermanentlyDenied,
      onError: BldrsMediaMaker.onPickingError,
      ownersIDs: [],
      uploadPathMaker: (String? title){
        return StoragePath.entities_title(title) ?? Numeric.createRandomIndex().toString();
      },
    );

    final File? _file = await Filer.createFromMediaModel(
      mediaModel: _video,
    );

    await _setVideo(_file);

  }
  // --------------------
  Future<void> _picVideoFromCamera() async {

    final MediaModel? _videoMap = await VideoMaker.shootVideo(
      context: context,
      locale: Localizer.getCurrentLocale(),
      // compressWithQuality: ,
      // confirmText: ,
      // resizeToWidth: ,
      // selectedAsset: ,
      langCode: Localizer.getCurrentLangCode(),
      onPermissionPermanentlyDenied: BldrsMediaMaker.onPermissionPermanentlyDenied,
      onError: BldrsMediaMaker.onPickingError,
      ownersIDs: [],
      uploadPathMaker: (String? title){
        return StoragePath.entities_title(title) ?? Numeric.createRandomIndex().toString();
      },
    );

    final File? _file = await Filer.createFromMediaModel(
      mediaModel: _videoMap,
    );

    await _setVideo(_file);

  }
  // --------------------
  Future<void> _onRotateVideo() async {

    _setActiveButton(null);
    _videoEditorController?.rotate90Degrees(RotateDirection.left);

  }
  // --------------------
  Future<void> resizeVideo() async {

    blog('scrolling aho : ${_timeLineScrollController.position.isScrollingNotifier.value}');

  }
  // --------------------
  Future<void> compressVideo() async {

  }
  // --------------------
  bool _isMuted = false;
  Future<void> muteVideo() async {

    if (_isMuted == true){
      await _videoEditorController?.video.setVolume(100);
    }
    else {
      await _videoEditorController?.video.setVolume(0);
    }
    setState(() {
      _isMuted = !_isMuted;
    });

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _panelHeight = 70;
    const double _buttonSize = _panelHeight - 5;
    const double _editorBarHeight = 80;
    final double _bodyHeight = Scale.screenHeight(context) - _panelHeight - _editorBarHeight;
    final double _screenWidth = Scale.screenWidth(context);
    final double _videoHeight = _bodyHeight - Stratosphere.smallAppBarStratosphere - 10;
    // --------------------
    final bool _isInitialized = Mapper.boolIsTrue(_videoEditorController?.initialized);
    // final double _videoWidth = _videoEditorController?.
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      canGoBack: false,
      loading: _loading,
      title: Verse.plain('Video Editor'),
      appBarRowWidgets: <Widget>[

        /// MORE
        AppBarButton(
          icon: Iconz.more,
          onTap: () async {

            await BottomDialog.showButtonsBottomDialog(
              numberOfWidgets: 7,
                buttonHeight: 30,
                // titleVerse: Verse.plain('Stuff'),
                builder: (_, __){

                return <Widget>[

                  /// BLOG CONTROLLER
                  BottomDialog.wideButton(
                    verse: Verse.plain('Blog controller'),
                    icon: Icons.print,
                    onTap: () async {

                      VideoOps.blogVideoEditorController(
                          controller: _videoEditorController,
                      );

                    },
                  ),

                  /// UPDATE TRIM
                  BottomDialog.wideButton(
                    verse: Verse.plain('trim to first half duration'),
                    icon: Icons.cut,
                    onTap: () async {

                      _videoEditorController?.updateTrim(0, 0.5);

                    },
                  ),

                  /// CROP ASPECT RATIO
                  BottomDialog.wideButton(
                    verse: Verse.plain('crop Aspect Ratio to 1'),
                    icon: Icons.aspect_ratio,
                    onTap: () async {
                      _videoEditorController?.cropAspectRatio(1);
                    },
                  ),

                  /// PLAY FILE IN PLAYER
                  BottomDialog.wideButton(
                    verse: Verse.plain('Play file in player'),
                    icon: Iconz.play,
                    onTap: () async {
                      final File? _file = _videoEditorController?.file;
                      await Keyboard.copyToClipboardAndNotify(copy: _file?.path);
                      await VideoPlayerScreen.playFile(file: _file);
                    },
                  ),

                  /// GET DIMENSIONS
                  BottomDialog.wideButton(
                    verse: Verse.plain('Get Dimensions'),
                    icon: Icons.photo_size_select_large_sharp,
                    onTap: () async {

                      final Dimensions? _dims = VideoOps.getVideoEditorControllerDimensions(
                          controller: _videoEditorController
                      );

                      _dims?.blogDimensions(invoker: 'video dims');


                    },
                  ),

                  /// FILE SIZE IN KB
                  BottomDialog.wideButton(
                    verse: Verse.plain('Get file size in KB'),
                    icon: 'Mb',
                    onTap: () async {

                      final double?  _kb = VideoOps.getFileSize(
                        controller: _videoEditorController,
                        unit: FileSizeUnit.kiloByte,
                      );

                      final double? _mb = VideoOps.getFileSize(
                        controller: _videoEditorController,
                        unit: FileSizeUnit.megaByte,
                      );

                      blog('size : $_kb Kb : $_mb mb');

                    },
                  ),

                  /// PUSH VIDEO DIALOG
                  BottomDialog.wideButton(
                    verse: Verse.plain('Push original Video dialog'),
                    icon: Icons.play_circle_outlined,
                    onTap: () async {

                      await VideoDialog.push(file: _videoEditorController?.file);

                    },
                  ),

                  /// EXPORT COVER
                  BottomDialog.wideButton(
                    verse: Verse.plain('Export cover'),
                    icon: Icons.import_export,
                    onTap: () async {

                      final bool _go = await Dialogs.confirmProceed();

                      if (_go == true){

                        WaitDialog.showUnawaitedWaitDialog();

                        final File? _file = await VideoOps.exportCover(
                            videoEditorController: _videoEditorController,
                            fileName: TextMod.idifyString(FilePathing.getNameFromFile(file: _videoEditorController!.file, withExtension: false)),
                            onProgress: (Statistics progress, CoverFFmpegVideoEditorConfig config){
                              final double _progress = config.getFFmpegProgress(progress.getTime().toInt());
                              final String _percent = '${(_progress * 100).ceil()}%';
                              UiProvider.proSetLoadingVerse(verse: Verse.plain(_percent));
                            }
                        );

                        blog('got back the file aho $_file');

                        Filer.blogFile(file: _file, invoker: 'the Cover');

                        await WaitDialog.closeWaitDialog();

                        if (_file != null){

                          await PicFullScreen.openFile(
                            file: _file,
                            title: _file.path,
                          );

                        }

                      }

                    },
                  ),

                  /// EXPORT VIDEO
                  BottomDialog.wideButton(
                    verse: Verse.plain('Export Video.'),
                    icon: Icons.import_export,
                    onTap: () async {

                      final bool _go = await Dialogs.confirmProceed();

                      if (_go == true){

                        WaitDialog.showUnawaitedWaitDialog();

                        final File? _file = await VideoOps.exportVideo(
                            videoEditorController: _videoEditorController,
                            scale: 0.5,
                            onProgress: (Statistics progress, VideoFFmpegVideoEditorConfig config){

                              final double _progress = config.getFFmpegProgress(progress.getTime().toInt());
                              final String _percent = '${(_progress * 100).ceil()}%';
                              UiProvider.proSetLoadingVerse(verse: Verse.plain(_percent));

                            }
                        );

                        Filer.blogFile(file: _videoEditorController!.file, invoker: 'the Original');
                        Filer.blogFile(file: _file, invoker: 'the new');

                        await WaitDialog.closeWaitDialog();

                        if (_file != null){
                          await VideoDialog.push(file: _file);
                        }

                      }

                    },
                  ),

                  /// EXPORT VIDEO MUTED
                  BottomDialog.wideButton(
                    verse: Verse.plain('Export Video muted'),
                    icon: Icons.import_export,
                    onTap: () async {

                      final bool _go = await Dialogs.confirmProceed();

                      if (_go == true){

                        WaitDialog.showUnawaitedWaitDialog();

                        final File? _file = await VideoOps.exportVideo(
                            videoEditorController: _videoEditorController,
                            mute: true,
                            onProgress: (Statistics progress, VideoFFmpegVideoEditorConfig config){

                              final double _progress = config.getFFmpegProgress(progress.getTime().toInt());
                              final String _percent = '${(_progress * 100).ceil()}%';
                              UiProvider.proSetLoadingVerse(verse: Verse.plain(_percent));

                            }
                        );

                        Filer.blogFile(file: _videoEditorController!.file, invoker: 'the Original');
                        Filer.blogFile(file: _file, invoker: 'the new');

                        await WaitDialog.closeWaitDialog();

                        if (_file != null){
                          await VideoDialog.push(file: _file);
                        }

                      }

                    },
                  ),

                  /// EXPORT GIF
                  BottomDialog.wideButton(
                    verse: Verse.plain('Export GIF'),
                    icon: Icons.import_export,
                    onTap: () async {

                      final bool _go = await Dialogs.confirmProceed();

                      if (_go == true){

                        WaitDialog.showUnawaitedWaitDialog();

                        final File? _file = await VideoOps.exportVideo(
                            videoEditorController: _videoEditorController,
                            format: VideoExportFormat.gif,
                            onProgress: (Statistics progress, VideoFFmpegVideoEditorConfig config){

                              final double _progress = config.getFFmpegProgress(progress.getTime().toInt());
                              final String _percent = '${(_progress * 100).ceil()}%';
                              UiProvider.proSetLoadingVerse(verse: Verse.plain(_percent));

                            }
                        );

                        Filer.blogFile(file: _videoEditorController!.file, invoker: 'the Original');
                        Filer.blogFile(file: _file, invoker: 'the new');

                        await WaitDialog.closeWaitDialog();

                        if (_file != null){
                          await VideoDialog.push(file: _file);
                        }

                      }

                    },
                  ),

                  /// SHOW SNACK BAR
                  BottomDialog.wideButton(
                    verse: Verse.plain('Show Snack bar'),
                    icon: Icons.check_box_outline_blank_sharp,
                    onTap: () async {

                      void _showErrorSnackBar(String message) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              duration: const Duration(seconds: 1),
                            ),
                          );

                      _showErrorSnackBar('wtf');

                    },
                  ),

                  /// SET RATIO FROM CROP
                  BottomDialog.wideButton(
                    verse: Verse.plain('Set Ratio from crop'),
                    icon: Icons.eighteen_up_rating,
                    onTap: () async {

                      _videoEditorController?.setPreferredRatioFromCrop();
                      setState(() {});
                      // _videoEditorController?.preferredCropAspectRatio = 1;

                    },
                  ),

                  /// SET RATIO FROM CROP
                  BottomDialog.wideButton(
                    verse: Verse.plain('Define crop ratio'),
                    icon: Icons.aspect_ratio_outlined,
                    onTap: () async {

                      setState(() {
                        _videoEditorController?.preferredCropAspectRatio = 1;
                      });

                    },
                  ),

                  /// PICK FILE AND GET ITS SIZE
                  BottomDialog.wideButton(
                    verse: Verse.plain('PIC FILE AND GET ITS SIZE.'),
                    icon: Icons.aspect_ratio_outlined,
                    onTap: () async {

                      final MediaModel? _video = await VideoMaker.pickVideo(
                        context: context,
                        langCode: Localizer.getCurrentLangCode(),
                        onPermissionPermanentlyDenied: BldrsMediaMaker.onPermissionPermanentlyDenied,
                        onError: BldrsMediaMaker.onPickingError,
                        ownersIDs: [],
                        uploadPathMaker: (String? title){
                          return StoragePath.entities_title(title) ?? Numeric.createRandomIndex().toString();
                        },
                      );

                      final Dimensions? _dims = await DimensionsGetter.fromMediaModel(
                          mediaModel: _video,
                      );

                      _dims?.blogDimensions(invoker: 'zz');

                    },
                  ),

                  /// PIC INSIDE getVideoFileDimensions
                  BottomDialog.wideButton(
                    verse: Verse.plain('PIC Dims in getVideoFileDimensions'),
                    icon: Icons.aspect_ratio_outlined,
                    onTap: () async {

                      final MediaModel? _bigPic = await BldrsMediaMaker.makePic(
                        cropAfterPick: false,
                        aspectRatio: FlyerDim.flyerAspectRatio(),
                        compressWithQuality: Standards.slideBigQuality,
                        resizeToWidth: Standards.slideBigWidth,
                        uploadPathMaker: (String? title){
                          return StoragePath.entities_title(title) ?? Numeric.createRandomIndex().toString();
                        },
                        mediaOrigin: MediaOrigin.galleryImage,
                        ownersIDs: ['x'],
                      );

                      if (_bigPic != null){

                        final Dimensions? _dims = await DimensionsGetter.fromMediaModel(
                          mediaModel: _bigPic,
                        );

                        _dims?.blogDimensions(invoker: 'zz');

                      }


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

          /// VIDEO AREA
          SizedBox(
            width: _screenWidth,
            height: _bodyHeight,
            child: FloatingList(
              width: _screenWidth,
              height: _bodyHeight,
              columnChildren: <Widget>[

                const Stratosphere(),

                /// VIDEO AREA
                if (_isInitialized == true)
                  SizedBox(
                    height: _videoHeight,
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     color: Colorz.white255,
                    //     width: 1,
                    //   ),
                    // ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[

                        // if (_videoFile != null)
                        // SuperVideoPlayer(
                        //   file: _videoFile,
                        //   width: _screenWidth,
                        // ),

                        /// VIEWING
                        if (_activeButton == _view || _activeButton == _trimButton)
                          SizedBox(
                            height: _videoHeight,
                            child: CropGridViewer.preview(
                                controller: _videoEditorController!
                            ),
                          ),

                        /// PLAY ICON
                        if (_activeButton  == _view)
                          Center(
                            child: AnimatedBuilder(
                              animation: _videoEditorController!.video,
                              builder: (_, __) => WidgetFader(
                                fadeType: _videoEditorController!.isPlaying ? FadeType.fadeOut : FadeType.fadeIn,
                                duration: const Duration(milliseconds: 100),
                                ignorePointer: _videoEditorController!.isPlaying,
                                child: SuperBox(
                                  height: _screenWidth * 0.3,
                                  width: _screenWidth * 0.3,
                                  icon: Iconz.play,
                                  bubble: false,
                                  opacity: 0.5,
                                  onTap: _videoEditorController!.video.play,
                                ),
                              ),
                            ),
                          ),

                        /// CROPPING
                        if (_activeButton == _cropButton)
                          SizedBox(
                            height: _videoHeight,
                            child: CropGridViewer.edit(
                              controller: _videoEditorController!,
                              // rotateCropArea: true,
                            ),
                          ),

                        /// COVER
                        if (_activeButton == _coverButton)
                          SizedBox(
                            height: _videoHeight,
                            child: CoverViewer(controller: _videoEditorController!),
                          ),

                        /// START - FINISH - TEXT
                        AnimatedBuilder(
                            animation: Listenable.merge([
                              _videoEditorController,
                              _videoEditorController!.video,
                            ]),
                            builder: (_, __) {

                            final String _start = VideoOps.formatDurationToSeconds(
                              duration: _videoEditorController!.startTrim,
                              factions: 1,
                            );
                            final String _end = VideoOps.formatDurationToSeconds(
                              duration: _videoEditorController!.endTrim,
                              factions: 1,
                            );
                            final int duration = _videoEditorController!.videoDuration.inSeconds;
                            final double pos = _videoEditorController!.trimPosition * duration;
                            final String _current = VideoOps.formatDurationToSeconds(
                              duration: Duration(seconds: pos.toInt()),
                              factions: 1,
                            );
                            final double? _size = FileSizer.getFileSizeWithUnit(
                                file: _videoEditorController!.file,
                                unit: FileSizeUnit.megaByte,
                            );

                            return Align(
                              alignment: Alignment.topCenter,
                              child: BldrsText(
                                verse: Verse.plain('$_start | $_end \n$_current\n$_size Mb'),
                                maxLines: 3,
                                labelColor: Colorz.black125,
                                weight: VerseWeight.thin,
                                margin: 10,
                              ),
                            );
                          }
                        ),

                      ],
                    ),
                  ),

              ],
            ),
          ),

          // if (_isTrimming == false)
            const Expander(),

          /// TRIM BAR
          if (_isInitialized == true && _activeButton == _trimButton)
            SuperTimeLine(
              totalWidth: _screenWidth,
              height: _editorBarHeight,
              videoEditorController: _videoEditorController,
              scrollController: _timeLineScrollController,
              msPixelLength: _timelineMsPixelLength,
              // limitScrollingBetweenHandles: false,
              onHandleChanged: (int leftMs, int rightMs){

              },
              onTimeChanged: (int currentMs) async {

                if (_videoEditorController != null){

                  if (_videoEditorController!.isPlaying == true){
                    await _videoEditorController?.video.pause();
                  }

                  await _videoEditorController?.video.seekTo(
                      Duration(milliseconds: currentMs)
                  );

                }

              },
            ),

          /// CROP BAR
          if (_isInitialized == true && _activeButton == _cropButton)
            FloatingList(
              width: _screenWidth,
              height: _editorBarHeight,
              boxColor: Colorz.bloodTest,
              scrollDirection: Axis.horizontal,
              columnChildren: <Widget>[

                /// FREE
                BldrsBox(
                  height: _editorBarHeight - 10,
                  width: 100,
                  verse: Verse.plain('Free'),
                  onTap: (){
                    _videoEditorController?.cropAspectRatio(null);
                  },
                ),

                /// 1 / 1
                BldrsBox(
                  height: _editorBarHeight - 10,
                  width: 100,
                  verse: Verse.plain('1/1'),
                  onTap: (){
                    _videoEditorController?.cropAspectRatio(1);
                  },
                ),

                /// 16 / 9
                BldrsBox(
                  height: _editorBarHeight - 10,
                  width: 100,
                  verse: Verse.plain('16/9'),
                  // bubble: true,
                  onTap: (){
                    _videoEditorController?.cropAspectRatio(16/9);
                  },
                ),

                /// CONFIRM CROP
                BldrsBox(
                  height: _editorBarHeight - 10,
                  width: 100,
                  verse: Verse.plain('Crop'),
                  // bubble: true,
                  onTap: (){

                    _videoEditorController?.applyCacheCrop();
                    // _videoEditorController?.setPreferredRatioFromCrop();
                    // _videoEditorController?.preferredCropAspectRatio = 1;
                    // _videoEditorController?.updateCrop(const Offset(0.2, 0.2), const Offset(0.8, 0.8));
                    _setActiveButton(null);

                  },
                ),

              ],
            ),

          /// COVERS SELECTION BAR
          if (_isInitialized == true && _activeButton == _coverButton)
            FloatingList(
              width: _screenWidth,
              height: _editorBarHeight,
              boxColor: Colorz.black255,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              columnChildren: <Widget>[

                CoverSelection(
                  controller: _videoEditorController!,
                  // size: _editorBarHeight - 20,
                  quantity: 12,
                  wrap: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    textDirection: UiProvider.getAppTextDir(),
                  ),
                  selectedCoverBuilder: (cover, size) {

                    return RedDotBadge(
                      redDotIsOn: true,
                      shrinkChild: true,
                      approxChildWidth: size.width,
                      isNano: true,
                      color: Colorz.yellow255,
                      child: cover,
                    );

                  },
                ),

              ],
            ),

          /// BOTTOM BAR
          FloatingList(
            width: _screenWidth,
            height: _panelHeight,
            boxColor: Colorz.blue20,
            scrollDirection: Axis.horizontal,
            columnChildren: <Widget>[

              /// GO BACK
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.arrowWhiteLeft,
                verse: Verse.plain('Back'),
                isSelected: false,
                onTap: () => Nav.goBack(context: context),
              ),

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
                isSelected: _activeButton == _trimButton,
                onTap: () => _setActiveButton(_trimButton),
              ),

              /// CROP
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.crop,
                verse: Verse.plain('Crop'),
                isSelected: _activeButton == _cropButton,
                onTap: () => _setActiveButton(_cropButton),
              ),

              /// ROTATE
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.rotate_left,
                verse: Verse.plain('Rotate'),
                isSelected: false,
                onTap: _onRotateVideo,
              ),

              /// COVER
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.image_rounded,
                verse: Verse.plain('Cover'),
                isSelected: _activeButton == _coverButton,
                onTap: () => _setActiveButton(_coverButton),
              ),

              /// RESIZE
              PanelCircleButton(
                size: _buttonSize,
                icon: Iconz.resize,
                verse: Verse.plain('Resize'),
                isSelected: false,
                onTap: resizeVideo,
              ),

              /// COMPRESS
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.compress,
                verse: Verse.plain('Compress'),
                isSelected: false,
                onTap: compressVideo,
              ),

              /// MUTE
              PanelCircleButton(
                size: _buttonSize,
                icon: Icons.volume_mute,
                verse: Verse.plain('Mute'),
                isSelected: false,
                onTap: () async {},
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
