part of super_time_line;

class TimelineBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TimelineBar({
    required this.width,
    required this.height,
    required this.scrollController,
    required this.secondPixelLength,
    required this.totalSeconds,
    required this.onHandleChanged,
    required this.videoEditorController,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final ScrollController scrollController;
  final ValueNotifier<double> secondPixelLength;
  final double totalSeconds;
  final Function(double start, double end) onHandleChanged;
  final VideoEditorController? videoEditorController;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _timelineStripHeight = height * 0.5;
    // --------------------
    return FloatingList(
      width: width,
      height: height,
      scrollDirection: Axis.horizontal,
      scrollController: scrollController,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisAlignment: MainAxisAlignment.center,
      columnChildren: <Widget>[

        ValueListenableBuilder(
            valueListenable: secondPixelLength,
            builder: (context, double _secondPixelLength, Widget? blankSpace) {

              final double _totalAvailableWidth = TimelineScale.totalAvailableWidth(
                totalSeconds: totalSeconds,
                secondPixelLength: _secondPixelLength,
              );

              return SizedBox(
                width: _totalAvailableWidth,
                height: height,
                child: Stack(
                  // alignment: Alignment.topCenter,
                  children: <Widget>[

                    /// SECONDS BOXES
                    SecondsBoxes(
                      height: height,
                      secondPixelLength: _secondPixelLength,
                      totalSeconds: totalSeconds,
                      videoEditorController: videoEditorController,
                    ),

                    /// RULER
                    Ruler(
                      height: _timelineStripHeight,
                      totalSeconds: totalSeconds,
                      secondPixelLength: _secondPixelLength,
                    ),

                    /// SELECTOR
                    TimelineSelector(
                      height: _timelineStripHeight,
                      secondPixelLength: _secondPixelLength,
                      totalSeconds: totalSeconds,
                      onHandleChanged: onHandleChanged,
                    ),

                  ],
                ),
              );
            }
        ),

      ],

    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
