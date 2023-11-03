// ignore_for_file: unused_element
part of top_button;

class _TopButtonSwitcher extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _TopButtonSwitcher({
    required this.flyerModel,
    required this.flyerBoxWidth,
    super.key
  });
  // --------------------
  final FlyerModel? flyerModel;
  final double flyerBoxWidth;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final PriceModel? _priceModel = flyerModel?.price;

    if (_priceModel == null){
      return const SizedBox();
    }

    else {

      /// NORMAL PRICE BUTTON
      if (_priceModel.old == null || _priceModel.old == 0){
        return _PriceButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

      /// DISCOUNT PRICE BUTTON
      else {
        return _DiscountButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );
      }

    }

    /// AMAZON BUTTON
    if (GtaModel.isAmazonAffiliateLink(flyerModel?.affiliateLink) == true){
      return _AmazonButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
      );
    }

    /// PRICE - DISCOUNT BUTTON
    else {

      final PriceModel? _priceModel = flyerModel?.price;

      if (_priceModel == null){
        return const SizedBox();
      }
      else {

        /// NORMAL PRICE BUTTON
        if (_priceModel.old == null || _priceModel.old == 0){
          return _PriceButton(
            flyerModel: flyerModel,
            flyerBoxWidth: flyerBoxWidth,
          );
        }

        /// DISCOUNT PRICE BUTTON
        else {
          return _DiscountButton(
            flyerModel: flyerModel,
            flyerBoxWidth: flyerBoxWidth,
          );
        }

      }

    }

  }
  // -----------------------------------------------------------------------------
}
