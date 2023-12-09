part of top_button;

class _WasLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _WasLine({
    required this.flyerModel,
    required this.flyerBoxWidth,
    // this.textColor = Colorz.white255,
  });
  // --------------------
  final double flyerBoxWidth;
  final FlyerModel? flyerModel;
  // final Color textColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
   // --------------------
    /// MAIN SCALES
    final double _height = getTopButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    final double _bottomLineScaleFactor = getBottomLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    final double _textMarginValue = getTextMarginValue(
        flyerBoxWidth: flyerBoxWidth
    );
    // --------------------
    return Row(
      children: <Widget>[

        /// SPACING
        Spacing(size: _textMarginValue),

        /// WAS
        BldrsText(
          // width: _priceLineWidth,
          verse: const Verse(
            id: 'phid_was',
            translate: true,
          ),
          scaleFactor: _bottomLineScaleFactor,
          centered:  false,
          weight: VerseWeight.thin,
          italic: true,
          appIsLTR: true,
          textDirection: TextDirection.ltr,
          // color: textColor,
        ),

        /// SPACING
        Spacing(size: _height * 0.05),

        /// OLD PRICE
        BldrsText(
          // width: _priceLineWidth,
          verse: generateLine_old_price(
            flyerModel: flyerModel,
          ),
          scaleFactor: _bottomLineScaleFactor,
          centered:  false,
          weight: VerseWeight.regular,
          strikeThrough: true,
          italic: true,
          appIsLTR: true,
          textDirection: TextDirection.ltr,
          // color: textColor,
        ),

        /// SPACING
        Spacing(size: _textMarginValue),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
