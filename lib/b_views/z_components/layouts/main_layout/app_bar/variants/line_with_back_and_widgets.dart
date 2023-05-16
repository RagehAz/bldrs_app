part of bldrs_app_bar;

class LineWithBackAndWidgets extends StatelessWidget {

  const LineWithBackAndWidgets({
    @required this.onBack,
    @required this.scrollController,
    @required this.appBarRowWidgets,
    Key key
  }) : super(key: key);

  final Function onBack;
    final List<Widget> appBarRowWidgets;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {

    final double _clearWidth = BldrsAppBar.clearWidth(context);
    const double _backButtonSize = Ratioz.appBarButtonSize;
    const double _spacing = Ratioz.appBarPadding;
    final double _scrollableWidth = _clearWidth
                                    - _backButtonSize
                                    - _spacing;

    return LineBox(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        const SizedBox(width: Ratioz.appBarPadding),

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
