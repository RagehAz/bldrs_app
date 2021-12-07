import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:flutter/material.dart';

class DashBoardLayout extends StatelessWidget {
  final List<Widget> listWidgets;
  final String pageTitle;
  final bool loading;
  final Function onBldrsTap;

  const DashBoardLayout({
    @required this.listWidgets,
    this.pageTitle,
    this.loading = false,
    this.onBldrsTap,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  static double clearScreenHeight(BuildContext context){
    return
      Scale.superScreenHeight(context) - Ratioz.stratosphere - ( 2 * Ratioz.appBarMargin);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ScrollController _controller = ScrollController();

    return MainLayout(
      // scaffoldKey: _globalKey,
      pyramids: Iconz.dvBlankSVG,
      appBarType: AppBarType.basic,
      pageTitle: pageTitle,
      loading: loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        BldrsButton(onTap: onBldrsTap,),

      ],
      layoutWidget: MaxBounceNavigator(
        child: Scroller(
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
  final Widget child;

  const FloatingLayout({
    @required this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Scale.superScreenWidth(context),
      height: DashBoardLayout.clearScreenHeight(context),
      child: child,
    );
  }
}
