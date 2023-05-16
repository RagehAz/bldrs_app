part of bldrs_app_bar;

class AppBarFilters extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const AppBarFilters({
    @required this.appBarType,
    @required this.children,
    Key key
  }) : super(key: key);
  // --------------------
  final AppBarType appBarType;
  final List<Widget> children;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxWidth = BldrsAppBar.width(context);

    final double _filtersTopMargin = BldrsAppBar.getFiltersTopMargin(
      context: context,
      appBarType: appBarType,
    );

    final double _filtersBoxHeight = BldrsAppBar.filtersBoxHeight(
      context: context,
      appBarType: appBarType,
    );

    return Padding(
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
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: Ratioz.appBarPadding,
              right: Ratioz.appBarPadding,
              bottom: Ratioz.horizon,
              top: Ratioz.appBarPadding,
            ),
            children: children,
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
