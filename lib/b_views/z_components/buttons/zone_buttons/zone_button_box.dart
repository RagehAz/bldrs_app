import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ZoneButtonBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ZoneButtonBox({
    @required this.columnChildren,
    @required this.onTap,
    @required this.isActive,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final Function onTap;
  final bool isActive;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonWidth = Bubble.bubbleWidth(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
      child: Center(
        child: InkWell(
          borderRadius: Borderers.constantCornersAll12,
          onTap: onTap,
          highlightColor: Colorz.white10,
          child: Container(
            width: _buttonWidth,
            decoration: BoxDecoration(
              color: isActive == true ? Colorz.white10 : Colorz.nothing,
              borderRadius: Borderers.constantCornersAll12,
            ),
            child: Column(
              children: columnChildren,
          ),
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
