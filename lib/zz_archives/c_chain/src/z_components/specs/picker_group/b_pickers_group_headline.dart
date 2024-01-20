part of chains;

class PickersGroupHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersGroupHeadline({
    required this.headline,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse headline;
  final double? width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = width ?? Bubble.bubbleWidth(context: context);

    return Center(
      child: Container(
        key: const ValueKey<String>('PickersGroupHeadline'),
        width: _width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: BldrsAligners.superCenterAlignment(context),
        child: BldrsText(
          width: _width - 40,
          verse: headline,
          weight: VerseWeight.black,
          centered: false,
          margin: 10,
          size: 3,
          scaleFactor: 0.85,
          italic: true,
          color: Colorz.yellow125,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
