part of bldrs_video_editor;

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

    final double _screenWidth = Scale.screenWidth(context);
    final double _sideWidth = (_screenWidth - EditorScale.subPanelHeight) / 2;
    // --------------------
    return SizedBox(
      width: Scale.screenWidth(context),
      height: EditorScale.subPanelHeight,
      // color: Colorz.bloodTest,
      child: videoEditorController == null ? const SizedBox() : Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          /// START - FINISH
          Container(
            width: _sideWidth,
            height: EditorScale.subPanelHeight,
            alignment: BldrsAligners.superCenterAlignment(context),
            child: AnimatedBuilder(
                animation: Listenable.merge([
                  videoEditorController,
                  videoEditorController!.video,
                ]),
                builder: (_, __) {

                  final String _start = VideoOps.formatDurationToSeconds(
                    duration: videoEditorController!.startTrim,
                    factions: 1,
                  );
                  final String _end = VideoOps.formatDurationToSeconds(
                    duration: videoEditorController!.endTrim,
                    factions: 1,
                  );

                  return BldrsText(
                    verse: Verse.plain('$_start / $_end'),
                    size: 1,
                    labelColor: Colorz.white20,
                    weight: VerseWeight.thin,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  );

                }
            ),
          ),

          /// PLAY BUTTON
          AnimatedBuilder(
              animation: videoEditorController!.video,
              builder: (_, __) {

                final bool _isPlaying = Mapper.boolIsTrue(videoEditorController?.isPlaying);

              return BldrsBox(
                height: EditorScale.subPanelHeight,
                icon: _isPlaying? Iconz.pause : Iconz.play,
                iconSizeFactor: 0.7,
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
          Container(
            width: _sideWidth,
            height: EditorScale.subPanelHeight,
            alignment: BldrsAligners.superInverseCenterAlignment(context),
            child: AnimatedBuilder(
                animation: Listenable.merge([
                  videoEditorController,
                  videoEditorController!.video,
                ]),
                builder: (_, __) {

                  // final int duration = videoEditorController!.videoDuration.inSeconds;
                  // final double pos = videoEditorController!.trimPosition * duration;
                  // final String _current = VideoOps.formatDuration(Duration(seconds: pos.toInt()));
                  final double? _size = FileSizer.getFileSizeWithUnit(
                    file: videoEditorController!.file,
                    unit: FileSizeUnit.megaByte,
                  );

                  return BldrsText(
                    verse: Verse.plain('$_size MB'),
                    size: 1,
                    labelColor: Colorz.white20,
                    weight: VerseWeight.thin,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  );

                }
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
