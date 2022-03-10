import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DashBoardLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DashBoardLayout({
    @required this.listWidgets,
    this.pageTitle,
    this.loading = false,
    this.onBldrsTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> listWidgets;
  final String pageTitle;
  final bool loading;
  final Function onBldrsTap;
  /// --------------------------------------------------------------------------
  static double clearScreenHeight(BuildContext context) {
    return Scale.superScreenHeight(context) -
        Ratioz.stratosphere -
        (2 * Ratioz.appBarMargin);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ScrollController _controller = ScrollController();

    return MainLayout(
      // scaffoldKey: _globalKey,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pageTitle: pageTitle,
      // loading: loading,
      appBarRowWidgets: <Widget>[
        const Expander(),
        BldrsNameButton(
          onTap: onBldrsTap,
        ),
      ],

      layoutWidget: OldMaxBounceNavigator(
        child: Scroller(
          controller: _controller,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            children: <Widget>[

              const Stratosphere(),

              ...listWidgets,

            ],
          ),
        ),
      ),
    );
  }
}