part of super_time_line;

class SecondsBoxes extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SecondsBoxes({
    required this.height,
    required this.totalMss,
    required this.msPixelLength,
    required this.videoEditorController,
    super.key
  });
  // --------------------
  final double height;
  final int totalMss;
  final double msPixelLength;
  final VideoEditorController? videoEditorController;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _timelineStripHeight = height * 0.5;
    final double _blankWidth = TimelineScale.blankZoneWidth();
    final double _totalAvailableWidth = TimelineScale.totalAvailableWidth(
      totalMss: totalMss,
      msPixelLength: msPixelLength,
    );
    final double _boxesWidth = _totalAvailableWidth - (2*_blankWidth);
    // --------------------
    return Row(
      children: <Widget>[

        /// LEFT BLANK
        SizedBox(
          width: _blankWidth,
          height: _timelineStripHeight,
        ),

        /// FRAMES BOXES
        if (videoEditorController != null)
        VideoBoxer(
          width: _boxesWidth,
          height: _timelineStripHeight,
          controller: videoEditorController!,
        ),

        /// RIGHT BLANK
        SizedBox(
          width: _blankWidth,
          height: _timelineStripHeight,
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
