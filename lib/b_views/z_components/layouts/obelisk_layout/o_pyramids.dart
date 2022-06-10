import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/bz_obelisk.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class OPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OPyramids({
    @required this.tabIndex,
    @required this.onRowTap,
    @required this.onExpansion,
    @required this.isExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final ValueNotifier<int> tabIndex;
  final Function onExpansion;
  final ValueChanged<BzTab> onRowTap;

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
        BzObelisk(
          isExpanded: isExpanded,
          onTriggerExpansion: onExpansion,
          onRowTap: onRowTap,
          tabIndex: tabIndex,
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

                        isExpanded.value = !isExpanded.value;

                      },
                      child: const SuperImage(
                        width: 256 * 0.7,
                        height: 80 * 0.7,
                        pic: Iconz.pyramidsYellowClean,
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
