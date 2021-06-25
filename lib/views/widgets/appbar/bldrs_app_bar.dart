import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/search_bar.dart';
import 'package:bldrs/views/widgets/buttons/back_anb_search_button.dart';
import 'package:bldrs/views/widgets/buttons/sections_button.dart';
import 'package:bldrs/views/widgets/buttons/zone_button.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BldrsAppBar extends StatelessWidget {
  final AppBarType appBarType;
  final bool backButtonIsOn;
  final String pageTitle;
  final List<Widget> appBarRowWidgets;
  final bool loading;
  final ScrollController appBarScrollController;

  BldrsAppBar({
    this.appBarType,
    this.backButtonIsOn = false,
    this.pageTitle,
    this.appBarRowWidgets,
    this.loading = false,
    this.appBarScrollController,
  });
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _screenWidth = Scale.superScreenWidth(context);
    double _abWidth = Scale.appBarClearWidth(context);
    double _abHeight = Scale.appBarClearHeight(context, appBarType);
    double _blurValue = Ratioz.blur1;
// -----------------------------------------------------------------------------
    bool _scrollable = appBarType == AppBarType.Scrollable ? true : false;
    double _titleHorizontalMargins = backButtonIsOn == true ? 5 : 15;
// -----------------------------------------------------------------------------
    bool _backButtonIsOn =
    appBarType == AppBarType.Basic ? true :
    appBarType == AppBarType.Scrollable ? true :
    appBarType == AppBarType.Main ? false :
    appBarType == AppBarType.Intro ? false :
    appBarType == AppBarType.Search ? true :
    false;
// -----------------------------------------------------------------------------
    bool _searchButtonIsOn =
    appBarType == AppBarType.Basic ? false :
    appBarType == AppBarType.Scrollable ? false :
    appBarType == AppBarType.Main ? true :
    appBarType == AppBarType.Intro ? false :
    appBarType == AppBarType.Search ? false :
    false;
// -----------------------------------------------------------------------------
    bool _sectionButtonIsOn =
    appBarType == AppBarType.Basic ? false :
    appBarType == AppBarType.Scrollable ? false :
    appBarType == AppBarType.Main ? true :
    appBarType == AppBarType.Intro ? false :
    appBarType == AppBarType.Search ? true :
    false;
// -----------------------------------------------------------------------------
    bool _zoneButtonIsOn =
    appBarType == AppBarType.Basic ? false :
    appBarType == AppBarType.Scrollable ? false :
    appBarType == AppBarType.Main ? true :
    appBarType == AppBarType.Intro ? true :
    appBarType == AppBarType.Search ? true :
    false;
// -----------------------------------------------------------------------------
    double _backButtonWidth = _backButtonIsOn == true ? 50 : 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        /// MAIN APPBAR
        Container(
          width: _abWidth,
          height: _abHeight,
          alignment: Alignment.center,
          margin: EdgeInsets.all(Ratioz.appBarMargin),
          decoration: BoxDecoration(
            // color: Colorz.BlackBlack,
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

                        /// BackButton
                        if (_backButtonIsOn == true)
                          BackAndSearchButton(
                            backAndSearchAction: BackAndSearchAction.GoBack,
                          ),

                        /// Go to Search Button
                        if (_searchButtonIsOn == true)
                          BackAndSearchButton(
                            backAndSearchAction: BackAndSearchAction.GoToSearchScreen,
                          ),

                        /// Row Widgets
                        if (_scrollable == true)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Ratioz.appBarCorner),
                            child: Container(
                              width: _screenWidth - (2 * Ratioz.appBarMargin) - _backButtonWidth,
                              height: _abHeight,
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
                                verse: pageTitle,
                                weight: VerseWeight.thin,
                                color: Colorz.WhiteLingerie,
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
                          Expanded(child: Container(),),

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
                      SearchBar(),

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



