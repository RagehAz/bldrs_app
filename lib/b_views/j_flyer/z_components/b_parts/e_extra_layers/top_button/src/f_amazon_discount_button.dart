// ignore_for_file: unused_element
part of top_button;

class _AmazonDiscountButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _AmazonDiscountButton({
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
    final double _pricesBoxWidth = _width - (_height * 2);
    // --------------------
    final double _bottomLineScaleFactor = getBottomLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    final bool _appIsLTR = UiProvider.checkAppIsLeftToRight();
    // --------------------
    return TopButtonLabelStructure(
      flyerBoxWidth: flyerBoxWidth,
      color: _amazonColor,
      width: _width,
      splashColor: Colorz.white200,
      onTap: () => Launcher.launchURL(flyerModel?.affiliateLink),
      child: Row(
        children: <Widget>[

          /// AMAZON LOGO
          TopButtonLabelStructure(
            width: _height * 2,
            flyerBoxWidth: flyerBoxWidth,
            color: _basicColor,
            child: Stack(
              children: <Widget>[

                /// AMAZON LOGO
                SuperPositioned(
                  appIsLTR: _appIsLTR,
                  enAlignment: Alignment.centerLeft,
                  child: BldrsBox(
                    width: _height,
                    height: _height,
                    icon: Iconz.amazon,
                    color: _darkColor,
                    iconColor: _amazonColor,
                    iconSizeFactor: 0.6,
                    corners: getButtonCorners(flyerBoxWidth: flyerBoxWidth),
                  ),
                ),

                /// PERCENTAGE
                SuperPositioned(
                  appIsLTR: _appIsLTR,
                  enAlignment: Alignment.centerRight,
                  child: _PercentageBox(
                      flyerBoxWidth: flyerBoxWidth,
                      flyerModel: flyerModel
                  ),
                ),


              ],
            ),
          ),

          /// PRICE
          _ThreeLinesStructure(
            columnWidth: _pricesBoxWidth,
            flyerBoxWidth: flyerBoxWidth,

            /// PRICE LINE
            topChild: BldrsText(
              verse: _priceLine,
              scaleFactor: getTopLineScaleFactor(
                flyerBoxWidth: flyerBoxWidth,
              ),
              centered:  false,
              color: _darkColor,
              // appIsLTR: true,
              // textDirection: TextDirection.ltr,
              margin: getTextMargins(flyerBoxWidth: flyerBoxWidth),
            ),

            /// WAS LINE
            middleChild: _WasLine(
              flyerModel: flyerModel,
              flyerBoxWidth: flyerBoxWidth,
              textColor: _darkColor,
            ),

            /// BUY ON AMAZON
            bottomChild: BldrsText(
              // width: _priceLineWidth,
              verse: _buyOnAmazonLine,
              scaleFactor: _bottomLineScaleFactor,
              centered:  false,
              italic: true,
              color: _darkColor,
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
