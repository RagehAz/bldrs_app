part of super_time_line;

class SecondsBoxes extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SecondsBoxes({
    required this.height,
    required this.totalSeconds,
    required this.secondPixelLength,
    super.key
  });
  // --------------------
  final double height;
  final double totalSeconds;
  final double secondPixelLength;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<double> _parts = TimelineScale.createTimeBoxes(
      seconds: totalSeconds,
    );
    // --------------------
    const List<Color> colors = [
      Colorz.green125,
      Colorz.blue125,
      Colorz.white125,
      Colorz.facebook,
      Colorz.darkBlue,
      Colorz.green125,
      Colorz.blue125,
      Colorz.white125,
      Colorz.facebook,
      Colorz.darkBlue,
      Colorz.green125,
      Colorz.blue125,
      Colorz.white125,
      Colorz.facebook,
      Colorz.darkBlue,
    ];
    // --------------------
    final double _timelineStripHeight = height * 0.5;
    final double _blankWidth = TimelineScale.blankZoneWidth();
    // --------------------
    return Row(
      children: <Widget>[

        /// LEFT BLANK
        SizedBox(
          width: _blankWidth,
          height: _timelineStripHeight,
        ),

        /// BOXES
        ...List.generate(_parts.length, (index){

          final double _part = _parts[index];

          return Container(
            width: _part * secondPixelLength,
            height: _timelineStripHeight,
            color: colors[index],
          );

        }),

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
