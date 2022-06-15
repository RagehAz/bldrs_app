import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_icons_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_verses_builder.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
  /// --------------------------------------------------------------------------
  static const double circleWidth = 40;
  static const boxWidth = circleWidth + (2 * Ratioz.appBarPadding);
// -------------------------------------
  static double getBoxMaxHeight({
    @required bool isBig,
    @required int numberOfButtons,
  }){
    const double _circleWidth = Obelisk.circleWidth;
    final double _height = isBig ?
    ((numberOfButtons * _circleWidth) + ((numberOfButtons+1) * Ratioz.appBarPadding))
        :
    boxWidth;

    return _height + 30;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Positioned(
      key: const ValueKey<String>('Obelisk'),
      left: Ratioz.appBarMargin,
      bottom: Ratioz.appBarMargin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[

          /// ICONS
          ObeliskIconsBuilder(
            isExpanded: isExpanded,
            navModels: navModels,
            tabIndex: tabIndex,
            onRowTap: onRowTap,
          ),

          /// TEXTS
          ObeliskVersesBuilder(
            isExpanded: isExpanded,
            navModels: navModels,
            tabIndex: tabIndex,
            onRowTap: onRowTap,
          ),

        ],
      ),
    );

  }
}