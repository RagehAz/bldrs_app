part of top_button;

class TopButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TopButton({
    required this.flyerBoxWidth,
    required this.flyerModel,
    required this.inStack,
    super.key
  });
  // --------------------
  final double flyerBoxWidth;
  final FlyerModel? flyerModel;
  final bool inStack;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (_checkHideTopButton(flyerModel: flyerModel) == true){
      return const SizedBox();
    }
    else {

      /// IN STACK
      if (inStack == true){
        return SuperPositioned(
          enAlignment: Alignment.bottomLeft,
          verticalOffset: FlyerDim.footerBoxHeight(
            context: context,
            flyerBoxWidth: flyerBoxWidth,
            infoButtonExpanded: false,
            hasLink: false,
          ),
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          child: _TopButtonSwitcher(
            flyerModel: flyerModel,
            flyerBoxWidth: flyerBoxWidth,
          ),
        );
      }

      /// FLOATING
      else {
        return _TopButtonSwitcher(
            flyerModel: flyerModel,
            flyerBoxWidth: flyerBoxWidth,
          );
      }

    }

    // --------------------

  }
  // -----------------------------------------------------------------------------
}
