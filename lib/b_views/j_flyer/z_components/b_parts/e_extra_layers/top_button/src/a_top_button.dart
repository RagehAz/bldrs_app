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

    if (checkCanShowTopButton(flyerModel: flyerModel) == false){
      return const SizedBox();
    }
    else {

      /// IN STACK
      if (inStack == true){
        return SuperPositioned(
          enAlignment: Alignment.bottomLeft,
          verticalOffset: FlyerDim.footerBoxHeight(
            flyerBoxWidth: flyerBoxWidth,
            infoButtonExpanded: false,
            showTopButton: false,
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
