import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class XButtonPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const XButtonPart({
    @required this.headerBorders,
    @required this.onHeaderTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BorderRadius headerBorders;
  final Function onHeaderTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Consumer<ActiveFlyerProvider>(
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
      builder: (_, ActiveFlyerProvider activeFlyerProvider, Widget child){

        final bool _headerIsExpanded = activeFlyerProvider.headerIsExpanded;

        return AnimatedOpacity(
          opacity: _headerIsExpanded == true ? 1 : 0,
          duration: Ratioz.duration150ms,
          child: child,
        );

      },
    );
  }
}
