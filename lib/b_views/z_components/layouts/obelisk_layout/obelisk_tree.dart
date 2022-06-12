import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_button_row.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ObeliskTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskTree({
    @required this.isExpanded,
    @required this.numberOfButtons,
    @required this.child,
    Key key
  }) : super(key: key);

  final ValueNotifier<bool> isExpanded;
  final int numberOfButtons;
  final Widget child;
  /// --------------------------------------------------------------------------
  static const boxWidth = OButtonRow.circleWidth + (2*Ratioz.appBarPadding);
// -------------------------------------
  static double getBoxMaxHeight({
    @required bool isBig,
    @required int numberOfButtons,
  }){
    const double _circleWidth = OButtonRow.circleWidth;
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
      key: const ValueKey<String>('BzObelisk'),
      left: Ratioz.appBarMargin,
      bottom: Ratioz.appBarMargin,
      child: ValueListenableBuilder(
        valueListenable: isExpanded,
        child: child,
        builder: (_, bool isBig, Widget childx){

          return AnimatedContainer(
            duration: Duration(milliseconds: isBig ? 1500 : 500),
            curve: Curves.easeOutQuint,
            width: isBig ? 250 : 0,
            height: getBoxMaxHeight(
              isBig: true,
              numberOfButtons: numberOfButtons,
            ),
            color: Colorz.bloodTest,
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
                  child: childx,
                ),

              ],
            ),
          );

        },
      ),
    );

  }
}
