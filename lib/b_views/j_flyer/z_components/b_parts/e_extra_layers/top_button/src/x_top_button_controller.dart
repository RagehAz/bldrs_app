// ignore_for_file: non_constant_identifier_names
part of top_button;
// -----------------------------------------------------------------------------

/// BUTTON TYPE

// --------------------
enum TopButtonType {
  price,
  discount,
  amazonPrice,
  amazonDiscount,
  amazon,
  facebook,
  instagram,
  non,
}
// --------------------
/// TESTED : WORKS PERFECT
TopButtonType getTopButtonType(FlyerModel? flyerModel){

  final bool _canShowTopButton = checkCanShowTopButton(
    flyerModel: flyerModel,
  );

  /// HAS NO BUTTON
  if (flyerModel == null || _canShowTopButton == false){
    return TopButtonType.non;
  }

  /// HAS BUTTON
  else {

    /// FACEBOOK
    if (_isFacebookButton(flyerModel) == true){
      return TopButtonType.facebook;
    }

    /// INSTAGRAM
    else if (_isInstagramButton(flyerModel) == true){
      return TopButtonType.instagram;
    }

    /// AMAZON
    else if (_isAmazonButton(flyerModel) == true){

      if (_isPriceButton(flyerModel) == true){
        return TopButtonType.amazonPrice;
      }
      else if (_isDiscountButton(flyerModel) == true){
        return TopButtonType.amazonDiscount;
      }
      else {
        return TopButtonType.amazon;
      }

    }

    /// PRICE
    else if (_isPriceButton(flyerModel) == true){
      return TopButtonType.price;
    }

    /// DISCOUNT
    else if (_isDiscountButton(flyerModel) == true){
      return TopButtonType.discount;
    }

    /// NON
    else {
      return TopButtonType.non;
    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
bool _isPriceButton(FlyerModel? flyerModel){

  if (flyerModel?.price == null){
    return false;
  }

  else {

    final PriceModel _priceModel = flyerModel!.price!;

    /// NORMAL PRICE BUTTON
    if (_priceModel.old == null || _priceModel.old == 0){
      return true;
    }
    /// DISCOUNT PRICE BUTTON
    else {
      return false;
    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
bool _isDiscountButton(FlyerModel? flyerModel){

  if (flyerModel?.price == null){
    return false;
  }

  else {

    final PriceModel _priceModel = flyerModel!.price!;

    /// NORMAL PRICE BUTTON
    if (_priceModel.old == null || _priceModel.old == 0){
      return false;
    }
    /// DISCOUNT PRICE BUTTON
    else {
      return true;
    }

  }
}
// --------------------
/// TESTED : WORKS PERFECT
bool _isAmazonButton(FlyerModel? flyerModel){
  return GtaModel.isAmazonAffiliateLink(flyerModel?.affiliateLink);
}
// --------------------
/// TESTED : WORKS PERFECT
bool _isFacebookButton(FlyerModel? flyerModel){
  final ContactType? _contactType = ContactModel.concludeContactTypeByURLDomain(
    url: flyerModel?.affiliateLink,
  );

  return _contactType == ContactType.facebook;
}
// --------------------
/// TESTED : WORKS PERFECT
bool _isInstagramButton(FlyerModel? flyerModel){
  final ContactType? _contactType = ContactModel.concludeContactTypeByURLDomain(
    url: flyerModel?.affiliateLink,
  );

  return _contactType == ContactType.instagram;
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

  final double _buttonHeight = getTopButtonHeight(flyerBoxWidth: flyerBoxWidth,);
  final double _smallWidth = priceButtonWidth(flyerBoxWidth: flyerBoxWidth);
  final double _mediumWidth = FlyerDim.gtaButtonWidth(flyerBoxWidth: flyerBoxWidth);
  final double _bigWidth = _mediumWidth + _buttonHeight;

  switch (_type){

      case TopButtonType.price: return _smallWidth;

      case TopButtonType.discount: return _mediumWidth;

      case TopButtonType.amazonPrice: return _mediumWidth;

      case TopButtonType.amazonDiscount: return _bigWidth;

      case TopButtonType.amazon: return _mediumWidth;

      case TopButtonType.facebook: return _mediumWidth;

      case TopButtonType.instagram: return _mediumWidth;

      case TopButtonType.non: return 0;

      default: return 0;

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
// -----------------------------------------------------------------------------

/// LABEL CORNERS

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

/// TEXT MARGIN

// --------------------
/// TESTED : WORKS PERFECT
double getTextMarginValue({
  required double flyerBoxWidth,
}){
  final double _height = getTopButtonHeight(
    flyerBoxWidth: flyerBoxWidth,
  );
  return _height * 0.2;
}
// --------------------
/// TESTED : WORKS PERFECT
EdgeInsets getTextMargins({
  required double flyerBoxWidth,
}){
  final double _textMarginValue = getTextMarginValue(
      flyerBoxWidth: flyerBoxWidth
  );
  return EdgeInsets.symmetric(horizontal: _textMarginValue);
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
  )?.symbol ?? '';

  final String _line = '$_price $_currencySymbol';

  return Verse(
      id: _line,
      translate: false,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Verse? generateBuyOnAmazonLine({
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

    final String _currencySymbol = CurrencyModel.getCurrencyISO3(
      currencyID: _currency?.id,
      symbolOverride: CurrencyModel.basicSymbolsOverride,
    ) ?? '';

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
    final String _currencySymbol = CurrencyModel.getCurrencyISO3(
      currencyID: _currency?.id,
      symbolOverride: CurrencyModel.basicSymbolsOverride,
    ) ?? '';

    return Verse(
      id: '$_number $_currencySymbol ',
      translate: false,
    );

  }

}
// -----------------------------------------------------------------------------

/// COLORS

// --------------------
Color _basicColor = Colorz.black150;
Color _darkColor = Colorz.black255;
Color _amazonColor = const Color.fromARGB(255, 255, 153, 0);
// -----------------------------------------------------------------------------

/// TEXT SCALING

// --------------------
/// TESTED : WORKS PERFECT
double getBottomLineScaleFactor({
  required double flyerBoxWidth,
}){
  final double _height = getTopButtonHeight(
    flyerBoxWidth: flyerBoxWidth,
  );
  return _height * 0.014;
}
// --------------------
/// TESTED : WORKS PERFECT
double getTopLineScaleFactor({
  required double flyerBoxWidth,
}){
  final double _bottomLineScaleFactor = getBottomLineScaleFactor(
    flyerBoxWidth: flyerBoxWidth,
  );
  return _bottomLineScaleFactor * 1.7;
}
// -----------------------------------------------------------------------------
