part of top_button;

class _AmazonButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _AmazonButton({
    required this.flyerModel,
    required this.flyerBoxWidth,
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
    final double _topTextScaleFactor = getTopLineScaleFactor(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return TopButtonLabelStructure(
      flyerBoxWidth: flyerBoxWidth,
      width: _width,
      color: _amazonBack150,
      onTap: () => Launcher.launchURL(flyerModel?.affiliateLink),
      child: Row(
        children: <Widget>[

          /// INSTAGRAM LOGO
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
            ),
          ),

          /// TEXT
          SizedBox(
            width: _pricesBoxWidth,
            height: _height,
            child: FittedBox(
              child: BldrsText(
                verse: const Verse(id: 'phid_buy_on_amazon', translate: true),
                // color: _darkColor,
                scaleFactor: _topTextScaleFactor,
                weight: VerseWeight.black,
                margin: getTextMargins(
                  flyerBoxWidth: flyerBoxWidth,
                ),
                // appIsLTR: true,
                // textDirection: TextDirection.ltr,
              ),
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
