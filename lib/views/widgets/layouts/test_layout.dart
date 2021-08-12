import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class TestLayout extends StatelessWidget {
  final List<Widget> listViewWidgets;
  final String screenTitle;
  final String appbarButtonVerse;
  final Function appbarButtonOnTap;

  const TestLayout({
    @required this.listViewWidgets,
    @required this.screenTitle,
    @required this.appbarButtonVerse,
    @required this.appbarButtonOnTap,

  });

  @override
  Widget build(BuildContext context) {


    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      pageTitle: screenTitle,
      // loading: _loading,
      appBarRowWidgets: [

        if (appbarButtonVerse != null)
        AppBarButton(
          verse: appbarButtonVerse,
          onTap: appbarButtonOnTap,
        ),

      ],
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          ...listViewWidgets,

        ],
      ),
    );
  }
}

