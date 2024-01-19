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
    final double _width = getTopButtonWidth(
      flyerBoxWidth: flyerBoxWidth,
      flyerModel: flyerModel,
    );
    // --------------------
    final double _topTextScaleFactor = getTopLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return TopButtonLabelStructure(
      flyerBoxWidth: flyerBoxWidth,
      color: _basicColor,
      width: _width,
      child: FittedBox(
        child: BldrsText(
          verse: generateLine_current_price(
            flyerModel: flyerModel,
          ),
          scaleFactor: _topTextScaleFactor,
          weight: VerseWeight.black,
          margin: getTextMargins(
            flyerBoxWidth: flyerBoxWidth,
          ),
          // appIsLTR: true,
          // textDirection: TextDirection.ltr,
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
