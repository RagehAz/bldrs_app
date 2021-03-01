import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
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

  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      pageTitle: pageTitle,
      appBarBackButton: true,
      sky: Sky.Black,
      loading: loading,
      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        child: ListView(
          children: <Widget>[

            Stratosphere(),

            ...listWidgets,

          ],
        ),
      ),
    );

  }

}
