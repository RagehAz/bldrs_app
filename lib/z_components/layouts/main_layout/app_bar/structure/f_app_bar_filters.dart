part of bldrs_app_bar;

class AppBarFilters extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const AppBarFilters({
    required this.appBarType,
    required this.child,
    super.key
  });
  // --------------------
  final AppBarType appBarType;
  final Widget child;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxWidth = Bubble.bubbleWidth(context: context);

    final double _filtersTopMargin = BldrsAppBar.getFiltersTopMargin(
      context: context,
      appBarType: appBarType,
    );

    final double _filtersBoxHeight = BldrsAppBar.filtersBoxHeight(
      context: context,
      appBarType: appBarType,
    );

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: _filtersTopMargin,
          bottom: Ratioz.appBarPadding,
          left: Ratioz.appBarPadding,
          right: Ratioz.appBarPadding,
        ),
        child: ClipRRect(
          borderRadius: BldrsAppBar.clearCorners,
          child: Container(
            width: _boxWidth - (Ratioz.appBarPadding * 2),
            height: _filtersBoxHeight - (Ratioz.appBarPadding * 2),
            decoration: const BoxDecoration(
              color: Colorz.white10,
              borderRadius: BldrsAppBar.clearCorners,
            ),
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
