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

    final TopButtonType _buttonType = getTopButtonType(flyerModel);

    switch (_buttonType){

      /// PRICE
      case TopButtonType.price:
        return _PriceButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );

        /// DISCOUNT
      case TopButtonType.discount:
        return _DiscountButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );

        /// AMAZON PRICE
      case TopButtonType.amazonPrice:
        return _AmazonPriceButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );

        /// AMAZON DISCOUNT
      case TopButtonType.amazonDiscount:
        return _AmazonPriceButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );

        /// FACEBOOK
      case TopButtonType.facebook:
        return const SizedBox();

        /// INSTAGRAM
      case TopButtonType.instagram:
        return const SizedBox();

        /// NON
        default:
          return const SizedBox();

    }

  }
  // -----------------------------------------------------------------------------
}
