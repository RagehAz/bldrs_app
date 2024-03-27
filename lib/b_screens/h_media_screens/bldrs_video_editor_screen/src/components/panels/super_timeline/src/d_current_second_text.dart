part of super_time_line;

class CurrentSecondText extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CurrentSecondText({
    required this.scrollController,
    required this.totalMss,
    required this.msPixelLength,
    super.key
  });
  // --------------------
  final ScrollController scrollController;
  final int totalMss;
  final ValueNotifier<double> msPixelLength;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return IgnorePointer(
      child: AnimatedBuilder(
          animation: scrollController,
          builder: (_, __) {

            int _milliSeconds = TimelineScale.getMssByPixel(
              msPixelLength: msPixelLength.value,
              pixels: scrollController.position.pixels,
            );
            _milliSeconds = _milliSeconds.clamp(0, totalMss);

            final String _second = Numeric.formatDoubleWithinDigits(
              value: _milliSeconds / 1000,
              digits: 1,
              addPlus: false,
            )!;

            return Align(
              alignment: Alignment.bottomCenter,
              child: BldrsBox(
                height: 20,
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
