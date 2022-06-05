import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/buttons/back_anb_search_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/nav_bar/nav_bar.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class MainLayoutStackWidgets extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MainLayoutStackWidgets({
    @required this.alignment,
    @required this.skyType,
    @required this.layoutWidget,
    @required this.appBarType,
    @required this.appBarRowWidgets,
    @required this.pageTitle,
    @required this.onBack,
    @required this.loading,
    @required this.appBarScrollController,
    @required this.searchController,
    @required this.onSearchSubmit,
    @required this.onSearchChanged,
    @required this.sectionButtonIsOn,
    @required this.historyButtonIsOn,
    @required this.zoneButtonIsOn,
    @required this.pyramidsAreOn,
    @required this.navBarIsOn,
    @required this.searchHint,
    @required this.pyramidType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Alignment alignment;
  final SkyType skyType;
  final Widget layoutWidget;
  final AppBarType appBarType;
  final List<Widget> appBarRowWidgets;
  final String pageTitle;
  final Function onBack;
  // final bool loading;
  final ScrollController appBarScrollController;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final ValueChanged<String> onSearchChanged;
  final bool pyramidsAreOn;
  final bool navBarIsOn;
  final bool historyButtonIsOn;
  final bool sectionButtonIsOn;
  final bool zoneButtonIsOn;
  final String searchHint;
  final ValueNotifier<bool> loading;
  final PyramidType pyramidType;
  /// --------------------------------------------------------------------------
  PyramidType _concludePyramidTypePerSkyType(){

    if (skyType == SkyType.black){
      return PyramidType.crystalWhite;
    }

    else if (skyType == SkyType.night){
      return PyramidType.crystalYellow;
    }

    else if (skyType == SkyType.non){
      return PyramidType.crystalBlue;
    }

    else {
      return PyramidType.glass;
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      key: key,
      alignment: alignment,
      children: <Widget>[

        if (skyType != SkyType.non)
        Sky(
          key: const ValueKey<String>('sky'),
          skyType: skyType,
          gradientIsOn: pyramidsAreOn,
        ),

        /// --- LAYOUT WIDGET
        if (layoutWidget != null)
          Container(
            key: const ValueKey<String>('layoutWidget'),
            width: Scale.superScreenWidth(context),
            height: Scale.superScreenHeight(context),
            alignment: Alignment.topCenter,
            child: layoutWidget,
          ),

        /// --- APP BAR
        if (appBarType != AppBarType.non)
          BldrsAppBar(
            key: const ValueKey<String>('appBar'),
            appBarType: appBarType,
            appBarRowWidgets: appBarRowWidgets,
            pageTitle: pageTitle,
            onBack: onBack,
            loading: loading,
            appBarScrollController: appBarScrollController,
            sectionButtonIsOn: sectionButtonIsOn,
            searchController: searchController,
            onSearchSubmit: onSearchSubmit,
            onSearchChanged: onSearchChanged,
            historyButtonIsOn: historyButtonIsOn,
            zoneButtonIsOn: zoneButtonIsOn,
            searchHint: searchHint,
          ),

        /// --- PYRAMIDS
        if (pyramidsAreOn == true)
          Pyramids(
            key: const ValueKey<String>('pyramids'),
            pyramidType: pyramidType ?? _concludePyramidTypePerSkyType(),
            loading: loading,
          ),

        /// --- NAV BAR
        if (navBarIsOn == true)
          const NavBar(
            key: ValueKey<String>('navBar'),
          ),

        /// --- IOS BACK BUTTON
        if (pyramidsAreOn == false && DeviceChecker.deviceIsIOS() == true)
          Positioned(
            key: const ValueKey<String>('backAndSearchButton'),
            bottom: 0,
            left: 0,
            child: BackAndSearchButton(
              backAndSearchAction: BackAndSearchAction.goBack,
              color: skyType == SkyType.black ? Colorz.yellow50 : Colorz.white20,
            ),
          ),

      ],
    );
  }
}
