import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class DashBoardLayout extends StatelessWidget {
  final List<Widget> listWidgets;
  final String pageTitle;
  final bool loading;
  final List<Widget> appBarRowWidgets;

  DashBoardLayout({
    @required this.listWidgets,
    this.pageTitle,
    this.loading = false,
    this.appBarRowWidgets,
});

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      pageTitle: pageTitle,
      // appBarBackButton: true,
      sky: Sky.Black,
      loading: loading,
      appBarRowWidgets: appBarRowWidgets,
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          ...listWidgets,

        ],
      ),
    );

  }

}
