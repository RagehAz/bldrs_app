import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
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
});
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
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      pageTitle: pageTitle,
      // appBarBackButton: true,
      sky: Sky.Night,
      loading: loading,
      appBarRowWidgets: [

        const Expander(),

          GestureDetector(
            onTap: onBldrsTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
              child: const BldrsName(
                size: 40,
              ),
            ),
          ),

      ],
      layoutWidget: MaxBounceNavigator(
        axis: Axis.vertical,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _controller,
          shrinkWrap: false,
          children: <Widget>[

            const Stratosphere(),

            ...listWidgets,

          ],
        ),
      ),
    );

  }

}

class FloatingLayout extends StatelessWidget {
  final Widget child;

  const FloatingLayout({
    @required this.child,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Scale.superScreenWidth(context),
      height: DashBoardLayout.clearScreenHeight(context),
      child: child,
    );
  }
}

