import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/artworks/pyramids.dart';
import 'package:bldrs/views/widgets/general/buttons/back_anb_search_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class MainLayoutStackWidgets extends StatelessWidget {
  final Alignment alignment;
  final SkyType skyType;
  final Widget layoutWidget;
  final AppBarType appBarType;
  final List<Widget> appBarRowWidgets;
  final String pageTitle;
  final Function onBack;
  final bool loading;
  final ScrollController appBarScrollController;
  final bool sectionButtonIsOn;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final bool historyButtonIsOn;
  final ValueChanged<String> onSearchChanged;
  final String pyramids;

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
    @required this.sectionButtonIsOn,
    @required this.searchController,
    @required this.onSearchSubmit,
    @required this.historyButtonIsOn,
    @required this.onSearchChanged,
    @required this.pyramids,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Stack(
      key: key,
      alignment: alignment,
      children: <Widget>[

        Sky(
            key: const ValueKey<String>('sky'),
            skyType: skyType
        ),

        if (layoutWidget != null)
          Container(
            key: const ValueKey<String>('layoutWidget'),
            width: Scale.superScreenWidth(context),
            height: Scale.superScreenHeight(context),
            alignment: Alignment.topCenter,
            child: layoutWidget,
          ),

        if(appBarType != AppBarType.Non)
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
            historyButtonIsOn: historyButtonIsOn,
            onSearchChanged: onSearchChanged,
          ),

        if (pyramids != null && pyramids != Iconz.DvBlankSVG)
          Pyramids(
            key: const ValueKey<String>('pyramids'),
            pyramidsIcon: pyramids,
            loading: loading,
          ),

        /// NAV BAR
        if (pyramids == null)
          NavBar(
            key: const ValueKey<String>('navBar'),
            barType: BarType.minWithText,
          ),

        if (pyramids != null && DeviceChecker.deviceIsIOS() == true)
          Positioned(
            key: const ValueKey<String>('backAndSearchButton'),
            bottom: 0,
            left: 0,
            child: BackAndSearchButton(
              backAndSearchAction: BackAndSearchAction.GoBack,
              color: skyType == SkyType.Black ? Colorz.yellow50 : Colorz.white20,
            ),
          ),


      ],
    );
  }
}
