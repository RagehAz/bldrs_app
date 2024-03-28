part of bldrs_video_editor;

class VideoEditorVideoZone extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoEditorVideoZone({
    required this.videoEditorController,
    required this.currentMs,
    required this.selectedButton,
    super.key
  });
  // --------------------
  final VideoEditorController? videoEditorController;
  final ValueNotifier<int> currentMs;
  final String? selectedButton;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _videoZoneHeight =  EditorScale.mediaZoneHeight(panelIsOn: true);
    final double _videoHeight = EditorScale.mediaHeight(panelIsOn: true);
    // --------------------
    final bool _isInitialized = Mapper.boolIsTrue(videoEditorController?.initialized);
    // --------------------
    if (_isInitialized == false){
      return SizedBox(
        width: _screenWidth,
        height: _videoZoneHeight,
      );
    }
    // --------------------
    else {
      return Container(
        width: _screenWidth,
        height: _videoZoneHeight,
        color: Colorz.bloodTest,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            // if (_videoFile != null)
            // SuperVideoPlayer(
            //   file: _videoFile,
            //   width: _screenWidth,
            // ),

            /// VIEWING
            if (selectedButton != VideoEditorNavBar.cropButtonID && selectedButton != VideoEditorNavBar.coverButtonID)
              SizedBox(
                height: _videoHeight,
                child: CropGridViewer.preview(
                    controller: videoEditorController!
                ),
              ),

            /// CROPPING
            if (selectedButton == VideoEditorNavBar.cropButtonID)
              VideoCropZone(
                controller: videoEditorController!,
                currentMs: currentMs,
              ),

              // SizedBox(
              //   height: _videoHeight,
              //   child: CropGridViewer.edit(
              //     controller: videoEditorController!,
              //     rotateCropArea: true,
              //     // rotateCropArea: true,
              //   ),
              // ),

            /// COVER
            if (selectedButton == VideoEditorNavBar.coverButtonID)
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
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
