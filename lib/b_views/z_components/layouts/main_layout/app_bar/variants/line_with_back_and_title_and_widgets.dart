part of bldrs_app_bar;

class LineWithBackAndTitleAndWidgets extends StatelessWidget {

  const LineWithBackAndTitleAndWidgets({
    required this.onBack,
    required this.appBarRowWidgets,
    required this.scrollController,
    required this.pageTitleVerse,
    required this.canGoBack,
    super.key
  });
  
  final Function onBack;
  final List<Widget>? appBarRowWidgets;
  final ScrollController? scrollController;
  final Verse? pageTitleVerse;
  final bool canGoBack;

  @override
  Widget build(BuildContext context) {

    final double _clearWidth = BldrsAppBar.clearWidth(context);
    final double _backButtonSize = canGoBack == true ? Ratioz.appBarButtonSize : 0;
    const double _spacing = Ratioz.appBarPadding;
    final double _titleAndScrollableWidth = _clearWidth
                                          - _backButtonSize
                                          - _spacing // between back button and title
                                          - _spacing; // between title and scrollable widgets
    final double _titleWidth = _titleAndScrollableWidth / 2;
    final double _scrollableWidth = _titleAndScrollableWidth / 2;

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

        AppBarTitle(
          width: _titleWidth,
          pageTitleVerse: pageTitleVerse,
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
