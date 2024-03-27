part of super_time_line;

class TimelineBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TimelineBar({
    required this.width,
    required this.height,
    required this.scrollController,
    required this.msPixelLength,
    required this.totalMss,
    required this.onHandleChanged,
    required this.videoEditorController,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final ScrollController scrollController;
  final ValueNotifier<double> msPixelLength;
  final int totalMss;
  final Function(int startMs, int endMs) onHandleChanged;
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
            valueListenable: msPixelLength,
            builder: (context, double _msPixelLength, Widget? blankSpace) {

              final double _totalAvailableWidth = TimelineScale.totalAvailableWidth(
                totalMss: totalMss,
                msPixelLength: _msPixelLength,
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
                      msPixelLength: _msPixelLength,
                      totalMss: totalMss,
                      videoEditorController: videoEditorController,
                    ),

                    /// RULER
                    Ruler(
                      height: _timelineStripHeight,
                      totalMss: totalMss,
                      msPixelLength: _msPixelLength,
                    ),

                    /// SELECTOR
                    TimelineSelector(
                      height: _timelineStripHeight,
                      msPixelLength: _msPixelLength,
                      totalMss: totalMss,
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
