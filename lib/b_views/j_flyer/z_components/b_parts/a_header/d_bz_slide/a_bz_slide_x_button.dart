import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class XButtonPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const XButtonPart({
    required this.headerBorders,
    required this.onHeaderTap,
    required this.headerIsExpanded,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BorderRadius headerBorders;
  final Function onHeaderTap;
  final ValueNotifier<bool> headerIsExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: headerIsExpanded,
      builder: (_, bool _headerIsExpanded, Widget? child){

        return AnimatedOpacity(
          opacity: _headerIsExpanded == true ? 1 : 0,
          duration: Ratioz.duration150ms,
          child: child,
        );


      },
      child: Align(
        alignment: BldrsAligners.superTopAlignment(context),
        child: BldrsBox(
          width: headerBorders.topLeft.x * 2 - 10,
          height: headerBorders.topLeft.x * 2 - 10,
          color: Colorz.white10,
          icon: Iconz.xLarge,
          corners: headerBorders.topLeft.x - 5,
          margins: 5,
          iconSizeFactor: 0.5,
          onTap: onHeaderTap,
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
