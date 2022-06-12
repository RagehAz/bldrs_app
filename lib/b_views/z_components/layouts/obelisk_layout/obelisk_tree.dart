import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/nav_bar/components/note_red_dot.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final int numberOfButtons;
  final List<NavModel> navModels;
  final ValueNotifier<int> tabIndex;
  final ValueChanged<int> onRowTap;
  /// --------------------------------------------------------------------------
  static const double circleWidth = 40;
  static const boxWidth = circleWidth + (2*Ratioz.appBarPadding);
// -------------------------------------
  static double getBoxMaxHeight({
    @required bool isBig,
    @required int numberOfButtons,
  }){
    const double _circleWidth = ObeliskTree.circleWidth;
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
      key: const ValueKey<String>('ObeliskTree'),
      left: Ratioz.appBarMargin,
      bottom: Ratioz.appBarMargin,
      child: ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (_, bool isBig, Widget xChild){

          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              /// ICONS
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                width: isBig == true ? ObeliskTree.circleWidth : 0,
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

                                /// BUTTON CIRCLE
                                if (_navModel?.canShow == true){
                                  return GestureDetector(
                                    onTap: () => onRowTap(index),
                                    child: NoteRedDotWrapper(
                                      redDotIsOn: true,
                                      // count: 5,
                                      childWidth: ObeliskTree.circleWidth,
                                      shrinkChild: true,
                                      isNano: true,
                                      child: DreamBox(
                                        width: ObeliskTree.circleWidth,
                                        height: ObeliskTree.circleWidth,
                                        corners: ObeliskTree.circleWidth * 0.5,
                                        color: _isSelected ? Colorz.yellow255 : Colorz.black255,
                                        icon: _navModel.icon,
                                        iconColor: _navModel.iconColor == Colorz.nothing ? null : _isSelected ? Colorz.black255 : Colorz.white255,
                                        iconSizeFactor: _navModel.iconSizeFactor ?? 0.45,
                                        margins: const EdgeInsets.only(bottom: 5),
                                      ),
                                    ),
                                  );
                                }

                                /// NOTHING
                                else if (_navModel?.canShow == false){
                                  return const SizedBox();
                                }

                                /// SEPARATOR
                                else {

                                  return const AbsorbPointer(
                                    child: SeparatorLine(
                                      width: ObeliskTree.circleWidth,
                                      margins: EdgeInsets.only(bottom: 10, top: 5),
                                    ),
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
                builder: (double value, Widget child){

                  return Transform.scale(
                    scaleX: value,
                    alignment: Alignment.centerLeft,
                    child: child,
                  );

                },
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

                            /// TEXT
                            if (_navModel?.canShow == true){
                              return GestureDetector(
                                onTap: () => onRowTap(index),
                                child: Container(
                                  height: ObeliskTree.circleWidth + 5,
                                  alignment: Alignment.centerLeft,
                                  color: Colorz.nothing,
                                  child: SuperVerse(
                                    verse: _isSelected ? _navModel.title.toUpperCase() : _navModel.title,
                                    margin: superInsets(
                                      context: context,
                                      enLeft: 5,
                                      enRight: 5,
                                    ),//const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
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

                            /// EMPTY
                            else if (_navModel?.canShow == false){
                              return const SizedBox();
                            }

                            /// SEPARATOR
                            else {

                              return const AbsorbPointer(
                                child: SeparatorLine(
                                  width: 100,
                                  margins: EdgeInsets.only(bottom: 10, top: 5),
                                  lineIsON: false,
                                ),
                              );

                            }

                          }),

                        ],
                      );

                    },
                  ),
                ),

              ),

            ],
          );

        },
      ),
    );

  }
}
