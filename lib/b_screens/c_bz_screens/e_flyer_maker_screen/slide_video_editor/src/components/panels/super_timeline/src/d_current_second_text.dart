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

            double _s = TimelineScale.getSecondsByPixel(
              secondPixelLength: secondPixelLength.value,
              pixels: scrollController.position.pixels,
            );
            _s = _s.clamp(0, totalSeconds);

            final String _second = Numeric.formatDoubleWithinDigits(
              value: _s,
              digits: 2,
              addPlus: false,
            )!;

            return Align(
              alignment: Alignment.bottomCenter,
              child: BldrsBox(
                height: 15,
                verse: Verse.plain('${_second}s'),
                color: Colorz.black255,
                verseScaleFactor: 1.2,
                borderColor: Colorz.white255,
              ),
            );
          }
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
