part of bldrs_app_bar;

class FirstAppBarLine extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FirstAppBarLine({
    @required this.canGoBack,
    @required this.appBarType,
    @required this.sectionButtonIsOn,
    @required this.onBack,
    @required this.pageTitleVerse,
    @required this.appBarRowWidgets,
    @required this.appBarScrollController,
    @required this.minBoxHeight,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final bool canGoBack;
  final AppBarType appBarType;
  final bool sectionButtonIsOn;
  final Function onBack;
  final Verse pageTitleVerse;
  final List<Widget> appBarRowWidgets;
  final ScrollController appBarScrollController;
  final double minBoxHeight;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    if (appBarType == AppBarType.main){
      return const LineWithSectionAndSearchButtons();
    }

    else {

      final bool _hasTitle = pageTitleVerse != null;
      final bool _hasWidgets = Mapper.checkCanLoopList(appBarRowWidgets) == true;

      /// TITLE + WIDGETS
      if (_hasTitle == true && _hasWidgets == true){
        return LineWithBackAndTitleAndWidgets(
          scrollController: appBarScrollController,
          appBarRowWidgets: appBarRowWidgets,
          onBack: onBack,
          pageTitleVerse: pageTitleVerse,
        );
      }

      /// TITLE
      else if (_hasTitle == true && _hasWidgets == false){
        return LineWithBackAndTitle(
          pageTitleVerse: pageTitleVerse,
          onBack: onBack,
        );
      }

      /// WIDGETS
      else if (_hasTitle == false && _hasWidgets == true){
        return LineWithBackAndWidgets(
          onBack: onBack,
          scrollController: appBarScrollController,
          appBarRowWidgets: appBarRowWidgets,
        );
      }

      /// NOTHING
      else if (_hasTitle == false && _hasWidgets == false){
        return LineWithBackButtonOnly(
          onBack: onBack,
        );
      }

      else {
        return LineWithBackButtonOnly(
          onBack: onBack,
        );
      }

    }

  }
  // -----------------------------------------------------------------------------
}
