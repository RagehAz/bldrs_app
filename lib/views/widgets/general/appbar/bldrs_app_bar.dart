import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/appbar/search_bar.dart';
import 'package:bldrs/views/widgets/general/appbar/sections_button.dart';
import 'package:bldrs/views/widgets/general/appbar/zone_button.dart';
import 'package:bldrs/views/widgets/general/artworks/blur_layer.dart';
import 'package:bldrs/views/widgets/general/buttons/back_anb_search_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BldrsAppBar extends StatelessWidget {
  final AppBarType appBarType;
  final Function onBack;
  final String pageTitle;
  final List<Widget> appBarRowWidgets;
  final bool loading;
  final ScrollController appBarScrollController;
  final bool sectionButtonIsOn;
  final TextEditingController searchController;
  final Function onSearchSubmit;
  final bool historyButtonIsOn;
  final Function onSearchChanged;

  BldrsAppBar({
    this.appBarType,
    this.onBack,
    this.pageTitle,
    this.appBarRowWidgets,
    this.loading = false,
    this.appBarScrollController,
    this.sectionButtonIsOn,
    this.searchController,
    this.onSearchSubmit,
    this.historyButtonIsOn,
    this.onSearchChanged,
  });
// -----------------------------------------------------------------------------
  static double width(BuildContext context){
    final double _abWidth = Scale.superScreenWidth(context) - (2 * Ratioz.appBarMargin);
    return _abWidth;
  }
// -----------------------------------------------------------------------------
  static double height(BuildContext context, AppBarType appBarType){
    final double _abHeight = appBarType == AppBarType.Search ? Ratioz.appBarBigHeight : Ratioz.appBarSmallHeight;
    return _abHeight;
  }
// -----------------------------------------------------------------------------
  static double scrollWidth(BuildContext context){
    final double _appBarScrollWidth = Scale.superScreenWidth(context) - (Ratioz.appBarMargin * 2) - (Ratioz.appBarPadding * 2) - Ratioz.appBarButtonSize - Ratioz.appBarPadding;
    return _appBarScrollWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _abWidth = width(context);
    final double _abHeight = height(context, appBarType);
    final double _blurValue = Ratioz.blur1;
    final bool _backButtonIsOn =
    appBarType == AppBarType.Basic ? true :
    appBarType == AppBarType.Scrollable ? true :
    appBarType == AppBarType.Main ? false :
    appBarType == AppBarType.Intro ? false :
    appBarType == AppBarType.Search ? true :
    appBarType == AppBarType.Non ? false :
    false;
// -----------------------------------------------------------------------------
    final bool _searchButtonIsOn =
    appBarType == AppBarType.Basic ? false :
    appBarType == AppBarType.Scrollable ? false :
    appBarType == AppBarType.Main ? true :
    appBarType == AppBarType.Intro ? false :
    appBarType == AppBarType.Search ? false :
    appBarType == AppBarType.Non ? false :
    false;
// -----------------------------------------------------------------------------
    final bool _sectionButtonIsOn =
    sectionButtonIsOn == true ? true :
    sectionButtonIsOn == false ? false :
    appBarType == AppBarType.Basic ? false :
    appBarType == AppBarType.Scrollable ? false :
    appBarType == AppBarType.Main ? true :
    appBarType == AppBarType.Intro ? false :
    appBarType == AppBarType.Search ? true :
    appBarType == AppBarType.Non ? false :
    false;
// -----------------------------------------------------------------------------
    final bool _zoneButtonIsOn =
    appBarType == AppBarType.Basic ? false :
    appBarType == AppBarType.Scrollable ? false :
    appBarType == AppBarType.Main ? true :
    appBarType == AppBarType.Intro ? true :
    appBarType == AppBarType.Search ? true :
    appBarType == AppBarType.Non ? false :
    false;
// -----------------------------------------------------------------------------
    final double _backButtonWidth = _backButtonIsOn == true ? 50 : 0;
// -----------------------------------------------------------------------------
    final bool _scrollable = appBarType == AppBarType.Scrollable ? true : false;
    final double _titleHorizontalMargins = _backButtonIsOn == true ? 5 : 15;
// -----------------------------------------------------------------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        /// MAIN APPBAR
        Container(
          width: _abWidth,
          height: _abHeight,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(Ratioz.appBarMargin),
          decoration: BoxDecoration(
            color: Colorz.Black230,
            borderRadius: BorderRadius.all(Radius.circular(Ratioz.appBarCorner)),
            boxShadow: Shadowz.appBarShadow,
          ),

          child: Stack(
            alignment: Aligners.superCenterAlignment(context),
            children: <Widget>[

              /// --- APPBAR BLUR
              BlurLayer(
                width: _abWidth,
                height: _abHeight,
                blur: _blurValue,
                borders: BorderRadius.all(Radius.circular(Ratioz.appBarCorner)),
              ),

              /// APP BAR CONTENTS
              Container(
                width: _abWidth,
                height: _abHeight,
                // color: Colorz.BabyBlueSmoke,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    /// BACK / SEARCH / SECTION / ZONE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(
                          width: Ratioz.appBarPadding,
                        ),

                        /// BackButton
                        if (_backButtonIsOn == true)
                          BackAndSearchButton(
                            backAndSearchAction: BackAndSearchAction.GoBack,
                            onTap: onBack,
                          ),

                        /// Go to Search Button
                        if (_searchButtonIsOn == true)
                          BackAndSearchButton(
                            backAndSearchAction: BackAndSearchAction.GoToSearchScreen,
                          ),

                        /// Row Widgets
                        if (_scrollable == true)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Ratioz.appBarCorner - Ratioz.appBarPadding),
                            child: Container(
                              width: _screenWidth - (2 * Ratioz.appBarMargin) - _backButtonWidth - Ratioz.appBarPadding,
                              height: _abHeight - (2 * Ratioz.appBarPadding),
                              alignment: Alignment.center,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                controller: appBarScrollController,
                                children: appBarRowWidgets,
                              ),
                            ),
                          ),

                        /// Section Button
                        if (_sectionButtonIsOn == true)
                          SectionsButton(),

                        /// Page Title
                        if (pageTitle != null)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: _titleHorizontalMargins),
                              child: SuperVerse(
                                verse: pageTitle.toUpperCase(),
                                weight: VerseWeight.black,
                                color: Colorz.White200,
                                size: 3,
                                margin: 0,
                                shadow: true,
                                italic: true,
                              ),
                            ),),

                        if(appBarRowWidgets != null &&_scrollable == false)
                          ...appBarRowWidgets,

                        /// Expander
                        if (_zoneButtonIsOn == true)
                          Expander(),

                        /// --- LOADING INDICATOR
                        // if (loading != null)
                        //   Loading(loading: true),

                        /// Zone button
                        if (_zoneButtonIsOn == true)
                          ZoneButton(),

                      ],
                    ),

                    /// SEARCH BAR,
                    if (appBarType == AppBarType.Search)
                      SearchBar(
                        searchController: searchController,
                        onSearchSubmit: onSearchSubmit,
                        historyButtonIsOn: historyButtonIsOn,
                        onSearchChanged: onSearchChanged,
                      ),

                  ],
                ),
              ),

            ],
          ),
        ),


      ],
    );
  }
}



