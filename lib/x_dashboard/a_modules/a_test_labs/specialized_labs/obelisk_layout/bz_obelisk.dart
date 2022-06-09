import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/obelisk_layout/obelisk_row.dart';
import 'package:flutter/material.dart';


class BzObelisk extends StatelessWidget {

  const BzObelisk({
    @required this.isExpanded,
    @required this.onTriggerExpansion,
    @required this.onRowTap,
    Key key
  }) : super(key: key);

  final ValueNotifier<bool> isExpanded;
  final Function onTriggerExpansion;
  final ValueChanged<BzTab> onRowTap;

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
            children: <Widget>[

              /// COLORED BACKGROUND
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOutQuint,
                width: ObeliskRow.circleWidth + 10,
                height: isBig ? ((8 * 50) + (9 * 5.0)) : 60,
                decoration: BoxDecoration(
                  borderRadius: superBorderAll(context, 30),
                  color: Colorz.bloodTest,
                ),
              ),

              /// COMPONENTS
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeOutQuint,
                width: 200,
                height: isBig ? ((8 * 50) + (9 * 5.0)) : 60,
                // decoration: BoxDecoration(
                //   borderRadius: superBorderAll(context, 30),
                //   color: Colorz.bloodTest,
                // ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  children: <Widget>[

                    const SizedBox(height: 5,),

                    /// TRIGGER BUTTON
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedRotation(
                        duration: const Duration(milliseconds: 1250),
                        curve: Curves.easeOutQuint,
                        turns: isBig ? 1.75 : 1,
                        child: DreamBox(
                          icon: Iconz.more,
                          width: 50,
                          height: 50,
                          corners: 25,
                          color: Colorz.black255,
                          iconSizeFactor: 0.45,
                          onTap: onTriggerExpansion,
                        ),
                      ),
                    ),

                    /// TABS BUTTONS
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 1250),
                      curve: Curves.easeOutQuint,
                      opacity: isBig ? 1 : 0,
                      child: Column(
                        children: <Widget>[

                          ...List.generate(_bzTabs.length, (index){

                            final BzTab _bzTab = _bzTabs[index];
                            final String _bzTabString = BzModel.translateBzTab(_bzTab);
                            final String _icon = BzModel.getBzTabIcon(_bzTab);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
                              child: ObeliskRow(
                                verse: _bzTabString,
                                icon: _icon,
                                onTap: () => onRowTap(_bzTab),
                              ),
                            );

                          }),

                        ],
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
