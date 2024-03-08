part of slide_video_editor;

class VideoEditorScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoEditorScreen({
    this.video,
    super.key
  });
  // --------------------
  final MediaModel? video;
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

        if (widget.video != null){

          final File? _file = await Filers.getFileFromUint8List(
            uInt8List: widget.video!.bytes,
            fileName: widget.video?.meta?.name,
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
    super.dispose();
  }
  // --------------------
  String? _selectedButton;
  // --------------------
  void _setActiveButton(String? button){

    if (_selectedButton == button){
      if (_selectedButton != null){
        setState(() {
          _selectedButton = null;
        });
      }
    }

    else {
      setState(() {
        _selectedButton = button;
      });
    }

  }
  // -----------------------------------------------------------------------------
  Future<void> _setVideo(File? file) async {

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
      //   _videoFile = file;
    });

  }
  // --------------------
  Future<void> _onRotateVideo() async {

    _setActiveButton(null);
    _videoEditorController?.rotate90Degrees(RotateDirection.left);

  }
  // --------------------
  Future<void> resizeVideo() async {}
  // --------------------
  Future<void> compressVideo() async {}
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
  // --------------------
  Future<void> _more() async {

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
                    fileName: TextMod.idifyString(Filers.getFileNameFromFile(file: _videoEditorController!.file, withExtension: false)),
                    onProgress: (Statistics progress, CoverFFmpegVideoEditorConfig config){
                      final double _progress = config.getFFmpegProgress(progress.getTime().toInt());
                      final String _percent = '${(_progress * 100).ceil()}%';
                      UiProvider.proSetLoadingVerse(verse: Verse.plain(_percent));
                    }
                );

                blog('got back the file aho $_file');

                Filers.blogFile(file: _file, invoker: 'the Cover');

                await WaitDialog.closeWaitDialog();

                if (_file != null){

                  final Dimensions? _dims = await Dimensions.superDimensions(_file);

                  await PicFullScreen.goToImageFullScreenByBytes(
                    bytes: _file.readAsBytesSync(),
                    title: _file.path,
                    dims: _dims!,
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

                Filers.blogFile(file: _videoEditorController!.file, invoker: 'the Original');
                Filers.blogFile(file: _file, invoker: 'the new');

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

                Filers.blogFile(file: _videoEditorController!.file, invoker: 'the Original');
                Filers.blogFile(file: _file, invoker: 'the new');

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

                Filers.blogFile(file: _videoEditorController!.file, invoker: 'the Original');
                Filers.blogFile(file: _file, invoker: 'the new');

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

              final MediaModel? _videoMap = await VideoMaker.pickVideo(
                context: context,
                langCode: Localizer.getCurrentLangCode(),
                onPermissionPermanentlyDenied: BldrsMediaMaker.onPermissionPermanentlyDenied,
                onError: BldrsMediaMaker.onPickingError,
                name: 'x',
                compressWithQuality: 100,
                assignPath: '',
                ownersIDs: [],
              );

              final Dimensions? _dims = await Dimensions.superDimensions(_videoMap?.bytes);

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
                assignPath: 'storage:bldrs/bjo',
                name: 'bjo',
                mediaOrigin: MediaOrigin.galleryImage,
                ownersIDs: ['x'],
              );

              if (_bigPic != null){

                final Dimensions? _dims = await VideoOps.getVideoBytesDimensions(
                  bytes: _bigPic.bytes,
                );

                _dims?.blogDimensions(invoker: 'zz');

              }


            },
          ),

        ];

      },
    );

  }
  // --------------------
  Future<void> onConfirm() async {
    blog('should confirm now');
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      canGoBack: false,
      appBarType: AppBarType.non,
      child: Column(
        children: <Widget>[

          /// VIDEO AREA
          VideoEditorVideoZone(
            videoEditorController: _videoEditorController,
            selectedButton: _selectedButton,
          ),

          /// PLAY BAR
          VideoEditorPlayBar(
            videoEditorController: _videoEditorController,

          ),

          /// PANEL
          VideoEditorPanelSwitcher(
            selectedButton: _selectedButton,
            videoEditorController: _videoEditorController,
            onConfirmCrop: (){

              _videoEditorController?.applyCacheCrop();
              // _videoEditorController?.setPreferredRatioFromCrop();
              // _videoEditorController?.preferredCropAspectRatio = 1;
              // _videoEditorController?.updateCrop(const Offset(0.2, 0.2), const Offset(0.8, 0.8));
              _setActiveButton(null);

            },
          ),

          /// NAV BAR
          VideoEditorNavBar(
            onBack: () => Nav.goBack(context: context),
            isMuted: _isMuted,
            onCrop: () => _setActiveButton(VideoEditorScales.cropButtonID),
            onForward: onConfirm,
            onMute: muteVideo,
            onRotate: _onRotateVideo,
            onTrim: () => _setActiveButton(VideoEditorScales.trimButtonID),
            selectedButton: _selectedButton,
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}