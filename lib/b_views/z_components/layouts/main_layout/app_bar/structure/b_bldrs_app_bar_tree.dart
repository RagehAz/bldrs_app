part of bldrs_app_bar;

class BldrsAppBarTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppBarTree({
    required this.globalKey,
    required this.appBarType,
    required this.onBack,
    required this.pageTitleVerse,
    required this.appBarRowWidgets,
    required this.loading,
    required this.progressBarModel,
    required this.appBarScrollController,
    required this.sectionButtonIsOn,
    required this.searchController,
    required this.onSearchSubmit,
    required this.onPaste,
    required this.onSearchChanged,
    required this.searchButtonIsOn,
    required this.searchHintVerse,
    required this.canGoBack,
    required this.onSearchCancelled,
    required this.filtersAreOn,
    required this.filters,
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
  final bool? sectionButtonIsOn;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onPaste;
  final ValueChanged<String?>? onSearchChanged;
  final bool searchButtonIsOn;
  final Verse? searchHintVerse;
  final bool canGoBack;
  final Function? onSearchCancelled;
  final GlobalKey? globalKey;
  final ValueNotifier<bool?>? filtersAreOn;
  final Widget? filters;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _boxWidth = BldrsAppBar.width();
    final double _collapsedHeight = BldrsAppBar.collapsedHeight(context, appBarType);
    // --------------------
    final Widget _appBarContents = _AppBarContents(
      loading: loading,
      onBack: onBack,
      searchController: searchController,
      canGoBack: canGoBack,
      progressBarModel: progressBarModel,
      appBarRowWidgets: appBarRowWidgets,
      appBarType: appBarType,
      appBarScrollController: appBarScrollController,
      filtersAreOn: filtersAreOn,
      globalKey: globalKey,
      onPaste: onPaste,
      onSearchCancelled: onSearchCancelled,
      onSearchChanged: onSearchChanged,
      onSearchSubmit: onSearchSubmit,
      pageTitleVerse: pageTitleVerse,
      searchButtonIsOn: searchButtonIsOn,
      searchHintVerse: searchHintVerse,
      sectionButtonIsOn: sectionButtonIsOn,
      filters: filters,
    );
    // --------------------
    if (filtersAreOn == null) {
      return Container(
        width: _boxWidth,
        height: _collapsedHeight,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.all(Ratioz.appBarMargin),
        decoration: BldrsAppBar.boxDecoration,
        child: _appBarContents,
      );
    }
    // --------------------
    else {

      final double _expandedHeight = BldrsAppBar.expandedHeight(
          context: context,
      );

      return ValueListenableBuilder(
          valueListenable: filtersAreOn!,
          child: _appBarContents,
          builder: (_, bool? expanded, Widget? child){

            return AnimatedContainer(
              duration: BldrsAppBar.expansionDuration,
              curve: BldrsAppBar.expansionCurve,
              width: _boxWidth,
              height: Mapper.boolIsTrue(expanded) == true ? _expandedHeight : _collapsedHeight,
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(Ratioz.appBarMargin),
              decoration: BldrsAppBar.boxDecoration,
              child: _appBarContents,
            );
          }
          );
    }
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class _AppBarContents extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _AppBarContents({
    required this.globalKey,
    required this.appBarType,
    required this.onBack,
    required this.pageTitleVerse,
    required this.appBarRowWidgets,
    required this.loading,
    required this.progressBarModel,
    required this.appBarScrollController,
    required this.sectionButtonIsOn,
    required this.searchController,
    required this.onSearchSubmit,
    required this.onPaste,
    required this.onSearchChanged,
    required this.searchButtonIsOn,
    required this.searchHintVerse,
    required this.canGoBack,
    required this.onSearchCancelled,
    required this.filtersAreOn,
    required this.filters,
  });
  // --------------------------------------------------------------------------
  final AppBarType? appBarType;
  final Function onBack;
  final Verse? pageTitleVerse;
  final List<Widget>? appBarRowWidgets;
  final ValueNotifier<bool>? loading;
  final ValueNotifier<ProgressBarModel?>? progressBarModel;
  final ScrollController? appBarScrollController;
  final bool? sectionButtonIsOn;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onPaste;
  final ValueChanged<String?>? onSearchChanged;
  final bool searchButtonIsOn;
  final Verse? searchHintVerse;
  final bool canGoBack;
  final Function? onSearchCancelled;
  final GlobalKey? globalKey;
  final ValueNotifier<bool?>? filtersAreOn;
  final Widget? filters;
  // -----------------------------------------------------------------------------
  bool _sectionButtonIsOnCheck() {

    if (sectionButtonIsOn != null) {
      return sectionButtonIsOn!;
    }
    else if (sectionButtonIsOn == false) {
      return false;
    }
    else if (appBarType == AppBarType.basic) {
      return false;
    }
    else if (appBarType == AppBarType.scrollable) {
      return false;
    }
    else if (appBarType == AppBarType.main) {
      return true;
    }
    else if (appBarType == AppBarType.search) {
      return false;
    }
    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _boxWidth = BldrsAppBar.width();
    final double _collapsedHeight = BldrsAppBar.collapsedHeight(context, appBarType);
    // --------------------
    final bool _sectionButtonIsOn = _sectionButtonIsOnCheck();
    // --------------------
    return Stack(
      alignment: BldrsAligners.superTopAlignment(context),
      children: <Widget>[

        /// BLUR
        AppBarBlurLayer(
          isExpanded: filtersAreOn,
          blurIsOn: true,
          appBarType: appBarType,
        ),

        /// CONTENTS
        SizedBox(
          width: _boxWidth,
          height: _collapsedHeight,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              /// BACK / SEARCH / SECTION / ZONE
              FirstAppBarLine(
                canGoBack: canGoBack,
                appBarType: appBarType,
                pageTitleVerse: pageTitleVerse,
                onBack: onBack,
                appBarScrollController: appBarScrollController,
                minBoxHeight: _collapsedHeight,
                sectionButtonIsOn: _sectionButtonIsOn,
                appBarRowWidgets: appBarRowWidgets,
              ),

              /// SEARCH BAR,
              if (appBarType == AppBarType.search)
                SearchBar(
                  searchController: searchController,
                  onSearchSubmit: onSearchSubmit,
                  onPaste: onPaste,
                  searchButtonIsOn: searchButtonIsOn,
                  onSearchChanged: onSearchChanged,
                  hintVerse: searchHintVerse,
                  onSearchCancelled: onSearchCancelled,
                  appBarType: appBarType,
                  globalKey: globalKey,
                  filtersAreOn: filtersAreOn,
                  onFilterTap: (){

                    if (filtersAreOn != null){

                      setNotifier(
                          notifier: filtersAreOn,
                          mounted: true,
                          value: !Mapper.boolIsTrue(filtersAreOn?.value),
                      );

                    }

                  },
                ),

            ],
          ),
        ),

        /// PROGRESS BAR
        if (loading != null)
          AppBarProgressBar(
            progressBarModel: progressBarModel,
            loading: loading!,
            appBarType: appBarType,
          ),

        if (filtersAreOn != null && filters != null)
          AppBarFilters(
            appBarType: appBarType!,
            child: filters!,
          ),

      ],
    );

  }

}
