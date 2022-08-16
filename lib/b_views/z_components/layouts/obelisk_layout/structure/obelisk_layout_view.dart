import 'package:flutter/material.dart';

class ObeliskLayoutView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskLayoutView({
    @required this.tabController,
    @required this.children,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final List<Widget> children;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: children,
    );

  }

}
