import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_expanding_pyramid.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_pyramids.dart';
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
    @required this.isFlashing,
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
  final ValueNotifier<bool> isFlashing;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      key: const ValueKey('SuperPyramids'),
      children: <Widget>[

        /// SINGLE PYRAMID
        ObeliskExpandingPyramid(
          isExpanded: isExpanded,
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
        ObeliskPyramids(
          isExpanded: isExpanded,
          isFlashing: isFlashing,
          isYellow: isYellow,
        ),

        // ValueListenableBuilder(
        //     valueListenable: isExpanded,
        //     builder: (_, bool expanded, Widget child){
        //
        //       return Positioned(
        //         bottom: 0,
        //         right: 0,
        //         child: Padding(
        //           padding: const EdgeInsets.only(right: 17 * 0.7),
        //           child: AnimatedScale(
        //             duration: const Duration(milliseconds: 500),
        //             curve: expanded == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
        //             scale: expanded == true ? 0.95 : 1,
        //             alignment: Alignment.bottomRight,
        //             child: GestureDetector(
        //               onTap: (){
        //
        //                 if (isExpanded.value == null || isExpanded.value == false){
        //                   isExpanded.value = true;
        //                 }
        //                 else {
        //                   isExpanded.value = false;
        //                 }
        //
        //               },
        //               child: Stack(
        //                 children: <Widget>[
        //
        //                   /// FOOT
        //                   const SuperImage(
        //                     width: 256 * 0.7,
        //                     height: 80 * 0.7,
        //                     iconColor: Colorz.black255,
        //                     pic: Iconz.pyramidsWhiteClean,
        //                     boxFit: BoxFit.fitWidth,
        //                   ),
        //
        //                   ValueListenableBuilder(
        //                       valueListenable: isFlashing,
        //                       child: SuperImage(
        //                         width: 256 * 0.7,
        //                         height: 80 * 0.7,
        //                         pic: isYellow ? Iconz.pyramidsYellowClean : Iconz.pyramidsWhiteClean,
        //                         boxFit: BoxFit.fitWidth,
        //                       ),
        //                       builder: (_, bool isFlashing, Widget child){
        //
        //                         return WidgetFader(
        //                           fadeType: isFlashing ? FadeType.repeatAndReverse : FadeType.stillAtMax,
        //                           duration: const Duration(milliseconds: 1000),
        //                           child: child,
        //                         );
        //
        //                       }
        //                   ),
        //
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       );
        //
        //     }
        // ),

      ],
    );

  }

}
