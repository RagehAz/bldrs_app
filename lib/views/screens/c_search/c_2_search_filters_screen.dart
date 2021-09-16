import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SearchFiltersScreen extends StatefulWidget {

  @override
  _SearchFiltersScreenState createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  ScrollController _appBarScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarType: AppBarType.Non,
      // appBarBackButton: true,
      pyramids: Iconz.DvBlankSVG,
      // appBarScrollController: _appBarScrollController,
      layoutWidget: Stack(
        children: <Widget>[

          BldrsAppBar(
            appBarType: AppBarType.Non,
            appBarRowWidgets: <Widget>[

              // DreamBox(
              //     height: Ratioz.appBarButtonSize,
              //     width: Ratioz.appBarButtonSize,
              //     corners: Ratioz.appBarButtonCorner,
              //     boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
              //     icon: Iconz.Search,
              //     iconRounded: false,
              //     iconSizeFactor: 0.6,
              //     bubble: true,
              //     color: null,
              //     // textDirection: superInverseTextDirection(context),
              //     boxFunction: () async {
              //
              //     }
              //
              // ),

            ],
            pageTitle: null,
            loading: false,
            appBarScrollController: _appBarScrollController,
          ),


        ],
      ),
    );
  }
}
