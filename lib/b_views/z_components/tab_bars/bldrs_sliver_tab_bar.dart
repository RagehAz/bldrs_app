import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:flutter/material.dart';

class BldrsSliverTabBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsSliverTabBar({
    required this.tabs,
    required this.tabController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<Widget> tabs;
  final TabController tabController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverSafeArea(
        top: false,
        sliver: SliverAppBar(
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
            indicator: const BoxDecoration(
              color: Colorz.yellow255,
              borderRadius: Borderers.constantCornersAll15,
            ),

            isScrollable: true,
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            labelPadding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),

            onTap: (int x){
              blog('x is : $x');
            },

            tabs: tabs,
          ),
        ),
      ),
    );

    // return DefaultTabController(
    //   length: tabs.length,
    //   child: SliverAppBar(
    //     collapsedHeight: Ratioz.stratosphere,
    //     backgroundColor: Colorz.blackSemi230,
    //     leadingWidth: 0,
    //     leading: Container(),
    //     floating: true,
    //     bottom: TabBar(
    //       controller: tabController,
    //       physics: const BouncingScrollPhysics(),
    //       // labelColor: Colorz.BloodTest,
    //
    //       // indicatorColor: Colorz.BloodTest,
    //       indicatorSize: TabBarIndicatorSize.tab,
    //       indicatorWeight: 0,
    //       indicator: BoxDecoration(
    //         color: Colorz.yellow255,
    //         borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner12 + 2.5),
    //       ),
    //
    //       isScrollable: true,
    //       padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
    //       labelPadding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
    //
    //       onTap: (int x){
    //         blog('x is : $x');
    //       },
    //
    //       tabs: tabs,
    //     ),
    //   ),
    // );

  }
/// --------------------------------------------------------------------------
}
