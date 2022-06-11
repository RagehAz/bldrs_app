import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_button_row.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzObelisk extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzObelisk({
    @required this.isExpanded,
    @required this.onTriggerExpansion,
    @required this.onRowTap,
    @required this.tabIndex,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final Function onTriggerExpansion;
  final ValueChanged<BzTab> onRowTap;
  final ValueNotifier<int> tabIndex;
// -----------------------------------------------------------------------------
  static const boxWidth = OButtonRow.circleWidth + (2*Ratioz.appBarPadding);
// -------------------------------------
  static double getBoxMaxHeight({
    @required bool isBig,
  }){
    final int _numberOfButtons = BzModel.bzTabsList.length;
    const double _circleWidth = OButtonRow.circleWidth;
    final double _height = isBig ?
    ((_numberOfButtons * _circleWidth) + ((_numberOfButtons+1) * Ratioz.appBarPadding))
        :
    boxWidth;

    return _height;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const List<BzTab> _bzTabs = BzModel.bzTabsList;

    return Positioned(
      key: const ValueKey<String>('BzObelisk'),
      left: Ratioz.appBarMargin,
      bottom: Ratioz.appBarMargin,
      child: ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (_, bool isBig, Widget child){

          return AnimatedContainer(
            duration: Duration(milliseconds: isBig ? 1500 : 500),
            curve: Curves.easeOutQuint,
            width: isBig ? 200 : 0,
            height: getBoxMaxHeight(isBig: true),
            alignment: Alignment.bottomLeft,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[

                /// TABS BUTTONS
                AnimatedOpacity(
                  duration: Duration(milliseconds: isBig ? 1000 : 500),
                  curve: Curves.easeOutQuint,
                  opacity: isBig ? 1 : 0.5,
                  child: ValueListenableBuilder(
                    valueListenable: tabIndex,
                    builder: (_, int _tabIndex, Widget child){

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          ...List.generate(_bzTabs.length, (index){

                            final bool _isSelected = _tabIndex == index;
                            final BzTab _bzTab = _bzTabs[index];
                            final String _bzTabString = BzModel.translateBzTab(_bzTab);
                            final String _icon = BzModel.getBzTabIcon(_bzTab);

                            return OButtonRow(
                              verse: _bzTabString,
                              icon: _icon,
                              isSelected: _isSelected,
                              onTap: () => onRowTap(_bzTab),
                            );

                          }),

                        ],
                      );

                    },
                  ),
                ),

              ],
            ),
          );

        },
      ),
    );

  }
}
