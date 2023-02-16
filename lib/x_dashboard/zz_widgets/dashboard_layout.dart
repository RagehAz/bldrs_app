import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class DashBoardLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DashBoardLayout({
    @required this.listWidgets,
    this.pageTitle,
    this.loading,
    this.onBldrsTap,
    this.scrollable = true,
    this.scrollerIsOn = true,
    this.appBarWidgets,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> listWidgets;
  final String pageTitle;
  final ValueNotifier<bool> loading;
  final Function onBldrsTap;
  final bool scrollable;
  final bool scrollerIsOn;
  final List<Widget> appBarWidgets;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      title: Verse.plain(pageTitle),
      loading: loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        if (onBldrsTap != null)
          BldrsNameButton(
            onTap: onBldrsTap,
          ),

        if (appBarWidgets != null)
          ...appBarWidgets,

      ],
      child: ListView(
        physics: scrollable ?
        const BouncingScrollPhysics()
            :
        const NeverScrollableScrollPhysics(),

        padding: Stratosphere.stratosphereInsets,
        children: <Widget>[

          // const Stratosphere(),

          ...listWidgets,

        ],
      ),
    );
  }
// -----------------------------------------------------------------------------
}
