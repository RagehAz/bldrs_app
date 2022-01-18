import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';

class TestingLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TestingLayout({
    @required this.listViewWidgets,
    @required this.screenTitle,
    this.appbarButtonVerse,
    this.appbarButtonOnTap,
    this.scrollable = false,
    // this.scaffoldKey,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> listViewWidgets;
  final String screenTitle;
  final String appbarButtonVerse;
  final Function appbarButtonOnTap;
  // final Key scaffoldKey;
  final bool scrollable;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pyramidsAreOn: true,
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
