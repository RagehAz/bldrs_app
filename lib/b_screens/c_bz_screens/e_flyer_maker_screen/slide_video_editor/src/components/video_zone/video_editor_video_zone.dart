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
    final double _videoHeight = VideoEditorScales.getVideoBoxHeight();
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

                  // /// PLAY ICON
                  // if (selectedButton != VideoEditorScales.cropButtonID && selectedButton != VideoEditorScales.coverButtonID)
                  //   Center(
                  //     child: AnimatedBuilder(
                  //       animation: videoEditorController!.video,
                  //       builder: (_, __) => WidgetFader(
                  //         fadeType: videoEditorController!.isPlaying ? FadeType.fadeOut : FadeType.fadeIn,
                  //         duration: const Duration(milliseconds: 100),
                  //         ignorePointer: videoEditorController!.isPlaying,
                  //         child: SuperBox(
                  //           height: _screenWidth * 0.3,
                  //           width: _screenWidth * 0.3,
                  //           icon: Iconz.play,
                  //           bubble: false,
                  //           opacity: 0.5,
                  //           onTap: videoEditorController!.video.play,
                  //         ),
                  //       ),
                  //     ),
                  //   ),

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
