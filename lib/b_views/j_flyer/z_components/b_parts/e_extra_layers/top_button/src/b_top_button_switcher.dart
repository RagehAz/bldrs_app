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
        return _AmazonDiscountButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );

        /// AMAZON DISCOUNT
      case TopButtonType.amazon:
        return _AmazonButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );

        /// FACEBOOK
      case TopButtonType.facebook:
        return _FacebookButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );

        /// INSTAGRAM
      case TopButtonType.instagram:
        return  _InstagramButton(
          flyerModel: flyerModel,
          flyerBoxWidth: flyerBoxWidth,
        );

        /// NON
        default:
          return const SizedBox();

    }

  }
  // -----------------------------------------------------------------------------
}
