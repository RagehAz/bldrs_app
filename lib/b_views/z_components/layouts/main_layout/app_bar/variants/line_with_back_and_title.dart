part of bldrs_app_bar;

class LineWithBackAndTitle extends StatelessWidget {

  const LineWithBackAndTitle({
    required this.pageTitleVerse,
    required this.onBack,
    super.key
  });
  
  final Verse? pageTitleVerse;
  final Function onBack;

  @override
  Widget build(BuildContext context) {

    final double _clearWidth = BldrsAppBar.clearWidth(context);
    const double _backButtonSize = Ratioz.appBarButtonSize;
    const double _spacing = Ratioz.appBarPadding;
    final double _titleWidth = _clearWidth - _backButtonSize - _spacing;

    return LineBox(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        const SizedBox(width: Ratioz.appBarPadding),

        BackAndSearchButton(
          backAndSearchAction: BackAndSearchAction.goBack,
          onTap: onBack,
        ),

        const SizedBox(width: Ratioz.appBarPadding),

        AppBarTitle(
          width: _titleWidth,
          pageTitleVerse: pageTitleVerse,
          // backButtonIsOn: _backButtonIsOn,
          // appBarRowWidgets: appBarRowWidgets,
        ),

      ],
    );

  }

}
