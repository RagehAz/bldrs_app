import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
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
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pageTitle: pageTitle,
      loading: loading,
      appBarRowWidgets: <Widget>[
        const Expander(),
        BldrsButton(
          onTap: onBldrsTap,
        ),
      ],
      layoutWidget: MaxBounceNavigator(
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

class FloatingLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FloatingLayout({
    @required this.child,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final Widget child;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Scale.superScreenWidth(context),
      height: DashBoardLayout.clearScreenHeight(context),
      child: child,
    );
  }
}
