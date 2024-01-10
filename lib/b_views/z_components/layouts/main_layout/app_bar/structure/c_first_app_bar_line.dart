part of bldrs_app_bar;

class FirstAppBarLine extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FirstAppBarLine({
    required this.canGoBack,
    required this.appBarType,
    required this.sectionButtonIsOn,
    required this.onBack,
    required this.pageTitleVerse,
    required this.appBarRowWidgets,
    required this.appBarScrollController,
    required this.minBoxHeight,
    required this.searchController,
    required this.onSearchSubmit,
    required this.onSearchChanged,
    required this.hintVerse,
    required this.onSearchCancelled,
    super.key
  });
  // -----------------------------------------------------------------------------
  final bool canGoBack;
  final AppBarType? appBarType;
  final bool sectionButtonIsOn;
  final Function onBack;
  final Verse? pageTitleVerse;
  final List<Widget>? appBarRowWidgets;
  final ScrollController? appBarScrollController;
  final double minBoxHeight;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onSearchChanged;
  final Verse? hintVerse;
  final Function? onSearchCancelled;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    if (appBarType == AppBarType.main){
      return LineWithSearchbar(
        onSearchChanged: onSearchChanged,
        searchController: searchController,
        onSearchCancelled: onSearchCancelled,
        onSearchSubmit: onSearchSubmit,
        hintVerse: hintVerse,
      );
      // return const LineWithSectionAndSearchButtons();
    }

    else {

      final bool _hasTitle =  TextCheck.isEmpty(pageTitleVerse?.id) == false;
      final bool _hasWidgets = Lister.checkCanLoop(appBarRowWidgets) == true;

      /// TITLE + WIDGETS
      if (_hasTitle == true && _hasWidgets == true){
        return LineWithBackAndTitleAndWidgets(
          scrollController: appBarScrollController,
          appBarRowWidgets: appBarRowWidgets,
          onBack: onBack,
          canGoBack: canGoBack,
          pageTitleVerse: pageTitleVerse,
        );
      }

      /// TITLE
      else if (_hasTitle == true && _hasWidgets == false){
        return LineWithBackAndTitle(
          pageTitleVerse: pageTitleVerse,
          onBack: onBack,
          canGoBack: canGoBack,
        );
      }

      /// WIDGETS
      else if (_hasTitle == false && _hasWidgets == true){
        return LineWithBackAndWidgets(
          onBack: onBack,
          canGoBack: canGoBack,
          scrollController: appBarScrollController,
          appBarRowWidgets: appBarRowWidgets,
        );
      }

      /// NOTHING
      else if (_hasTitle == false && _hasWidgets == false){
        return LineWithBackButtonOnly(
          onBack: onBack,
          canGoBack: canGoBack,
        );
      }

      else {
        return LineWithBackButtonOnly(
          onBack: onBack,
          canGoBack: canGoBack,
        );
      }

    }

  }
  // -----------------------------------------------------------------------------
}
