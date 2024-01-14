import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/d_collapsed_info_button_content.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:flutter/material.dart';

class CollapsedInfoButtonTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedInfoButtonTree({
    required this.buttonIsExpanded,
    required this.flyerBoxWidth,
    required this.infoButtonType,
    required this.tinyMode,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool?> buttonIsExpanded;
  final double flyerBoxWidth;
  final InfoButtonType infoButtonType;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('CollapsedInfoButtonTree'),
      valueListenable: buttonIsExpanded,
      builder: (_, bool? _buttonIsExpanded, Widget? collapsedInfoButtonContent){

        return AnimatedAlign(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 100),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 100),
              scale: Mapper.boolIsTrue(_buttonIsExpanded) == true ? 1.4 : 1,
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 100),
                padding: EdgeInsets.only(top: Mapper.boolIsTrue(_buttonIsExpanded) == true ? 10 :
                0),
                child: collapsedInfoButtonContent,
              ),
            )
        );
      },

      child: CollapsedInfoButtonContent(
        infoButtonType: infoButtonType,
        flyerBoxWidth: flyerBoxWidth,
        buttonIsExpanded: buttonIsExpanded,
        tinyMode: tinyMode,
      ),

    );

  }
/// --------------------------------------------------------------------------
}
