part of bldrs_video_editor;

class VideoEditorPlayBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoEditorPlayBar({
    required this.videoEditorController,
    required this.isPlaying,
    required this.onPlay,
    super.key
  });
  // --------------------
  final VideoEditorController? videoEditorController;
  final bool isPlaying;
  final Function onPlay;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
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

                // final bool _isPlaying = Mapper.boolIsTrue(videoEditorController?.isPlaying);

              return BldrsBox(
                height: EditorScale.subPanelHeight,
                icon: isPlaying? Iconz.pause : Iconz.play,
                iconSizeFactor: 0.7,
                onTap: onPlay,
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

                  final double _trimmedDuration = VideoOps.getClearTrimDurationS(
                    controller: videoEditorController,
                  );
                  String _duration = Numeric.formatDoubleWithinDigits(
                    value: _trimmedDuration,
                    digits: 1,
                    addPlus: false,
                  )!;
                  _duration = '${_duration}s';

                  final bool _maxDurationReached = _trimmedDuration > (Standards.maxVideoDurationMs * 1000);

                  final double _durationS = videoEditorController!.videoDuration.inMilliseconds / 100;
                  final double _trimmedRatio = _trimmedDuration / _durationS;
                  int _length = videoEditorController!.file.lengthSync();
                  _length = (_length * _trimmedRatio).toInt();
                  final double? _size = FileSizer.calculateSize(_length, FileSizeUnit.megaByte);
                  final String _sizeStringified = Numeric.formatDoubleWithinDigits(
                    value: _size,
                    digits: 2,
                    addPlus: false,
                  )!;

                  return BldrsText(
                    verse: Verse.plain('$_duration ~ $_sizeStringified MB'),
                    size: 1,
                    labelColor: _maxDurationReached == true ? Colorz.bloodTest : Colorz.white20,
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
