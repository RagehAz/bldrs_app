import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/obelisk_layout/obelisk_row.dart';
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
  static const boxWidth = ObeliskRow.circleWidth + (2*Ratioz.appBarPadding);
// -------------------------------------
  static double getBoxMaxHeight({
    @required bool isBig,
  }){
    final int _numberOfButtons = BzModel.bzTabsList.length;
    const double _circleWidth = ObeliskRow.circleWidth;
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
      left: Ratioz.appBarMargin,
      bottom: Ratioz.appBarMargin,
      child: ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (_, bool isBig, Widget child){

          return Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[

              // /// COLORED BACKGROUND
              // AnimatedContainer(
              //   duration: const Duration(seconds: 1),
              //   curve: Curves.easeOutQuint,
              //   width: isBig ? 200 : boxWidth,
              //   height: getBoxMaxHeight(isBig: isBig),
              //   decoration: BoxDecoration(
              //     borderRadius: superBorderAll(context, (ObeliskRow.circleWidth / 2) + Ratioz.appBarPadding),
              //     color: Colorz.bloodTest,
              //   ),
              // ),

              /// COMPONENTS
              AnimatedContainer(
                duration: Duration(milliseconds: isBig ? 1500 : 500),
                curve: Curves.easeOutQuint,
                width: isBig ? 200 : 0,
                height: getBoxMaxHeight(isBig: true),
                // decoration: BoxDecoration(
                //   borderRadius: superBorderAll(context, 30),
                //   color: Colorz.bloodTest,
                // ),
                alignment: Alignment.bottomLeft,
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  // reverse: false,
                  // padding: const EdgeInsets.symmetric(horizontal: 5),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[

                    // const SizedBox(height: 5,),

                    // /// TRIGGER BUTTON
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: AnimatedRotation(
                    //     duration: Duration(milliseconds: isBig ? 1500 : 500),
                    //     curve: Curves.easeOutQuint,
                    //     turns: isBig ? 1.75 : 1,
                    //     child: DreamBox(
                    //       icon: Iconz.more,
                    //       width: ObeliskRow.circleWidth,
                    //       height: ObeliskRow.circleWidth,
                    //       corners: ObeliskRow.circleWidth * 0.5,
                    //       color: Colorz.black255,
                    //       iconSizeFactor: 0.45,
                    //       onTap: onTriggerExpansion,
                    //     ),
                    //   ),
                    // ),

                    /// TABS BUTTONS
                    AnimatedOpacity(
                      duration: Duration(milliseconds: isBig ? 1000 : 500),
                      curve: Curves.easeOutQuint,
                      opacity: isBig ? 1 : 0.5,
                      child: ValueListenableBuilder(
                        valueListenable: tabIndex,
                        builder: (_, int _tabIndex, Widget child){

                          return Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              ...List.generate(_bzTabs.length, (index){

                                final bool _isSelected = _tabIndex == index;
                                final BzTab _bzTab = _bzTabs[index];
                                final String _bzTabString = BzModel.translateBzTab(_bzTab);
                                final String _icon = BzModel.getBzTabIcon(_bzTab);

                                return Padding(
                                  padding: const EdgeInsets.only(top: Ratioz.appBarPadding),
                                  child: ObeliskRow(
                                    verse: _bzTabString,
                                    icon: _icon,
                                    isSelected: _isSelected,
                                    onTap: () => onRowTap(_bzTab),
                                  ),
                                );

                              }),

                            ],
                          );

                        },
                      ),
                    ),

                  ],
                ),
              ),

            ],
          );

        },
      ),
    );

  }
}
