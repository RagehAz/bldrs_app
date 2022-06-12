import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk_tree.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';

class Obelisk extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Obelisk({
    @required this.isExpanded,
    @required this.onTriggerExpansion,
    @required this.onRowTap,
    @required this.tabIndex,
    @required this.navModels,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final Function onTriggerExpansion;
  final ValueChanged<int> onRowTap;
  final ValueNotifier<int> tabIndex;
  final List<NavModel> navModels;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ObeliskTree(
      isExpanded: isExpanded,
      numberOfButtons: NavModel.getNumberOfButtons(navModels),
      tabIndex: tabIndex,
      onRowTap: (int index) => onRowTap(index),
      navModels: navModels,
    );

  }
}
