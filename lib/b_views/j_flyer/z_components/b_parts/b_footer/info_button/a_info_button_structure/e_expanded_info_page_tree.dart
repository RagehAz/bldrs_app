import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/f_info_page_contents.dart';
import 'package:flutter/material.dart';

class ExpandedInfoPageTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ExpandedInfoPageTree({
    @required this.buttonIsExpanded,
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    @required this.flyerCounter,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> buttonIsExpanded; /// p
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;
  final ValueNotifier<FlyerCounterModel> flyerCounter;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('INFO_PAGE_CONTENTS'),
      valueListenable: buttonIsExpanded,
      builder: (_, bool buttonExpanded, Widget infoPageContents){

        return AnimatedOpacity(
          opacity: buttonExpanded == true ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: infoPageContents,
        );

      },

      child: InfoPageContents(
        flyerBoxWidth: flyerBoxWidth,
        flyerModel: flyerModel,
        flyerZone: flyerZone,
        buttonExpanded: buttonIsExpanded,
        flyerCounter: flyerCounter,
      ),

    );

  }
/// --------------------------------------------------------------------------
}
