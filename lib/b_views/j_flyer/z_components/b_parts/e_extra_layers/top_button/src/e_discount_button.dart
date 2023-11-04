// ignore_for_file: unused_element
part of top_button;

class _DiscountButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _DiscountButton({
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
    /// LEFT DISCOUNT BOX
    final double _discountBoxWidth = _height;
    // --------------------
    /// RIGHT PRICE BOX
    final double _pricesBoxWidth = _width - _discountBoxWidth;
    // --------------------
    final double _bottomLineScaleFactor = getBottomLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    final double _topTextScaleFactor = getTopLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    final double _textMarginValue = getTextMarginValue(
        flyerBoxWidth: flyerBoxWidth
    );
    // --------------------
    return _LabelStructure(
      flyerBoxWidth: flyerBoxWidth,
      width: _width,
      color: _basicColor,
      child: Row(
        children: <Widget>[

          /// DISCOUNT PERCENTAGE
          _LabelStructure(
            width: _discountBoxWidth,
            flyerBoxWidth: flyerBoxWidth,
            color: _darkColor,
            child: _DiscountStructure(
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

            ),
          ),

          /// CURRENT - OLD PRICES
          _DiscountStructure(
            columnWidth: _pricesBoxWidth,
            flyerBoxWidth: flyerBoxWidth,

              topChild: BldrsText(
                verse: generateLine_current_price(
                  flyerModel: flyerModel,
                ),
                scaleFactor: _topTextScaleFactor,
                centered:  false,
                weight: VerseWeight.black,
                // appIsLTR: true,
                // textDirection: TextDirection.ltr,
                margin: getTextMargins(flyerBoxWidth: flyerBoxWidth),
              ),

              bottomChild: Row(
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
                  ),

                  /// SPACING
                  Spacing(size: _textMarginValue),

                ],
              ),

          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
