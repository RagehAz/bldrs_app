import 'package:bldrs/b_views/z_components/app_bar/app_bar_progress_bar.dart';
import 'package:bldrs/b_views/z_components/app_bar/app_bar_title.dart';
import 'package:bldrs/b_views/z_components/app_bar/search_bar.dart';
import 'package:bldrs/b_views/z_components/app_bar/sections_button.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BldrsAppBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsAppBar({
    this.appBarType,
    this.onBack,
    this.pageTitle,
    this.appBarRowWidgets,
    this.loading,
    this.swipeDirection,
    this.index,
    this.numberOfStrips,
    this.appBarScrollController,
    this.sectionButtonIsOn,
    this.searchController,
    this.onSearchSubmit,
    this.onSearchChanged,
    this.historyButtonIsOn,
    this.searchHint,
    this.canGoBack,
    this.onSearchCancelled,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AppBarType appBarType;
  final Function onBack;
  final dynamic pageTitle;
  final List<Widget> appBarRowWidgets;
  final ValueNotifier<bool> loading;
  final ValueNotifier<SwipeDirection> swipeDirection;
  final ValueNotifier<int> index;
  final int numberOfStrips;
  final ScrollController appBarScrollController;
  final bool sectionButtonIsOn;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onSearchChanged;
  final bool historyButtonIsOn;
  final String searchHint;
  final bool canGoBack;
  final Function onSearchCancelled;
  /// --------------------------------------------------------------------------
  static double width(BuildContext context, {double boxWidth}) {
    final double _boxWidth = boxWidth ?? Scale.superScreenWidth(context);
    final double _abWidth = _boxWidth - (2 * Ratioz.appBarMargin);
    return _abWidth;
  }
// -----------------------------------------------------------------------------
  static double height(BuildContext context, AppBarType appBarType) {
    final double _abHeight = appBarType == AppBarType.search ?
    Ratioz.appBarBigHeight
        :
    Ratioz.appBarSmallHeight;
    return _abHeight;
  }
// -----------------------------------------------------------------------------
  static double scrollWidth(BuildContext context) {
    final double _appBarScrollWidth = Scale.superScreenWidth(context) -
        (Ratioz.appBarMargin * 2) -
        (Ratioz.appBarPadding * 2) -
        Ratioz.appBarButtonSize -
        Ratioz.appBarPadding;
    return _appBarScrollWidth;
  }
// -----------------------------------------------------------------------------
  bool _backButtonIsOnCheck() {
    bool _isOn = false;

    if (canGoBack == true){

      if (appBarType == AppBarType.basic) {
        _isOn = true;
      } else if (appBarType == AppBarType.scrollable) {
        _isOn = true;
      } else if (appBarType == AppBarType.main) {
        _isOn = false;
      } else if (appBarType == AppBarType.intro) {
        _isOn = false;
      } else if (appBarType == AppBarType.search) {
        _isOn = true;
      } else if (appBarType == AppBarType.non) {
        _isOn = false;
      } else {
        _isOn = false;
      }

    }


    return _isOn;
  }
// -----------------------------------------------------------------------------
  bool _searchButtonIsOnCheck() {
    bool _isOn;

    if (appBarType == AppBarType.basic) {
      _isOn = false;
    } else if (appBarType == AppBarType.scrollable) {
      _isOn = false;
    } else if (appBarType == AppBarType.main) {
      _isOn = true;
    } else if (appBarType == AppBarType.intro) {
      _isOn = false;
    } else if (appBarType == AppBarType.search) {
      _isOn = false;
    } else if (appBarType == AppBarType.non) {
      _isOn = false;
    } else {
      _isOn = false;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  bool _sectionButtonIsOnCheck() {
    bool _isOn;

    if (sectionButtonIsOn != null) {
      _isOn = sectionButtonIsOn;
    } else if (sectionButtonIsOn == false) {
      _isOn = false;
    } else if (appBarType == AppBarType.basic) {
      _isOn = false;
    } else if (appBarType == AppBarType.scrollable) {
      _isOn = false;
    } else if (appBarType == AppBarType.main) {
      _isOn = true;
    } else if (appBarType == AppBarType.intro) {
      _isOn = false;
    } else if (appBarType == AppBarType.search) {
      _isOn = true;
    } else if (appBarType == AppBarType.non) {
      _isOn = false;
    } else {
      _isOn = false;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  bool _scrollableCheck() {
    bool _scrollable;

    if (appBarType == AppBarType.scrollable) {
      _scrollable = true;
    } else {
      _scrollable = false;
    }

    return _scrollable;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _abWidth = width(context);
    final double _abHeight = height(context, appBarType);
    // const double _blurValue = Ratioz.blur1;
    final bool _backButtonIsOn = _backButtonIsOnCheck();
    final bool _searchButtonIsOn = _searchButtonIsOnCheck();
    final bool _sectionButtonIsOn = _sectionButtonIsOnCheck();
// -----------------------------------------------------------------------------
    final double _backButtonWidth = _backButtonIsOn == true ? 50 : 0;
// -----------------------------------------------------------------------------
    final bool _scrollable = _scrollableCheck();
// -----------------------------------------------------------------------------
    return Container(
      width: _abWidth,
      height: _abHeight,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(Ratioz.appBarMargin),
      decoration: const BoxDecoration(
        color: Colorz.black230,
        borderRadius: BorderRadius.all(Radius.circular(Ratioz.appBarCorner)),
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

                    /// STARTING SPACER
                    const SizedBox(
                      width: Ratioz.appBarPadding,
                    ),

                    /// BackButton
                    if (_backButtonIsOn == true && canGoBack == true)
                      BackAndSearchButton(
                        backAndSearchAction: BackAndSearchAction.goBack,
                        onTap: onBack,
                      ),

                    /// Go to Search Button
                    if (_searchButtonIsOn == true)
                      const BackAndSearchButton(
                        backAndSearchAction:
                            BackAndSearchAction.goToSearchScreen,
                      ),


                    /// MIDDLE SPACER
                    const SizedBox(
                      width: Ratioz.appBarPadding,
                    ),

                    /// SECTION BUTTON
                    if (_sectionButtonIsOn == true)
                      const SectionsButton(),

                    /// PAGE TITLE
                    if (pageTitle != null)
                      AppBarTitle(
                        pageTitle: pageTitle,
                        backButtonIsOn: _backButtonIsOn,
                      ),

                    /// CUSTOM APP BAR WIDGETS
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
                            scrollDirection: Axis.horizontal,
                            controller: appBarScrollController,
                            children: appBarRowWidgets,
                          ),
                        ),
                      ),

                    /// CUSTOM APP BAR WIDGETS
                    if (appBarRowWidgets != null && _scrollable == false)
                      ...appBarRowWidgets,

                  ],
                ),

                /// SEARCH BAR,
                if (appBarType == AppBarType.search)
                  SearchBar(
                    searchController: searchController,
                    onSearchSubmit: onSearchSubmit,
                    historyButtonIsOn: historyButtonIsOn,
                    onSearchChanged: onSearchChanged,
                    hintText: searchHint,
                    onSearchCancelled: onSearchCancelled,
                  ),

              ],
            ),
          ),

          /// PROGRESS BAR
          if (loading != null)
            AppBarProgressBar(
              index: index,
              numberOfStrips: numberOfStrips,
              loading: loading,
              swipeDirection: swipeDirection,
            ),

        ],
      ),
    );
  }
}
