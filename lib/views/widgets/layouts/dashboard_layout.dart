import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pyramids/bldrs_name.dart';
import 'package:flutter/material.dart';

class DashBoardLayout extends StatelessWidget {
  final List<Widget> listWidgets;
  final String pageTitle;
  final bool loading;

  DashBoardLayout({
    @required this.listWidgets,
    this.pageTitle,
    this.loading = false,
});
// -----------------------------------------------------------------------------
  static double clearScreenHeight(BuildContext context){
    return
      Scale.superScreenHeight(context) - Ratioz.stratosphere - ( 2 * Ratioz.appBarMargin);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      pageTitle: pageTitle,
      // appBarBackButton: true,
      sky: Sky.Black,
      loading: loading,
      appBarRowWidgets: [

          Expander(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: BldrsName(
              size: 40,
            ),
          ),

      ],
      layoutWidget: Scroller(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[

            Stratosphere(),

            ...listWidgets,

          ],
        ),
      ),
    );

  }

}
