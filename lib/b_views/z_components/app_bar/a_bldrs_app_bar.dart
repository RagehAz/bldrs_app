import 'package:bldrs/b_views/z_components/app_bar/app_bar_progress_bar.dart';
import 'package:bldrs/b_views/z_components/app_bar/app_bar_title.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/search_bar.dart';
import 'package:bldrs/b_views/z_components/app_bar/sections_button.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BldrsAppBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppBar({
    @required this.globalKey,
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
  final ValueChanged<String> onSearchChanged;
  final bool historyButtonIsOn;
  final Verse searchHintVerse;
  final bool canGoBack;
  final Function onSearchCancelled;
  final GlobalKey globalKey;
  /// --------------------------------------------------------------------------
  static double width(BuildContext context) {
    return Scale.superScreenWidth(context) - (2 * Ratioz.appBarMargin);
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
    return  Scale.superScreenWidth(context)
            - (Ratioz.appBarMargin * 2)
            - (Ratioz.appBarPadding * 2)
            - Ratioz.appBarButtonSize
            - Ratioz.appBarPadding;
  }
  // --------------------
  static const BorderRadius corners = BorderRadius.all(Radius.circular(Ratioz.appBarCorner));
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
      else if (appBarType == AppBarType.intro) {
        return false;
      }
      else if (appBarType == AppBarType.search) {
        return true;
      }
      else if (appBarType == AppBarType.non) {
        return false;
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
    else if (appBarType == AppBarType.intro) {
      return false;
    }
    else if (appBarType == AppBarType.search) {
      return false;
    }
    else if (appBarType == AppBarType.non) {
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
    else if (appBarType == AppBarType.intro) {
      return false;
    }
    else if (appBarType == AppBarType.search) {
      return false;
    }
    else if (appBarType == AppBarType.non) {
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
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _abWidth = width(context);
    final double _abClearWidth = clearWidth(context);
    final double _abHeight = height(context, appBarType);
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
    return Container(
      width: _abWidth,
      height: _abHeight,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(Ratioz.appBarMargin),
      decoration: const BoxDecoration(
        color: Colorz.black230,
        borderRadius: corners,
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
            // color: Colorz.BabyBlueSmoke,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

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
                          width: _screenWidth -
                              (2 * Ratioz.appBarMargin) -
                              _backButtonWidth -
                              Ratioz.appBarPadding,
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

                /// SEARCH BAR,
                if (appBarType == AppBarType.search)
                  SearchBar(
                    searchController: searchController,
                    onSearchSubmit: onSearchSubmit,
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
