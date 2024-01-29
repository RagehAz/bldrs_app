part of bldrs_app_bar;

class LineWithBackAndTitle extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LineWithBackAndTitle({
    required this.pageTitleVerse,
    required this.onBack,
    required this.canGoBack,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Verse? pageTitleVerse;
  final Function onBack;
  final bool canGoBack;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = BldrsAppBar.clearWidth(context);
    final double _backButtonSize = canGoBack == true ? Ratioz.appBarButtonSize : 0;
    const double _spacing = Ratioz.appBarPadding;
    final double _titleWidth = _clearWidth - _backButtonSize - _spacing;

    return LineBox(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        const SizedBox(
          width: Ratioz.appBarPadding,
          height: Ratioz.appBarButtonSize,
        ),

        if (canGoBack == true)
        TheBackButton(
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
  // -----------------------------------------------------------------------------
}
