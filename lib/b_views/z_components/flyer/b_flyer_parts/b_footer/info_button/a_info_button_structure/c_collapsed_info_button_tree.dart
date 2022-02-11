import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/d_collapsed_info_button_content.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:flutter/material.dart';

class CollapsedInfoButtonTree extends StatelessWidget {

  const CollapsedInfoButtonTree({
    @required this.buttonIsExpanded,
    @required this.flyerBoxWidth,
    @required this.infoButtonType,
    Key key
  }) : super(key: key);

  final ValueNotifier<bool> buttonIsExpanded;
  final double flyerBoxWidth;
  final InfoButtonType infoButtonType;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        key: const ValueKey<String>('CollapsedInfoButtonTree'),
        valueListenable: buttonIsExpanded,
        child: CollapsedInfoButtonContent(
          infoButtonType: infoButtonType,
          flyerBoxWidth: flyerBoxWidth,
          buttonIsExpanded: buttonIsExpanded,
        ),
        builder: (_, bool _buttonIsExpanded, Widget collapsedInfoButtonContent){

          final double _paddingValue = _buttonIsExpanded ? 10 : 0;

          return AnimatedAlign(
              alignment: _buttonIsExpanded ? Alignment.center : Aligners.superCenterAlignment(context),
              duration: const Duration(milliseconds: 100),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 100),
                scale: _buttonIsExpanded ? 1.4 : 1,
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 100),
                  padding: EdgeInsets.only(top: _paddingValue),
                  child: collapsedInfoButtonContent,
                ),
              )
          );
        }
    );
  }
}
