import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class TabModel {
  /// --------------------------------------------------------------------------
  const TabModel({
    @required this.tabButton,
    @required this.page,
  });

  /// --------------------------------------------------------------------------
  final Widget tabButton;
  final Widget page;

  /// --------------------------------------------------------------------------
  static List<Widget> getPageWidgetsFromTabModels(List<TabModel> tabModels) {
    final List<Widget> _widgets = <Widget>[];

    for (final TabModel tabModel in tabModels) {
      _widgets.add(tabModel.page);
    }

    return _widgets;
  }

// -----------------------------------------------------------------------------
  static List<Widget> getTabButtonsFromTabModels(List<TabModel> tabModels) {
    final List<Widget> _widgets = <Widget>[];

    for (final TabModel tabModel in tabModels) {
      _widgets.add(tabModel.tabButton);
    }

    return _widgets;
  }
// -----------------------------------------------------------------------------

}

class TabLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
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

  /// --------------------------------------------------------------------------
  final List<TabModel> tabModels;
  final String pageTitle;
  final TabController tabController;
  final int currentIndex;
  final bool selectionMode;
  final List<dynamic> selectedItems;
  final List<Widget> appBarRowWidgets;

  /// --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = TabModel.getTabButtonsFromTabModels(tabModels);
    final List<Widget> _pages = TabModel.getPageWidgetsFromTabModels(tabModels);

    return MainLayout(
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pageTitle: pageTitle,
      pyramids: Iconz.dvBlankSVG,
      onBack: selectionMode == false
          ? null
          : () {
              Nav.goBack(context, argument: selectedItems);
              // await null;
            },
      appBarRowWidgets: appBarRowWidgets,
      layoutWidget: MaxBounceNavigator(
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              DefaultTabController(
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
                    indicatorWeight: 0,
                    indicator: BoxDecoration(
                      color: Colorz.yellow255,
                      borderRadius: Borderers.superBorderAll(
                          context, Ratioz.boxCorner12 + 2.5),
                    ),

                    isScrollable: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Ratioz.appBarMargin),
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: Ratioz.appBarPadding),

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
