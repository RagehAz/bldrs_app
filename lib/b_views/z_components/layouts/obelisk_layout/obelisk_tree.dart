import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_button_row.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_separator_line.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';

class ObeliskTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskTree({
    @required this.isExpanded,
    @required this.numberOfButtons,
    @required this.navModels,
    @required this.tabIndex,
    @required this.onRowTap,
    this.child,
    Key key
  }) : super(key: key);

  final ValueNotifier<bool> isExpanded;
  final int numberOfButtons;
  final Widget child;
  final List<NavModel> navModels;
  final ValueNotifier<int> tabIndex;
  final ValueChanged<int> onRowTap;
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

          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              /// ICONS
              AnimatedContainer(
                duration: Duration(milliseconds: isBig == true ? 500 : 500),
                curve: Curves.easeOut,
                width: isBig == true ? OButtonRow.circleWidth : 0,
                height: getBoxMaxHeight(
                  isBig: true,
                  numberOfButtons: numberOfButtons,
                ),
                alignment: Alignment.bottomLeft,

                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [

                    ValueListenableBuilder(
                        valueListenable: tabIndex,
                        builder: (_, int _tabIndex, Widget child){

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[

                              ...List.generate(navModels.length, (index){

                                final bool _isSelected = _tabIndex == index;
                                final NavModel _navModel = navModels[index];

                                if (_navModel?.canShow == true){
                                  return GestureDetector(
                                    onTap: () => onRowTap(index),
                                    child: DreamBox(
                                      width: OButtonRow.circleWidth,
                                      height: OButtonRow.circleWidth,
                                      corners: OButtonRow.circleWidth * 0.5,
                                      color: _isSelected ? Colorz.yellow255 : Colorz.black255,
                                      icon: _navModel.icon,
                                      iconColor: _navModel.iconColor == Colorz.nothing ? null : _isSelected ? Colorz.black255 : Colorz.white255,
                                      iconSizeFactor: _navModel.iconSizeFactor ?? 0.45,
                                      margins: const EdgeInsets.only(bottom: 5),
                                    ),
                                  );
                                }

                                else if (_navModel?.canShow == false){
                                  blog('can not show');
                                  return const SizedBox();
                                }

                                else {

                                  return const SeparatorLine(
                                    width: OButtonRow.circleWidth,
                                    margins: EdgeInsets.only(bottom: 10, top: 5),
                                  );

                                }

                              }),
                            ],
                          );
                        }),

                  ],
                ),
              ),

              /// TEXTS
              WidgetFader(
                fadeType: isBig == null ? FadeType.stillAtMin : isBig == true ? FadeType.fadeIn : FadeType.fadeOut,
                curve: isBig == true ? Curves.easeInCirc : Curves.easeOutQuart,
                duration: const Duration(milliseconds: 250),
                builder: (double value, Widget childy){

                  blog('value is : $value');

                  return Transform.scale(
                    scaleX: value,
                    alignment: Alignment.centerLeft,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: isBig == true ? 500 : 500),
                      curve: Curves.easeOutQuint,
                      opacity: isBig == true ? 1 : 0.5,
                      child: ValueListenableBuilder(
                        valueListenable: tabIndex,
                        builder: (_, int _tabIndex, Widget child){

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              ...List.generate(navModels.length, (index){

                                final bool _isSelected = _tabIndex == index;
                                final NavModel _navModel = navModels[index];

                                if (_navModel?.canShow == true){
                                  return GestureDetector(
                                    onTap: () => onRowTap(index),
                                    child: Container(
                                      height: OButtonRow.circleWidth + 5,
                                      alignment: Alignment.topLeft,
                                      child: SuperVerse(
                                        verse: _isSelected ? _navModel.title.toUpperCase() : _navModel.title,
                                        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                                        italic: true,
                                        weight: _isSelected ? VerseWeight.black : VerseWeight.thin,
                                        labelColor: Colorz.black200,
                                        color: _isSelected ? Colorz.yellow255 : Colorz.white255,
                                        shadow: true,
                                        shadowColor: Colorz.black255,
                                      ),
                                    ),
                                  );
                                }

                                else if (_navModel?.canShow == false){
                                  blog('can not show');
                                  return const SizedBox();
                                }

                                else {

                                  return const SeparatorLine(
                                    width: OButtonRow.circleWidth,
                                    margins: EdgeInsets.only(bottom: 10, top: 5),
                                    lineIsON: false,
                                  );

                                }

                              }),

                            ],
                          );

                        },
                      ),
                    ),
                  );

                },

              ),

            ],
          );

        },
      ),
    );

  }
}
