part of bldrs_app_bar;

class BldrsAppBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppBar({
    required this.appBarType,
    required this.onBack,
    required this.pageTitleVerse,
    required this.appBarRowWidgets,
    required this.loading,
    required this.progressBarModel,
    required this.appBarScrollController,
    required this.searchController,
    required this.onSearchSubmit,
    required this.onPaste,
    required this.onSearchChanged,
    required this.searchButtonIsOn,
    required this.searchHintVerse,
    required this.canGoBack,
    required this.onSearchCancelled,
    required this.listenToHideLayout,
    required this.filtersAreOn,
    required this.filters,
    this.onTextFieldTap,
    this.onSearchButtonTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final AppBarType? appBarType;
  final Function onBack;
  final Verse? pageTitleVerse;
  final List<Widget>? appBarRowWidgets;
  final ValueNotifier<bool>? loading;
  final ValueNotifier<ProgressBarModel?>? progressBarModel;
  final ScrollController? appBarScrollController;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onPaste;
  final ValueChanged<String?>? onSearchChanged;
  final bool searchButtonIsOn;
  final Verse? searchHintVerse;
  final bool canGoBack;
  final Function? onSearchCancelled;
  final bool listenToHideLayout;
  final ValueNotifier<bool?>? filtersAreOn;
  final Widget? filters;
  final Function? onTextFieldTap;
  final Function? onSearchButtonTap;
  /// --------------------------------------------------------------------------
  static const Widget appBarDot = SuperBox(
    height: Ratioz.appBarButtonSize,
    width: Ratioz.appBarButtonSize,
    bubble: false,
    icon: Iconz.circleDot,
    iconSizeFactor: 0.7,
    iconColor: Colorz.white50,
  );
  // -----------------------------------------------------------------------------

  /// SCALE

  // --------------------
  static double width() {
    return Scale.screenWidth(getMainContext()) - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  static double responsiveWidth() {

    final BuildContext context = getMainContext();
    final double _appBarWidth = BldrsAppBar.width();

    return Scale.responsive(
      context: context,
      landscape: Scale.screenShortestSide(context) - (2 * Ratioz.appBarMargin),
      portrait: _appBarWidth,
    );

  }
  // --------------------
  static double clearWidth(BuildContext context){
    return width() - (2 * Ratioz.appBarPadding);
  }
  // --------------------
  static double collapsedHeight(BuildContext context, AppBarType? appBarType) {

    if (appBarType == AppBarType.search){
      return Ratioz.appBarBigHeight;
    }
    else {
      return Ratioz.appBarSmallHeight;
    }

  }
  // --------------------
  static double clearLineHeight(BuildContext context) {
    return BldrsAppBar.collapsedHeight(context, AppBarType.basic) - (2 * Ratioz.appBarPadding);
  }
  // --------------------
  static double expandedHeight({
    required BuildContext context,
  }){
    return Scale.screenHeight(context) - Ratioz.appBarMargin;
  }
  // --------------------
  static double scrollWidth(BuildContext context) {
    return  Scale.screenWidth(context)
            - (Ratioz.appBarMargin * 2)
            - (Ratioz.appBarPadding * 2)
            - Ratioz.appBarButtonSize
            - Ratioz.appBarPadding;
  }
  // -----------------------------------------------------------------------------
  static const double buttonSize = Ratioz.appBarButtonSize;
  // -----------------------------------------------------------------------------

  /// CORNERS

  // --------------------
  static const BorderRadius corners = BorderRadius.all(Radius.circular(Ratioz.appBarCorner));
  // --------------------
  static const BorderRadius clearCorners = BorderRadius.all(Radius.circular(Ratioz.appBarCorner - 5));
  // -----------------------------------------------------------------------------

  /// DECORATION

  // --------------------
  static const Decoration boxDecoration = BoxDecoration(
    color: Colorz.black125,
    borderRadius: BldrsAppBar.corners,
    // boxShadow: Shadower.appBarShadow,
  );
  // --------------------
  static const double blur = 15;
  // -----------------------------------------------------------------------------

  /// ANIMATION

  // --------------------
  static const Curve expansionCurve = Curves.easeOut;
  static Duration expansionDuration = const Duration(milliseconds: 150);
  // -----------------------------------------------------------------------------

  /// FILTERS

  // --------------------
  static double filtersBoxHeight({
    required BuildContext context,
    required AppBarType appBarType,
  }) {
    final double _filtersTopMargin = BldrsAppBar.getFiltersTopMargin(
      context: context,
      appBarType: appBarType,
    );
    final double _maxBoxHeight = BldrsAppBar.expandedHeight(
      context: context,
    );
    return _maxBoxHeight - _filtersTopMargin;
  }
  // --------------------
  static double getFiltersTopMargin({
    required BuildContext context,
    required AppBarType appBarType,
  }) {

    final double _filtersTopMargin =
        BldrsAppBar.collapsedHeight(context, appBarType)
            +
        StaticProgressBar.getBoxHeight(
          flyerBoxWidth: width(),
          stripThicknessFactor: 0.4,
        );

    return _filtersTopMargin;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return LayoutVisibilityListener(
      isOn: listenToHideLayout,
      child: BldrsAppBarTree(
        appBarType: appBarType,
        onBack: onBack,
        pageTitleVerse: pageTitleVerse,
        appBarRowWidgets: appBarRowWidgets,
        loading: loading,
        progressBarModel: progressBarModel,
        appBarScrollController: appBarScrollController,
        searchController: searchController,
        onSearchSubmit: onSearchSubmit,
        onPaste: onPaste,
        onSearchChanged: onSearchChanged,
        searchButtonIsOn: searchButtonIsOn,
        searchHintVerse: searchHintVerse,
        canGoBack: canGoBack,
        onSearchCancelled: onSearchCancelled,
        filtersAreOn: filtersAreOn,
        onSearchButtonTap: onSearchButtonTap,
        onTextFieldTap: onTextFieldTap,
        filters: filters,
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
