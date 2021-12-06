import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/appbar/search_bar.dart';
import 'package:bldrs/views/widgets/general/appbar/sections_button.dart';
import 'package:bldrs/views/widgets/general/appbar/zone_button.dart';
import 'package:bldrs/views/widgets/general/artworks/blur_layer.dart';
import 'package:bldrs/views/widgets/general/buttons/back_anb_search_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
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
  final ValueChanged<String> onSearchSubmit;
  final bool historyButtonIsOn;
  final ValueChanged<String> onSearchChanged;

  const BldrsAppBar({
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
    Key key
  }) : super (key: key);
// -----------------------------------------------------------------------------
  static double width(BuildContext context, {double boxWidth}){

    final double _boxWidth = boxWidth ?? Scale.superScreenWidth(context);

    final double _abWidth =  _boxWidth - (2 * Ratioz.appBarMargin);
    return _abWidth;
  }
// -----------------------------------------------------------------------------
  static double height(BuildContext context, AppBarType appBarType){
    final double _abHeight = appBarType == AppBarType.search ? Ratioz.appBarBigHeight : Ratioz.appBarSmallHeight;
    return _abHeight;
  }
// -----------------------------------------------------------------------------
  static double scrollWidth(BuildContext context){
    final double _appBarScrollWidth = Scale.superScreenWidth(context) - (Ratioz.appBarMargin * 2) - (Ratioz.appBarPadding * 2) - Ratioz.appBarButtonSize - Ratioz.appBarPadding;
    return _appBarScrollWidth;
  }
// -----------------------------------------------------------------------------
  bool _backButtonIsOnCheck(){
    bool _isOn;

    if (appBarType == AppBarType.basic){
      _isOn = true;
    }
    else if (appBarType == AppBarType.scrollable){
      _isOn = true;
    }
    else if (appBarType == AppBarType.main){
      _isOn = false;
    }
    else if (appBarType == AppBarType.intro){
      _isOn = false;
    }
    else if (appBarType == AppBarType.search){
      _isOn = true;
    }
    else if (appBarType == AppBarType.non){
      _isOn = false;
    }
    else {
      _isOn = false;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  bool _searchButtonIsOnCheck(){
    bool _isOn;

    if (appBarType == AppBarType.basic){
      _isOn = false;
    }
    else if (appBarType == AppBarType.scrollable){
      _isOn = false;
    }
    else if (appBarType == AppBarType.main){
      _isOn = true;
    }
    else if (appBarType == AppBarType.intro){
      _isOn = false;
    }
    else if (appBarType == AppBarType.search){
      _isOn = false;
    }
    else if (appBarType == AppBarType.non){
      _isOn = false;
    }
    else {
      _isOn = false;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  bool _sectionButtonIsOnCheck(){
    bool _isOn;

    if (sectionButtonIsOn == true){
      _isOn = true;
    }
    else if (sectionButtonIsOn == false){
      _isOn = false;
    }
    else if (appBarType == AppBarType.basic){
      _isOn = false;
    }
    else if (appBarType == AppBarType.scrollable){
      _isOn = false;
    }
    else if (appBarType == AppBarType.main){
      _isOn = true;
    }
    else if (appBarType == AppBarType.intro){
      _isOn = false;
    }
    else if (appBarType == AppBarType.search){
      _isOn = true;
    }
    else if (appBarType == AppBarType.non){
      _isOn = false;
    }
    else {
      _isOn = false;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  bool _zoneButtonIsOnCheck(){
    bool _isOn;

    if (appBarType == AppBarType.basic){
      _isOn = false;
    }
    else if (appBarType == AppBarType.scrollable){
      _isOn = false;
    }
    else if (appBarType == AppBarType.main){
      _isOn = true;
    }
    else if (appBarType == AppBarType.intro){
      _isOn = true;
    }
    else if (appBarType == AppBarType.search){
      _isOn = true;
    }
    else if (appBarType == AppBarType.non){
      _isOn = false;
    }
    else {
      _isOn = false;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  bool _scrollableCheck(){
    bool _scrollable;

    if (appBarType == AppBarType.scrollable){
      _scrollable = true;
    }
    else {
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
    final bool _zoneButtonIsOn = _zoneButtonIsOnCheck();
// -----------------------------------------------------------------------------
    final double _backButtonWidth = _backButtonIsOn == true ? 50 : 0;
// -----------------------------------------------------------------------------
    final bool _scrollable = _scrollableCheck();
    final double _titleHorizontalMargins = _backButtonIsOn == true ? 5 : 15;
// -----------------------------------------------------------------------------
    return Column(
      key: key,
      children: <Widget>[

        /// MAIN APPBAR
        Container(
          width: _abWidth,
          height: _abHeight,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(Ratioz.appBarMargin),
          decoration: const BoxDecoration(
            color: Colorz.black230,
            borderRadius: const BorderRadius.all(Radius.circular(Ratioz.appBarCorner)),
            boxShadow: Shadowz.appBarShadow,
          ),

          child: Stack(
            alignment: Aligners.superCenterAlignment(context),
            children: <Widget>[

              /// --- APPBAR BLUR
              BlurLayer(
                width: _abWidth,
                height: _abHeight,
                borders: const BorderRadius.all(Radius.circular(Ratioz.appBarCorner)),
              ),

              /// APP BAR CONTENTS
              Container(
                width: _abWidth,
                height: _abHeight,
                // color: Colorz.BabyBlueSmoke,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    /// BACK / SEARCH / SECTION / ZONE
                    Row(
                      children: <Widget>[

                        const SizedBox(
                          width: Ratioz.appBarPadding,
                        ),

                        /// BackButton
                        if (_backButtonIsOn == true)
                          BackAndSearchButton(
                            backAndSearchAction: BackAndSearchAction.goBack,
                            onTap: onBack,
                          ),

                        /// Go to Search Button
                        if (_searchButtonIsOn == true)
                          const BackAndSearchButton(
                            backAndSearchAction: BackAndSearchAction.goToSearchScreen,
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
                          const SectionsButton(),

                        /// Page Title
                        if (pageTitle != null)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: _titleHorizontalMargins),
                              child: SuperVerse(
                                verse: pageTitle.toUpperCase(),
                                weight: VerseWeight.black,
                                color: Colorz.white200,
                                margin: 0,
                                shadow: true,
                                italic: true,
                                maxLines: 2,
                                centered: false,
                              ),
                            ),),

                        if(appBarRowWidgets != null &&_scrollable == false)
                          ...appBarRowWidgets,

                        /// Expander
                        if (_zoneButtonIsOn == true)
                          const Expander(),

                        /// --- LOADING INDICATOR
                        // if (loading != null)
                        //   Loading(loading: true),

                        /// Zone button
                        if (_zoneButtonIsOn == true)
                          const ZoneButton(),

                      ],
                    ),

                    /// SEARCH BAR,
                    if (appBarType == AppBarType.search)
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



