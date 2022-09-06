import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class XButtonPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const XButtonPart({
    @required this.headerBorders,
    @required this.onHeaderTap,
    @required this.headerIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BorderRadius headerBorders;
  final Function onHeaderTap;
  final ValueNotifier<bool> headerIsExpanded; /// p
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: headerIsExpanded,
      child: Align(
        alignment: Aligners.superTopAlignment(context),
        child: DreamBox(
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
      builder: (_, bool _headerIsExpanded, Widget child){

        return AnimatedOpacity(
          opacity: _headerIsExpanded == true ? 1 : 0,
          duration: Ratioz.duration150ms,
          child: child,
        );


      },
    );

  }
/// --------------------------------------------------------------------------
}
