part of top_button;

class _PercentageBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _PercentageBox({
    required this.flyerBoxWidth,
    required this.flyerModel,
  });
  // --------------------
  final double flyerBoxWidth;
  final FlyerModel? flyerModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
   // --------------------
    /// MAIN SCALES
    final double _height = getTopButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    /// LEFT DISCOUNT BOX
    final double _discountBoxWidth = _height;
    // --------------------
    final double _bottomLineScaleFactor = getBottomLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    final double _topTextScaleFactor = getTopLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return _TwoLinesStructure(
      flyerBoxWidth: flyerBoxWidth,
      columnWidth: _discountBoxWidth,

      /// PERCENTAGE
      topChild: BldrsText(
        width: _discountBoxWidth,
        verse: generateLine_discount_rate(
            flyerModel: flyerModel
        ),
        scaleFactor: _topTextScaleFactor,
        weight: VerseWeight.black,
      ),

      /// OFF
      bottomChild: BldrsText(
        width: _discountBoxWidth,
        verse: const Verse(
            id: 'phid_off',
            translate: true,
            casing: Casing.upperCase
        ),
        scaleFactor: _bottomLineScaleFactor,
        weight: VerseWeight.black,
      ),

    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
