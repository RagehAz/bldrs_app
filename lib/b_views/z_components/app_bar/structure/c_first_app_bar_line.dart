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
  bool _backButtonIsOnCheck() {

    if (canGoBack == true){

      if (appBarType == AppBarType.basic) {
        return true;
      }
      else if (appBarType == AppBarType.scrollable) {
        return true;
      }
      else if (appBarType == AppBarType.main) {
        return false;
      }
      else if (appBarType == AppBarType.search) {
        return true;
      }
      else {
        return false;
      }

    }
    else {
      return false;
    }

  }
  // --------------------
  bool _searchButtonIsOnCheck() {

    if (appBarType == AppBarType.basic) {
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
  // --------------------
  bool _sectionButtonIsOnCheck() {

    if (sectionButtonIsOn != null) {
      return sectionButtonIsOn;
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
  // --------------------
  double _getBackButtonWidth(){
    final bool _backButtonIsOn = _backButtonIsOnCheck();
    final double _backButtonWidth = _backButtonIsOn == true ? 50 : 0;
    return _backButtonWidth;
  }
  // --------------------
  double _getTitleWidth(BuildContext context) {
    final double _clearWidth = BldrsAppBar.clearWidth(context);
    final bool _backButtonIsOn = _backButtonIsOnCheck();
    final double _backButtonWidth = _getBackButtonWidth();
    final double _titleWidth = _clearWidth
        - _backButtonWidth
        - 60
        - AppBarTitle.getTitleHorizontalMargin(
            backButtonIsOn: _backButtonIsOn
        );
    return _titleWidth;
  }
  // --------------------
  bool _scrollableCheck() {
    if (appBarType == AppBarType.scrollable) {
      return true;
    }

    else {
      return false;
    }
  }
  // --------------------
  double _getScrollableWidth(BuildContext context) {
    final double _screenWidth = Scale.screenWidth(context);
    final double _backButtonWidth = _getBackButtonWidth();
    final double _scrollableSpaceWidth = _screenWidth -
        (2 * Ratioz.appBarMargin) -
        _backButtonWidth -
        Ratioz.appBarPadding;

    return _scrollableSpaceWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _backButtonIsOn = _backButtonIsOnCheck();
    final bool _searchButtonIsOn = _searchButtonIsOnCheck();
    final bool _sectionButtonIsOn = _sectionButtonIsOnCheck();
    final double _titleWidth = _getTitleWidth(context);
    final bool _scrollable = _scrollableCheck();
    final double _scrollableSpaceWidth =  _getScrollableWidth(context);
    // --------------------
    return Padding(
      padding: const EdgeInsets.only(top: Ratioz.appBarPadding),
      child: Row(
        children: <Widget>[

          /// STARTING SPACER
          const SizedBox(
            width: Ratioz.appBarPadding,
          ),

          /// BACK BUTTON
          if (_backButtonIsOn == true && canGoBack == true)
            BackAndSearchButton(
              backAndSearchAction: BackAndSearchAction.goBack,
              onTap: onBack,
            ),

          /// SECTION BUTTON
          if (_sectionButtonIsOn == true) const SectionsButton(),

          /// PAGE TITLE SPACER
          const SizedBox(
            width: Ratioz.appBarPadding,
          ),

          /// PAGE TITLE
          if (pageTitleVerse != null)
            AppBarTitle(
              width: _titleWidth,
              pageTitleVerse: pageTitleVerse,
              backButtonIsOn: _backButtonIsOn,
              appBarRowWidgets: appBarRowWidgets,
            ),

          /// SCROLLER WIDGETS
          if (_scrollable == true)
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  Ratioz.appBarCorner - Ratioz.appBarPadding),
              child: Container(
                width: _scrollableSpaceWidth,
                height: minBoxHeight - (2 * Ratioz.appBarPadding),
                alignment: Alignment.center,
                color: Colorz.white20,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: appBarScrollController,
                    // children: appBarRowWidgets,
                    itemCount: appBarRowWidgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return appBarRowWidgets[index];
                    }),
              ),
            ),

          /// CUSTOM APP BAR WIDGETS
          if (appBarRowWidgets != null && _scrollable == false)
            ...appBarRowWidgets,

          /// SEARCH BUTTON PUSHER
          if (_searchButtonIsOn == true) const Expander(),

          /// SEARCH BUTTON
          if (_searchButtonIsOn == true)
            const BackAndSearchButton(
              backAndSearchAction: BackAndSearchAction.goToSearchScreen,
            ),

          /// SEARCH BUTTON SPACER SPACER
          if (_searchButtonIsOn == true)
            const SizedBox(
              width: Ratioz.appBarPadding,
            ),

        ],
      ),
    );
  }
  // -----------------------------------------------------------------------------
}
