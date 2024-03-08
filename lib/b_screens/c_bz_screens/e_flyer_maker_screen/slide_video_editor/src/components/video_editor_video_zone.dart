part of slide_video_editor;

class VideoEditorVideoZone extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoEditorVideoZone({
    required this.videoEditorController,
    required this.selectedButton,
    super.key
  });
  // --------------------
  final VideoEditorController? videoEditorController;
  final String? selectedButton;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _videoZoneHeight =  VideoEditorScales.getVideoZoneHeight();
    final double _videoHeight = _videoZoneHeight - 10;
    // --------------------
    final bool _isInitialized = Mapper.boolIsTrue(videoEditorController?.initialized);
    // --------------------
    return SizedBox(
      width: _screenWidth,
      height: _videoZoneHeight,
      // color: Colorz.bloodTest,
      child: FloatingList(
        width: _screenWidth,
        height: _videoZoneHeight,
        columnChildren: <Widget>[

          /// VIDEO AREA
          if (_isInitialized == true)
            SizedBox(
              height: _videoHeight,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  // if (_videoFile != null)
                  // SuperVideoPlayer(
                  //   file: _videoFile,
                  //   width: _screenWidth,
                  // ),

                  /// VIEWING
                  if (selectedButton != VideoEditorScales.cropButtonID && selectedButton != VideoEditorScales.coverButtonID)
                    SizedBox(
                      height: _videoHeight,
                      child: CropGridViewer.preview(
                          controller: videoEditorController!
                      ),
                    ),

                  /// CROPPING
                  if (selectedButton == VideoEditorScales.cropButtonID)
                    SizedBox(
                      height: _videoHeight,
                      child: CropGridViewer.edit(
                        controller: videoEditorController!,
                        // rotateCropArea: true,
                      ),
                    ),

                  /// COVER
                  if (selectedButton == VideoEditorScales.coverButtonID)
                    SizedBox(
                      height: _videoHeight,
                      child: CoverViewer(controller: videoEditorController!),
                    ),

                  /// PLAY ICON
                  if (selectedButton != VideoEditorScales.cropButtonID && selectedButton != VideoEditorScales.coverButtonID)
                    Center(
                      child: AnimatedBuilder(
                        animation: videoEditorController!.video,
                        builder: (_, __) => WidgetFader(
                          fadeType: videoEditorController!.isPlaying ? FadeType.fadeOut : FadeType.fadeIn,
                          duration: const Duration(milliseconds: 100),
                          ignorePointer: videoEditorController!.isPlaying,
                          child: SuperBox(
                            height: _screenWidth * 0.3,
                            width: _screenWidth * 0.3,
                            icon: Iconz.play,
                            bubble: false,
                            opacity: 0.5,
                            onTap: videoEditorController!.video.play,
                          ),
                        ),
                      ),
                    ),

                  /// START - FINISH - TEXT
                  AnimatedBuilder(
                      animation: Listenable.merge([
                        videoEditorController,
                        videoEditorController!.video,
                      ]),
                      builder: (_, __) {

                        final String _start = VideoOps.formatDuration(videoEditorController!.startTrim);
                        final String _end = VideoOps.formatDuration(videoEditorController!.endTrim);
                        final int duration = videoEditorController!.videoDuration.inSeconds;
                        final double pos = videoEditorController!.trimPosition * duration;
                        final String _current = VideoOps.formatDuration(Duration(seconds: pos.toInt()));
                        final double? _size = Filers.getFileSizeWithUnit(
                          file: videoEditorController!.file,
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
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
