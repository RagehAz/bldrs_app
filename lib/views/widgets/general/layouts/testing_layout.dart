import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class TestingLayout extends StatelessWidget {
  final List<Widget> listViewWidgets;
  final String screenTitle;
  final String appbarButtonVerse;
  final Function appbarButtonOnTap;
  // final Key scaffoldKey;
  final bool scrollable;

  const TestingLayout({
    @required this.listViewWidgets,
    @required this.screenTitle,
    @required this.appbarButtonVerse,
    @required this.appbarButtonOnTap,
    this.scrollable = false,
    // this.scaffoldKey,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      pageTitle: screenTitle,
      // scaffoldKey: scaffoldKey,

      // loading: _loading,
      appBarRowWidgets: <Widget>[

        if (appbarButtonVerse != null)
        AppBarButton(
          verse: appbarButtonVerse,
          onTap: appbarButtonOnTap,
        ),

      ],
      layoutWidget: ListView(
        physics: scrollable == true ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        children: <Widget>[

          const Stratosphere(),

          ...listViewWidgets,

        ],
      ),
    );
  }
}

