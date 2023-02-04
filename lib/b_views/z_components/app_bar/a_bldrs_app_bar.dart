import 'package:bldrs/b_views/z_components/app_bar/app_bar_progress_bar.dart';
import 'package:bldrs/b_views/z_components/app_bar/app_bar_title.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/search_bar.dart';
import 'package:bldrs/b_views/i_phid_picker/app_bar_pick_phid_button/sections_button.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:provider/provider.dart';
import 'package:scale/scale.dart';

import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:widget_fader/widget_fader.dart';

class BldrsAppBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppBar({
    this.globalKey,
    this.appBarType,
    this.onBack,
    this.pageTitleVerse,
    this.appBarRowWidgets,
    this.loading,
    this.progressBarModel,
    this.appBarScrollController,
    this.sectionButtonIsOn,
    this.searchController,
    this.onSearchSubmit,
    this.onPaste,
    this.onSearchChanged,
    this.historyButtonIsOn,
    this.searchHintVerse,
    this.canGoBack,
    this.onSearchCancelled,
    this.listenToHideLayout,
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
  final bool historyButtonIsOn;
  final Verse searchHintVerse;
  final bool canGoBack;
  final Function onSearchCancelled;
  final GlobalKey globalKey;
  final bool listenToHideLayout;
  /// --------------------------------------------------------------------------
  static double width(BuildContext context) {
    return Scale.screenWidth(context) - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  static double clearWidth(BuildContext context){
    return width(context) - (2 * Ratioz.appBarPadding);
  }
  // --------------------
  static double height(BuildContext context, AppBarType appBarType) {

    if (appBarType == AppBarType.search){
      return Ratioz.appBarBigHeight;
    }
    else {
      return Ratioz.appBarSmallHeight;
    }

  }
  // --------------------
  static double scrollWidth(BuildContext context) {
    return  Scale.screenWidth(context)
            - (Ratioz.appBarMargin * 2)
            - (Ratioz.appBarPadding * 2)
            - Ratioz.appBarButtonSize
            - Ratioz.appBarPadding;
  }
  // --------------------
  static const BorderRadius corners = BorderRadius.all(Radius.circular(Ratioz.appBarCorner));
  // --------------------
  static const BorderRadius clearCorners = BorderRadius.all(Radius.circular(Ratioz.appBarCorner - 5));
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _theAppBar = _TheAppBar(
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
      historyButtonIsOn: historyButtonIsOn,
      searchHintVerse: searchHintVerse,
      canGoBack: canGoBack,
      onSearchCancelled: onSearchCancelled,
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

class _TheAppBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _TheAppBar({
    this.globalKey,
    this.appBarType,
    this.onBack,
    this.pageTitleVerse,
    this.appBarRowWidgets,
    this.loading,
    this.progressBarModel,
    this.appBarScrollController,
    this.sectionButtonIsOn,
    this.searchController,
    this.onSearchSubmit,
    this.onPaste,
    this.onSearchChanged,
    this.historyButtonIsOn,
    this.searchHintVerse,
    this.canGoBack,
    this.onSearchCancelled,
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
  final bool historyButtonIsOn;
  final Verse searchHintVerse;
  final bool canGoBack;
  final Function onSearchCancelled;
  final GlobalKey globalKey;
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
  bool _scrollableCheck() {

    if (appBarType == AppBarType.scrollable) {
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _abWidth = BldrsAppBar.width(context);
    final double _abClearWidth = BldrsAppBar.clearWidth(context);
    final double _abHeight = BldrsAppBar.height(context, appBarType);
    // const double _blurValue = Ratioz.blur1;
    final bool _backButtonIsOn = _backButtonIsOnCheck();
    final bool _searchButtonIsOn = _searchButtonIsOnCheck();
    final bool _sectionButtonIsOn = _sectionButtonIsOnCheck();
    // --------------------
    final double _backButtonWidth = _backButtonIsOn == true ? 50 : 0;
    // --------------------
    final bool _scrollable = _scrollableCheck();
    // --------------------
    final double _titleWidth =  _abClearWidth
                                - _backButtonWidth
                                - 60
                                - AppBarTitle.getTitleHorizontalMargin(
                                      backButtonIsOn: _backButtonIsOn
                                  );
    // --------------------
    final double _scrollableSpaceWidth =  _screenWidth -
                                          (2 * Ratioz.appBarMargin) -
                                          _backButtonWidth -
                                          Ratioz.appBarPadding;
    return Container(
      width: _abWidth,
      height: _abHeight,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(Ratioz.appBarMargin),
      decoration: const BoxDecoration(
        color: Colorz.black230,
        borderRadius: BldrsAppBar.corners,
        boxShadow: Shadower.appBarShadow,
      ),
      child: Stack(
        alignment: Aligners.superCenterAlignment(context),
        children: <Widget>[

          // // BLUR
          // BlurLayer(
          //   width: _abWidth,
          //   height: _abHeight,
          //   borders: const BorderRadius.all(
          //       Radius.circular(Ratioz.appBarCorner)),
          // ),

          /// CONTENTS
          SizedBox(
            width: _abWidth,
            height: _abHeight,
            // color: Colorz.red50,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                  const SizedBox(width: 5, height: 5,),

                /// BACK / SEARCH / SECTION / ZONE
                Row(
                  children: <Widget>[
                    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                    /// STARTING SPACER
                    const SizedBox(
                      width: Ratioz.appBarPadding,
                    ),
                    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                    /// BACK BUTTON
                    if (_backButtonIsOn == true && canGoBack == true)
                      BackAndSearchButton(
                        backAndSearchAction: BackAndSearchAction.goBack,
                        onTap: onBack,
                      ),
                    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                    /// SECTION BUTTON
                    if (_sectionButtonIsOn == true)
                      const SectionsButton(),
                    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
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
                    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                    /// SCROLLER WIDGETS
                    if (_scrollable == true)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Ratioz.appBarCorner - Ratioz.appBarPadding),
                        child: Container(
                          width: _scrollableSpaceWidth,
                          height: _abHeight - (2 * Ratioz.appBarPadding),
                          alignment: Alignment.center,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            controller: appBarScrollController,
                            children: appBarRowWidgets,
                          ),
                        ),
                      ),
                    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                    /// CUSTOM APP BAR WIDGETS
                    if (appBarRowWidgets != null && _scrollable == false)
                      ...appBarRowWidgets,
                    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                    /// SEARCH BUTTON PUSHER
                    if (_searchButtonIsOn == true)
                      const Expander(),
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
                    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0

                  ],
                ),

                if (appBarType == AppBarType.search)
                  const SizedBox(
                    width: 5,
                    height: 5,
                  ),

                /// SEARCH BAR,
                if (appBarType == AppBarType.search)
                  SearchBar(
                    searchController: searchController,
                    onSearchSubmit: onSearchSubmit,
                    onPaste: onPaste,
                    searchIconIsOn: historyButtonIsOn,
                    onSearchChanged: onSearchChanged,
                    hintVerse: searchHintVerse,
                    onSearchCancelled: onSearchCancelled,
                    appBarType: appBarType,
                    globalKey: globalKey,
                  ),

              ],
            ),
          ),

          /// PROGRESS BAR
          if (loading != null)
            AppBarProgressBar(
              progressBarModel: progressBarModel,
              loading: loading,
              appBarType: appBarType,
            ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
