import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_button_row.dart';
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
      numberOfButtons: navModels.length,
      child: ValueListenableBuilder(
        valueListenable: tabIndex,
        builder: (_, int _tabIndex, Widget child){

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              ...List.generate(navModels.length, (index){

                final bool _isSelected = _tabIndex == index;
                final NavModel _navModel = navModels[index];

                return OButtonRow(
                  navModel: _navModel,
                  isSelected: _isSelected,
                  onTap: () => onRowTap(index),
                );

              }),

            ],
          );

        },
      ),
    );

  }
}
