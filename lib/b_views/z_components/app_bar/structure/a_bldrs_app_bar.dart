part of bldrs_app_bar;

class BldrsAppBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppBar({
    @required this.globalKey,
    @required this.appBarType,
    @required this.onBack,
    @required this.pageTitleVerse,
    @required this.appBarRowWidgets,
    @required this.loading,
    @required this.progressBarModel,
    @required this.appBarScrollController,
    @required this.sectionButtonIsOn,
    @required this.searchController,
    @required this.onSearchSubmit,
    @required this.onPaste,
    @required this.onSearchChanged,
    @required this.searchButtonIsOn,
    @required this.searchHintVerse,
    @required this.canGoBack,
    @required this.onSearchCancelled,
    @required this.listenToHideLayout,
    @required this.filtersAreOn,
    @required this.filtersChildren,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AppBarType appBarType;
  final Function onBack;
  final Verse pageTitleVerse;
  final List<Widget> appBarRowWidgets;
  final ValueNotifier<bool> loading;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final ScrollController appBarScrollController;
  final bool sectionButtonIsOn;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onPaste;
  final ValueChanged<String> onSearchChanged;
  final bool searchButtonIsOn;
  final Verse searchHintVerse;
  final bool canGoBack;
  final Function onSearchCancelled;
  final GlobalKey globalKey;
  final bool listenToHideLayout;
  final ValueNotifier<bool> filtersAreOn;
  final List<Widget> filtersChildren;
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
  static double width(BuildContext context) {
    return Scale.screenWidth(context) - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  static double clearWidth(BuildContext context){
    return width(context) - (2 * Ratioz.appBarPadding);
  }
  // --------------------
  static double collapsedHeight(BuildContext context, AppBarType appBarType) {

    if (appBarType == AppBarType.search){
      return Ratioz.appBarBigHeight;
    }
    else {
      return Ratioz.appBarSmallHeight;
    }

  }
  // --------------------
  static double expandedHeight({
    @required BuildContext context,
    @required AppBarType appBarType,
  }){
    final double _collapsedHeight = BldrsAppBar.collapsedHeight(context, appBarType);
    return _collapsedHeight * 4;
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
    @required BuildContext context,
    @required AppBarType appBarType,
  }) {
    final double _filtersTopMargin = BldrsAppBar.getFiltersTopMargin(
      context: context,
      appBarType: appBarType,
    );
    final double _maxBoxHeight = BldrsAppBar.expandedHeight(
      context: context,
      appBarType: appBarType,
    );
    return _maxBoxHeight - _filtersTopMargin;
  }
  // --------------------
  static double getFiltersTopMargin({
    @required BuildContext context,
    @required AppBarType appBarType,
  }) {

    final double _filtersTopMargin =
        BldrsAppBar.collapsedHeight(context, appBarType)
            +
        StaticProgressBar.getBoxHeight(
          flyerBoxWidth: width(context),
          stripThicknessFactor: 0.4,
        );

    return _filtersTopMargin;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _theAppBar = BldrsAppBarTree(
      globalKey: globalKey,
      appBarType: appBarType,
      onBack: onBack,
      pageTitleVerse: pageTitleVerse,
      appBarRowWidgets: appBarRowWidgets,
      loading: loading,
      progressBarModel: progressBarModel,
      appBarScrollController: appBarScrollController,
      sectionButtonIsOn: sectionButtonIsOn,
      searchController: searchController,
      onSearchSubmit: onSearchSubmit,
      onPaste: onPaste,
      onSearchChanged: onSearchChanged,
      searchButtonIsOn: searchButtonIsOn,
      searchHintVerse: searchHintVerse,
      canGoBack: canGoBack,
      onSearchCancelled: onSearchCancelled,
      filtersAreOn: filtersAreOn,
      filtersChildren: filtersChildren,
    );

    // --------------------
    if (listenToHideLayout == false){
      return _theAppBar;
    }

    else {
      return Selector<UiProvider, bool>(
        selector: (_, UiProvider uiProvider) => uiProvider.layoutIsVisible,
        builder: (_, bool isVisible, Widget child) {

          // blog('bldrs app bar isVisible: $isVisible');

          return IgnorePointer(
            ignoring: !isVisible,
            child: WidgetFader(
              fadeType: isVisible == false ? FadeType.fadeOut : FadeType.fadeIn,
              duration: const Duration(milliseconds: 300),
              child: child,
            ),
          );

        },

        child: _theAppBar,
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
