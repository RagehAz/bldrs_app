import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';

class TabModel{
  final Widget tabButton;
  final Widget page;

  const TabModel({
    @required this.tabButton,
    @required this.page,
  });
// -----------------------------------------------------------------------------
  static List<Widget> getPageWidgetsFromTabModels(List<TabModel> tabModels){

    final List<Widget> _widgets = <Widget>[];

    for (TabModel tabModel in tabModels){
      _widgets.add(tabModel.page);
    }

    return _widgets;
  }
// -----------------------------------------------------------------------------
  static List<Widget> getTabButtonsFromTabModels(List<TabModel> tabModels){

    final List<Widget> _widgets = <Widget>[];

    for (TabModel tabModel in tabModels){
      _widgets.add(tabModel.tabButton);
    }

    return _widgets;
  }
// -----------------------------------------------------------------------------

}

class TabLayout extends StatelessWidget {
  final List<TabModel> tabModels;
  final String pageTitle;
  final TabController tabController;
  final int currentIndex;
  final bool selectionMode;
  final List<dynamic> selectedItems;
  final List<Widget> appBarRowWidgets;

  const TabLayout({
    @required this.tabModels,
    @required this.tabController,
    @required this.currentIndex,
    this.pageTitle,
    this.selectionMode = false,
    this.selectedItems,
    this.appBarRowWidgets,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final List<Widget> _tabs = TabModel.getTabButtonsFromTabModels(tabModels);
    final List<Widget> _pages = TabModel.getPageWidgetsFromTabModels(tabModels);

    return MainLayout(
      appBarType: AppBarType.Basic,
      skyType: SkyType.Black,
      pageTitle: pageTitle,
      pyramids: Iconz.DvBlankSVG,
      onBack: selectionMode == false ? null : () async {await Nav.goBack(context, argument: selectedItems);},
      appBarRowWidgets: appBarRowWidgets,
      layoutWidget: MaxBounceNavigator(
        axis: Axis.vertical,

        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return
              <Widget>[

                DefaultTabController(
                  initialIndex: 0,
                  length: tabModels.length,
                  child: SliverAppBar(
                    collapsedHeight: Ratioz.stratosphere,
                    backgroundColor: Colorz.blackSemi230,
                    leadingWidth: 0,
                    leading: Container(),
                    floating: true,

                    bottom: TabBar(
                      controller: tabController,
                      physics: const BouncingScrollPhysics(),
                      // labelColor: Colorz.BloodTest,

                      // indicatorColor: Colorz.BloodTest,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.symmetric(vertical: 0),
                      indicatorWeight: 0,
                      indicator: BoxDecoration(
                        color: Colorz.yellow255,
                        borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner12 + 2.5),

                      ),

                      isScrollable: true,
                      padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                      labelPadding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),

                      // onTap: (int x){
                      //   print('x is : $x');
                      // },


                      tabs: <Widget>[

                        ..._tabs,

                      ],
                    ),
                  ),
                ),

              ];
          },
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: tabController,
            children: <Widget>[

              ..._pages,

            ],
          ),
        ),
      ),
    );
  }
}



