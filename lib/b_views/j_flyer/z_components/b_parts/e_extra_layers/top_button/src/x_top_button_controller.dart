// ignore_for_file: non_constant_identifier_names

part of top_button;

// -----------------------------------------------------------------------------

/// CHECKERS

// --------------------
/// TESTED : WORKS PERFECT
bool _checkHideTopButton({
  required FlyerModel? flyerModel,
}){
  return flyerModel?.affiliateLink == null && flyerModel?.hasPriceTag == false;
}
// --------------------
/// TESTED : WORKS PERFECT
bool _checkPriceIsGood({
   required FlyerModel? flyerModel,
}){
  final double? _price = flyerModel?.price?.current;
  final String? _currencyID = flyerModel?.price?.currencyID;
  final bool _showPrice = _price != null && _currencyID != null;
  return _showPrice;
}
// -----------------------------------------------------------------------------

/// SCALES

// --------------------
/// TESTED : WORKS PERFECT
double getTopButtonHeight({
  required double flyerBoxWidth,
}){
  return FlyerDim.footerBoxHeight(
    context: getMainContext(),
    flyerBoxWidth: flyerBoxWidth,
    infoButtonExpanded: false,
    hasLink: false,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
double getTopButtonWidth({
  required double flyerBoxWidth,
}){
  return FlyerDim.gtaButtonWidth(
    context: getMainContext(),
    flyerBoxWidth: flyerBoxWidth,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
BorderRadius getButtonCorners({
  required double flyerBoxWidth,
}){
  final BorderRadius _slateCorners = FlyerDim.headerSlateCorners(
      flyerBoxWidth: flyerBoxWidth
  );

  return Borderers.cornerOnly(
    appIsLTR: UiProvider.checkAppIsLeftToRight(),
    enBottomLeft: 0,
    enTopLeft: 0,
    enTopRight: _slateCorners.topRight.x,
    enBottomRight: _slateCorners.topRight.x,
  );
}
// -----------------------------------------------------------------------------

/// STRINGERS

// --------------------
/// TESTED : WORKS PERFECT
Verse generateLine_price_symbol({
  required FlyerModel? flyerModel,
}){

  final double? _price = flyerModel?.price?.current;
  final String? _currencyID = flyerModel?.price?.currencyID;

  final String? _currencySymbol = ZoneProvider.proGetCurrencyByCurrencyID(
    context: getMainContext(),
    currencyID: _currencyID,
    listen: false,
  )?.symbol;

  final String _line = '$_price $_currencySymbol';

  return Verse(
      id: _line,
      translate: false,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Verse generateFirstLineForAmazonButton({
  required FlyerModel? flyerModel,
}){
  final Verse _priceVerse = generateLine_price_symbol(
    flyerModel: flyerModel,
  );
  const Verse _buyOnAmazonVerse = Verse(id: 'phid_buy_on_amazon', translate: true);
  final bool _showPrice =_checkPriceIsGood(flyerModel: flyerModel);
  return _showPrice == true ? _priceVerse : _buyOnAmazonVerse;
}
// --------------------
/// TESTED : WORKS PERFECT
Verse? generateSecondLineForAmazonButton({
  required FlyerModel? flyerModel,
}){
  const Verse _buyOnAmazonVerse = Verse(id: 'phid_buy_on_amazon', translate: true);
  final bool _showPrice =_checkPriceIsGood(flyerModel: flyerModel);
  return _showPrice == true ? _buyOnAmazonVerse : null;
}
// --------------------
/// TESTED : WORKS PERFECT
Verse? generateLine_discount_rate({
  required FlyerModel? flyerModel,
}){

  if (flyerModel?.price == null){
    return null;
  }

  else {

    final int _percent = PriceModel.getDiscountPercentage(price: flyerModel?.price);
    final String _line = '$_percent %';

    return Verse(
      id: _line,
      translate: false,
    );
  }

}

Verse? generateLine_was_button({
  required FlyerModel? flyerModel,
}){

  if (flyerModel == null){
    return null;
  }

  else {

    final String _number = Numeric.stringifyDouble(flyerModel.price?.old);

  }

}
// -----------------------------------------------------------------------------

/// STRINGERS

// --------------------

// -----------------------------------------------------------------------------
