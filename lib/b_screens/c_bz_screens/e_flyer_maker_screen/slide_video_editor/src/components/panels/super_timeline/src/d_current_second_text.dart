part of super_time_line;

class CurrentSecondText extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CurrentSecondText({
    required this.scrollController,
    required this.totalSeconds,
    required this.secondPixelLength,
    super.key
  });
  // --------------------
  final ScrollController scrollController;
  final double totalSeconds;
  final ValueNotifier<double> secondPixelLength;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return IgnorePointer(
      child: AnimatedBuilder(
          animation: scrollController,
          builder: (_, __) {

            final double _second = TimelineScale.getSecondsByPixel(
              secondPixelLength: secondPixelLength.value,
              pixels: scrollController.position.pixels,
              totalSeconds: totalSeconds,
            );

            return Align(
              alignment: Alignment.bottomCenter,
              child: BldrsText(
                verse: Verse.plain('${_second}s'),
                labelColor: Colorz.black125,
                size: 1,
                margin: 3,
              ),
            );
          }
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
