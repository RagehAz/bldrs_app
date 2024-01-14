part of bldrs_app_bar;

class LineWithBackAndWidgets extends StatelessWidget {

  const LineWithBackAndWidgets({
    required this.onBack,
    required this.scrollController,
    required this.appBarRowWidgets,
    required this.canGoBack,
    super.key
  });
  
  final Function onBack;
  final List<Widget>? appBarRowWidgets;
  final ScrollController? scrollController;
  final bool canGoBack;

  @override
  Widget build(BuildContext context) {

    final double _clearWidth = BldrsAppBar.clearWidth(context);
    final double _backButtonSize = canGoBack == true ? Ratioz.appBarButtonSize : 0;
    const double _spacing = Ratioz.appBarPadding;
    final double _scrollableWidth = _clearWidth
                                    - _backButtonSize
                                    - _spacing;

    return LineBox(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        const SizedBox(width: Ratioz.appBarPadding),

        if (canGoBack == true)
        BackAndSearchButton(
          backAndSearchAction: BackAndSearchAction.goBack,
          onTap: onBack,
        ),


        const SizedBox(width: Ratioz.appBarPadding),


        ScrollableAppBarWidgets(
          width: _scrollableWidth,
          scrollController: scrollController,
          children: appBarRowWidgets,
        ),

      ],
    );

  }

}
