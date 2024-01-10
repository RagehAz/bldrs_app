import 'package:flutter/material.dart';

class ObeliskLayoutView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskLayoutView({
    required this.tabController,
    required this.children,
    super.key
  });
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final List<Widget> children;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /*
        return PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      itemBuilder: (_, index){
        return children[index % children.length];
      },
    );
     */

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: children,
    );

  }
/// --------------------------------------------------------------------------
}
