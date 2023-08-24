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

    final double _height = getTopButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    final double _width = getTopButtonWidth(
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _discountBoxWidth = _height;
    final double _pricesBoxWidth = _width - _discountBoxWidth;

    final double _priceLineSideMargin = _pricesBoxWidth * 0.05;
    final double _priceLineWidth = _pricesBoxWidth - (_priceLineSideMargin * 2);

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: getButtonCorners(
          flyerBoxWidth: flyerBoxWidth,
        ),
        color: Colorz.black200,
      ),
      child: Row(
        children: <Widget>[

          /// DISCOUNT RATE
          Container(
            width: _discountBoxWidth,
            height: _height,
            decoration: BoxDecoration(
              borderRadius: getButtonCorners(
                flyerBoxWidth: flyerBoxWidth,
              ),
              color: Colorz.black255,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                SuperPositioned(
                  appIsLTR: UiProvider.checkAppIsLeftToRight(),
                  verticalOffset: _height * 0.13,
                  enAlignment: Alignment.topCenter,
                  child: BldrsText(
                    // height: _height * 0.5,
                    width: _discountBoxWidth,
                    verse: generateLine_discount_rate(
                      flyerModel: flyerModel
                    ),
                    scaleFactor: 0.8,
                    centered:  true,
                    weight: VerseWeight.black,
                  ),
                ),

                SuperPositioned(
                  appIsLTR: UiProvider.checkAppIsLeftToRight(),
                  verticalOffset: _height * 0.13,
                  enAlignment: Alignment.bottomCenter,
                  child: BldrsText(
                    // height: _height * 0.5,
                    width: _discountBoxWidth,
                    verse: const Verse(
                      id: 'off',
                      translate: false,
                      casing: Casing.upperCase
                    ),
                    scaleFactor: 0.6,
                    centered:  true,
                    weight: VerseWeight.black,
                  ),
                ),

              ],
            ),
          ),

          /// CURRENT - OLD PRICES
          Container(
            width: _pricesBoxWidth,
            height: _height,
            padding: EdgeInsets.symmetric(horizontal: _priceLineSideMargin),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                SuperPositioned(
                  appIsLTR: UiProvider.checkAppIsLeftToRight(),
                  verticalOffset: _height * 0.13,
                  enAlignment: Alignment.topCenter,
                  child: BldrsText(
                    // height: _height * 0.5,
                    width: _priceLineWidth,
                    verse: Verse(
                      id: Numeric.stringifyDouble(flyerModel?.price?.current),
                      translate: false,
                    ),
                    scaleFactor: 0.8,
                    centered:  false,
                    weight: VerseWeight.black,
                  ),
                ),

                /// OLD
                SuperPositioned(
                  appIsLTR: UiProvider.checkAppIsLeftToRight(),
                  verticalOffset: _height * 0.13,
                  enAlignment: Alignment.bottomCenter,
                  child: BldrsText(
                    // height: _height * 0.5,
                    width: _priceLineWidth,
                    verse: Verse(
                      id: Numeric.stringifyDouble(flyerModel?.price?.old),
                      translate: false,
                      casing: Casing.upperCase
                    ),
                    scaleFactor: 0.6,
                    centered:  false,
                    weight: VerseWeight.black,
                    strikeThrough: true,
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
