// ignore_for_file: avoid_redundant_argument_values
import 'dart:io';
import 'dart:typed_data';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/v_videos/video_dialog.dart';
import 'package:bldrs/v_videos/video_ops.dart';
import 'package:bldrs/v_videos/video_result.dart';
import 'package:flutter/material.dart';
import 'package:video_editor/video_editor.dart';

class TrimScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TrimScreen({
    required this.file,
    super.key
  });
  // --------------------
  final File file;

  @override
  State<TrimScreen> createState() => _TrimScreenState();
}

class _TrimScreenState extends State<TrimScreen> {
  // -----------------------------------------------------------------------------
  late VideoEditorController _videoEditorController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _videoEditorController = VideoEditorController.file(
      widget.file,
      minDuration: const Duration(seconds: 1),
      maxDuration: const Duration(seconds: 10),
    );

    // await _videoEditorController?.initialize();

    _videoEditorController.initialize(aspectRatio: 9 / 16)
        .then((_) => setState(() {}))
        .catchError((error) {
          // handle minimum duration bigger than video duration error
      Navigator.pop(context);
    },
        test: (e) => e is VideoMinDurationError);


  }
  // --------------------
  @override
  void dispose() {
    _videoEditorController.dispose();
    _exportingProgress.dispose();
    _isExporting.dispose();
    VideoOps.disposeFFmpegKit();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  final ValueNotifier<double> _exportingProgress = ValueNotifier<double>(0);
  final ValueNotifier<bool> _isExporting = ValueNotifier<bool>(false);
  // --------------------------------------------------------------------------
  final double height = 60;
  // --------------------
  /// Basic export video function
  Future<void> exportVideo() async {
    final config = VideoFFmpegVideoEditorConfig(_videoEditorController);
    // Returns the generated command and the output path
    final FFmpegVideoEditorExecute execute = await config.getExecuteConfig();

    // ... handle the video exportation yourself, using ffmpeg_kit_flutter, your own video server, ...




  }
  // --------------------
  /// Export the video as a GIF image
  Future<void> exportGif() async {
    final gifConfig = VideoFFmpegVideoEditorConfig(
      _videoEditorController,
      format: VideoExportFormat.gif,
    );
    // Returns the generated command and the output path
    final FFmpegVideoEditorExecute gifExecute = await gifConfig.getExecuteConfig();

    // ...
  }
  // --------------------
  /// Export a video, with custom command (ultrafast preset + horizontal flip)
  Future<void> exportMirroredVideo() async {

    final VideoFFmpegVideoEditorConfig mirrorConfig = VideoFFmpegVideoEditorConfig(
      _videoEditorController,
      name: 'mirror-video',
      commandBuilder: (FFmpegVideoEditorConfig config, String videoPath, String outputPath){
        final List<String> filters = config.getExportFilters();
        filters.add('hflip'); // add horizontal flip

        return '-i $videoPath ${config.filtersCmd(filters)} -preset ultrafast $outputPath';
      },
    );

    // Returns the generated command and the output path
    final FFmpegVideoEditorExecute mirrorExecute = await mirrorConfig.getExecuteConfig();

    // ...
  }
  // --------------------
  void _showErrorSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );
  // --------------------
  Future<void> _exportVideo() async {
    _exportingProgress.value = 0;
    _isExporting.value = true;

    final config = VideoFFmpegVideoEditorConfig(
      _videoEditorController,
      // format: VideoExportFormat.gif,
      // commandBuilder: (config, videoPath, outputPath) {
      //   final List<String> filters = config.getExportFilters();
      //   filters.add('hflip'); // add horizontal flip

      //   return '-i $videoPath ${config.filtersCmd(filters)} -preset ultrafast $outputPath';
      // },
    );

    await VideoOps.runFFmpegCommand(
      execute: await config.getExecuteConfig(),
      onProgress: (stats) {
        _exportingProgress.value = config.getFFmpegProgress(stats.getTime());
      },
      onError: (e, s) => _showErrorSnackBar('Error on export video :('),
      onCompleted: (file) async {

        _isExporting.value = false;
        if (!mounted) {
          return;
        }

        await VideoDialog.push(file: file);


        // final File _file = File(execute.outputPath);

        final Uint8List? _bytes = await file.readAsBytes();

        await Nav.goBack(
          context: context,
          passedData: _bytes,
        );

      },
    );
  }
  // --------------------
  Future<void> _exportCover() async {
    final config = CoverFFmpegVideoEditorConfig(_videoEditorController);
    final execute = await config.getExecuteConfig();
    if (execute == null) {
      _showErrorSnackBar('Error on cover exportation initialization.');
      return;
    }

    await VideoOps.runFFmpegCommand(
      execute: execute,
      onError: (e, s) => _showErrorSnackBar('Error on cover exportation :('),
      onCompleted: (cover) {
        if (!mounted) {
          return;
        }

        showDialog(
          context: context,
          builder: (_) => CoverResultPopup(cover: cover),
        );
      },
    );
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // -------------------
    return Scaffold(
      backgroundColor: Colors.black,
      body: _videoEditorController.initialized ?

      SafeArea(
        child: Stack(
          children: [

            Column(
              children: [

                /// TOP NAV BAR
                SafeArea(
                  child: Container(
                    height: height,
                    color: Colorz.bloodTest,
                    child: Row(
                      children: [

                        /// EXIT
                        Expanded(
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.exit_to_app),
                            tooltip: 'Leave editor',
                          ),
                        ),

                        Expanded(
                          child: PopupMenuButton(
                            tooltip: 'Open export menu',
                            icon: const Icon(Icons.save),
                            itemBuilder: (context) => [

                              PopupMenuItem(
                                onTap: _exportCover,
                                child: const Text('Export cover'),
                              ),

                              PopupMenuItem(
                                onTap: _exportVideo,
                                child: const Text('Export video'),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                /// REST
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [

                        /// VIDEO AREA
                        Expanded(
                          child: TabBarView(
                            physics:
                            const NeverScrollableScrollPhysics(),
                            children: [

                              /// VIDEO PREVIEW
                              Stack(
                                alignment: Alignment.center,
                                children: [

                                  /// VIDEO AND CROP GRID
                                  CropGridViewer.preview(controller: _videoEditorController),

                                  /// PLAY ICON
                                  AnimatedBuilder(
                                    animation: _videoEditorController.video,
                                    builder: (_, __) => AnimatedOpacity(
                                      opacity: _videoEditorController.isPlaying ? 0 : 1,
                                      duration: kThemeAnimationDuration,
                                      child: GestureDetector(
                                        onTap: _videoEditorController.video.play,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration:
                                          const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              /// COVER PREVIEW
                              CoverViewer(controller: _videoEditorController),

                            ],
                          ),
                        ),

                        /// SLIDER
                        Container(
                          height: 200,
                          margin: const EdgeInsets.only(top: 10),
                          color: Colorz.green80,
                          child: Column(
                            children: [

                              /// TRIM - COVER BUTTONS
                              const TabBar(
                                tabs: [

                                  /// TRIM BUTTON
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [

                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Icon(Icons.content_cut),
                                        ),

                                        Text('Trim')

                                      ]

                                  ),

                                  /// COVER BUTTON
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Icon(Icons.video_label)),
                                      Text('Cover')
                                    ],
                                  ),

                                ],
                              ),

                              /// SLIDER AREA
                              Expanded(
                                child: TabBarView(
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  children: [

                                    /// TRIM SLIDER
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        /// SECONDS & DURATION LINES
                                        AnimatedBuilder(
                                          animation: Listenable.merge([
                                            _videoEditorController,
                                            _videoEditorController.video,
                                          ]),
                                          builder: (_, __) {

                                            final int duration = _videoEditorController.videoDuration.inSeconds;
                                            final double pos = _videoEditorController.trimPosition * duration;

                                            return Padding(
                                              padding: EdgeInsets.symmetric(horizontal: height / 4),
                                              child: Row(children: [

                                                Text(VideoOps.formatDuration(Duration(seconds: pos.toInt()))),

                                                const Expanded(child: SizedBox()),

                                                AnimatedOpacity(
                                                  opacity: _videoEditorController.isTrimming ? 1 : 0,
                                                  duration: kThemeAnimationDuration,
                                                  child: Row(mainAxisSize: MainAxisSize.min, children: [

                                                    Text(VideoOps.formatDuration(_videoEditorController.startTrim)),

                                                    const SizedBox(width: 10),

                                                    Text(VideoOps.formatDuration(_videoEditorController.endTrim)),

                                                  ]),
                                                ),
                                              ]),
                                            );
                                          },
                                        ),

                                        /// TRIM TIMELINE
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          color: Colorz.bloodTest,
                                          margin: EdgeInsets.symmetric(vertical: height / 4),
                                          child: TrimSlider(
                                            controller: _videoEditorController,
                                            height: height,
                                            horizontalMargin: height / 4,
                                            child: TrimTimeline(
                                              controller: _videoEditorController,
                                              padding: const EdgeInsets.only(top: 10),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                    /// COVERS BAR
                                    SingleChildScrollView(
                                      child: Center(
                                        child: Container(
                                          margin: const EdgeInsets.all(15),
                                          color: Colorz.yellow50,
                                          child: CoverSelection(
                                            controller: _videoEditorController,
                                            size: height + 10,
                                            quantity: 8,
                                            selectedCoverBuilder: (cover, size) {

                                              return Stack(
                                                alignment: Alignment.center,
                                                children: [

                                                  cover,

                                                  Icon(
                                                    Icons.check_circle,
                                                    color: const CoverSelectionStyle().selectedBorderColor,
                                                  ),

                                                ],
                                              );

                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        /// EXPORTING BAR
                        ValueListenableBuilder(
                          valueListenable: _isExporting,
                          builder: (_, bool export, Widget? child) => AnimatedSize(
                            duration: kThemeAnimationDuration,
                            child: export ? child : null,
                          ),
                          child: AlertDialog(
                            title: ValueListenableBuilder(
                              valueListenable: _exportingProgress,
                              builder: (_, double value, __) => Text(
                                'Exporting video ${(value * 100).ceil()}%',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            )

          ],
        ),
      )

          :

      const Center(child: CircularProgressIndicator()),

    );
    // --------------------
  }
  // --------------------
}
