// ignore_for_file: unused_element
part of top_button;

class _PriceButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _PriceButton({
    required this.flyerModel,
    required this.flyerBoxWidth,
    super.key,
  });
  // --------------------
  final FlyerModel? flyerModel;
  final double flyerBoxWidth;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
   // --------------------
    /// MAIN SCALES
    final double _height = getTopButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    final double _width = getTopButtonWidth(
      flyerBoxWidth: flyerBoxWidth,
      flyerModel: flyerModel,
    );
    // --------------------
    /// TOP LINE SCALES
    final double _topLineScaleFactor = getTopLineScaleFactor(topButtonHeight: _height);
    // --------------------
    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        borderRadius: getButtonCorners(
          flyerBoxWidth: flyerBoxWidth,
        ),
        color: Colorz.black150,
      ),
      alignment: Alignment.center,
      child: BldrsText(
        width: _width,
        verse: generateLine_current_price(
          flyerModel: flyerModel,
        ),
        scaleFactor: _topLineScaleFactor,
        weight: VerseWeight.black,
        margin: EdgeInsets.symmetric(horizontal: _height * 0.2),
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        textDirection: UiProvider.getAppTextDir(),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
