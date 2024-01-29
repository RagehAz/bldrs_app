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
    final double _topTextScaleFactor = getTopLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return TopButtonLabelStructure(
      flyerBoxWidth: flyerBoxWidth,
      width: _width,
      color: _basicColor,
      child: Row(
        children: <Widget>[

          /// DISCOUNT PERCENTAGE
          TopButtonLabelStructure(
            width: _discountBoxWidth,
            flyerBoxWidth: flyerBoxWidth,
            color: _darkColor,
            child: _PercentageBox(
              flyerBoxWidth: flyerBoxWidth,
              flyerModel: flyerModel,
            ),
          ),

          /// CURRENT - OLD PRICES
          _TwoLinesStructure(
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

            bottomChild: _WasLine(
              flyerBoxWidth: flyerBoxWidth,
              flyerModel: flyerModel,
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
