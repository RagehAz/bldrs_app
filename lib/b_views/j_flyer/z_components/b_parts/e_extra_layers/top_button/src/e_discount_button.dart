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
    final bool _appIsLTR = UiProvider.checkAppIsLeftToRight();
    // --------------------
    /// LEFT DISCOUNT BOX
    final double _discountBoxWidth = _height;
    // --------------------
    /// RIGHT PRICE BOX
    final double _pricesBoxWidth = _width - _discountBoxWidth;
    final double _priceLineWidth = _pricesBoxWidth;
    // --------------------
    /// TOP LINE SCALES
    final double _topLineVerticalOffset = getTopLiveVerticalOffset(topButtonHeight: _height);
    final double _topLineScaleFactor = getTopLineScaleFactor(topButtonHeight: _height);
    // --------------------
    /// BOTTOM LINE SCALES
    final double _bottomLineVerticalOffset = getBottomLiveVerticalOffset(topButtonHeight: _height);
    final double _bottomLineScaleFactor = getBottomLineScaleFactor(topButtonHeight: _height);
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

                /// DISCOUNT RATE
                SuperPositioned(
                  appIsLTR: _appIsLTR,
                  verticalOffset: _topLineVerticalOffset,
                  enAlignment: Alignment.topCenter,
                  child: BldrsText(
                    width: _discountBoxWidth,
                    verse: generateLine_discount_rate(
                      flyerModel: flyerModel
                    ),
                    scaleFactor: _topLineScaleFactor * 1.7,
                    weight: VerseWeight.black,
                  ),
                ),

                /// OFF
                SuperPositioned(
                  appIsLTR: _appIsLTR,
                  verticalOffset: _bottomLineVerticalOffset,
                  enAlignment: Alignment.bottomCenter,
                  child: BldrsText(
                    width: _discountBoxWidth * 0.75,
                    verse: const Verse(
                      id: 'phid_off',
                      translate: true,
                      casing: Casing.upperCase
                    ),
                    scaleFactor: _bottomLineScaleFactor,
                    // centered:  true,
                    weight: VerseWeight.black,
                  ),
                ),

              ],
            ),
          ),

          /// CURRENT - OLD PRICES
          SizedBox(
            width: _pricesBoxWidth,
            height: _height,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[

                /// CURRENT
                SuperPositioned(
                  appIsLTR: _appIsLTR,
                  verticalOffset: _topLineVerticalOffset,
                  enAlignment: Alignment.topLeft,
                  child: SizedBox(
                    width: _priceLineWidth,
                    child: FittedBox(
                      child: BldrsText(
                        verse: generateLine_current_price(
                          flyerModel: flyerModel,
                        ),
                        scaleFactor: _topLineScaleFactor * 1.7,
                        centered:  false,
                        weight: VerseWeight.black,
                        appIsLTR: true,
                        textDirection: TextDirection.ltr,
                        margin: EdgeInsets.symmetric(horizontal: _height * 0.2),
                      ),
                    ),
                  ),
                ),

                /// OLD
                SuperPositioned(
                  appIsLTR: _appIsLTR,
                  verticalOffset: _bottomLineVerticalOffset,
                  enAlignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: _priceLineWidth,
                    child: Row(
                      children: <Widget>[

                        BldrsText(
                          // width: _priceLineWidth,
                          verse: const Verse(
                            id: 'phid_was',
                            translate: true,
                          ),
                          scaleFactor: _bottomLineScaleFactor,
                          centered:  false,
                          weight: VerseWeight.thin,
                          // margin: EdgeInsets.symmetric(horizontal: _height * 0.2),
                          margin: Scale.superInsets(
                            context: context,
                            appIsLTR: _appIsLTR,
                            enLeft: _height * 0.2,
                          ),
                          italic: true,
                          appIsLTR: true,
                          textDirection: TextDirection.ltr,
                        ),

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
                          margin: EdgeInsets.symmetric(horizontal: _height * 0.05),
                          appIsLTR: true,
                          textDirection: TextDirection.ltr,
                        ),

                      ],
                    ),
                  ),
                ),

                /// SEPARATOR LINE
                // SuperPositioned(
                //   enAlignment: Alignment.centerLeft,
                //   appIsLTR: _appIsLTR,
                //   child: Container(
                //     width: 1,
                //     height: _height * 0.5,
                //     color: Colorz.white20,
                //   ),
                // ),

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
