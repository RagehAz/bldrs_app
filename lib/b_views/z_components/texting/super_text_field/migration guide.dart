
/*

  SuperValidator

            scrollPadding: EdgeInsets.only(
            bottom: Scale.screenHeight(context) * 0.3,
            top: Scale.screenHeight(context) * 0.3,
          ),


 */

// --------------------------------------------------------------------------

/*

  static EdgeInsets getFieldScrollPadding({
    @required BuildContext context,
    @required AppBarType appBarType,

  }){

    final EdgeInsets _scrollPadding = EdgeInsets.only(
      bottom: 100 + MediaQuery.of(context).viewInsets.bottom,
      top: BldrsAppBar.height(context, appBarType) + BubbleHeader.getHeight() + Bubble.paddingValue() + 20,
    );

    return _scrollPadding;
  }


 */
