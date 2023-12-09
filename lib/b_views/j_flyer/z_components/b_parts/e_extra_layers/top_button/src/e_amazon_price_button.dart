// ignore_for_file: unused_element
part of top_button;

class _AmazonPriceButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _AmazonPriceButton({
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
    final double _height = getTopButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    final double _width = getTopButtonWidth(
      flyerModel: flyerModel,
      flyerBoxWidth: flyerBoxWidth,
    );
    final Verse? _priceLine = generateLine_current_price(
      flyerModel: flyerModel,
    );
    final Verse? _buyOnAmazonLine = generateBuyOnAmazonLine(
      flyerModel: flyerModel,
    );
    // --------------------
    /// RIGHT PRICE BOX
    final double _pricesBoxWidth = _width - _height;
    // --------------------
    final double _bottomLineScaleFactor = getBottomLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return TopButtonLabelStructure(
      flyerBoxWidth: flyerBoxWidth,
      color: _amazonBack150,
      width: _width,
      splashColor: Colorz.white200,
      onTap: () => Launcher.launchURL(flyerModel?.affiliateLink),
      child: Row(
        children: <Widget>[

          /// AMAZON LOGO
          TopButtonLabelStructure(
            width: _height,
            flyerBoxWidth: flyerBoxWidth,
            color: _darkColor,
            child: BldrsBox(
              width: _height,
              height: _height,
              icon: Iconz.amazon,
              iconColor: Colorz.white255,
              iconSizeFactor: 0.6,
              corners: getButtonCorners(flyerBoxWidth: flyerBoxWidth),
            ),
          ),

          /// PRICE
          _TwoLinesStructure(
            columnWidth: _pricesBoxWidth,
            flyerBoxWidth: flyerBoxWidth,

            /// PRICE LINE
            topChild: BldrsText(
              verse: _priceLine,
              scaleFactor: getTopLineScaleFactor(
                flyerBoxWidth: flyerBoxWidth,
              ),
              centered:  false,
              // color: _darkColor,
              // appIsLTR: true,
              // textDirection: TextDirection.ltr,
              margin: getTextMargins(flyerBoxWidth: flyerBoxWidth),
            ),

            /// BUY ON AMAZON
            bottomChild: BldrsText(
              // width: _priceLineWidth,
              verse: _buyOnAmazonLine,
              scaleFactor: _bottomLineScaleFactor,
              centered:  false,
              italic: true,
              // color: _darkColor,
              margin: getTextMargins(flyerBoxWidth: flyerBoxWidth),
              // appIsLTR: true,
              // textDirection: TextDirection.ltr,
            ),
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
