import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/f_info_page_contents.dart';
import 'package:flutter/material.dart';

class ExpandedInfoPageTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ExpandedInfoPageTree({
    required this.buttonIsExpanded,
    required this.flyerBoxWidth,
    required this.flyerModel,
    required this.flyerCounter,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool?> buttonIsExpanded;
  final double flyerBoxWidth;
  final FlyerModel? flyerModel;
  final ValueNotifier<FlyerCounterModel?> flyerCounter;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('INFO_PAGE_CONTENTS'),
      valueListenable: buttonIsExpanded,
      builder: (_, bool? buttonExpanded, Widget? infoPageContents){

        final bool _expanded = Mapper.boolIsTrue(buttonExpanded);

        return AnimatedOpacity(
          opacity: _expanded == true ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: infoPageContents,
        );

      },

      child: InfoPageContents(
        flyerBoxWidth: flyerBoxWidth,
        flyerModel: flyerModel,
        buttonExpanded: buttonIsExpanded,
        flyerCounter: flyerCounter,
      ),

    );

  }
/// --------------------------------------------------------------------------
}
