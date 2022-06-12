import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';

class SuperPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperPyramids({
    @required this.tabIndex,
    @required this.onRowTap,
    @required this.onExpansion,
    @required this.isExpanded,
    @required this.navModels,
    this.isYellow = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final ValueNotifier<int> tabIndex;
  final Function onExpansion;
  final ValueChanged<int> onRowTap;
  final List<NavModel> navModels;
  final bool isYellow;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      key: const ValueKey('o_pyramids'),
      children: <Widget>[

        /// SINGLE PYRAMID
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(right: 17 * 0.7),
            child: ValueListenableBuilder(
              valueListenable: isExpanded,
              child: const SuperImage(
                width: 143.1 * 0.7,
                height: 66.4 * 0.7,
                pic: Iconz.pyramid,
                boxFit: BoxFit.fitWidth,
                iconColor: Colorz.black230,
                // scale: 1,
              ),
              builder: (_, bool expanded, Widget child){

                return AnimatedScale(
                  scale: expanded == true ? 8 : 1,
                  duration: const Duration(milliseconds: 500),
                  curve: expanded == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
                  alignment: Alignment.bottomRight,
                  child: child,
                );

              },
            ),
          ),
        ),

        /// OBELISK
        Obelisk(
          isExpanded: isExpanded,
          onTriggerExpansion: onExpansion,
          onRowTap: onRowTap,
          tabIndex: tabIndex,
          navModels: navModels,
        ),

        /// PYRAMIDS
        ValueListenableBuilder(
            valueListenable: isExpanded,
            builder: (_, bool expanded, Widget child){

              return Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 17 * 0.7),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 500),
                    curve: expanded == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
                    scale: expanded == true ? 0.95 : 1,
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: (){

                        if (isExpanded.value == null || isExpanded.value == false){
                          isExpanded.value = true;
                        }
                        else {
                          isExpanded.value = false;
                        }

                      },
                      child: SuperImage(
                        width: 256 * 0.7,
                        height: 80 * 0.7,
                        pic: isYellow ? Iconz.pyramidsYellowClean : Iconz.pyramidsWhiteClean,
                        boxFit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              );

            }
        ),

      ],
    );

  }

}
