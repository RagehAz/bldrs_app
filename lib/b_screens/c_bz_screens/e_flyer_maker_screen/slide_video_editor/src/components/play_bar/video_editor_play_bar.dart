part of slide_video_editor;

class VideoEditorPlayBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoEditorPlayBar({
    required this.videoEditorController,
    super.key
  });
  // --------------------
  final VideoEditorController? videoEditorController;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      width: Scale.screenWidth(context),
      height: VideoEditorScales.editorPlayBarHeight,
      color: Colorz.bloodTest,
      child: videoEditorController == null ? const SizedBox() : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          /// START - FINISH
          AnimatedBuilder(
              animation: Listenable.merge([
                videoEditorController,
                videoEditorController!.video,
              ]),
              builder: (_, __) {

                final String _start = VideoOps.formatDuration(videoEditorController!.startTrim);
                final String _end = VideoOps.formatDuration(videoEditorController!.endTrim);

                return BldrsText(
                  verse: Verse.plain('$_start/$_end'),
                  maxLines: 3,
                  labelColor: Colorz.black125,
                  weight: VerseWeight.thin,
                );

              }
          ),

          /// PLAY BUTTON
          AnimatedBuilder(
              animation: videoEditorController!.video,
              builder: (_, __) {

                final bool _isPlaying = Mapper.boolIsTrue(videoEditorController?.isPlaying);

              return BldrsBox(
                height: VideoEditorScales.editorPlayBarHeight,
                icon: _isPlaying? Iconz.pause : Iconz.play,
                onTap: () async {
                  if (_isPlaying == true){
                    await videoEditorController?.video.pause();
                  }
                  else {
                    await videoEditorController?.video.play();
                  }
                },
              );
            }
          ),

          /// CURRENT - SIZE
          AnimatedBuilder(
              animation: Listenable.merge([
                videoEditorController,
                videoEditorController!.video,
              ]),
              builder: (_, __) {

                final int duration = videoEditorController!.videoDuration.inSeconds;
                final double pos = videoEditorController!.trimPosition * duration;
                final String _current = VideoOps.formatDuration(Duration(seconds: pos.toInt()));
                final double? _size = FileSizer.getFileSizeWithUnit(
                  file: videoEditorController!.file,
                  unit: FileSizeUnit.megaByte,
                );

                return BldrsText(
                  verse: Verse.plain('$_current .. $_size Mb'),
                  maxLines: 3,
                  labelColor: Colorz.black125,
                  weight: VerseWeight.thin,
                );

              }
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
