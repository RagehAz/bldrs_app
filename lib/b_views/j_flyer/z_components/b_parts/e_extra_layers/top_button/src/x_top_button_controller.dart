// ignore_for_file: non_constant_identifier_names
part of top_button;
// -----------------------------------------------------------------------------

/// BUTTON TYPE

// --------------------
enum TopButtonType {
  price,
  discount,
  amazon,
  non,
}
// --------------------
/// TESTED : WORKS PERFECT
TopButtonType getTopButtonType(FlyerModel? flyerModel){

  final bool _canShowTopButton = checkCanShowTopButton(
    flyerModel: flyerModel,
  );

  if (flyerModel == null || _canShowTopButton == false){
    return TopButtonType.non;
  }
  else {

    final bool _isAmazon = GtaModel.isAmazonAffiliateLink(flyerModel.affiliateLink);

    if (_isAmazon == true){
      return TopButtonType.amazon;
    }
    else {

      final PriceModel? _priceModel = flyerModel.price;

      /// NORMAL PRICE BUTTON
      if (_priceModel?.old == null || _priceModel?.old == 0){
        return TopButtonType.price;
      }
      /// DISCOUNT PRICE BUTTON
      else {
        return TopButtonType.discount;
      }

    }

  }

}
// -----------------------------------------------------------------------------

/// CHECKERS

// --------------------
/// TESTED : WORKS PERFECT
bool checkCanShowTopButton({
  required FlyerModel? flyerModel,
}){
  if (flyerModel?.affiliateLink == null && flyerModel?.hasPriceTag == false){
    return false;
  }
  else {
    return true;
  }
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
    flyerBoxWidth: flyerBoxWidth,
    infoButtonExpanded: false,
    showTopButton: false,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
double getTopButtonWidth({
  required double flyerBoxWidth,
  required FlyerModel? flyerModel,
}){

  final TopButtonType _type = getTopButtonType(flyerModel);

  switch (_type){

      case TopButtonType.amazon:
        return FlyerDim.gtaButtonWidth(
          flyerBoxWidth: flyerBoxWidth,
        );

      case TopButtonType.price:
        return priceButtonWidth(
          flyerBoxWidth: flyerBoxWidth,
        );

        case TopButtonType.discount:
          return FlyerDim.gtaButtonWidth(
            flyerBoxWidth: flyerBoxWidth,
          );

      case TopButtonType.non:
        return 0;
  }

}
// --------------------
/// TESTED : WORKS PERFECT
double amazonButtonWidth({
  required double flyerBoxWidth,
}){

  final double _footerButtonSpacing = FlyerDim.footerButtonMarginValue(flyerBoxWidth);
  final double _footerButtonSize = FlyerDim.footerButtonSize(
    flyerBoxWidth: flyerBoxWidth,
  );

  return flyerBoxWidth
      - (_footerButtonSpacing * 2)
      - _footerButtonSize
      - (_footerButtonSize * 0.5);
}
// --------------------
/// TESTED : WORKS PERFECT
double priceButtonWidth({
  required double flyerBoxWidth,
}){

  final double _footerButtonSpacing = FlyerDim.footerButtonMarginValue(flyerBoxWidth);
  final double _footerButtonSize = FlyerDim.footerButtonSize(
    flyerBoxWidth: flyerBoxWidth,
  );

  return flyerBoxWidth
      - (_footerButtonSpacing * 3)
      - (_footerButtonSize * 2)
      - (_footerButtonSize * 0.5);
}
// --------------------
/// TESTED : WORKS PERFECT
double discountButtonWidth({
  required double flyerBoxWidth,
}){

  final double _footerButtonSpacing = FlyerDim.footerButtonMarginValue(flyerBoxWidth);
  final double _footerButtonSize = FlyerDim.footerButtonSize(

    flyerBoxWidth: flyerBoxWidth,
  );

  return flyerBoxWidth
      - (_footerButtonSpacing * 2)
      - _footerButtonSize
      - (_footerButtonSize * 0.5);
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
    final String _line = '$_percent%';

    return Verse(
      id: _line,
      translate: false,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Verse? generateLine_current_price({
  required FlyerModel? flyerModel,
}){

  if (flyerModel == null){
    return null;
  }

  else {

    final CurrencyModel? _currency = ZoneProvider.proGetCurrencyByCurrencyID(
        context: getMainContext(),
        currencyID: flyerModel.price?.currencyID,
        listen: false,
    );

    final String _number = Numeric.formatNumToSeparatedKilos(
      number: flyerModel.price?.current,
      fractions: _currency?.digits ?? 1,
    );

    final String? _currencySymbol = ZoneProvider.proGetCurrencyByCurrencyID(
      context: getMainContext(),
      currencyID: flyerModel.price?.currencyID,
      listen: false,
    )?.symbol;

    final String _line = '$_number $_currencySymbol';

    return Verse(
      id: _line,
      translate: false,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Verse? generateLine_old_price({
  required FlyerModel? flyerModel,
}){

  if (flyerModel == null){
    return null;
  }

  else {

    final CurrencyModel? _currency = ZoneProvider.proGetCurrencyByCurrencyID(
        context: getMainContext(),
        currencyID: flyerModel.price?.currencyID,
        listen: false,
    );

    final String _number = Numeric.formatNumToSeparatedKilos(
      number: flyerModel.price?.old,
      fractions: _currency?.digits ?? 1,
    );
    final String? _currencySymbol = ZoneProvider.proGetCurrencyByCurrencyID(
      context: getMainContext(),
      currencyID: flyerModel.price?.currencyID,
      listen: false,
    )?.symbol;

    return Verse(
      id: '$_number $_currencySymbol ',
      translate: false,
    );
  }

}
// -----------------------------------------------------------------------------

/// TEXT SCALING

// --------------------
/// TESTED : WORKS PERFECT
double getTopLiveVerticalOffset({
  required double topButtonHeight,
}){
  return topButtonHeight * 0.17;
}
// --------------------
/// TESTED : WORKS PERFECT
double getTopLineScaleFactor({
  required double topButtonHeight,
}){
  return topButtonHeight * 0.014;
}
// --------------------
/// TESTED : WORKS PERFECT
double getBottomLiveVerticalOffset({
  required double topButtonHeight,
}){
  return topButtonHeight * 0.23;
}
// --------------------
/// TESTED : WORKS PERFECT
double getBottomLineScaleFactor({
  required double topButtonHeight,
}){
  return topButtonHeight * 0.01;
}
// -----------------------------------------------------------------------------
